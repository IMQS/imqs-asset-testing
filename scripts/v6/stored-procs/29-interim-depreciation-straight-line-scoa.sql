CREATE PROCEDURE [dbo].[InterimDepreciationStraightLine_SCOA](
	@FinYear INT,
	@Period INT,
	@IntDeprDate DATETIME,
	@StartDate DATETIME,
	@EndDate DATETIME,
	--BGV | TA6-883 Handling period 13/14 adjustments
	@ComponentID VARCHAR(40) = NULL
)
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @EULMeasure VARCHAR(10)
	DECLARE @RUL_CALC VARCHAR(10)
	DECLARE @CStrRecognitionDay VARCHAR(MAX) = 'Include day for Recognition'
	DECLARE @CStrDepreciation VARCHAR(MAX) = 'Depreciation'
	DECLARE @ExtraDays INT = 0
	DECLARE @SQL VARCHAR(MAX) = ''
	DECLARE @FinRegister VARCHAR(MAX)
	DECLARE @FormReference VARCHAR(40)
	DECLARE @SCOAVersion VARCHAR(10)
	
	--Determine the RUL multiplier based on the EULMeasure
	SELECT @EULMeasure = UPPER(Value) FROM AssetPolicyGeneral WHERE Section='General' AND Identifier='Useful Life Measure'
	SET @RUL_CALC = CASE 
						WHEN @EULMeasure = 'YEAR' THEN  '(RUL*12)'
						WHEN @EULMeasure = 'MONTH' THEN '(RUL*1)'
					END
		
	SELECT @ExtraDays = CASE WHEN UPPER(ISNULL(Value,'YES'))='YES' THEN 1 ELSE 0 END FROM AssetPolicyGeneral WHERE Section=@CStrDepreciation AND Identifier=@CStrRecognitionDay
	--SET @StartDate = DateAdd(Day,-1,@StartDate)
	SET @FormReference = ('SL' + CONVERT(VARCHAR(38),(DATEDIFF(DAY, '1899-12-30T00:00:00', GETDATE())) + CONVERT(INT,86400 * CONVERT(FLOAT,GETDATE() - CONVERT(DATETIME,GETDATE()))) + ABS(CHECKSUM(NewId())) % 1000))

	SET @FinRegister = 'AssetRegisterIconFin' + CAST(@FinYear AS VARCHAR(4))
	SET @SCOAVersion = (SELECT ISNULL(SCOAVersion, '6.1') FROM AssetFinYear WHERE FinYear = @FinYear)
	
	SET @SQL =
	   'DECLARE @StartDate DATETIME = ' + QUOTENAME(CAST(@StartDate AS VARCHAR(MAX)),'''') + '
		DECLARE @IntDeprDate DATETIME = ' + QUOTENAME(CAST(@IntDeprDate AS VARCHAR(MAX)),'''') + '
		DECLARE @EndDate DATETIME = ' + QUOTENAME(CAST(@EndDate AS VARCHAR(MAX)),'''') + ' 
		DECLARE @PeriodDays INT = 365
		DECLARE @DayOffset INT = 1  --Used when calculating the days between two dates to either include or exclude the start date
		 
		INSERT INTO SCOAJournal 
		(Form_Reference, ComponentID, FinancialField, Date, Amount, EffectiveDate, FinYear, Period, 
		 SCOA_Fund, SCOA_Function, SCOA_Mun_Classification, SCOA_Project, SCOA_Costing, SCOA_Region, SCOA_Item_Debit, 
		 SCOA_Fund_Credit, SCOA_Function_Credit, SCOA_Mun_Classification_Credit, SCOA_Project_Credit, SCOA_Costing_Credit, SCOA_Region_Credit, SCOA_Item_Credit, 
		 BudgetID,
		 BREAKDOWN_SCOA_Fund, BREAKDOWN_SCOA_Function, BREAKDOWN_SCOA_Project, BREAKDOWN_SCOA_Costing, BREAKDOWN_SCOA_Region, BREAKDOWN_SCOA_Item_Debit, 
		 BREAKDOWN_SCOA_Fund_Credit, BREAKDOWN_SCOA_Function_Credit, BREAKDOWN_SCOA_Project_Credit, BREAKDOWN_SCOA_Costing_Credit, BREAKDOWN_SCOA_Region_Credit, BREAKDOWN_SCOA_Item_Credit )
		
		SELECT ''' + @FormReference + ''' as Form_Reference
		,a.ComponentID
		,''DepreciationFinYTD'' as FinancialField
		,Date = GETDATE()
		,Amount = a.DepreciationFinYTD - (ISNULL(-a.DailyDepr,0) * ISNULL(a.DeprDays,0))
		,EffectiveDate = @IntDeprDate
		,' + CAST(@FinYear AS VARCHAR(4)) + ' as FinYear
		,' + CAST(@Period AS VARCHAR(4)) + ' as Period
		
		--debit leg
		,a.SCOA_Fund
		,a.SCOA_Function
		,a.SCOA_Mun_Classification
		,a.SCOA_Project
		,a.SCOA_Costing
		,a.SCOA_Region
		,a.SCOA_Item
		
		--duplicate	for credit leg according to specs for now
		,a.SCOA_Fund
		,a.SCOA_Function
		,a.SCOA_Mun_Classification
		,a.SCOA_Project
		,a.SCOA_Costing
		,a.SCOA_Region
		,a.SCOA_Item_Credit
		
		,a.DepreciationBudgetNr_Debit
		
		--breakdown debit leg
		,a.BREAKDOWN_SCOA_Fund 
		,a.BREAKDOWN_SCOA_Function
		,a.BREAKDOWN_SCOA_Project
		,a.BREAKDOWN_SCOA_Costing
		,a.BREAKDOWN_SCOA_Region
		,a.BREAKDOWN_SCOA_Item
		
		--duplicate for credit leg according to specs for now
		,a.BREAKDOWN_SCOA_Fund 
		,a.BREAKDOWN_SCOA_Function
		,a.BREAKDOWN_SCOA_Project
		,a.BREAKDOWN_SCOA_Costing
		,a.BREAKDOWN_SCOA_Region
		,a.BREAKDOWN_SCOA_Item_Credit
		
		FROM
		(
			SELECT ComponentID
			, DepreciationFinYTD
			, DepreciationBudgetNr_Debit 
			, SCOA_Item_Depreciation_Credit as SCOA_Item_Credit
			, (SELECT CASE WHEN sc.IsBreakdown = 1 THEN sc.AccountNumber END	 
				FROM SCOAClassification sc WHERE sc.SCOAId = SCOA_Item_Depreciation_Credit AND sc.SCOAVersion = ''' + (@SCOAVersion) + ''')	as BREAKDOWN_SCOA_Item_Credit
			, sbDT.SCOA_Costing
			, sbDT.SCOA_Function
			, sbDT.SCOA_Fund
			, sbDT.SCOA_Mun_Classification 
			, sbDT.SCOA_Region
			, sbDT.SCOA_Item
			, sbDT.SCOA_Project
			, sbDT.BREAKDOWN_SCOA_Fund 
			, sbDT.BREAKDOWN_SCOA_Function
			, sbDT.BREAKDOWN_SCOA_Costing
			, sbDT.BREAKDOWN_SCOA_Region
			, sbDT.BREAKDOWN_SCOA_Project
			, sbDT.BREAKDOWN_SCOA_Item '
		
		SET @SQL = @SQL + '
			-- Since we do not persist the original Acquisition Cost and Accumulated Depreciation (we also reset the
			-- DepreciationFinYTD to zero on every financial year roll over) we do not have the necessary data to use the standard 
			-- Straight Line calculation method. Hence the general approach we use to calculate the daily depreciation amount is:			
			--		(CarryingValueOpening - ResidualValue) / RUL in number of days  
			-- 		depending on the transacion, for addtions CarryingValueopening will be replaced with AdditnionsFinYTD
			-- We then calculate the depeciation amount by taking the daily depreciation amount and mulptiply that by the number 
			-- of days in the depreciation period selected.
			--		Depreciation Amount = Daily Depreciation Amount * RUL Number of Days in Period
			
			, ((CarryingValueOpening + AdditionsFinYTD + TransferCost - ResidualValue) / ((' + @RUL_CALC + '/12) * @PeriodDays)) as DailyDepr
		
			, CASE 
				-- Derecognition of Existing Asset - DerecognitionDate occurs before Depreciation Date and before RUL=0 Date
				WHEN (DerecognitionDate >= @StartDate) AND (DerecognitionDate <= @IntDeprDate) AND (TakeOnDate <= @StartDate)
					AND (DerecognitionDate <= DATEADD(MONTH, ' + @RUL_CALC + ', @StartDate)) 
					THEN --1 
						DATEDIFF(DAY, @StartDate, DerecognitionDate) + @DayOffset
						
				-- Derecognition of Recognised Asset(Addition) in the same financial year
				WHEN (DerecognitionDate >= @StartDate) AND (DerecognitionDate <= @IntDeprDate) AND (TakeOnDate >= @StartDate)
					AND (DerecognitionDate <= DATEADD(MONTH, ' + @RUL_CALC + ', @StartDate)) 
					THEN --2 
						DATEDIFF(DAY, TakeOnDate, DerecognitionDate) + @DayOffset	
							
				-- RUL=0 Date before Interim Depr Date
				WHEN (@IntDeprDate >= @StartDate) AND (@IntDeprDate > DATEADD(MONTH, ' + @RUL_CALC + ', @StartDate) - @DayOffset) 
					THEN --3 
						DATEDIFF(DAY, @StartDate, DATEADD(MONTH, ' + @RUL_CALC + ', @StartDate) + @DayOffset)
						
				-- TakeOnDate before Interim Depr Date - existing, additions and transfers
				WHEN (TakeOnDate >= @StartDate) AND (TakeOnDate <= @IntDeprDate) AND ((AdditionsFinYTD > 0) OR ((TransferCost > 0)))
					THEN --4 
						DATEDIFF(DAY, TakeOnDate, @IntDeprDate) + @DayOffset
						
				-- TakeOnDate after Interim Depreciation Date
				WHEN (TakeOnDate >= @StartDate) AND (TakeOnDate > @IntDeprDate) 
					THEN --5 
						0 
						
				-- Else RUL=0 Date must be after Interim Depr Date and no other special cases triggered
				ELSE --6 
					DATEDIFF(DAY, @StartDate, @IntDeprDate) + @DayOffset
			  END DeprDays
			
			FROM ' + @FinRegister + '
			LEFT OUTER JOIN SCOABudget sbDT on sbDT.BudgetNr = DepreciationBudgetNr_Debit
			--LEFT OUTER JOIN SCOABudget sbCT on sbCT.BudgetNr = DepreciationBudgetNr_Credit
			WHERE (DepreciationMethodID = ''STR'' OR DepreciationMethodID = ''SL'')
			AND RUL > 0'
						
		if @ComponentID IS NOT NULL
				SET @SQL = @SQL + ' AND ComponentID = ''' + @ComponentID + ''''
			
		SET @SQL = @SQL + ') a '
		
	EXEC(@SQL)
	--PRINT @SQL

	
	--Insert corresponding records for SCOADepreciationStatus with Pending Authorisation (4) as status
	SET @SQL = 'INSERT INTO SCOADepreciationStatus (SCOAJournalID, Status) 
				SELECT ID, 4 FROM SCOAJournal WHERE Form_Reference = ' + QUOTENAME(@FormReference,'''')
	if @ComponentID IS NOT NULL
			SET @SQL = @SQL + ' AND ComponentID = ''' + @ComponentID + ''''
	EXEC(@SQL)	
	--PRINT(@SQL)
END
