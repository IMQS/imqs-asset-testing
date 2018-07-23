CREATE PROCEDURE [dbo].[roll_over_rul_year](
	@FinYear INT,
	@IntDeprDate DATETIME,
	@StartDate DATETIME,
	@EndDate DATETIME,
	--BGV | TA6-883 Handling period 13/14 adjustments
	@ComponentID VARCHAR(40) = NULL
)
AS
BEGIN
	DECLARE @CStrRecognitionDay VARCHAR(MAX)='Include day for Recognition';
	DECLARE @CStrDepreciation VARCHAR(MAX)= 'Depreciation'
	DECLARE @ExtraDays INT=0
	DECLARE @Finregister VARCHAR(MAX) = 'AssetRegisterIconFin' + CAST(@FinYear AS VARCHAR(4))
	DECLARE @PrevRegister VARCHAR(MAX) =  'AssetRegisterIconFin' + CAST(@FinYear - 1 AS VARCHAR(4))
	DECLARE @CNT INT = 0
	DECLARE @SQL VARCHAR(MAX)=''
	
	SELECT @ExtraDays=CASE WHEN UPPER(ISNULL(Value,'YES'))='YES' THEN 1 ELSE 0 END FROM AssetPolicyGeneral WHERE Section=@CStrDepreciation AND Identifier=@CStrRecognitionDay	
	SELECT @CNT=COUNT(1) FROM sys.objects WHERE name = @PrevRegister
	
	IF @CNT>0 
	BEGIN	
		SET @SQL= 'DECLARE @IntDeprDate DATETIME='+QuoteName(CAST(@IntDeprDate AS VARCHAR(MAX)),'''') + '
			 DECLARE @StartDate DATETIME='+QuoteName(CAST(@StartDate AS VARCHAR(MAX)),'''') + '
			 DECLARE @EndDate DATETIME='+QuoteName(CAST(@EndDate AS VARCHAR(MAX)),'''') + '
			UPDATE '+ @FinRegister + ' 
			SET RUL=((a.RUL) - (12 * DeprDays/DATEDIFF(DAY, @StartDate, @EndDate)))/12
			FROM
			(
				SELECT ComponentID
				, CostOpening
				, CarryingValueOpening
				, DepreciationOpening
				, DepreciationFinYTD
				, AdditionsFinYTD
				, ResidualValue
				, TakeOnDate
				, DerecognitionDate
				, EUL
				, (RUL*12) RUL
				, ((RUL*12)/12)*DATEDIFF(DAY, @StartDate,@EndDate) D
				, CASE WHEN CarryingValueOpening-ResidualValue<=0 THEN 0
					   WHEN (RUL*12)<12 AND DATEADD(MONTH, (RUL*12), @StartDate)<@IntDeprDate THEN (CarryingValueOpening-ResidualValue)
				       WHEN AdditionsFinYTD>0 THEN (AdditionsFinYTD-ResidualValue)
				       WHEN CostOpening>0 THEN (CarryingValueOpening-ResidualValue) END DeprAmount

				, CASE WHEN (RUL*12)<12 AND DATEADD(MONTH, (RUL*12), @StartDate)<@IntDeprDate THEN (CarryingValueOpening-ResidualValue) / ((RUL*12)*DATEDIFF(DAY, @StartDate,@EndDate))*12
				   WHEN AdditionsFinYTD>0 THEN (AdditionsFinYTD-ResidualValue) / (((RUL*12)/12)*DATEDIFF(DAY, @StartDate,@EndDate))
				   WHEN CostOpening>0 THEN (CarryingValueOpening-ResidualValue) /(((RUL*12)/12)*DATEDIFF(DAY, @StartDate,@EndDate))
				END DailyDepr
				, CASE WHEN DerecognitionDate>=@StartDate AND DerecognitionDate<=@IntDeprDate AND DerecognitionDate < DATEADD(DAY, ((RUL*12)/12)*DATEDIFF(DAY, @StartDate,@EndDate), @StartDate) THEN DATEDIFF(DAY,@StartDate,DerecognitionDate)
				   WHEN DerecognitionDate >=@StartDate AND (RUL*12)<12 AND DerecognitionDate<@IntDeprDate THEN ((RUL*12)/12)*DATEDIFF(DAY, @StartDate,@EndDate)
				   WHEN DerecognitionDate >=@StartDate AND DerecognitionDate<@IntDeprDate THEN DATEDIFF(DAY,@StartDate,DerecognitionDate)    
				   WHEN TakeOnDate >= @StartDate AND TakeOnDate<@IntDeprDate THEN DATEDIFF(DAY, TakeOnDate, @IntDeprDate)+'+ CAST(@ExtraDays AS VARCHAR(3)) + '  
				   WHEN TakeOnDate >= @StartDate AND TakeOnDate>=@IntDeprDate THEN ' + CAST(@ExtraDays AS VARCHAR(3)) + '  
				   WHEN (RUL*12)<12 AND DATEADD(MONTH, (RUL*12), @StartDate)<@IntDeprDate THEN ((RUL*12)*DATEDIFF(DAY, @StartDate,@EndDate))/12
				   WHEN (RUL*12)<12 AND DATEADD(MONTH, (RUL*12), @StartDate)>@IntDeprDate THEN DATEDIFF(DAY,@StartDate, @IntDeprDate)
				   WHEN (RUL*12)>=12 THEN DATEDIFF(DAY,@StartDate, @IntDeprDate)
				   END DeprDays
				FROM ' + @PrevRegister + ' 
				WHERE DepreciationMethodID=''STR'' OR DepreciationMethodID=''SL''
				AND (RUL*12)>0
			) a
			WHERE ' + @FinRegister + '.componentID=a.ComponentID'
		
		--BGV | TA6-883 Handling period 13/14 adjustments
		if @ComponentID IS NOT NULL
			SET @SQL = @SQL + ' AND (a.ComponentID = ''' + @ComponentID + ''')'
		
		EXEC(@SQL)
		
		SET @SQL = 'UPDATE ' + @FinRegister + ' SET DepreciationMethodID=''FD'' WHERE RUL<=0 AND (DepreciationMethodID=''SL'' OR DepreciationMethodID=''STR'')'
		--BGV | TA6-883 Handling period 13/14 adjustments
		if @ComponentID IS NOT NULL
			SET @SQL = @SQL + ' AND (ComponentID = ''' + @ComponentID + ''')'
		EXEC(@SQL)	
	END
END;