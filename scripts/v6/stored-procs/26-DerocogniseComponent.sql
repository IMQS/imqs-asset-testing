CREATE  procedure [dbo].[DerecogniseComponent] 
	@FinYear INT,
	@ComponentID VARCHAR(40),
	@RemoveFromFollwingYear bit = 0
	
AS

BEGIN
	 -- SET NOCOUNT ON added to prevent extra result sets from
	 -- interfering with SELECT statements.
	 SET NOCOUNT ON

	 DECLARE @SQL VARCHAR(MAX)
	 DECLARE @CurrentFinTableName VARCHAR(30)
	 DECLARE @NextFinTableName VARCHAR(30)

	 SET @CurrentFinTableName = 'AssetRegisterIconFin' + CAST(@FinYear AS VARCHAR(4));
	 SET @NextFinTableName	  =	'AssetRegisterIconFin' + CAST(@FinYear + 1 AS VARCHAR(4));

	 --Insert Component into the Dercognised Asset Register
	 SET @SQL = 'INSERT INTO AssetRegisterDerecognitions 
		    (ComponentID
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
			,ImpairmentDerecog
			,RevImpairmentFinYTD
			,RevImpairmentAll
			,RevaluationLastDate
			,RevaluationNextDate
			,RevaluationMethod
			,CRC
			,RevaluedAmount
			,ValueChangeFinYTD
			,RevaluationReserve
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
			,MaintenanceBudgetNeed
			,MaintenanceBudgetPct
			,MaintenanceExpenditure
			,DateCreated
			,DateLastFinMonth
			,FinYear
			,TransferCost
			,TransferDepr
			,RefSuburbsCode
			,CaseNumber
			,InsuranceClaimed
			,InsuranceAmount
			,TransferredFrom
			,TransferredTo
			,UseStatusID
			,FinHierarchyPath
			,SCOA_Item_Depreciation_Debit
			,SCOA_Item_Depreciation_Credit
			,RevaluationReserveFinYTDImp
			,RevaluationReserveFinYTDDepr
			,VerificationLastDate
			,VerificationNextDate
			--BGV | 2017-10-25 | TA6-947 SCOA Setup
			,SCOAAssignmentID
			)

	 SELECT ComponentID
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
			,ImpairmentDerecog
			,RevImpairmentFinYTD
			,RevImpairmentAll
			,RevaluationLastDate
			,RevaluationNextDate
			,RevaluationMethod
			,CRC
			,RevaluedAmount
			,ValueChangeFinYTD
			,RevaluationReserveClosing AS RevaluationReserve
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
			,MaintenanceBudgetNeed
			,MaintenanceBudgetPct
			,MaintenanceExpenditure
			,DateCreated
			,DateLastFinMonth 
			,' + CAST(@FinYear as varchar(4)) + '
			,ISNULL(TransferCost,0)
			,ISNULL(TransferDepr,0)
			,RefSuburbsCode
			,CaseNumber
			,InsuranceClaimed
			,InsuranceAmount
			,TransferredFrom
			,TransferredTo 
			,UseStatusID
			,FinHierarchyPath
			,SCOA_Item_Depreciation_Debit
			,SCOA_Item_Depreciation_Credit
			,RevaluationReserveFinYTDImp
			,RevaluationReserveFinYTDDepr
			,VerificationLastDate
			,VerificationNextDate
			--BGV | 2017-10-25 | TA6-947 SCOA Setup
			,SCOAAssignmentID
			
			FROM dbo.' + @CurrentFinTableName +	
			' WHERE ComponentID = ''' + @ComponentID + ''''; 
			
	BEGIN TRANSACTION [Tran1]
	BEGIN TRY		
		--Insert Component into the Dercognised Asset Register
		EXEC(@SQL);
		    
		--Remove Component for the Next Financial Year
		IF @RemoveFromFollwingYear = 1
		BEGIN
			SET @SQL = 'DELETE FROM ' + @NextFinTableName + ' WHERE ComponentID = ''' + @ComponentID + '''';
			EXEC(@SQL);
		END
		
		COMMIT TRANSACTION [Tran1]

	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION [Tran1];
		---raise the error
		DECLARE @ErrorMessage NVARCHAR(MAX), @ErrorSeverity INT, @ErrorState INT;
		SELECT @ErrorMessage = ERROR_MESSAGE() + ' Line ' + cast(ERROR_LINE() as nvarchar(5)), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE();
		RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);  
	END CATCH
	
END