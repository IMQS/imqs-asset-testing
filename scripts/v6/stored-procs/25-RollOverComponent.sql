CREATE PROCEDURE [dbo].[RollOverComponent] 
	   @CurrentFinYear INT,
	   @ComponentID VARCHAR(40)
  AS

  BEGIN
	SET NOCOUNT ON

	DECLARE @SQL VARCHAR(MAX)
	DECLARE @CurrentFinTableName VARCHAR(30)
	DECLARE @NewFinTableName VARCHAR(30)
	DECLARE @NextFinYear INT

	SET  @NextFinYear = @CurrentFinYear + 1;

	SET  @CurrentFinTableName = 'AssetRegisterIconFin' + CAST(@CurrentFinYear AS VARCHAR(4));
	SET  @NewFinTableName	  = 'AssetRegisterIconFin' + CAST(@NextFinYear AS VARCHAR(4));
	
	SET @SQL = 'INSERT INTO dbo.' + @NewFinTableName +
			' (ComponentID
			,ClientAssetID
			,AssetMoveableID
			,AccountingGroupID
			,AssetCategoryID
			,AssetSubCategoryID
			,AssetGroupID
			,AssetTypeID
			,ComponentType
			,AssetOwnerID
			,AssetFacilityID
			,AssetFacilityName
			,DescriptorType
			,DescriptorSize
			,DescriptorSize_Unit
			,DescriptorClass
			,ComponentDesc
			,Extent
			,Extent_Unit
			,Extent_Unit_Rate
			,NetworkNr
			,WardNr
			,RegionName
			,SuburbName
			,LocationAddress
			,LocationStand
			,LocationSGcode
			,Latitude
			,Longitude
			,MapFeatureID
			,MapFeatureType
			,TreasuryCode
			,CostCentreCode
			,GeneralLedgerCode
			,TakeOnDate
			,MethodAcquiredID
			,OwnedLeasedID
			,SupplierID
			,WIP_Project_ID
			,MeasurementModel
			,FairValue
			,CostOpening
			,CarryingValueOpening
			,FundingSourceID
			,FundingTypeID
			,RespDepartmentID
			,AssetCustodianID
			,CustodianshipDate
			,BasicMunService
			,ApplicableContracts
			,InsurancePolicyNr
			,InsuranceCover
			,DebtSecurityApplicable
			,DebtSecurityExpiryDate
			,YearConstruct
			,YearRenewed
			,DateLastRenewed
			,AdditionsOpening
			,AdditionsFinYTD
			,AdditionsFundSourceID
			,AdditionsFundTypeID
			,AdditionsNature
			,EUL
			,EUL_Adjusted
			,RUL
			,ResidualPct
			,DepreciationMethodID
			,DepreciationOpening
			,DepreciationFinYTD
			,ProvisionOpening
			,ProvisionAdjust
			,CashGenerating
			,DisposalMethodID
			,DisposalProceedCost
			,DerecognitionDate
			,DerecognitionCost
			,DerecognitionDepr
			,ImpairmentFinYTD
			,ImpairmentAll
			,RevImpairmentFinYTD
			,RevImpairmentAll
			,RevaluationLastDate
			,RevaluationNextDate
			,RevaluationMethod
			,CRC
			,RevaluedAmount
			,ValueChangeFinYTD
			,RevaluationReserveOpening
			,RevaluationReserveFinYTD          
			,RevaluationRUL
			,RevaluedBy
			,RevaluationAccuracy
			,CriticalityGrade
			,ConditionGrade
			,PerformanceGrade
			,UtilisationGrade
			,OpsCostGrade
			,RiskExposure
			,ForecastReplValue
			,CRC_Adjusted
			,AnnualisedMaintPct
			,MaintenanceBudgetPct
			,MaintenanceExpenditure
			,DateCreated
			,DateLastFinMonth
			,ImpairmentDate
			,RevImpairmentDate
			,ImpairmentReason
			,RevImpairmentReason
			,Impairment_Review_Date
			,RefSuburbsCode
			,CaseNumber
			,InsuranceClaimed
			,InsuranceAmount
			,TransferredFrom
			,TransferredTo
			,ImpairmentTransfer
			,UseStatusID
			,MeasurementModelID
			,FinHierarchyPath
			,SCOA_Item_Depreciation_Debit
			,SCOA_Item_Depreciation_Credit
			,RevaluationReserveFinYTDImp
			,RevaluationReserveFinYTDDepr
			,VerificationLastDate
			,VerificationNextDate
			--BGV | 2017-07-17 | TA6-899 - BOQ Enhancements
			,BOQPath
			--BGV | 2017-08-08 | TA6-923 Replaced Components field
			,ReplacedComponents
			--BGV | 2017-10-25 | TA6-947 SCOA Setup
			,SCOAAssignmentID
			)

    SELECT  ComponentID
			,ClientAssetID
			,AssetMoveableID
			,AccountingGroupID
			,AssetCategoryID
			,AssetSubCategoryID
			,AssetGroupID
			,AssetTypeID
			,ComponentType
			,AssetOwnerID
			,AssetFacilityID
			,AssetFacilityName
			,DescriptorType
			,DescriptorSize
			,DescriptorSize_Unit
			,DescriptorClass
			,ComponentDesc
			,Extent
			,Extent_Unit
			,Extent_Unit_Rate
			,NetworkNr
			,WardNr
			,RegionName
			,SuburbName
			,LocationAddress
			,LocationStand
			,LocationSGcode
			,Latitude
			,Longitude
			,MapFeatureID
			,MapFeatureType
			,TreasuryCode
			,CostCentreCode
			,GeneralLedgerCode
			,TakeOnDate
			,MethodAcquiredID
			,OwnedLeasedID
			,SupplierID
			,WIP_Project_ID
			,MeasurementModel
			,FairValue
			,CostOpening
			,ISNULL(CarryingValueOpening,0)
			,FundingSourceID
			,FundingTypeID
			,RespDepartmentID
			,AssetCustodianID
			,CustodianshipDate
			,BasicMunService
			,ApplicableContracts
			,InsurancePolicyNr
			,InsuranceCover
			,DebtSecurityApplicable
			,DebtSecurityExpiryDate
			,YearConstruct
			,YearRenewed
			,DateLastRenewed
			,AdditionsOpening
			,AdditionsFinYTD
			,AdditionsFundSourceID
			,AdditionsFundTypeID
			,AdditionsNature
			,EUL
			,EUL_Adjusted
			,RUL
			,ResidualPct
			,DepreciationMethodID
			,DepreciationOpening
			,DepreciationFinYTD
			,ProvisionOpening
			,ProvisionAdjust
			,CashGenerating
			,DisposalMethodID
			,ISNULL(DisposalProceedCost,0)
			,DerecognitionDate
			,DerecognitionCost
			,DerecognitionDepr
			,ISNULL(ImpairmentFinYTD,0)
			,ISNULL(ImpairmentAll,0)
			,RevImpairmentFinYTD
			,RevImpairmentAll
			,RevaluationLastDate
			,RevaluationNextDate
			,RevaluationMethod
			,CRC
			,RevaluedAmount
			,0 --ValueChangeFinYTD
			,RevaluationReserveOpening
			,RevaluationReserveFinYTD
			,RevaluationRUL
			,RevaluedBy
			,RevaluationAccuracy
			,CriticalityGrade
			,ConditionGrade
			,PerformanceGrade
			,UtilisationGrade
			,OpsCostGrade
			,RiskExposure
			,ForecastReplValue
			,CRC_Adjusted
			,AnnualisedMaintPct
			,MaintenanceBudgetPct
			,MaintenanceExpenditure
			,DateCreated
			,DateLastFinMonth
			,ImpairmentDate
			,RevImpairmentDate
			,ImpairmentReason
			,RevImpairmentReason
			,Impairment_Review_Date
			,RefSuburbsCode
			,CaseNumber
			,InsuranceClaimed
			,InsuranceAmount
			,TransferredFrom
			,TransferredTo
			,ISNULL(ImpairmentTransfer,0)
			,UseStatusID
			,MeasurementModelID
			,FinHierarchyPath
			,SCOA_Item_Depreciation_Debit
			,SCOA_Item_Depreciation_Credit
			,RevaluationReserveFinYTDImp
			,RevaluationReserveFinYTDDepr
			,VerificationLastDate
			,VerificationNextDate
			--BGV | 2017-07-17 | TA6-899 - BOQ Enhancements
			,BOQPath
			--BGV | 2017-08-08 | TA6-923 Replaced Components field
			,ReplacedComponents
			--BGV | 2017-10-25 | TA6-947 SCOA Setup
			,SCOAAssignmentID
			
		    FROM dbo.' + @CurrentFinTableName + '
		    WHERE ComponentID = ''' + @ComponentID + '''';
	PRINT @SQL;
	EXEC(@SQL);

	--Default Useful life measurement
	DECLARE @ULM VARCHAR(30)
	DECLARE @Interval VARCHAR(30)

	SET @ULM =''
	SELECT @ULM = UPPER(Value) FROM AssetPolicyGeneral WHERE Section='General' AND Identifier='Useful Life Measure'

	IF @ULM='DAY'
		SET @Interval='365'
	IF @ULM='MONTH'
		SET @Interval='12'
	else
		SET @Interval = '1' 

	--Update the balances
	SET @SQL = ' UPDATE ' + @NewFinTableName +
	              ' SET DepreciationOpening = a.DepreciationClosing ' +
	              ',ImpairmentAll = ISNULL(a.ImpairmentClose,0) ' +
	              ',RevaluationReserveOpening = ISNULL(a.RevaluationReserveClosing,0) ' +
	              ',RUL = CASE WHEN (a.RUL -' + @Interval + ') < 0 THEN 0 ELSE (a.RUL -' + @Interval + ') END ' +
	              ',DepreciationFinYTD = 0 ' +
	              ',ImpairmentFinYTD = 0 ' +
	              ',RevImpairmentFinYTD = 0 ' +
	              ',AdditionsOpening = a.AdditionsClosing ' +
	              ',AdditionsFinYTD = 0 '+ 
	              ',CarryingValueOpening = a.CarryingValueClosing' +
	              ',CostOpening = a.CostClosing ' +
	              ',ProvisionOpening = a.ProvisionClosing ' +
	              ',ProvisionAdjust = 0 ' +
	              ',ImpairmentTransfer = 0 ' +
	              ',ImpairmentDerecog = 0 ' +
	              ',DerecognitionDepr = 0 ' +
	              ',DerecognitionCost = 0 ' +
	              ',TransferCost = 0 ' +
	              ',TransferDepr = 0 ' +
	              ',ValueChangeFinYTD = 0 ' +
	              ',DisposalProceedCost = 0 ' +
	              ',RevaluationReserveFinYTD = 0 ' +
	              'FROM '  + @CurrentFinTableName + ' a ' +
	              'WHERE ' + @NewFinTableName + '.ComponentID = a.ComponentID  AND a.ComponentID = ''' + @ComponentID + '''';
	EXEC(@SQL);
	
	--Roll over RUL 
    DECLARE @StartOfYear VARCHAR(MAX)
	DECLARE @EndOfYear VARCHAR(MAX)
	DECLARE @EULMeasure VARCHAR(MAX)
	DECLARE @TargetFinYear INT = @CurrentFinYear + 1
	SELECT @EULMeasure = UPPER(Value) FROM AssetPolicyGeneral WHERE Section='General' AND Identifier='Useful Life Measure'
	

	SET @StartOfYear = '01-JUL-'+ CAST(@CurrentFinYear-1 AS VARCHAR(4))
	SET @EndOfYear = '30-JUN-'+CAST(@CurrentFinYear AS VARCHAR(4))
	
	IF @EULMeasure='YEAR'
	BEGIN
		PRINT 'roll_over_rul_year' + @EndOfYear + ',' + @StartOfYear
		EXEC roll_over_rul_year @TargetFinYear, @EndOfYear, @StartOfYear, @EndOfYear, @ComponentID
	END
	ELSE
	IF @EULMeasure='MONTH'
	BEGIN
		PRINT 'roll_over_rul_month' + @EndOfYear + ',' + @StartOfYear
		EXEC roll_over_rul_month @TargetFinYear, @EndOfYear, @StartOfYear, @EndOfYear, @ComponentID
	END
END