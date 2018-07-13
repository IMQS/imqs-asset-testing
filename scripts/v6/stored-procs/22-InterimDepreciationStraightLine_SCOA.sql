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
	SET NOCOUNT ON
	
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
	SET @StartDate = DateAdd(Day,-1,@StartDate)
	SET @FormReference = ('SL' + CONVERT(VARCHAR(38),(DATEDIFF(DAY, '1899-12-30T00:00:00', GETDATE())) + CONVERT(INT,86400 * CONVERT(FLOAT,GETDATE() - CONVERT(DATETIME,GETDATE())))))
	SET @FinRegister = 'AssetRegisterIconFin' + CAST(@FinYear AS VARCHAR(4))
	SET @SCOAVersion = (SELECT ISNULL(SCOAVersion, '6.1') FROM AssetFinYear WHERE FinYear = @FinYear)
	
	SET @SQL =
	   'DECLARE @StartDate DATETIME = ' + QUOTENAME(CAST(@StartDate AS VARCHAR(MAX)),'''') + '
		DECLARE @IntDeprDate DATETIME = ' + QUOTENAME(CAST(@IntDeprDate AS VARCHAR(MAX)),'''') + '
		DECLARE @EndDate DATETIME = ' + QUOTENAME(CAST(@EndDate AS VARCHAR(MAX)),'''') + ' 
		 
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
			, CostOpening
			, CarryingValueOpening
			, DepreciationOpening
			, DepreciationFinYTD
			, AdditionsFinYTD
			, ResidualValue
			, TakeOnDate
			, DerecognitionDate
			, EUL
			, ' + @RUL_CALC + ' RUL
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
			, CASE 
				--Since we do not persist the original Acquisition Cost and Accumulated Depreciation (we also as reset the
				--DepreciationFinYTD to zero on every roll over) we do not have the necessary data to use the standard 
				--Straight Line calculation method. Hence the general formula we use to calculate the daily depreciation amount is:
				
				--		(CarryingValueOpening - ResidualValue) / RUL in number of days
				
				--We then calculate the depeciation amount by taking the daily depreciation amount and mulptiply that by the number 
				--of days in the depreciation period selected.
				
				--		Depreciation Amount = Daily Depreciation Amount * RUL Number of Days in Period
				
				--Existing assets
				WHEN ((CarryingValueOpening > 0) AND (CarryingValueOpening > ResidualValue) AND (AdditionsFinYTD = 0) AND (TransferCost = 0)) 
					THEN ((CarryingValueOpening - ResidualValue) / ((' + @RUL_CALC + '/12) * DATEDIFF(DAY, @StartDate, @EndDate)))
				--Additions
				WHEN ((CarryingValueOpening = 0) AND (AdditionsFinYTD > ResidualValue) AND (AdditionsFinYTD > 0) AND (TransferCost = 0)) 
					THEN ((AdditionsFinYTD - ResidualValue) / ((' + @RUL_CALC + '/12) * DATEDIFF(DAY, @StartDate, @EndDate)))		
				--Transfers
				WHEN ((CarryingValueOpening = 0) AND (TransferCost > ResidualValue) AND (TransferCost > 0) AND (TransferDepr + ImpairmentTransfer = 0)) 
					THEN ((TransferCost - ResidualValue) / ((' + @RUL_CALC + '/12) * DATEDIFF(DAY, @StartDate, @EndDate)))
				--Refurbishments
				--WHEN (CarryingValueOpening > 0) AND (AdditionsFinYTD > 0 OR TransferCost > 0) 
					--THEN (CarryingValueOpening - ResidualValue) / ((' + @RUL_CALC + '/12) * DATEDIFF(DAY, @StartDate, @EndDate)))
				--Reclassifications
				WHEN ((CarryingValueOpening = 0) AND (TransferCost > 0) AND (TransferDepr + ImpairmentTransfer > ResidualValue) AND (TransferDepr + ImpairmentTransfer <> 0)) 
					THEN ((TransferCost + TransferDepr + ImpairmentTransfer - ResidualValue) / ((' + @RUL_CALC + '/12) * DATEDIFF(DAY, @StartDate, @EndDate)))
				
			END DailyDepr

			, CASE 
				-- DerecognitionDate before RUL=0 Date
				WHEN (DerecognitionDate >= @StartDate) AND (DerecognitionDate <= @IntDeprDate) AND (DerecognitionDate <= DATEADD(MONTH, ' + @RUL_CALC + ', @StartDate)) 
					THEN DATEDIFF(DAY, @StartDate, DerecognitionDate)
				-- RUL=0 Date before Interim Depr Date
				WHEN (@IntDeprDate >= @StartDate) AND (@IntDeprDate > DATEADD(MONTH, ' + @RUL_CALC + ', @StartDate) -1) 
					THEN DATEDIFF(DAY, @StartDate, DATEADD(MONTH, ' + @RUL_CALC + ', @StartDate) -1)
				-- TakeOn Date before Interim Depr Date
				WHEN (TakeOnDate >= @StartDate) AND (TakeOnDate <= @IntDeprDate) AND (AdditionsFinYTD > 0) 
					THEN DATEDIFF(DAY, TakeOnDate, @IntDeprDate)+0
				-- TakeOn Date after Interim Depr Date
				WHEN (TakeOnDate >=  @StartDate) AND (TakeOnDate >  @IntDeprDate) 
					THEN 0 
				-- Else RUL=0 Date must be after Interim Depr Date
				ELSE DATEDIFF(DAY, @StartDate, @IntDeprDate)
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
	--PRINT @SQL;
	
	--Insert corresponding records for SCOADepreciationStatus with Pending Authorisation (4) as status
	SET @SQL = 'INSERT INTO SCOADepreciationStatus (SCOAJournalID, Status) 
				SELECT ID, 4 FROM SCOAJournal WHERE Form_Reference = ' + QUOTENAME(@FormReference,'''')
	EXEC(@SQL)
	--PRINT(@SQL);
END