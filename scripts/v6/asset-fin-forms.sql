-- Asset Financial Forms are used to deliver asset component data between registers ans states

IF OBJECT_ID (N'InputFormView', N'V') IS NOT NULL DROP View [dbo].[InputFormView];
IF OBJECT_ID (N'AssetFinFormBatch', N'U') IS NOT NULL DROP TABLE [AssetFinFormBatch];
IF OBJECT_ID (N'AssetFinFormRef', N'U') IS NOT NULL DROP TABLE [AssetFinFormRef];
IF OBJECT_ID (N'AssetFinFormInput', N'U') IS NOT NULL DROP TABLE [AssetFinFormInput];
IF OBJECT_ID (N'AssetFinFormState', N'U') IS NOT NULL DROP TABLE [AssetFinFormState];
IF OBJECT_ID (N'AssetFinForm', N'U') IS NOT NULL DROP TABLE [AssetFinForm];


CREATE TABLE [dbo].[AssetFinFormBatch](
	[BatchNr] [int] IDENTITY(1,1) NOT NULL,
	[DT_CREATED] [datetime] NOT NULL,
	[CREATED_BY] [varchar](30) NULL,
	[Information] [varchar](max) NULL,
	[Instructions] [varchar](max) NULL,
	CONSTRAINT [PK_AssetFinFormBatch] PRIMARY KEY CLUSTERED([BatchNr] ASC)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY];
ALTER TABLE [dbo].[AssetFinFormBatch] ADD [Ext_Batch_Reference] [varchar](40) NULL;
ALTER TABLE [dbo].[AssetFinFormBatch] ADD  CONSTRAINT [DF_AssetFinFormBatch_DT_CREATED]  DEFAULT (getdate()) FOR [DT_CREATED];
CREATE UNIQUE NONCLUSTERED INDEX [Idx_Ext_Batch_Reference] ON  [dbo].[AssetFinFormBatch] ([Ext_Batch_Reference]);

------- AssetFinFormBatch INSERTS --------
SET IDENTITY_INSERT [AssetFinFormBatch] ON;
INSERT
	[dbo].[AssetFinFormBatch] ([BatchNr], [Ext_Batch_Reference],[DT_CREATED], [CREATED_BY], [Information], [Instructions]) 
VALUES 
	(001, N'P000000001', CAST(N'2013-09-25 10:10:31.050' AS DateTime), N'ADMIN', N'', N'');

-- P000000011 - This batch has 3 input forms (for the purpose of testing that the status gets changed for all 3 forms)
INSERT
	[dbo].[AssetFinFormBatch] ([BatchNr], [Ext_Batch_Reference],[DT_CREATED], [CREATED_BY], [Information], [Instructions]) 
VALUES 
	(011, N'P000000011', CAST(N'2013-09-25 10:10:31.050' AS DateTime), N'ADMIN', N'', N'');
-- Add test batch for scoa
INSERT INTO AssetFinFormBatch ([BatchNr], [DT_CREATED], [CREATED_BY], [Information], [Instructions], [Ext_Batch_Reference]) values (5647, GETDATE(), 'ImqsAdmin', 'SCOA Test Batch', 'Use this batch for automated testing', 'P5647');
SET IDENTITY_INSERT [AssetFinFormBatch] OFF;



CREATE TABLE [dbo].[AssetFinFormInput](
	[Batch_Reference] [varchar](15) NOT NULL,
	[Form_Reference] [int] IDENTITY(1,1) NOT NULL,
	[ComponentID] [varchar](40) NOT NULL,
	[ClientAssetID] [varchar](40) NULL,
	[AssetMoveableID] [varchar](4) NULL,
	[AccountingGroupID] [varchar](4) NULL,
	[AssetCategoryID] [varchar](4) NULL,
	[AssetSubCategoryID] [varchar](4) NULL,
	[AssetGroupID] [varchar](4) NULL,
	[AssetTypeID] [varchar](4) NULL,
	[ComponentType] [varchar](4) NULL,
	[AssetOwnerID] [varchar](4) NULL,
	[AssetFacilityID] [int] NULL,
	[AssetFacilityName] [varchar](150) NULL,
	[DescriptorType] [varchar](80) NULL,
	[DescriptorSize] [numeric](18, 2) NULL,
	[DescriptorSize_Unit] [varchar](40) NULL,
	[DescriptorClass] [varchar](40) NULL,
	[ComponentDesc] [varchar](150) NULL,
	[Extent] [numeric](18, 2) NULL,
	[Extent_Unit] [varchar](40) NULL,
	[Extent_Unit_Rate] [numeric](18, 2) NULL,
	[NetworkNr] [int] NULL,
	[WardNr] [int] NULL,
	[RegionName] [varchar](40) NULL,
	[SuburbName] [varchar](40) NULL,
	[LocationAddress] [varchar](80) NULL,
	[LocationStand] [varchar](32) NULL,
	[LocationSGcode] [varchar](32) NULL,
	[Latitude] [numeric](18, 6) NULL,
	[Longitude] [numeric](18, 6) NULL,
	[MapFeatureID] [varchar](80) NULL,
	[MapFeatureType] [int] NULL,
	[TreasuryCode] [varchar](40) NULL,
	[CostCentreCode] [varchar](40) NULL,
	[GeneralLedgerCode] [varchar](40) NULL,
	[TakeOnDate] [datetime] NULL,
	[MethodAcquiredID] [varchar](4) NULL,
	[OwnedLeasedID] [varchar](4) NULL,
	[SupplierID] [varchar](40) NULL,
	[WIP_Project_ID] [varchar](40) NULL,
	[MeasurementModel] [varchar](40) NULL,
	[CostPrice] [numeric](18, 2) NULL,
	[FairValue] [numeric](18, 2) NULL,
	[CostOpening] [numeric](18, 2) NULL,
	[CostClosing] [numeric](18, 2) NULL,
	[CarryingValueOpening] [numeric](18, 2) NULL,
	[CarryingValueClosing] [numeric](18, 2) NULL,
	[FundingSourceID] [varchar](30) NULL,
	[FundingTypeID] [varchar](30) NULL,
	[RespDepartmentID] [varchar](40) NULL,
	[AssetCustodianID] [varchar](40) NULL,
	[CustodianshipDate] [datetime] NULL,
	[BasicMunService] [varchar](4) NULL,
	[ApplicableContracts] [varchar](40) NULL,
	[InsurancePolicyNr] [varchar](40) NULL,
	[InsuranceCover] [numeric](18, 2) NULL,
	[DebtSecurityApplicable] [bit] NULL,
	[DebtSecurityExpiryDate] [datetime] NULL,
	[YearConstruct] [int] NULL,
	[YearRenewed] [int] NULL,
	[DateLastRenewed] [datetime] NULL,
	[AdditionsOpening] [numeric](18, 2) NULL,
	[AdditionsFinYTD] [numeric](18, 2) NULL,
	[AdditionsClosing] [numeric](18, 2) NULL,
	[AdditionsFundSourceID] [varchar](20) NULL,
	[AdditionsFundTypeID] [varchar](20) NULL,
	[AdditionsNature] [varchar](20) NULL,
	[EUL] [int] NULL,
	[EUL_Adjusted] [int] NULL,
	[RUL] [numeric](18, 2) NULL,
	[ResidualPct] [numeric](18, 2) NULL,
	[ResidualValue] [numeric](18, 2) NULL,
	[DepreciationMethodID] [varchar](4) NULL,
	[DepreciationOpening] [numeric](18, 2) NULL,
	[DepreciationFinYTD] [numeric](18, 2) NULL,
	[DepreciationClosing] [numeric](18, 2) NULL,
	[ProvisionOpening] [numeric](18, 2) NULL,
	[ProvisionAdjust] [numeric](18, 2) NULL,
	[ProvisionClosing] [numeric](18, 2) NULL,
	[CashGenerating] [varchar](4) NULL,
	[DisposalMethodID] [varchar](4) NULL,
	[DisposalProceedCost] [numeric](18, 2) NULL,
	[DisposalProfitLoss] [numeric](18, 2) NULL,
	[DerecognitionDate] [datetime] NULL,
	[DerecognitionCost] [numeric](18, 2) NULL,
	[DerecognitionDepr] [numeric](18, 2) NULL,
	[ImpairmentFinYTD] [numeric](18, 2) NULL,
	[RevImpairmentFinYTD] [numeric](18, 2) NULL,
	[RevaluationLastDate] [datetime] NULL,
	[RevaluationNextDate] [datetime] NULL,
	[RevaluationMethod] [varchar](4) NULL,
	[CRC] [numeric](18, 2) NULL,
	[RevaluedAmount] [numeric](18, 2) NULL,
	[ValueChangeFinYTD] [numeric](18, 2) NULL,
	[RevaluationRUL] [int] NULL,
	[RevaluedBy] [varchar](40) NULL,
	[RevaluationAccuracy] [int] NULL,
	[CriticalityGrade] [int] NULL,
	[ConditionGrade] [int] NULL,
	[PerformanceGrade] [int] NULL,
	[UtilisationGrade] [int] NULL,
	[OpsCostGrade] [int] NULL,
	[RiskExposure] [int] NULL,
	[ForecastReplYear] [int] NULL,
	[ForecastReplValue] [numeric](18, 2) NULL,
	[CRC_Adjusted] [numeric](18, 2) NULL,
	[DRC] [numeric](18, 2) NULL,
	[AnnualisedMaintPct] [numeric](18, 2) NULL,
	[MaintenanceBudgetNeed] [numeric](18, 2) NULL,
	[MaintenanceBudgetPct] [numeric](18, 2) NULL,
	[MaintenanceExpenditure] [numeric](18, 2) NULL,
	[DateCreated] [datetime] NULL,
	[DateLastFinMonth] [datetime] NULL,
	[ImpairmentAll] [numeric](18, 2) NULL,
	[RevImpairmentAll] [numeric](18, 2) NULL,
	[Asset_Barcode_Nr] [varchar](40) NULL,
	[Room_Barcode_Nr] [varchar](40) NULL,
	[Room_Number] [varchar](40) NULL,
	[Building_Name] [varchar](40) NULL,
	[Serial_Number] [varchar](40) NULL,
	[Fleet_Number] [varchar](32) NULL,
	[Fleet_Reg_Year] [int] NULL,
	[Treasury_Code] [varchar](30) NULL,
	[Cost_Centre] [varchar](40) NULL,
	[Acquisition_Date] [datetime] NULL,
	[Impairment_Test_Date] [datetime] NULL,
	[Impairment_Review_Date] [datetime] NULL,
	[EUL_Review_Date] [datetime] NULL,
	[RV_Review_Date] [datetime] NULL,
	[Depr_Review_Date] [datetime] NULL,
	[Condition_Review_Date] [datetime] NULL,
	[Resp_CostCentre_ID] [int] NULL,
	[Maint_CostCentre_ID] [int] NULL,
	[PLANT_ID] [int] NULL,
	[WorkCentre_ID] [int] NULL,
	[LOC_ID] [int] NULL,
	[CriticalityGrade_CG] [int] NULL,
	[ConditionGrade_CG] [int] NULL,
	[PerformanceGrade_CG] [int] NULL,
	[UtilisationGrade_CG] [int] NULL,
	[OpsCostGrade_CG] [int] NULL,
	[YearConstruct_CG] [int] NULL,
	[YearRenewed_CG] [int] NULL,
	[ImpairmentDerecog] [numeric](18, 2) NULL,
	[FairValueLessCostSell] [numeric](18, 2) NULL,
	[ValueInUse] [numeric](18, 2) NULL,
	[ImpairmentDate] [datetime] NULL,
	[RevImpairmentDate] [datetime] NULL,
	[ImpairmentReason] [varchar](4) NULL,
	[RevImpairmentReason] [varchar](4) NULL,
	[TransferCost] [numeric](18, 2) NULL,
	[TransferDepr] [numeric](18, 2) NULL,
	[TransferDate] [datetime] NULL,
	[ImpairmentClose] [numeric](18, 2) NULL,
	[RevaluationReserveOpening] [numeric](18, 2) NOT NULL,
	[RevaluationReserveFinYTD] [numeric](18, 2) NOT NULL,
	[RevaluationReserveClosing] [numeric](18, 2) NOT NULL,
	[RefSuburbsCode] [varchar](20) NULL,
	[CaseNumber] [varchar](40) NULL,
	[InsuranceClaimed] [bit] NULL,
	[InsuranceAmount] [numeric](18, 2) NULL,
	[TransferredFrom] [varchar](40) NULL,
	[TransferredTo] [varchar](40) NULL,
	[EquipmentNr] [varchar](18) NULL,
	[ImpairmentTransfer] [numeric](18, 2) NOT NULL,
	[SCOA_Fund] [varchar](40) NULL,
	[SCOA_Function] [varchar](40) NULL,
	[SCOA_Mun_Classification] [varchar](40) NULL,
	[SCOA_Project] [varchar](40) NULL,
	[SCOA_Costing] [varchar](40) NULL,
	[SCOA_Region] [varchar](40) NULL,
	[SCOA_ItemAsset] [varchar](40) NULL,
	[SCOA_Item_Depreciation_Debit] [varchar](40) NULL,
	[SCOA_Item_Depreciation_Credit] [varchar](40) NULL,
	[MeasurementModelID] [varchar](4) NULL,
	[UseStatusID] [varchar](4) NULL,
	[FinHierarchyPath] [varchar](100) NULL,
	[RevaluationReserveFinYTDImp] [numeric](18, 2) NOT NULL,
	[RevaluationReserveFinYTDDepr] [numeric](18, 2) NOT NULL,
	[VerificationLastDate] [datetime] NULL,
	[VerificationNextDate] [datetime] NULL,
	[FinYear] [int] NULL,
	[UpgradeDate] [datetime] NULL,
	[BudgetNr] [varchar](40) NULL,
	[LastMaintenanceDate] [datetime] NULL,
	CONSTRAINT [PK_AssetFinFormInput] PRIMARY KEY CLUSTERED([Form_Reference] ASC)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
ALTER TABLE [dbo].[AssetFinFormInput] ADD  CONSTRAINT [DF_AssetFinFormInput_CostCentreCode]  DEFAULT ('Not Specified') FOR [CostCentreCode];
ALTER TABLE [dbo].[AssetFinFormInput] ADD  CONSTRAINT [DF_AssetFinFormInput_GeneralLedgerCode]  DEFAULT ('Not Specified') FOR [GeneralLedgerCode];
ALTER TABLE [dbo].[AssetFinFormInput] ADD  CONSTRAINT [DF_AssetFinFormInput_RespDepartmentID]  DEFAULT ('Not Specified') FOR [RespDepartmentID];
ALTER TABLE [dbo].[AssetFinFormInput] ADD  DEFAULT ((0)) FOR [RevaluationReserveOpening];
ALTER TABLE [dbo].[AssetFinFormInput] ADD  DEFAULT ((0)) FOR [RevaluationReserveFinYTD];
ALTER TABLE [dbo].[AssetFinFormInput] ADD  DEFAULT ((0)) FOR [RevaluationReserveClosing];
ALTER TABLE [dbo].[AssetFinFormInput] ADD  DEFAULT ((0)) FOR [ImpairmentTransfer];
ALTER TABLE [dbo].[AssetFinFormInput] ADD  DEFAULT ((0)) FOR [RevaluationReserveFinYTDImp];
ALTER TABLE [dbo].[AssetFinFormInput] ADD  DEFAULT ((0)) FOR [RevaluationReserveFinYTDDepr];

------- AssetFinFormInput INSERTS --------
SET IDENTITY_INSERT [AssetFinFormInput] ON;
INSERT [dbo].[AssetFinFormInput](
[Batch_Reference], [Form_Reference], [ComponentID], [ClientAssetID], [AssetMoveableID], [AccountingGroupID], [AssetCategoryID], [AssetSubCategoryID], [AssetGroupID], [AssetTypeID], [ComponentType], [AssetOwnerID],
[AssetFacilityID], [AssetFacilityName], [DescriptorType], [DescriptorSize], [DescriptorSize_Unit], [DescriptorClass], [ComponentDesc], [Extent], [Extent_Unit], [Extent_Unit_Rate], [NetworkNr], [WardNr], [RegionName],
[SuburbName], [LocationAddress], [LocationStand], [LocationSGcode], [Latitude], [Longitude], [MapFeatureID], [MapFeatureType], [TreasuryCode], [CostCentreCode], [GeneralLedgerCode], [TakeOnDate], [MethodAcquiredID],
[OwnedLeasedID], [SupplierID], [WIP_Project_ID], [MeasurementModel], [CostPrice], [FairValue], [CostOpening], [CostClosing], [CarryingValueOpening], [CarryingValueClosing], [FundingSourceID], [FundingTypeID],
[RespDepartmentID], [AssetCustodianID], [CustodianshipDate], [BasicMunService], [ApplicableContracts], [InsurancePolicyNr], [InsuranceCover], [DebtSecurityApplicable], [DebtSecurityExpiryDate], [YearConstruct],
[YearRenewed], [DateLastRenewed], [AdditionsOpening], [AdditionsFinYTD], [AdditionsClosing], [AdditionsFundSourceID], [AdditionsFundTypeID], [AdditionsNature], [EUL], [EUL_Adjusted], [RUL], [ResidualPct],
[ResidualValue], [DepreciationMethodID], [DepreciationOpening], [DepreciationFinYTD], [DepreciationClosing], [ProvisionOpening], [ProvisionAdjust], [ProvisionClosing], [CashGenerating], [DisposalMethodID],
[DisposalProceedCost], [DisposalProfitLoss], [DerecognitionDate], [DerecognitionCost], [DerecognitionDepr], [ImpairmentFinYTD], [RevImpairmentFinYTD], [RevaluationLastDate], [RevaluationNextDate], [RevaluationMethod],
[CRC], [RevaluedAmount], [ValueChangeFinYTD], [RevaluationRUL], [RevaluedBy], [RevaluationAccuracy], [CriticalityGrade], [ConditionGrade], [PerformanceGrade], [UtilisationGrade], [OpsCostGrade],
[RiskExposure], [ForecastReplYear], [ForecastReplValue], [CRC_Adjusted], [DRC], [AnnualisedMaintPct], [MaintenanceBudgetNeed], [MaintenanceBudgetPct], [MaintenanceExpenditure], [DateCreated], [DateLastFinMonth],
[ImpairmentAll], [RevImpairmentAll], [Asset_Barcode_Nr], [Room_Barcode_Nr], [Room_Number], [Building_Name], [Serial_Number], [Fleet_Number], [Fleet_Reg_Year], [Treasury_Code], [Cost_Centre], [Acquisition_Date],
[Impairment_Test_Date], [Impairment_Review_Date], [EUL_Review_Date], [RV_Review_Date], [Depr_Review_Date], [Condition_Review_Date], [Resp_CostCentre_ID], [Maint_CostCentre_ID], [PLANT_ID], [WorkCentre_ID], [LOC_ID],
[CriticalityGrade_CG], [ConditionGrade_CG], [PerformanceGrade_CG], [UtilisationGrade_CG], [OpsCostGrade_CG], [YearConstruct_CG], [YearRenewed_CG], [ImpairmentDerecog], [FairValueLessCostSell], [ValueInUse], [ImpairmentDate],
[RevImpairmentDate], [ImpairmentReason], [RevImpairmentReason], [TransferCost], [TransferDepr], [TransferDate], [RevaluationReserveOpening], [RevaluationReserveFinYTD], [RevaluationReserveClosing], [RefSuburbsCode],
[CaseNumber], [InsuranceClaimed], [InsuranceAmount], [TransferredFrom], [TransferredTo], [EquipmentNr], [ImpairmentTransfer],
[SCOA_Fund], [SCOA_Function], [SCOA_Mun_Classification], [SCOA_Project], [SCOA_Costing], [SCOA_Region], [SCOA_ItemAsset], [FinYear])
VALUES (
	N'P000000001', 1, N'INF_GEN1_WAS60019_ROA1_EAR.4', N'000000989069', N'IMM', N'PPE', N'INF', N'WWTW', N'BAL', N'RDF', N'BLBD', NULL, NULL, N'Test Project', N'', NULL, NULL, N'', N'test_comp1',
	CAST(10.00 AS Numeric(18, 2)), N'EA', CAST(37730.00 AS Numeric(18, 2)), NULL, NULL, 'Dummy - Region 01', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2013-11-15 00:00:00.000' AS DateTime),
	NULL, NULL, NULL, N'TestProject001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2013, NULL, NULL, NULL, CAST(25000.00 AS Numeric(18, 2)),
	NULL, NULL, NULL, NULL, 15, NULL, CAST(15.00 AS Numeric(18, 2)), 0, CAST(0.00 AS Numeric(18, 2)), N'ZJW1', NULL, CAST(0.00 AS Numeric(18, 2)), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
	NULL, NULL, NULL, NULL, NULL, NULL, CAST(377300.00 AS Numeric(18, 2)), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(377300.00 AS Numeric(18, 2)), NULL,
	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'comp1', NULL, NULL, NULL, N'78987', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 78987, 78987, 78987, 1, 99092, NULL, NULL, NULL, NULL, NULL,
	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), NULL, NULL, NULL, NULL, NULL, NULL,
	N'240612638294574528', CAST(0.00 AS Numeric(18, 2)), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2015
);
INSERT [dbo].[AssetFinFormInput](
[Batch_Reference],
[Form_Reference], [ComponentID], [ClientAssetID], [AssetMoveableID], [AccountingGroupID], [AssetCategoryID], [AssetSubCategoryID], [AssetGroupID], [AssetTypeID], [ComponentType], [AssetOwnerID],
[AssetFacilityID], [AssetFacilityName], [DescriptorType], [DescriptorSize], [DescriptorSize_Unit], [DescriptorClass], [ComponentDesc], [Extent], [Extent_Unit], [Extent_Unit_Rate], [NetworkNr], [WardNr], [RegionName],
[SuburbName], [LocationAddress], [LocationStand], [LocationSGcode], [Latitude], [Longitude], [MapFeatureID], [MapFeatureType], [TreasuryCode], [CostCentreCode], [GeneralLedgerCode], [TakeOnDate], [MethodAcquiredID],
[OwnedLeasedID], [SupplierID], [WIP_Project_ID], [MeasurementModel], [CostPrice], [FairValue], [CostOpening], [CostClosing], [CarryingValueOpening], [CarryingValueClosing], [FundingSourceID], [FundingTypeID],
[RespDepartmentID], [AssetCustodianID], [CustodianshipDate], [BasicMunService], [ApplicableContracts], [InsurancePolicyNr], [InsuranceCover], [DebtSecurityApplicable], [DebtSecurityExpiryDate], [YearConstruct],
[YearRenewed], [DateLastRenewed], [AdditionsOpening], [AdditionsFinYTD], [AdditionsClosing], [AdditionsFundSourceID], [AdditionsFundTypeID], [AdditionsNature], [EUL], [EUL_Adjusted], [RUL], [ResidualPct],
[ResidualValue], [DepreciationMethodID], [DepreciationOpening], [DepreciationFinYTD], [DepreciationClosing], [ProvisionOpening], [ProvisionAdjust], [ProvisionClosing], [CashGenerating], [DisposalMethodID],
[DisposalProceedCost], [DisposalProfitLoss], [DerecognitionDate], [DerecognitionCost], [DerecognitionDepr], [ImpairmentFinYTD], [RevImpairmentFinYTD], [RevaluationLastDate], [RevaluationNextDate], [RevaluationMethod],
[CRC], [RevaluedAmount], [ValueChangeFinYTD], [RevaluationRUL], [RevaluedBy], [RevaluationAccuracy], [CriticalityGrade], [ConditionGrade], [PerformanceGrade], [UtilisationGrade], [OpsCostGrade],
[RiskExposure], [ForecastReplYear], [ForecastReplValue], [CRC_Adjusted], [DRC], [AnnualisedMaintPct], [MaintenanceBudgetNeed], [MaintenanceBudgetPct], [MaintenanceExpenditure], [DateCreated], [DateLastFinMonth],
[ImpairmentAll], [RevImpairmentAll], [Asset_Barcode_Nr], [Room_Barcode_Nr], [Room_Number], [Building_Name], [Serial_Number], [Fleet_Number], [Fleet_Reg_Year], [Treasury_Code], [Cost_Centre], [Acquisition_Date],
[Impairment_Test_Date], [Impairment_Review_Date], [EUL_Review_Date], [RV_Review_Date], [Depr_Review_Date], [Condition_Review_Date], [Resp_CostCentre_ID], [Maint_CostCentre_ID], [PLANT_ID], [WorkCentre_ID], [LOC_ID],
[CriticalityGrade_CG], [ConditionGrade_CG], [PerformanceGrade_CG], [UtilisationGrade_CG], [OpsCostGrade_CG], [YearConstruct_CG], [YearRenewed_CG], [ImpairmentDerecog], [FairValueLessCostSell], [ValueInUse], [ImpairmentDate],
[RevImpairmentDate], [ImpairmentReason], [RevImpairmentReason], [TransferCost], [TransferDepr], [TransferDate], [RevaluationReserveOpening], [RevaluationReserveFinYTD], [RevaluationReserveClosing], [RefSuburbsCode],
[CaseNumber], [InsuranceClaimed], [InsuranceAmount], [TransferredFrom], [TransferredTo], [EquipmentNr], [ImpairmentTransfer],
[SCOA_Fund], [SCOA_Function], [SCOA_Mun_Classification], [SCOA_Project], [SCOA_Costing], [SCOA_Region], [SCOA_ItemAsset], [FinYear])
VALUES (
	N'P000000011', 11, N'INF_GEN1_WAS60019_ROA1_EAR.5', N'000000989069', N'IMM', N'PPE', N'INF', N'WWTW', N'BAL', N'RDF', N'BLBD', NULL, NULL, N'Test Project', N'', NULL, NULL, N'', N'test_comp1',
	CAST(10.00 AS Numeric(18, 2)), N'EA', CAST(37730.00 AS Numeric(18, 2)), NULL, NULL, 'Dummy - Region 01', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2013-11-15 00:00:00.000' AS DateTime),
	NULL, NULL, NULL, N'TestProject001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2013, NULL, NULL, NULL, CAST(25000.00 AS Numeric(18, 2)),
	NULL, NULL, NULL, NULL, 15, NULL, CAST(15.00 AS Numeric(18, 2)), 0, CAST(0.00 AS Numeric(18, 2)), N'ZJW1', NULL, CAST(0.00 AS Numeric(18, 2)), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
	NULL, NULL, NULL, NULL, NULL, NULL, CAST(377300.00 AS Numeric(18, 2)), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(377300.00 AS Numeric(18, 2)), NULL,
	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'comp1', NULL, NULL, NULL, N'78987', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 78987, 78987, 78987, 1, 99092, NULL, NULL, NULL, NULL, NULL,
	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), NULL, NULL, NULL, NULL, NULL, NULL,
	N'240612638294574528', CAST(0.00 AS Numeric(18, 2)), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2015
);
INSERT [dbo].[AssetFinFormInput](
[Batch_Reference], [Form_Reference], [ComponentID], [ClientAssetID], [AssetMoveableID], [AccountingGroupID], [AssetCategoryID], [AssetSubCategoryID], [AssetGroupID], [AssetTypeID], [ComponentType], [AssetOwnerID],
[AssetFacilityID], [AssetFacilityName], [DescriptorType], [DescriptorSize], [DescriptorSize_Unit], [DescriptorClass], [ComponentDesc], [Extent], [Extent_Unit], [Extent_Unit_Rate], [NetworkNr], [WardNr], [RegionName],
[SuburbName], [LocationAddress], [LocationStand], [LocationSGcode], [Latitude], [Longitude], [MapFeatureID], [MapFeatureType], [TreasuryCode], [CostCentreCode], [GeneralLedgerCode], [TakeOnDate], [MethodAcquiredID],
[OwnedLeasedID], [SupplierID], [WIP_Project_ID], [MeasurementModel], [CostPrice], [FairValue], [CostOpening], [CostClosing], [CarryingValueOpening], [CarryingValueClosing], [FundingSourceID], [FundingTypeID],
[RespDepartmentID], [AssetCustodianID], [CustodianshipDate], [BasicMunService], [ApplicableContracts], [InsurancePolicyNr], [InsuranceCover], [DebtSecurityApplicable], [DebtSecurityExpiryDate], [YearConstruct],
[YearRenewed], [DateLastRenewed], [AdditionsOpening], [AdditionsFinYTD], [AdditionsClosing], [AdditionsFundSourceID], [AdditionsFundTypeID], [AdditionsNature], [EUL], [EUL_Adjusted], [RUL], [ResidualPct],
[ResidualValue], [DepreciationMethodID], [DepreciationOpening], [DepreciationFinYTD], [DepreciationClosing], [ProvisionOpening], [ProvisionAdjust], [ProvisionClosing], [CashGenerating], [DisposalMethodID],
[DisposalProceedCost], [DisposalProfitLoss], [DerecognitionDate], [DerecognitionCost], [DerecognitionDepr], [ImpairmentFinYTD], [RevImpairmentFinYTD], [RevaluationLastDate], [RevaluationNextDate], [RevaluationMethod],
[CRC], [RevaluedAmount], [ValueChangeFinYTD], [RevaluationRUL], [RevaluedBy], [RevaluationAccuracy], [CriticalityGrade], [ConditionGrade], [PerformanceGrade], [UtilisationGrade], [OpsCostGrade],
[RiskExposure], [ForecastReplYear], [ForecastReplValue], [CRC_Adjusted], [DRC], [AnnualisedMaintPct], [MaintenanceBudgetNeed], [MaintenanceBudgetPct], [MaintenanceExpenditure], [DateCreated], [DateLastFinMonth],
[ImpairmentAll], [RevImpairmentAll], [Asset_Barcode_Nr], [Room_Barcode_Nr], [Room_Number], [Building_Name], [Serial_Number], [Fleet_Number], [Fleet_Reg_Year], [Treasury_Code], [Cost_Centre], [Acquisition_Date],
[Impairment_Test_Date], [Impairment_Review_Date], [EUL_Review_Date], [RV_Review_Date], [Depr_Review_Date], [Condition_Review_Date], [Resp_CostCentre_ID], [Maint_CostCentre_ID], [PLANT_ID], [WorkCentre_ID], [LOC_ID],
[CriticalityGrade_CG], [ConditionGrade_CG], [PerformanceGrade_CG], [UtilisationGrade_CG], [OpsCostGrade_CG], [YearConstruct_CG], [YearRenewed_CG], [ImpairmentDerecog], [FairValueLessCostSell], [ValueInUse], [ImpairmentDate],
[RevImpairmentDate], [ImpairmentReason], [RevImpairmentReason], [TransferCost], [TransferDepr], [TransferDate], [RevaluationReserveOpening], [RevaluationReserveFinYTD], [RevaluationReserveClosing], [RefSuburbsCode],
[CaseNumber], [InsuranceClaimed], [InsuranceAmount], [TransferredFrom], [TransferredTo], [EquipmentNr], [ImpairmentTransfer],
[SCOA_Fund], [SCOA_Function], [SCOA_Mun_Classification], [SCOA_Project], [SCOA_Costing], [SCOA_Region], [SCOA_ItemAsset], [FinYear])
VALUES (
	N'P000000011', 12, N'INF_GEN1_WAS60019_ROA1_EAR.6', N'000000989069', N'IMM', N'PPE', N'INF', N'WWTW', N'BAL', N'RDF', N'BLBD', NULL, NULL, N'Test Project', N'', NULL, NULL, N'', N'test_comp6',
	CAST(10.00 AS Numeric(18, 2)), N'EA', CAST(37730.00 AS Numeric(18, 2)), NULL, NULL, 'Dummy - Region 01', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2013-11-15 00:00:00.000' AS DateTime),
	NULL, NULL, NULL, N'TestProject001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2013, NULL, NULL, NULL, CAST(25000.00 AS Numeric(18, 2)),
	NULL, NULL, NULL, NULL, 15, NULL, CAST(15.00 AS Numeric(18, 2)), 0, CAST(0.00 AS Numeric(18, 2)), N'ZJW1', NULL, CAST(0.00 AS Numeric(18, 2)), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
	NULL, NULL, NULL, NULL, NULL, NULL, CAST(377300.00 AS Numeric(18, 2)), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(377300.00 AS Numeric(18, 2)), NULL,
	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'comp6', NULL, NULL, NULL, N'78987', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 78987, 78987, 78987, 1, 99092, NULL, NULL, NULL, NULL, NULL,
	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), NULL, NULL, NULL, NULL, NULL, NULL,
	N'240612638294574528', CAST(0.00 AS Numeric(18, 2)), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2015
);
INSERT [dbo].[AssetFinFormInput](
[Batch_Reference], [Form_Reference], [ComponentID], [ClientAssetID], [AssetMoveableID], [AccountingGroupID], [AssetCategoryID], [AssetSubCategoryID], [AssetGroupID], [AssetTypeID], [ComponentType], [AssetOwnerID],
[AssetFacilityID], [AssetFacilityName], [DescriptorType], [DescriptorSize], [DescriptorSize_Unit], [DescriptorClass], [ComponentDesc], [Extent], [Extent_Unit], [Extent_Unit_Rate], [NetworkNr], [WardNr], [RegionName],
[SuburbName], [LocationAddress], [LocationStand], [LocationSGcode], [Latitude], [Longitude], [MapFeatureID], [MapFeatureType], [TreasuryCode], [CostCentreCode], [GeneralLedgerCode], [TakeOnDate], [MethodAcquiredID],
[OwnedLeasedID], [SupplierID], [WIP_Project_ID], [MeasurementModel], [CostPrice], [FairValue], [CostOpening], [CostClosing], [CarryingValueOpening], [CarryingValueClosing], [FundingSourceID], [FundingTypeID],
[RespDepartmentID], [AssetCustodianID], [CustodianshipDate], [BasicMunService], [ApplicableContracts], [InsurancePolicyNr], [InsuranceCover], [DebtSecurityApplicable], [DebtSecurityExpiryDate], [YearConstruct],
[YearRenewed], [DateLastRenewed], [AdditionsOpening], [AdditionsFinYTD], [AdditionsClosing], [AdditionsFundSourceID], [AdditionsFundTypeID], [AdditionsNature], [EUL], [EUL_Adjusted], [RUL], [ResidualPct],
[ResidualValue], [DepreciationMethodID], [DepreciationOpening], [DepreciationFinYTD], [DepreciationClosing], [ProvisionOpening], [ProvisionAdjust], [ProvisionClosing], [CashGenerating], [DisposalMethodID],
[DisposalProceedCost], [DisposalProfitLoss], [DerecognitionDate], [DerecognitionCost], [DerecognitionDepr], [ImpairmentFinYTD], [RevImpairmentFinYTD], [RevaluationLastDate], [RevaluationNextDate], [RevaluationMethod],
[CRC], [RevaluedAmount], [ValueChangeFinYTD], [RevaluationRUL], [RevaluedBy], [RevaluationAccuracy], [CriticalityGrade], [ConditionGrade], [PerformanceGrade], [UtilisationGrade], [OpsCostGrade],
[RiskExposure], [ForecastReplYear], [ForecastReplValue], [CRC_Adjusted], [DRC], [AnnualisedMaintPct], [MaintenanceBudgetNeed], [MaintenanceBudgetPct], [MaintenanceExpenditure], [DateCreated], [DateLastFinMonth],
[ImpairmentAll], [RevImpairmentAll], [Asset_Barcode_Nr], [Room_Barcode_Nr], [Room_Number], [Building_Name], [Serial_Number], [Fleet_Number], [Fleet_Reg_Year], [Treasury_Code], [Cost_Centre], [Acquisition_Date],
[Impairment_Test_Date], [Impairment_Review_Date], [EUL_Review_Date], [RV_Review_Date], [Depr_Review_Date], [Condition_Review_Date], [Resp_CostCentre_ID], [Maint_CostCentre_ID], [PLANT_ID], [WorkCentre_ID], [LOC_ID],
[CriticalityGrade_CG], [ConditionGrade_CG], [PerformanceGrade_CG], [UtilisationGrade_CG], [OpsCostGrade_CG], [YearConstruct_CG], [YearRenewed_CG], [ImpairmentDerecog], [FairValueLessCostSell], [ValueInUse], [ImpairmentDate],
[RevImpairmentDate], [ImpairmentReason], [RevImpairmentReason], [TransferCost], [TransferDepr], [TransferDate], [RevaluationReserveOpening], [RevaluationReserveFinYTD], [RevaluationReserveClosing], [RefSuburbsCode],
[CaseNumber], [InsuranceClaimed], [InsuranceAmount], [TransferredFrom], [TransferredTo], [EquipmentNr], [ImpairmentTransfer],
[SCOA_Fund], [SCOA_Function], [SCOA_Mun_Classification], [SCOA_Project], [SCOA_Costing], [SCOA_Region], [SCOA_ItemAsset], [FinYear])
VALUES (
	N'P000000011', 13, N'INF_GEN1_WAS60019_ROA1_EAR.7', N'000000989069', N'IMM', N'PPE', N'INF', N'WWTW', N'BAL', N'RDF', N'BLBD', NULL, NULL, N'Test Project', N'', NULL, NULL, N'', N'test_comp7',
	CAST(10.00 AS Numeric(18, 2)), N'EA', CAST(37730.00 AS Numeric(18, 2)), NULL, NULL, 'Dummy - Region 01', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2013-11-15 00:00:00.000' AS DateTime),
	NULL, NULL, NULL, N'TestProject001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2013, NULL, NULL, NULL, CAST(25000.00 AS Numeric(18, 2)),
	NULL, NULL, NULL, NULL, 15, NULL, CAST(15.00 AS Numeric(18, 2)), 0, CAST(0.00 AS Numeric(18, 2)), N'ZJW1', NULL, CAST(0.00 AS Numeric(18, 2)), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
	NULL, NULL, NULL, NULL, NULL, NULL, CAST(377300.00 AS Numeric(18, 2)), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(377300.00 AS Numeric(18, 2)), NULL,
	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'comp7', NULL, NULL, NULL, N'78987', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 78987, 78987, 78987, 1, 99092, NULL, NULL, NULL, NULL, NULL,
	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), NULL, NULL, NULL, NULL, NULL, NULL,
	N'240612638294574528', CAST(0.00 AS Numeric(18, 2)), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2015
);
-- These 10 assets span 2 different sets of SCOA segment patterns
INSERT [dbo].[AssetFinFormInput] ([Batch_Reference], [Form_Reference], [ComponentID], [ClientAssetID], [AssetMoveableID], [AccountingGroupID], [AssetCategoryID], [AssetSubCategoryID], [AssetGroupID], [AssetTypeID], [ComponentType], [AssetOwnerID], [AssetFacilityID], [AssetFacilityName], [DescriptorType], [DescriptorSize], [DescriptorSize_Unit], [DescriptorClass], [ComponentDesc], [Extent], [Extent_Unit], [Extent_Unit_Rate], [NetworkNr], [WardNr], [RegionName], [SuburbName], [LocationAddress], [LocationStand], [LocationSGcode], [Latitude], [Longitude], [MapFeatureID], [MapFeatureType], [TreasuryCode], [CostCentreCode], [GeneralLedgerCode], [TakeOnDate], [MethodAcquiredID], [OwnedLeasedID], [SupplierID], [WIP_Project_ID], [MeasurementModel], [CostPrice], [FairValue], [CostOpening], [CostClosing], [CarryingValueOpening], [CarryingValueClosing], [FundingSourceID], [FundingTypeID], [RespDepartmentID], [AssetCustodianID], [CustodianshipDate], [BasicMunService], [ApplicableContracts], [InsurancePolicyNr], [InsuranceCover], [DebtSecurityApplicable], [DebtSecurityExpiryDate], [YearConstruct], [YearRenewed], [DateLastRenewed], [AdditionsOpening], [AdditionsFinYTD], [AdditionsClosing], [AdditionsFundSourceID], [AdditionsFundTypeID], [AdditionsNature], [EUL], [EUL_Adjusted], [RUL], [ResidualPct], [ResidualValue], [DepreciationMethodID], [DepreciationOpening], [DepreciationFinYTD], [DepreciationClosing], [ProvisionOpening], [ProvisionAdjust], [ProvisionClosing], [CashGenerating], [DisposalMethodID], [DisposalProceedCost], [DisposalProfitLoss], [DerecognitionDate], [DerecognitionCost], [DerecognitionDepr], [ImpairmentFinYTD], [RevImpairmentFinYTD], [RevaluationLastDate], [RevaluationNextDate], [RevaluationMethod], [CRC], [RevaluedAmount], [ValueChangeFinYTD], [RevaluationRUL], [RevaluedBy], [RevaluationAccuracy], [CriticalityGrade], [ConditionGrade], [PerformanceGrade], [UtilisationGrade], [OpsCostGrade], [RiskExposure], [ForecastReplYear], [ForecastReplValue], [CRC_Adjusted], [DRC], [AnnualisedMaintPct], [MaintenanceBudgetNeed], [MaintenanceBudgetPct], [MaintenanceExpenditure], [DateCreated], [DateLastFinMonth], [ImpairmentAll], [RevImpairmentAll], [Asset_Barcode_Nr], [Room_Barcode_Nr], [Room_Number], [Building_Name], [Serial_Number], [Fleet_Number], [Fleet_Reg_Year], [Treasury_Code], [Cost_Centre], [Acquisition_Date], [Impairment_Test_Date], [Impairment_Review_Date], [EUL_Review_Date], [RV_Review_Date], [Depr_Review_Date], [Condition_Review_Date], [Resp_CostCentre_ID], [Maint_CostCentre_ID], [PLANT_ID], [WorkCentre_ID], [LOC_ID], [CriticalityGrade_CG], [ConditionGrade_CG], [PerformanceGrade_CG], [UtilisationGrade_CG], [OpsCostGrade_CG], [YearConstruct_CG], [YearRenewed_CG], [ImpairmentDerecog], [FairValueLessCostSell], [ValueInUse], [ImpairmentDate], [RevImpairmentDate], [ImpairmentReason], [RevImpairmentReason], [TransferCost], [TransferDepr], [TransferDate], [ImpairmentClose], [RevaluationReserveOpening], [RevaluationReserveFinYTD], [RevaluationReserveClosing], [RefSuburbsCode], [CaseNumber], [InsuranceClaimed], [InsuranceAmount], [TransferredFrom], [TransferredTo], [EquipmentNr], [ImpairmentTransfer], [SCOA_Fund], [SCOA_Function], [SCOA_Mun_Classification], [SCOA_Project], [SCOA_Costing], [SCOA_Region], [SCOA_ItemAsset]) VALUES (N'P000005647', 5152, N'4LNZ_JJFT_DEP60046_PIPW_VALV', NULL, N'IMM', N'PPE', N'4LNZ', N'JJFT', N'DEP', N'PIPW', N'VALV', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(10.00 AS Decimal(18, 2)), N'm', CAST(20.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'Not Specified', N'Not Specified', CAST(N'2017-06-08T00:00:00.0000000' AS DateTime2), NULL, N'OWN', NULL, N'{C39D211F-3756-4CE6-B1B6-D49CE37BF74F}', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'Not Specified', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2017, NULL, CAST(N'2017-08-06T00:00:00.0000000' AS DateTime2), NULL, CAST(5504.59 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, 100, NULL, CAST(100.00 AS Decimal(18, 2)), 30, CAST(1651.37 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(200.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, CAST(N'2017-08-06T00:00:00.0000000' AS DateTime2), NULL, CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(0.00 AS Decimal(18, 2)), N'5692f970-c29c-4044-80d7-1bcdbdd34348', N'153259f6-1f08-4df3-a474-21a294ba4463', NULL, N'17536636-dbff-4a96-b61f-014a7c691cd1', N'0d191e3b-f2c9-4e9a-8524-8413d38cf9df', N'bb183961-c3fe-4d35-8b0f-732a88cfd3da', NULL)
INSERT [dbo].[AssetFinFormInput] ([Batch_Reference], [Form_Reference], [ComponentID], [ClientAssetID], [AssetMoveableID], [AccountingGroupID], [AssetCategoryID], [AssetSubCategoryID], [AssetGroupID], [AssetTypeID], [ComponentType], [AssetOwnerID], [AssetFacilityID], [AssetFacilityName], [DescriptorType], [DescriptorSize], [DescriptorSize_Unit], [DescriptorClass], [ComponentDesc], [Extent], [Extent_Unit], [Extent_Unit_Rate], [NetworkNr], [WardNr], [RegionName], [SuburbName], [LocationAddress], [LocationStand], [LocationSGcode], [Latitude], [Longitude], [MapFeatureID], [MapFeatureType], [TreasuryCode], [CostCentreCode], [GeneralLedgerCode], [TakeOnDate], [MethodAcquiredID], [OwnedLeasedID], [SupplierID], [WIP_Project_ID], [MeasurementModel], [CostPrice], [FairValue], [CostOpening], [CostClosing], [CarryingValueOpening], [CarryingValueClosing], [FundingSourceID], [FundingTypeID], [RespDepartmentID], [AssetCustodianID], [CustodianshipDate], [BasicMunService], [ApplicableContracts], [InsurancePolicyNr], [InsuranceCover], [DebtSecurityApplicable], [DebtSecurityExpiryDate], [YearConstruct], [YearRenewed], [DateLastRenewed], [AdditionsOpening], [AdditionsFinYTD], [AdditionsClosing], [AdditionsFundSourceID], [AdditionsFundTypeID], [AdditionsNature], [EUL], [EUL_Adjusted], [RUL], [ResidualPct], [ResidualValue], [DepreciationMethodID], [DepreciationOpening], [DepreciationFinYTD], [DepreciationClosing], [ProvisionOpening], [ProvisionAdjust], [ProvisionClosing], [CashGenerating], [DisposalMethodID], [DisposalProceedCost], [DisposalProfitLoss], [DerecognitionDate], [DerecognitionCost], [DerecognitionDepr], [ImpairmentFinYTD], [RevImpairmentFinYTD], [RevaluationLastDate], [RevaluationNextDate], [RevaluationMethod], [CRC], [RevaluedAmount], [ValueChangeFinYTD], [RevaluationRUL], [RevaluedBy], [RevaluationAccuracy], [CriticalityGrade], [ConditionGrade], [PerformanceGrade], [UtilisationGrade], [OpsCostGrade], [RiskExposure], [ForecastReplYear], [ForecastReplValue], [CRC_Adjusted], [DRC], [AnnualisedMaintPct], [MaintenanceBudgetNeed], [MaintenanceBudgetPct], [MaintenanceExpenditure], [DateCreated], [DateLastFinMonth], [ImpairmentAll], [RevImpairmentAll], [Asset_Barcode_Nr], [Room_Barcode_Nr], [Room_Number], [Building_Name], [Serial_Number], [Fleet_Number], [Fleet_Reg_Year], [Treasury_Code], [Cost_Centre], [Acquisition_Date], [Impairment_Test_Date], [Impairment_Review_Date], [EUL_Review_Date], [RV_Review_Date], [Depr_Review_Date], [Condition_Review_Date], [Resp_CostCentre_ID], [Maint_CostCentre_ID], [PLANT_ID], [WorkCentre_ID], [LOC_ID], [CriticalityGrade_CG], [ConditionGrade_CG], [PerformanceGrade_CG], [UtilisationGrade_CG], [OpsCostGrade_CG], [YearConstruct_CG], [YearRenewed_CG], [ImpairmentDerecog], [FairValueLessCostSell], [ValueInUse], [ImpairmentDate], [RevImpairmentDate], [ImpairmentReason], [RevImpairmentReason], [TransferCost], [TransferDepr], [TransferDate], [ImpairmentClose], [RevaluationReserveOpening], [RevaluationReserveFinYTD], [RevaluationReserveClosing], [RefSuburbsCode], [CaseNumber], [InsuranceClaimed], [InsuranceAmount], [TransferredFrom], [TransferredTo], [EquipmentNr], [ImpairmentTransfer], [SCOA_Fund], [SCOA_Function], [SCOA_Mun_Classification], [SCOA_Project], [SCOA_Costing], [SCOA_Region], [SCOA_ItemAsset]) VALUES (N'P000005647', 5153, N'4LNZ_UKOL_MANH60046_CVST_SSDR', NULL, N'IMM', N'PPE', N'4LNZ', N'UKOL', N'MANH', N'CVST', N'SSDR', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(15.00 AS Decimal(18, 2)), N'm', CAST(20.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'Not Specified', N'Not Specified', CAST(N'2017-06-08T00:00:00.0000000' AS DateTime2), NULL, N'OWN', NULL, N'{C39D211F-3756-4CE6-B1B6-D49CE37BF74F}', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'Not Specified', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2017, NULL, CAST(N'2017-08-06T00:00:00.0000000' AS DateTime2), NULL, CAST(8256.88 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, 120, NULL, CAST(120.00 AS Decimal(18, 2)), 10, CAST(825.68 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(300.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, CAST(N'2017-08-06T00:00:00.0000000' AS DateTime2), NULL, CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(0.00 AS Decimal(18, 2)), N'5692f970-c29c-4044-80d7-1bcdbdd34348', N'a797a4d7-533a-42da-8e3f-90ec84bd2d81', NULL, N'514e94b5-4495-4808-a365-392f582278b8', N'05ff368a-44cf-4c35-9393-e00ab27bdbea', N'c9d0cbf5-dfa8-43d5-b044-0ca2014adb01', NULL)
INSERT [dbo].[AssetFinFormInput] ([Batch_Reference], [Form_Reference], [ComponentID], [ClientAssetID], [AssetMoveableID], [AccountingGroupID], [AssetCategoryID], [AssetSubCategoryID], [AssetGroupID], [AssetTypeID], [ComponentType], [AssetOwnerID], [AssetFacilityID], [AssetFacilityName], [DescriptorType], [DescriptorSize], [DescriptorSize_Unit], [DescriptorClass], [ComponentDesc], [Extent], [Extent_Unit], [Extent_Unit_Rate], [NetworkNr], [WardNr], [RegionName], [SuburbName], [LocationAddress], [LocationStand], [LocationSGcode], [Latitude], [Longitude], [MapFeatureID], [MapFeatureType], [TreasuryCode], [CostCentreCode], [GeneralLedgerCode], [TakeOnDate], [MethodAcquiredID], [OwnedLeasedID], [SupplierID], [WIP_Project_ID], [MeasurementModel], [CostPrice], [FairValue], [CostOpening], [CostClosing], [CarryingValueOpening], [CarryingValueClosing], [FundingSourceID], [FundingTypeID], [RespDepartmentID], [AssetCustodianID], [CustodianshipDate], [BasicMunService], [ApplicableContracts], [InsurancePolicyNr], [InsuranceCover], [DebtSecurityApplicable], [DebtSecurityExpiryDate], [YearConstruct], [YearRenewed], [DateLastRenewed], [AdditionsOpening], [AdditionsFinYTD], [AdditionsClosing], [AdditionsFundSourceID], [AdditionsFundTypeID], [AdditionsNature], [EUL], [EUL_Adjusted], [RUL], [ResidualPct], [ResidualValue], [DepreciationMethodID], [DepreciationOpening], [DepreciationFinYTD], [DepreciationClosing], [ProvisionOpening], [ProvisionAdjust], [ProvisionClosing], [CashGenerating], [DisposalMethodID], [DisposalProceedCost], [DisposalProfitLoss], [DerecognitionDate], [DerecognitionCost], [DerecognitionDepr], [ImpairmentFinYTD], [RevImpairmentFinYTD], [RevaluationLastDate], [RevaluationNextDate], [RevaluationMethod], [CRC], [RevaluedAmount], [ValueChangeFinYTD], [RevaluationRUL], [RevaluedBy], [RevaluationAccuracy], [CriticalityGrade], [ConditionGrade], [PerformanceGrade], [UtilisationGrade], [OpsCostGrade], [RiskExposure], [ForecastReplYear], [ForecastReplValue], [CRC_Adjusted], [DRC], [AnnualisedMaintPct], [MaintenanceBudgetNeed], [MaintenanceBudgetPct], [MaintenanceExpenditure], [DateCreated], [DateLastFinMonth], [ImpairmentAll], [RevImpairmentAll], [Asset_Barcode_Nr], [Room_Barcode_Nr], [Room_Number], [Building_Name], [Serial_Number], [Fleet_Number], [Fleet_Reg_Year], [Treasury_Code], [Cost_Centre], [Acquisition_Date], [Impairment_Test_Date], [Impairment_Review_Date], [EUL_Review_Date], [RV_Review_Date], [Depr_Review_Date], [Condition_Review_Date], [Resp_CostCentre_ID], [Maint_CostCentre_ID], [PLANT_ID], [WorkCentre_ID], [LOC_ID], [CriticalityGrade_CG], [ConditionGrade_CG], [PerformanceGrade_CG], [UtilisationGrade_CG], [OpsCostGrade_CG], [YearConstruct_CG], [YearRenewed_CG], [ImpairmentDerecog], [FairValueLessCostSell], [ValueInUse], [ImpairmentDate], [RevImpairmentDate], [ImpairmentReason], [RevImpairmentReason], [TransferCost], [TransferDepr], [TransferDate], [ImpairmentClose], [RevaluationReserveOpening], [RevaluationReserveFinYTD], [RevaluationReserveClosing], [RefSuburbsCode], [CaseNumber], [InsuranceClaimed], [InsuranceAmount], [TransferredFrom], [TransferredTo], [EquipmentNr], [ImpairmentTransfer], [SCOA_Fund], [SCOA_Function], [SCOA_Mun_Classification], [SCOA_Project], [SCOA_Costing], [SCOA_Region], [SCOA_ItemAsset]) VALUES (N'P000005647', 5154, N'4LNZ_JJFT_OFF60046_METW_FABS', NULL, N'IMM', N'PPE', N'4LNZ', N'JJFT', N'OFF', N'METW', N'FABS', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(30.00 AS Decimal(18, 2)), N'm', CAST(10.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'Not Specified', N'Not Specified', CAST(N'2017-06-08T00:00:00.0000000' AS DateTime2), NULL, N'OWN', NULL, N'{C39D211F-3756-4CE6-B1B6-D49CE37BF74F}', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'Not Specified', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2017, NULL, CAST(N'2017-08-06T00:00:00.0000000' AS DateTime2), NULL, CAST(8256.88 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, 130, NULL, CAST(130.00 AS Decimal(18, 2)), 15, CAST(1238.53 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(300.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, CAST(N'2017-08-06T00:00:00.0000000' AS DateTime2), NULL, CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(0.00 AS Decimal(18, 2)), N'5692f970-c29c-4044-80d7-1bcdbdd34348', N'153259f6-1f08-4df3-a474-21a294ba4463', NULL, N'17536636-dbff-4a96-b61f-014a7c691cd1', N'0d191e3b-f2c9-4e9a-8524-8413d38cf9df', N'bb183961-c3fe-4d35-8b0f-732a88cfd3da', NULL)
INSERT [dbo].[AssetFinFormInput] ([Batch_Reference], [Form_Reference], [ComponentID], [ClientAssetID], [AssetMoveableID], [AccountingGroupID], [AssetCategoryID], [AssetSubCategoryID], [AssetGroupID], [AssetTypeID], [ComponentType], [AssetOwnerID], [AssetFacilityID], [AssetFacilityName], [DescriptorType], [DescriptorSize], [DescriptorSize_Unit], [DescriptorClass], [ComponentDesc], [Extent], [Extent_Unit], [Extent_Unit_Rate], [NetworkNr], [WardNr], [RegionName], [SuburbName], [LocationAddress], [LocationStand], [LocationSGcode], [Latitude], [Longitude], [MapFeatureID], [MapFeatureType], [TreasuryCode], [CostCentreCode], [GeneralLedgerCode], [TakeOnDate], [MethodAcquiredID], [OwnedLeasedID], [SupplierID], [WIP_Project_ID], [MeasurementModel], [CostPrice], [FairValue], [CostOpening], [CostClosing], [CarryingValueOpening], [CarryingValueClosing], [FundingSourceID], [FundingTypeID], [RespDepartmentID], [AssetCustodianID], [CustodianshipDate], [BasicMunService], [ApplicableContracts], [InsurancePolicyNr], [InsuranceCover], [DebtSecurityApplicable], [DebtSecurityExpiryDate], [YearConstruct], [YearRenewed], [DateLastRenewed], [AdditionsOpening], [AdditionsFinYTD], [AdditionsClosing], [AdditionsFundSourceID], [AdditionsFundTypeID], [AdditionsNature], [EUL], [EUL_Adjusted], [RUL], [ResidualPct], [ResidualValue], [DepreciationMethodID], [DepreciationOpening], [DepreciationFinYTD], [DepreciationClosing], [ProvisionOpening], [ProvisionAdjust], [ProvisionClosing], [CashGenerating], [DisposalMethodID], [DisposalProceedCost], [DisposalProfitLoss], [DerecognitionDate], [DerecognitionCost], [DerecognitionDepr], [ImpairmentFinYTD], [RevImpairmentFinYTD], [RevaluationLastDate], [RevaluationNextDate], [RevaluationMethod], [CRC], [RevaluedAmount], [ValueChangeFinYTD], [RevaluationRUL], [RevaluedBy], [RevaluationAccuracy], [CriticalityGrade], [ConditionGrade], [PerformanceGrade], [UtilisationGrade], [OpsCostGrade], [RiskExposure], [ForecastReplYear], [ForecastReplValue], [CRC_Adjusted], [DRC], [AnnualisedMaintPct], [MaintenanceBudgetNeed], [MaintenanceBudgetPct], [MaintenanceExpenditure], [DateCreated], [DateLastFinMonth], [ImpairmentAll], [RevImpairmentAll], [Asset_Barcode_Nr], [Room_Barcode_Nr], [Room_Number], [Building_Name], [Serial_Number], [Fleet_Number], [Fleet_Reg_Year], [Treasury_Code], [Cost_Centre], [Acquisition_Date], [Impairment_Test_Date], [Impairment_Review_Date], [EUL_Review_Date], [RV_Review_Date], [Depr_Review_Date], [Condition_Review_Date], [Resp_CostCentre_ID], [Maint_CostCentre_ID], [PLANT_ID], [WorkCentre_ID], [LOC_ID], [CriticalityGrade_CG], [ConditionGrade_CG], [PerformanceGrade_CG], [UtilisationGrade_CG], [OpsCostGrade_CG], [YearConstruct_CG], [YearRenewed_CG], [ImpairmentDerecog], [FairValueLessCostSell], [ValueInUse], [ImpairmentDate], [RevImpairmentDate], [ImpairmentReason], [RevImpairmentReason], [TransferCost], [TransferDepr], [TransferDate], [ImpairmentClose], [RevaluationReserveOpening], [RevaluationReserveFinYTD], [RevaluationReserveClosing], [RefSuburbsCode], [CaseNumber], [InsuranceClaimed], [InsuranceAmount], [TransferredFrom], [TransferredTo], [EquipmentNr], [ImpairmentTransfer], [SCOA_Fund], [SCOA_Function], [SCOA_Mun_Classification], [SCOA_Project], [SCOA_Costing], [SCOA_Region], [SCOA_ItemAsset]) VALUES (N'P000005647', 5155, N'4LNZ_JJFT_DEP60046_PAVE_ROA', NULL, N'IMM', N'PPE', N'4LNZ', N'JJFT', N'DEP', N'PAVE', N'ROA', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(20.00 AS Decimal(18, 2)), N'u', CAST(10.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'Not Specified', N'Not Specified', CAST(N'2017-06-08T00:00:00.0000000' AS DateTime2), NULL, N'OWN', NULL, N'{C39D211F-3756-4CE6-B1B6-D49CE37BF74F}', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'Not Specified', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2017, NULL, CAST(N'2017-08-06T00:00:00.0000000' AS DateTime2), NULL, CAST(5504.59 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, 180, NULL, CAST(180.00 AS Decimal(18, 2)), 20, CAST(1100.91 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(200.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, CAST(N'2017-08-06T00:00:00.0000000' AS DateTime2), NULL, CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(0.00 AS Decimal(18, 2)), N'5692f970-c29c-4044-80d7-1bcdbdd34348', N'a797a4d7-533a-42da-8e3f-90ec84bd2d81', NULL, N'514e94b5-4495-4808-a365-392f582278b8', N'05ff368a-44cf-4c35-9393-e00ab27bdbea', N'c9d0cbf5-dfa8-43d5-b044-0ca2014adb01', NULL)
INSERT [dbo].[AssetFinFormInput] ([Batch_Reference], [Form_Reference], [ComponentID], [ClientAssetID], [AssetMoveableID], [AccountingGroupID], [AssetCategoryID], [AssetSubCategoryID], [AssetGroupID], [AssetTypeID], [ComponentType], [AssetOwnerID], [AssetFacilityID], [AssetFacilityName], [DescriptorType], [DescriptorSize], [DescriptorSize_Unit], [DescriptorClass], [ComponentDesc], [Extent], [Extent_Unit], [Extent_Unit_Rate], [NetworkNr], [WardNr], [RegionName], [SuburbName], [LocationAddress], [LocationStand], [LocationSGcode], [Latitude], [Longitude], [MapFeatureID], [MapFeatureType], [TreasuryCode], [CostCentreCode], [GeneralLedgerCode], [TakeOnDate], [MethodAcquiredID], [OwnedLeasedID], [SupplierID], [WIP_Project_ID], [MeasurementModel], [CostPrice], [FairValue], [CostOpening], [CostClosing], [CarryingValueOpening], [CarryingValueClosing], [FundingSourceID], [FundingTypeID], [RespDepartmentID], [AssetCustodianID], [CustodianshipDate], [BasicMunService], [ApplicableContracts], [InsurancePolicyNr], [InsuranceCover], [DebtSecurityApplicable], [DebtSecurityExpiryDate], [YearConstruct], [YearRenewed], [DateLastRenewed], [AdditionsOpening], [AdditionsFinYTD], [AdditionsClosing], [AdditionsFundSourceID], [AdditionsFundTypeID], [AdditionsNature], [EUL], [EUL_Adjusted], [RUL], [ResidualPct], [ResidualValue], [DepreciationMethodID], [DepreciationOpening], [DepreciationFinYTD], [DepreciationClosing], [ProvisionOpening], [ProvisionAdjust], [ProvisionClosing], [CashGenerating], [DisposalMethodID], [DisposalProceedCost], [DisposalProfitLoss], [DerecognitionDate], [DerecognitionCost], [DerecognitionDepr], [ImpairmentFinYTD], [RevImpairmentFinYTD], [RevaluationLastDate], [RevaluationNextDate], [RevaluationMethod], [CRC], [RevaluedAmount], [ValueChangeFinYTD], [RevaluationRUL], [RevaluedBy], [RevaluationAccuracy], [CriticalityGrade], [ConditionGrade], [PerformanceGrade], [UtilisationGrade], [OpsCostGrade], [RiskExposure], [ForecastReplYear], [ForecastReplValue], [CRC_Adjusted], [DRC], [AnnualisedMaintPct], [MaintenanceBudgetNeed], [MaintenanceBudgetPct], [MaintenanceExpenditure], [DateCreated], [DateLastFinMonth], [ImpairmentAll], [RevImpairmentAll], [Asset_Barcode_Nr], [Room_Barcode_Nr], [Room_Number], [Building_Name], [Serial_Number], [Fleet_Number], [Fleet_Reg_Year], [Treasury_Code], [Cost_Centre], [Acquisition_Date], [Impairment_Test_Date], [Impairment_Review_Date], [EUL_Review_Date], [RV_Review_Date], [Depr_Review_Date], [Condition_Review_Date], [Resp_CostCentre_ID], [Maint_CostCentre_ID], [PLANT_ID], [WorkCentre_ID], [LOC_ID], [CriticalityGrade_CG], [ConditionGrade_CG], [PerformanceGrade_CG], [UtilisationGrade_CG], [OpsCostGrade_CG], [YearConstruct_CG], [YearRenewed_CG], [ImpairmentDerecog], [FairValueLessCostSell], [ValueInUse], [ImpairmentDate], [RevImpairmentDate], [ImpairmentReason], [RevImpairmentReason], [TransferCost], [TransferDepr], [TransferDate], [ImpairmentClose], [RevaluationReserveOpening], [RevaluationReserveFinYTD], [RevaluationReserveClosing], [RefSuburbsCode], [CaseNumber], [InsuranceClaimed], [InsuranceAmount], [TransferredFrom], [TransferredTo], [EquipmentNr], [ImpairmentTransfer], [SCOA_Fund], [SCOA_Function], [SCOA_Mun_Classification], [SCOA_Project], [SCOA_Costing], [SCOA_Region], [SCOA_ItemAsset]) VALUES (N'P000005647', 5156, N'4LNZ_WIKO_PMP60046_PIPW_VALV', NULL, N'IMM', N'PPE', N'4LNZ', N'WIKO', N'PMP', N'PIPW', N'VALV', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(15.00 AS Decimal(18, 2)), N'u', CAST(10.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'Not Specified', N'Not Specified', CAST(N'2017-06-08T00:00:00.0000000' AS DateTime2), NULL, N'OWN', NULL, N'{C39D211F-3756-4CE6-B1B6-D49CE37BF74F}', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'Not Specified', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2017, NULL, CAST(N'2017-08-06T00:00:00.0000000' AS DateTime2), NULL, CAST(4128.44 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, 120, NULL, CAST(120.00 AS Decimal(18, 2)), 10, CAST(412.84 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(150.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, CAST(N'2017-08-06T00:00:00.0000000' AS DateTime2), NULL, CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(0.00 AS Decimal(18, 2)), N'5692f970-c29c-4044-80d7-1bcdbdd34348', N'153259f6-1f08-4df3-a474-21a294ba4463', NULL, N'17536636-dbff-4a96-b61f-014a7c691cd1', N'0d191e3b-f2c9-4e9a-8524-8413d38cf9df', N'bb183961-c3fe-4d35-8b0f-732a88cfd3da', NULL)
INSERT [dbo].[AssetFinFormInput] ([Batch_Reference], [Form_Reference], [ComponentID], [ClientAssetID], [AssetMoveableID], [AccountingGroupID], [AssetCategoryID], [AssetSubCategoryID], [AssetGroupID], [AssetTypeID], [ComponentType], [AssetOwnerID], [AssetFacilityID], [AssetFacilityName], [DescriptorType], [DescriptorSize], [DescriptorSize_Unit], [DescriptorClass], [ComponentDesc], [Extent], [Extent_Unit], [Extent_Unit_Rate], [NetworkNr], [WardNr], [RegionName], [SuburbName], [LocationAddress], [LocationStand], [LocationSGcode], [Latitude], [Longitude], [MapFeatureID], [MapFeatureType], [TreasuryCode], [CostCentreCode], [GeneralLedgerCode], [TakeOnDate], [MethodAcquiredID], [OwnedLeasedID], [SupplierID], [WIP_Project_ID], [MeasurementModel], [CostPrice], [FairValue], [CostOpening], [CostClosing], [CarryingValueOpening], [CarryingValueClosing], [FundingSourceID], [FundingTypeID], [RespDepartmentID], [AssetCustodianID], [CustodianshipDate], [BasicMunService], [ApplicableContracts], [InsurancePolicyNr], [InsuranceCover], [DebtSecurityApplicable], [DebtSecurityExpiryDate], [YearConstruct], [YearRenewed], [DateLastRenewed], [AdditionsOpening], [AdditionsFinYTD], [AdditionsClosing], [AdditionsFundSourceID], [AdditionsFundTypeID], [AdditionsNature], [EUL], [EUL_Adjusted], [RUL], [ResidualPct], [ResidualValue], [DepreciationMethodID], [DepreciationOpening], [DepreciationFinYTD], [DepreciationClosing], [ProvisionOpening], [ProvisionAdjust], [ProvisionClosing], [CashGenerating], [DisposalMethodID], [DisposalProceedCost], [DisposalProfitLoss], [DerecognitionDate], [DerecognitionCost], [DerecognitionDepr], [ImpairmentFinYTD], [RevImpairmentFinYTD], [RevaluationLastDate], [RevaluationNextDate], [RevaluationMethod], [CRC], [RevaluedAmount], [ValueChangeFinYTD], [RevaluationRUL], [RevaluedBy], [RevaluationAccuracy], [CriticalityGrade], [ConditionGrade], [PerformanceGrade], [UtilisationGrade], [OpsCostGrade], [RiskExposure], [ForecastReplYear], [ForecastReplValue], [CRC_Adjusted], [DRC], [AnnualisedMaintPct], [MaintenanceBudgetNeed], [MaintenanceBudgetPct], [MaintenanceExpenditure], [DateCreated], [DateLastFinMonth], [ImpairmentAll], [RevImpairmentAll], [Asset_Barcode_Nr], [Room_Barcode_Nr], [Room_Number], [Building_Name], [Serial_Number], [Fleet_Number], [Fleet_Reg_Year], [Treasury_Code], [Cost_Centre], [Acquisition_Date], [Impairment_Test_Date], [Impairment_Review_Date], [EUL_Review_Date], [RV_Review_Date], [Depr_Review_Date], [Condition_Review_Date], [Resp_CostCentre_ID], [Maint_CostCentre_ID], [PLANT_ID], [WorkCentre_ID], [LOC_ID], [CriticalityGrade_CG], [ConditionGrade_CG], [PerformanceGrade_CG], [UtilisationGrade_CG], [OpsCostGrade_CG], [YearConstruct_CG], [YearRenewed_CG], [ImpairmentDerecog], [FairValueLessCostSell], [ValueInUse], [ImpairmentDate], [RevImpairmentDate], [ImpairmentReason], [RevImpairmentReason], [TransferCost], [TransferDepr], [TransferDate], [ImpairmentClose], [RevaluationReserveOpening], [RevaluationReserveFinYTD], [RevaluationReserveClosing], [RefSuburbsCode], [CaseNumber], [InsuranceClaimed], [InsuranceAmount], [TransferredFrom], [TransferredTo], [EquipmentNr], [ImpairmentTransfer], [SCOA_Fund], [SCOA_Function], [SCOA_Mun_Classification], [SCOA_Project], [SCOA_Costing], [SCOA_Region], [SCOA_ItemAsset]) VALUES (N'P000005647', 5157, N'4LNZ_XUCR_BIO60046_RDFN_BLST', NULL, N'IMM', N'PPE', N'4LNZ', N'XUCR', N'BIO', N'RDFN', N'BLST', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(15.00 AS Decimal(18, 2)), N'm', CAST(20.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'Not Specified', N'Not Specified', CAST(N'2017-06-08T00:00:00.0000000' AS DateTime2), NULL, N'OWN', NULL, N'{C39D211F-3756-4CE6-B1B6-D49CE37BF74F}', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'Not Specified', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2017, NULL, CAST(N'2017-08-06T00:00:00.0000000' AS DateTime2), NULL, CAST(8256.88 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, 170, NULL, CAST(170.00 AS Decimal(18, 2)), 25, CAST(2064.22 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(300.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, CAST(N'2017-08-06T00:00:00.0000000' AS DateTime2), NULL, CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(0.00 AS Decimal(18, 2)), N'5692f970-c29c-4044-80d7-1bcdbdd34348', N'a797a4d7-533a-42da-8e3f-90ec84bd2d81', NULL, N'514e94b5-4495-4808-a365-392f582278b8', N'05ff368a-44cf-4c35-9393-e00ab27bdbea', N'c9d0cbf5-dfa8-43d5-b044-0ca2014adb01', NULL)
INSERT [dbo].[AssetFinFormInput] ([Batch_Reference], [Form_Reference], [ComponentID], [ClientAssetID], [AssetMoveableID], [AccountingGroupID], [AssetCategoryID], [AssetSubCategoryID], [AssetGroupID], [AssetTypeID], [ComponentType], [AssetOwnerID], [AssetFacilityID], [AssetFacilityName], [DescriptorType], [DescriptorSize], [DescriptorSize_Unit], [DescriptorClass], [ComponentDesc], [Extent], [Extent_Unit], [Extent_Unit_Rate], [NetworkNr], [WardNr], [RegionName], [SuburbName], [LocationAddress], [LocationStand], [LocationSGcode], [Latitude], [Longitude], [MapFeatureID], [MapFeatureType], [TreasuryCode], [CostCentreCode], [GeneralLedgerCode], [TakeOnDate], [MethodAcquiredID], [OwnedLeasedID], [SupplierID], [WIP_Project_ID], [MeasurementModel], [CostPrice], [FairValue], [CostOpening], [CostClosing], [CarryingValueOpening], [CarryingValueClosing], [FundingSourceID], [FundingTypeID], [RespDepartmentID], [AssetCustodianID], [CustodianshipDate], [BasicMunService], [ApplicableContracts], [InsurancePolicyNr], [InsuranceCover], [DebtSecurityApplicable], [DebtSecurityExpiryDate], [YearConstruct], [YearRenewed], [DateLastRenewed], [AdditionsOpening], [AdditionsFinYTD], [AdditionsClosing], [AdditionsFundSourceID], [AdditionsFundTypeID], [AdditionsNature], [EUL], [EUL_Adjusted], [RUL], [ResidualPct], [ResidualValue], [DepreciationMethodID], [DepreciationOpening], [DepreciationFinYTD], [DepreciationClosing], [ProvisionOpening], [ProvisionAdjust], [ProvisionClosing], [CashGenerating], [DisposalMethodID], [DisposalProceedCost], [DisposalProfitLoss], [DerecognitionDate], [DerecognitionCost], [DerecognitionDepr], [ImpairmentFinYTD], [RevImpairmentFinYTD], [RevaluationLastDate], [RevaluationNextDate], [RevaluationMethod], [CRC], [RevaluedAmount], [ValueChangeFinYTD], [RevaluationRUL], [RevaluedBy], [RevaluationAccuracy], [CriticalityGrade], [ConditionGrade], [PerformanceGrade], [UtilisationGrade], [OpsCostGrade], [RiskExposure], [ForecastReplYear], [ForecastReplValue], [CRC_Adjusted], [DRC], [AnnualisedMaintPct], [MaintenanceBudgetNeed], [MaintenanceBudgetPct], [MaintenanceExpenditure], [DateCreated], [DateLastFinMonth], [ImpairmentAll], [RevImpairmentAll], [Asset_Barcode_Nr], [Room_Barcode_Nr], [Room_Number], [Building_Name], [Serial_Number], [Fleet_Number], [Fleet_Reg_Year], [Treasury_Code], [Cost_Centre], [Acquisition_Date], [Impairment_Test_Date], [Impairment_Review_Date], [EUL_Review_Date], [RV_Review_Date], [Depr_Review_Date], [Condition_Review_Date], [Resp_CostCentre_ID], [Maint_CostCentre_ID], [PLANT_ID], [WorkCentre_ID], [LOC_ID], [CriticalityGrade_CG], [ConditionGrade_CG], [PerformanceGrade_CG], [UtilisationGrade_CG], [OpsCostGrade_CG], [YearConstruct_CG], [YearRenewed_CG], [ImpairmentDerecog], [FairValueLessCostSell], [ValueInUse], [ImpairmentDate], [RevImpairmentDate], [ImpairmentReason], [RevImpairmentReason], [TransferCost], [TransferDepr], [TransferDate], [ImpairmentClose], [RevaluationReserveOpening], [RevaluationReserveFinYTD], [RevaluationReserveClosing], [RefSuburbsCode], [CaseNumber], [InsuranceClaimed], [InsuranceAmount], [TransferredFrom], [TransferredTo], [EquipmentNr], [ImpairmentTransfer], [SCOA_Fund], [SCOA_Function], [SCOA_Mun_Classification], [SCOA_Project], [SCOA_Costing], [SCOA_Region], [SCOA_ItemAsset]) VALUES (N'P000005647', 5158, N'4LNZ_XUCR_CLA60046_PIPW_VALV', NULL, N'IMM', N'PPE', N'4LNZ', N'XUCR', N'CLA', N'PIPW', N'VALV', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(20.00 AS Decimal(18, 2)), N'm', CAST(30.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'Not Specified', N'Not Specified', CAST(N'2017-06-08T00:00:00.0000000' AS DateTime2), NULL, N'OWN', NULL, N'{C39D211F-3756-4CE6-B1B6-D49CE37BF74F}', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'Not Specified', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2017, NULL, CAST(N'2017-08-06T00:00:00.0000000' AS DateTime2), NULL, CAST(16513.76 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, 200, NULL, CAST(200.00 AS Decimal(18, 2)), 30, CAST(4954.12 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(600.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, CAST(N'2017-08-06T00:00:00.0000000' AS DateTime2), NULL, CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(0.00 AS Decimal(18, 2)), N'5692f970-c29c-4044-80d7-1bcdbdd34348', N'153259f6-1f08-4df3-a474-21a294ba4463', NULL, N'17536636-dbff-4a96-b61f-014a7c691cd1', N'0d191e3b-f2c9-4e9a-8524-8413d38cf9df', N'bb183961-c3fe-4d35-8b0f-732a88cfd3da', NULL)
INSERT [dbo].[AssetFinFormInput] ([Batch_Reference], [Form_Reference], [ComponentID], [ClientAssetID], [AssetMoveableID], [AccountingGroupID], [AssetCategoryID], [AssetSubCategoryID], [AssetGroupID], [AssetTypeID], [ComponentType], [AssetOwnerID], [AssetFacilityID], [AssetFacilityName], [DescriptorType], [DescriptorSize], [DescriptorSize_Unit], [DescriptorClass], [ComponentDesc], [Extent], [Extent_Unit], [Extent_Unit_Rate], [NetworkNr], [WardNr], [RegionName], [SuburbName], [LocationAddress], [LocationStand], [LocationSGcode], [Latitude], [Longitude], [MapFeatureID], [MapFeatureType], [TreasuryCode], [CostCentreCode], [GeneralLedgerCode], [TakeOnDate], [MethodAcquiredID], [OwnedLeasedID], [SupplierID], [WIP_Project_ID], [MeasurementModel], [CostPrice], [FairValue], [CostOpening], [CostClosing], [CarryingValueOpening], [CarryingValueClosing], [FundingSourceID], [FundingTypeID], [RespDepartmentID], [AssetCustodianID], [CustodianshipDate], [BasicMunService], [ApplicableContracts], [InsurancePolicyNr], [InsuranceCover], [DebtSecurityApplicable], [DebtSecurityExpiryDate], [YearConstruct], [YearRenewed], [DateLastRenewed], [AdditionsOpening], [AdditionsFinYTD], [AdditionsClosing], [AdditionsFundSourceID], [AdditionsFundTypeID], [AdditionsNature], [EUL], [EUL_Adjusted], [RUL], [ResidualPct], [ResidualValue], [DepreciationMethodID], [DepreciationOpening], [DepreciationFinYTD], [DepreciationClosing], [ProvisionOpening], [ProvisionAdjust], [ProvisionClosing], [CashGenerating], [DisposalMethodID], [DisposalProceedCost], [DisposalProfitLoss], [DerecognitionDate], [DerecognitionCost], [DerecognitionDepr], [ImpairmentFinYTD], [RevImpairmentFinYTD], [RevaluationLastDate], [RevaluationNextDate], [RevaluationMethod], [CRC], [RevaluedAmount], [ValueChangeFinYTD], [RevaluationRUL], [RevaluedBy], [RevaluationAccuracy], [CriticalityGrade], [ConditionGrade], [PerformanceGrade], [UtilisationGrade], [OpsCostGrade], [RiskExposure], [ForecastReplYear], [ForecastReplValue], [CRC_Adjusted], [DRC], [AnnualisedMaintPct], [MaintenanceBudgetNeed], [MaintenanceBudgetPct], [MaintenanceExpenditure], [DateCreated], [DateLastFinMonth], [ImpairmentAll], [RevImpairmentAll], [Asset_Barcode_Nr], [Room_Barcode_Nr], [Room_Number], [Building_Name], [Serial_Number], [Fleet_Number], [Fleet_Reg_Year], [Treasury_Code], [Cost_Centre], [Acquisition_Date], [Impairment_Test_Date], [Impairment_Review_Date], [EUL_Review_Date], [RV_Review_Date], [Depr_Review_Date], [Condition_Review_Date], [Resp_CostCentre_ID], [Maint_CostCentre_ID], [PLANT_ID], [WorkCentre_ID], [LOC_ID], [CriticalityGrade_CG], [ConditionGrade_CG], [PerformanceGrade_CG], [UtilisationGrade_CG], [OpsCostGrade_CG], [YearConstruct_CG], [YearRenewed_CG], [ImpairmentDerecog], [FairValueLessCostSell], [ValueInUse], [ImpairmentDate], [RevImpairmentDate], [ImpairmentReason], [RevImpairmentReason], [TransferCost], [TransferDepr], [TransferDate], [ImpairmentClose], [RevaluationReserveOpening], [RevaluationReserveFinYTD], [RevaluationReserveClosing], [RefSuburbsCode], [CaseNumber], [InsuranceClaimed], [InsuranceAmount], [TransferredFrom], [TransferredTo], [EquipmentNr], [ImpairmentTransfer], [SCOA_Fund], [SCOA_Function], [SCOA_Mun_Classification], [SCOA_Project], [SCOA_Costing], [SCOA_Region], [SCOA_ItemAsset]) VALUES (N'P000005647', 5159, N'4LNZ_JJFT_DEP60046_PIPW_WATS', NULL, N'IMM', N'PPE', N'4LNZ', N'JJFT', N'DEP', N'PIPW', N'WATS', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(60.00 AS Decimal(18, 2)), N'm', CAST(40.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'Not Specified', N'Not Specified', CAST(N'2017-06-08T00:00:00.0000000' AS DateTime2), NULL, N'OWN', NULL, N'{C39D211F-3756-4CE6-B1B6-D49CE37BF74F}', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'Not Specified', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2017, NULL, CAST(N'2017-08-06T00:00:00.0000000' AS DateTime2), NULL, CAST(66055.05 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, 10, NULL, CAST(10.00 AS Decimal(18, 2)), 20, CAST(13211.01 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(2400.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, CAST(N'2017-08-06T00:00:00.0000000' AS DateTime2), NULL, CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(0.00 AS Decimal(18, 2)), N'5692f970-c29c-4044-80d7-1bcdbdd34348', N'a797a4d7-533a-42da-8e3f-90ec84bd2d81', NULL, N'514e94b5-4495-4808-a365-392f582278b8', N'05ff368a-44cf-4c35-9393-e00ab27bdbea', N'c9d0cbf5-dfa8-43d5-b044-0ca2014adb01', NULL)
INSERT [dbo].[AssetFinFormInput] ([Batch_Reference], [Form_Reference], [ComponentID], [ClientAssetID], [AssetMoveableID], [AccountingGroupID], [AssetCategoryID], [AssetSubCategoryID], [AssetGroupID], [AssetTypeID], [ComponentType], [AssetOwnerID], [AssetFacilityID], [AssetFacilityName], [DescriptorType], [DescriptorSize], [DescriptorSize_Unit], [DescriptorClass], [ComponentDesc], [Extent], [Extent_Unit], [Extent_Unit_Rate], [NetworkNr], [WardNr], [RegionName], [SuburbName], [LocationAddress], [LocationStand], [LocationSGcode], [Latitude], [Longitude], [MapFeatureID], [MapFeatureType], [TreasuryCode], [CostCentreCode], [GeneralLedgerCode], [TakeOnDate], [MethodAcquiredID], [OwnedLeasedID], [SupplierID], [WIP_Project_ID], [MeasurementModel], [CostPrice], [FairValue], [CostOpening], [CostClosing], [CarryingValueOpening], [CarryingValueClosing], [FundingSourceID], [FundingTypeID], [RespDepartmentID], [AssetCustodianID], [CustodianshipDate], [BasicMunService], [ApplicableContracts], [InsurancePolicyNr], [InsuranceCover], [DebtSecurityApplicable], [DebtSecurityExpiryDate], [YearConstruct], [YearRenewed], [DateLastRenewed], [AdditionsOpening], [AdditionsFinYTD], [AdditionsClosing], [AdditionsFundSourceID], [AdditionsFundTypeID], [AdditionsNature], [EUL], [EUL_Adjusted], [RUL], [ResidualPct], [ResidualValue], [DepreciationMethodID], [DepreciationOpening], [DepreciationFinYTD], [DepreciationClosing], [ProvisionOpening], [ProvisionAdjust], [ProvisionClosing], [CashGenerating], [DisposalMethodID], [DisposalProceedCost], [DisposalProfitLoss], [DerecognitionDate], [DerecognitionCost], [DerecognitionDepr], [ImpairmentFinYTD], [RevImpairmentFinYTD], [RevaluationLastDate], [RevaluationNextDate], [RevaluationMethod], [CRC], [RevaluedAmount], [ValueChangeFinYTD], [RevaluationRUL], [RevaluedBy], [RevaluationAccuracy], [CriticalityGrade], [ConditionGrade], [PerformanceGrade], [UtilisationGrade], [OpsCostGrade], [RiskExposure], [ForecastReplYear], [ForecastReplValue], [CRC_Adjusted], [DRC], [AnnualisedMaintPct], [MaintenanceBudgetNeed], [MaintenanceBudgetPct], [MaintenanceExpenditure], [DateCreated], [DateLastFinMonth], [ImpairmentAll], [RevImpairmentAll], [Asset_Barcode_Nr], [Room_Barcode_Nr], [Room_Number], [Building_Name], [Serial_Number], [Fleet_Number], [Fleet_Reg_Year], [Treasury_Code], [Cost_Centre], [Acquisition_Date], [Impairment_Test_Date], [Impairment_Review_Date], [EUL_Review_Date], [RV_Review_Date], [Depr_Review_Date], [Condition_Review_Date], [Resp_CostCentre_ID], [Maint_CostCentre_ID], [PLANT_ID], [WorkCentre_ID], [LOC_ID], [CriticalityGrade_CG], [ConditionGrade_CG], [PerformanceGrade_CG], [UtilisationGrade_CG], [OpsCostGrade_CG], [YearConstruct_CG], [YearRenewed_CG], [ImpairmentDerecog], [FairValueLessCostSell], [ValueInUse], [ImpairmentDate], [RevImpairmentDate], [ImpairmentReason], [RevImpairmentReason], [TransferCost], [TransferDepr], [TransferDate], [ImpairmentClose], [RevaluationReserveOpening], [RevaluationReserveFinYTD], [RevaluationReserveClosing], [RefSuburbsCode], [CaseNumber], [InsuranceClaimed], [InsuranceAmount], [TransferredFrom], [TransferredTo], [EquipmentNr], [ImpairmentTransfer], [SCOA_Fund], [SCOA_Function], [SCOA_Mun_Classification], [SCOA_Project], [SCOA_Costing], [SCOA_Region], [SCOA_ItemAsset]) VALUES (N'P000005647', 5160, N'4LNZ_JJFT_DEP60046_PIPW_WMET', NULL, N'IMM', N'PPE', N'4LNZ', N'JJFT', N'DEP', N'PIPW', N'WMET', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(10.00 AS Decimal(18, 2)), N'm', CAST(30.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'Not Specified', N'Not Specified', CAST(N'2017-06-08T00:00:00.0000000' AS DateTime2), NULL, N'OWN', NULL, N'{C39D211F-3756-4CE6-B1B6-D49CE37BF74F}', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'Not Specified', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2017, NULL, CAST(N'2017-08-06T00:00:00.0000000' AS DateTime2), NULL, CAST(8256.88 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, 30, NULL, CAST(30.00 AS Decimal(18, 2)), 5, CAST(412.84 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(300.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, CAST(N'2017-08-06T00:00:00.0000000' AS DateTime2), NULL, CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(0.00 AS Decimal(18, 2)), N'5692f970-c29c-4044-80d7-1bcdbdd34348', N'153259f6-1f08-4df3-a474-21a294ba4463', NULL, N'17536636-dbff-4a96-b61f-014a7c691cd1', N'0d191e3b-f2c9-4e9a-8524-8413d38cf9df', N'bb183961-c3fe-4d35-8b0f-732a88cfd3da', NULL)
INSERT [dbo].[AssetFinFormInput] ([Batch_Reference], [Form_Reference], [ComponentID], [ClientAssetID], [AssetMoveableID], [AccountingGroupID], [AssetCategoryID], [AssetSubCategoryID], [AssetGroupID], [AssetTypeID], [ComponentType], [AssetOwnerID], [AssetFacilityID], [AssetFacilityName], [DescriptorType], [DescriptorSize], [DescriptorSize_Unit], [DescriptorClass], [ComponentDesc], [Extent], [Extent_Unit], [Extent_Unit_Rate], [NetworkNr], [WardNr], [RegionName], [SuburbName], [LocationAddress], [LocationStand], [LocationSGcode], [Latitude], [Longitude], [MapFeatureID], [MapFeatureType], [TreasuryCode], [CostCentreCode], [GeneralLedgerCode], [TakeOnDate], [MethodAcquiredID], [OwnedLeasedID], [SupplierID], [WIP_Project_ID], [MeasurementModel], [CostPrice], [FairValue], [CostOpening], [CostClosing], [CarryingValueOpening], [CarryingValueClosing], [FundingSourceID], [FundingTypeID], [RespDepartmentID], [AssetCustodianID], [CustodianshipDate], [BasicMunService], [ApplicableContracts], [InsurancePolicyNr], [InsuranceCover], [DebtSecurityApplicable], [DebtSecurityExpiryDate], [YearConstruct], [YearRenewed], [DateLastRenewed], [AdditionsOpening], [AdditionsFinYTD], [AdditionsClosing], [AdditionsFundSourceID], [AdditionsFundTypeID], [AdditionsNature], [EUL], [EUL_Adjusted], [RUL], [ResidualPct], [ResidualValue], [DepreciationMethodID], [DepreciationOpening], [DepreciationFinYTD], [DepreciationClosing], [ProvisionOpening], [ProvisionAdjust], [ProvisionClosing], [CashGenerating], [DisposalMethodID], [DisposalProceedCost], [DisposalProfitLoss], [DerecognitionDate], [DerecognitionCost], [DerecognitionDepr], [ImpairmentFinYTD], [RevImpairmentFinYTD], [RevaluationLastDate], [RevaluationNextDate], [RevaluationMethod], [CRC], [RevaluedAmount], [ValueChangeFinYTD], [RevaluationRUL], [RevaluedBy], [RevaluationAccuracy], [CriticalityGrade], [ConditionGrade], [PerformanceGrade], [UtilisationGrade], [OpsCostGrade], [RiskExposure], [ForecastReplYear], [ForecastReplValue], [CRC_Adjusted], [DRC], [AnnualisedMaintPct], [MaintenanceBudgetNeed], [MaintenanceBudgetPct], [MaintenanceExpenditure], [DateCreated], [DateLastFinMonth], [ImpairmentAll], [RevImpairmentAll], [Asset_Barcode_Nr], [Room_Barcode_Nr], [Room_Number], [Building_Name], [Serial_Number], [Fleet_Number], [Fleet_Reg_Year], [Treasury_Code], [Cost_Centre], [Acquisition_Date], [Impairment_Test_Date], [Impairment_Review_Date], [EUL_Review_Date], [RV_Review_Date], [Depr_Review_Date], [Condition_Review_Date], [Resp_CostCentre_ID], [Maint_CostCentre_ID], [PLANT_ID], [WorkCentre_ID], [LOC_ID], [CriticalityGrade_CG], [ConditionGrade_CG], [PerformanceGrade_CG], [UtilisationGrade_CG], [OpsCostGrade_CG], [YearConstruct_CG], [YearRenewed_CG], [ImpairmentDerecog], [FairValueLessCostSell], [ValueInUse], [ImpairmentDate], [RevImpairmentDate], [ImpairmentReason], [RevImpairmentReason], [TransferCost], [TransferDepr], [TransferDate], [ImpairmentClose], [RevaluationReserveOpening], [RevaluationReserveFinYTD], [RevaluationReserveClosing], [RefSuburbsCode], [CaseNumber], [InsuranceClaimed], [InsuranceAmount], [TransferredFrom], [TransferredTo], [EquipmentNr], [ImpairmentTransfer], [SCOA_Fund], [SCOA_Function], [SCOA_Mun_Classification], [SCOA_Project], [SCOA_Costing], [SCOA_Region], [SCOA_ItemAsset]) VALUES (N'P000005647', 5161, N'4LNZ_JJFT_STO60046_METW_FABS', NULL, N'IMM', N'PPE', N'4LNZ', N'JJFT', N'STO', N'METW', N'FABS', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(20.00 AS Decimal(18, 2)), N'm', CAST(35.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'Not Specified', N'Not Specified', CAST(N'2017-06-08T00:00:00.0000000' AS DateTime2), NULL, N'OWN', NULL, N'{C39D211F-3756-4CE6-B1B6-D49CE37BF74F}', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'Not Specified', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2017, NULL, CAST(N'2017-08-06T00:00:00.0000000' AS DateTime2), NULL, CAST(19266.05 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, 20, NULL, CAST(20.00 AS Decimal(18, 2)), 10, CAST(1926.60 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(700.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, CAST(N'2017-08-06T00:00:00.0000000' AS DateTime2), NULL, CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(0.00 AS Decimal(18, 2)), N'5692f970-c29c-4044-80d7-1bcdbdd34348', N'a797a4d7-533a-42da-8e3f-90ec84bd2d81', NULL, N'514e94b5-4495-4808-a365-392f582278b8', N'05ff368a-44cf-4c35-9393-e00ab27bdbea', N'c9d0cbf5-dfa8-43d5-b044-0ca2014adb01', NULL)
SET IDENTITY_INSERT [AssetFinFormInput] OFF;


CREATE TABLE [dbo].[AssetFinFormRef](
	[Form_Reference] [int] NOT NULL,
	[Form_Nr] [int] NULL,
	[Issue_DateTime] [datetime] NULL,
	[Component_ID] [varchar](40) NULL,
	[Asset_Group_Name] [varchar](150) NULL,
	[Requested_Name] [varchar](40) NULL,
	[Requested_Date] [datetime] NULL,
	[Authorised_Name] [varchar](40) NULL,
	[Authorised_Date] [datetime] NULL,
	[Custodian_Name] [varchar](40) NULL,
	[Custodian_Date] [datetime] NULL,
	[ExManager_Name] [varchar](40) NULL,
	[ExManager_Date] [datetime] NULL,
	[Captured_Name] [varchar](40) NULL,
	[Captured_Date] [datetime] NULL,
	[Information] [text] NULL,
	[Instructions] [text] NULL,
	[Rec_Action] [varchar](4) NULL,
	[Carrying_Value] [decimal](18, 4) NULL,
	[Value_in_Use] [decimal](18, 4) NULL,
	[Fair_Value_Less] [decimal](18, 4) NULL,
	[Recoverable_Amt] [decimal](18, 4) NULL,
	[Police_Report_Nr] [varchar](20) NULL,
	[Take_on_Date] [datetime] NULL,
	[Reason_Code] [varchar](16) NULL,
	[Form_Level] [int] NULL,
	[form_timestamp] [timestamp] NOT NULL,
	[Ext_Form_Reference] [varchar](40) NULL,
	[Creator] [varchar](40) NULL,
	CONSTRAINT [PK_AssetFinFormRef] PRIMARY KEY CLUSTERED ([Form_Reference] ASC)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY];
ALTER TABLE [dbo].[AssetFinFormRef] ADD [Ext_Form_Reference] [varchar](40) NULL;
CREATE UNIQUE NONCLUSTERED INDEX [Idx_Ext_Form_Reference] ON  [dbo].[AssetFinFormRef] ([Ext_Form_Reference]);
ALTER TABLE [dbo].[AssetFinFormRef] ADD [Creator] [varchar](40) NULL;

------- AssetFinFormRef INSERTS --------
INSERT [dbo].[AssetFinFormRef] (
	[Form_Reference], [Ext_Form_Reference],[Creator],
	[Form_Nr], [Issue_DateTime], [Component_ID], [Asset_Group_Name], [Requested_Name], [Requested_Date], [Authorised_Name], [Authorised_Date], [Custodian_Name], [Custodian_Date],
	[ExManager_Name], [ExManager_Date], [Captured_Name], [Captured_Date], [Information], [Instructions], [Rec_Action], [Carrying_Value], [Value_in_Use], [Fair_Value_Less], [Recoverable_Amt],
	[Police_Report_Nr], [Take_on_Date], [Reason_Code], [Form_Level])
VALUES (
	1, '1', 'IMQS', 1, CAST(N'2014-03-24 12:39:22.303' AS DateTime), N'INF_GEN1_WAS60019_ROA1_EAR.4', N'Northern : General site', N'ADMIN', CAST(N'2014-03-24 12:39:22.303' AS DateTime), N'ADMIN',
	CAST(N'2015-01-28 00:00:00.000' AS DateTime), NULL, NULL, NULL, NULL, N'ADMIN', CAST(N'2014-03-24 12:39:22.303' AS DateTime), NULL, NULL, N'YES', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1)
;
INSERT [dbo].[AssetFinFormRef] (
	[Form_Reference], [Ext_Form_Reference], [Creator],
	[Form_Nr], [Issue_DateTime], [Component_ID], [Asset_Group_Name], [Requested_Name], [Requested_Date], [Authorised_Name], [Authorised_Date], [Custodian_Name], [Custodian_Date],
	[ExManager_Name], [ExManager_Date], [Captured_Name], [Captured_Date], [Information], [Instructions], [Rec_Action], [Carrying_Value], [Value_in_Use], [Fair_Value_Less], [Recoverable_Amt],
	[Police_Report_Nr], [Take_on_Date], [Reason_Code], [Form_Level])
VALUES (
	11, '11','IMQS', 1, CAST(N'2014-03-24 12:39:22.303' AS DateTime), N'INF_GEN1_WAS60019_ROA1_EAR.5', N'Northern : General site', N'ADMIN', CAST(N'2014-03-24 12:39:22.303' AS DateTime), N'ADMIN', CAST(N'2015-01-28 00:00:00.000' AS DateTime), NULL, NULL, NULL, NULL, N'ADMIN', CAST(N'2014-03-24 12:39:22.303' AS DateTime), NULL, NULL, N'YES', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1
);
INSERT [dbo].[AssetFinFormRef] (
	[Form_Reference], [Ext_Form_Reference], [Creator],
	[Form_Nr], [Issue_DateTime], [Component_ID], [Asset_Group_Name], [Requested_Name], [Requested_Date], [Authorised_Name], [Authorised_Date], [Custodian_Name], [Custodian_Date],
	[ExManager_Name], [ExManager_Date], [Captured_Name], [Captured_Date], [Information], [Instructions], [Rec_Action], [Carrying_Value], [Value_in_Use], [Fair_Value_Less], [Recoverable_Amt],
	[Police_Report_Nr], [Take_on_Date], [Reason_Code], [Form_Level])
VALUES (
	12, '12','IMQS', 1, CAST(N'2014-03-24 12:39:22.303' AS DateTime), N'INF_GEN1_WAS60019_ROA1_EAR.6', N'Northern : General site', N'ADMIN', CAST(N'2014-03-24 12:39:22.303' AS DateTime), N'ADMIN', CAST(N'2015-01-28 00:00:00.000' AS DateTime), NULL, NULL, NULL, NULL, N'ADMIN', CAST(N'2014-03-24 12:39:22.303' AS DateTime), NULL, NULL, N'YES', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1
);
INSERT [dbo].[AssetFinFormRef] (
	[Form_Reference], [Ext_Form_Reference], [Creator],
	[Form_Nr], [Issue_DateTime], [Component_ID], [Asset_Group_Name], [Requested_Name], [Requested_Date], [Authorised_Name], [Authorised_Date], [Custodian_Name], [Custodian_Date],
	[ExManager_Name], [ExManager_Date], [Captured_Name], [Captured_Date], [Information], [Instructions], [Rec_Action], [Carrying_Value], [Value_in_Use], [Fair_Value_Less], [Recoverable_Amt],
	[Police_Report_Nr], [Take_on_Date], [Reason_Code], [Form_Level])
VALUES (
	13, '13','IMQS', 1, CAST(N'2014-03-24 12:39:22.303' AS DateTime), N'INF_GEN1_WAS60019_ROA1_EAR.7', N'Northern : General site', N'ADMIN', CAST(N'2014-03-24 12:39:22.303' AS DateTime), N'ADMIN', CAST(N'2015-01-28 00:00:00.000' AS DateTime), NULL, NULL, NULL, NULL, N'ADMIN', CAST(N'2014-03-24 12:39:22.303' AS DateTime), NULL, NULL, N'YES', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1
);
-- Here are the SCOA test entries for AssetFinFormRef
INSERT [dbo].[AssetFinFormRef] ([Form_Reference], [Form_Nr], [Issue_DateTime], [Component_ID], [Asset_Group_Name], [Requested_Name], [Requested_Date], [Authorised_Name], [Authorised_Date], [Custodian_Name], [Custodian_Date], [ExManager_Name], [ExManager_Date], [Captured_Name], [Captured_Date], [Information], [Instructions], [Rec_Action], [Carrying_Value], [Value_in_Use], [Fair_Value_Less], [Recoverable_Amt], [Police_Report_Nr], [Take_on_Date], [Reason_Code], [Form_Level], [Ext_Form_Reference], [Creator]) values (5152, 1, '2016-03-24 12:39:22.303', (select ComponentID from AssetFinFormInput affi where affi.Form_Reference = 5152), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '5152', NULL);
INSERT [dbo].[AssetFinFormRef] ([Form_Reference], [Form_Nr], [Issue_DateTime], [Component_ID], [Asset_Group_Name], [Requested_Name], [Requested_Date], [Authorised_Name], [Authorised_Date], [Custodian_Name], [Custodian_Date], [ExManager_Name], [ExManager_Date], [Captured_Name], [Captured_Date], [Information], [Instructions], [Rec_Action], [Carrying_Value], [Value_in_Use], [Fair_Value_Less], [Recoverable_Amt], [Police_Report_Nr], [Take_on_Date], [Reason_Code], [Form_Level], [Ext_Form_Reference], [Creator]) values (5153, 1, '2016-03-24 12:39:22.303', (select ComponentID from AssetFinFormInput affi where affi.Form_Reference = 5153), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '5153', NULL);
INSERT [dbo].[AssetFinFormRef] ([Form_Reference], [Form_Nr], [Issue_DateTime], [Component_ID], [Asset_Group_Name], [Requested_Name], [Requested_Date], [Authorised_Name], [Authorised_Date], [Custodian_Name], [Custodian_Date], [ExManager_Name], [ExManager_Date], [Captured_Name], [Captured_Date], [Information], [Instructions], [Rec_Action], [Carrying_Value], [Value_in_Use], [Fair_Value_Less], [Recoverable_Amt], [Police_Report_Nr], [Take_on_Date], [Reason_Code], [Form_Level], [Ext_Form_Reference], [Creator]) values (5154, 1, '2016-03-24 12:39:22.303', (select ComponentID from AssetFinFormInput affi where affi.Form_Reference = 5154), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '5154', NULL);
INSERT [dbo].[AssetFinFormRef] ([Form_Reference], [Form_Nr], [Issue_DateTime], [Component_ID], [Asset_Group_Name], [Requested_Name], [Requested_Date], [Authorised_Name], [Authorised_Date], [Custodian_Name], [Custodian_Date], [ExManager_Name], [ExManager_Date], [Captured_Name], [Captured_Date], [Information], [Instructions], [Rec_Action], [Carrying_Value], [Value_in_Use], [Fair_Value_Less], [Recoverable_Amt], [Police_Report_Nr], [Take_on_Date], [Reason_Code], [Form_Level], [Ext_Form_Reference], [Creator]) values (5155, 1, '2016-03-24 12:39:22.303', (select ComponentID from AssetFinFormInput affi where affi.Form_Reference = 5155), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '5155', NULL);
INSERT [dbo].[AssetFinFormRef] ([Form_Reference], [Form_Nr], [Issue_DateTime], [Component_ID], [Asset_Group_Name], [Requested_Name], [Requested_Date], [Authorised_Name], [Authorised_Date], [Custodian_Name], [Custodian_Date], [ExManager_Name], [ExManager_Date], [Captured_Name], [Captured_Date], [Information], [Instructions], [Rec_Action], [Carrying_Value], [Value_in_Use], [Fair_Value_Less], [Recoverable_Amt], [Police_Report_Nr], [Take_on_Date], [Reason_Code], [Form_Level], [Ext_Form_Reference], [Creator]) values (5156, 1, '2016-03-24 12:39:22.303', (select ComponentID from AssetFinFormInput affi where affi.Form_Reference = 5156), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '5156', NULL);
INSERT [dbo].[AssetFinFormRef] ([Form_Reference], [Form_Nr], [Issue_DateTime], [Component_ID], [Asset_Group_Name], [Requested_Name], [Requested_Date], [Authorised_Name], [Authorised_Date], [Custodian_Name], [Custodian_Date], [ExManager_Name], [ExManager_Date], [Captured_Name], [Captured_Date], [Information], [Instructions], [Rec_Action], [Carrying_Value], [Value_in_Use], [Fair_Value_Less], [Recoverable_Amt], [Police_Report_Nr], [Take_on_Date], [Reason_Code], [Form_Level], [Ext_Form_Reference], [Creator]) values (5157, 1, '2016-03-24 12:39:22.303', (select ComponentID from AssetFinFormInput affi where affi.Form_Reference = 5157), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '5157', NULL);
INSERT [dbo].[AssetFinFormRef] ([Form_Reference], [Form_Nr], [Issue_DateTime], [Component_ID], [Asset_Group_Name], [Requested_Name], [Requested_Date], [Authorised_Name], [Authorised_Date], [Custodian_Name], [Custodian_Date], [ExManager_Name], [ExManager_Date], [Captured_Name], [Captured_Date], [Information], [Instructions], [Rec_Action], [Carrying_Value], [Value_in_Use], [Fair_Value_Less], [Recoverable_Amt], [Police_Report_Nr], [Take_on_Date], [Reason_Code], [Form_Level], [Ext_Form_Reference], [Creator]) values (5158, 1, '2016-03-24 12:39:22.303', (select ComponentID from AssetFinFormInput affi where affi.Form_Reference = 5158), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '5158', NULL);
INSERT [dbo].[AssetFinFormRef] ([Form_Reference], [Form_Nr], [Issue_DateTime], [Component_ID], [Asset_Group_Name], [Requested_Name], [Requested_Date], [Authorised_Name], [Authorised_Date], [Custodian_Name], [Custodian_Date], [ExManager_Name], [ExManager_Date], [Captured_Name], [Captured_Date], [Information], [Instructions], [Rec_Action], [Carrying_Value], [Value_in_Use], [Fair_Value_Less], [Recoverable_Amt], [Police_Report_Nr], [Take_on_Date], [Reason_Code], [Form_Level], [Ext_Form_Reference], [Creator]) values (5159, 1, '2016-03-24 12:39:22.303', (select ComponentID from AssetFinFormInput affi where affi.Form_Reference = 5159), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '5159', NULL);
INSERT [dbo].[AssetFinFormRef] ([Form_Reference], [Form_Nr], [Issue_DateTime], [Component_ID], [Asset_Group_Name], [Requested_Name], [Requested_Date], [Authorised_Name], [Authorised_Date], [Custodian_Name], [Custodian_Date], [ExManager_Name], [ExManager_Date], [Captured_Name], [Captured_Date], [Information], [Instructions], [Rec_Action], [Carrying_Value], [Value_in_Use], [Fair_Value_Less], [Recoverable_Amt], [Police_Report_Nr], [Take_on_Date], [Reason_Code], [Form_Level], [Ext_Form_Reference], [Creator]) values (5160, 1, '2016-03-24 12:39:22.303', (select ComponentID from AssetFinFormInput affi where affi.Form_Reference = 5160), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '5160', NULL);
INSERT [dbo].[AssetFinFormRef] ([Form_Reference], [Form_Nr], [Issue_DateTime], [Component_ID], [Asset_Group_Name], [Requested_Name], [Requested_Date], [Authorised_Name], [Authorised_Date], [Custodian_Name], [Custodian_Date], [ExManager_Name], [ExManager_Date], [Captured_Name], [Captured_Date], [Information], [Instructions], [Rec_Action], [Carrying_Value], [Value_in_Use], [Fair_Value_Less], [Recoverable_Amt], [Police_Report_Nr], [Take_on_Date], [Reason_Code], [Form_Level], [Ext_Form_Reference], [Creator]) values (5161, 1, '2016-03-24 12:39:22.303', (select ComponentID from AssetFinFormInput affi where affi.Form_Reference = 5161), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '5161', NULL);


CREATE TABLE [dbo].[AssetFinFormState](
	[State_ID] [int] IDENTITY(1,1) NOT NULL,
	[Workflow] [varchar] (30) NOT NULL,
	[State_Prefix] [varchar](2) NULL,
	[State_Desc] [varchar](30) NULL,
	[State_Req_Group] [int] NULL,
	[Form_Level] [int] NULL,
	[Next_State] [varchar](2) NULL,
	CONSTRAINT [PK_AssetFinFormState] PRIMARY KEY CLUSTERED([State_ID] ASC)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
--Generic Financial System Integration workflow
INSERT [dbo].[AssetFinFormState] ([Workflow], [State_Prefix], [State_Desc], [State_Req_Group], [Form_Level], [Next_State]) VALUES ('GENERIC', N'CT', N'CREATED', -1, 0, N'SM');
INSERT [dbo].[AssetFinFormState] ([Workflow], [State_Prefix], [State_Desc], [State_Req_Group], [Form_Level], [Next_State]) VALUES ('GENERIC', N'SM', N'SUBMITTED', -1, 1, N'PA');
INSERT [dbo].[AssetFinFormState] ([Workflow], [State_Prefix], [State_Desc], [State_Req_Group], [Form_Level], [Next_State]) VALUES ('GENERIC', N'CO', N'COMMITTED', -1, 3, NULL);
INSERT [dbo].[AssetFinFormState] ([Workflow], [State_Prefix], [State_Desc], [State_Req_Group], [Form_Level], [Next_State]) VALUES ('GENERIC', N'PA', N'PENDING AUTHORISATION', -1, 4, N'CO');
INSERT [dbo].[AssetFinFormState] ([Workflow], [State_Prefix], [State_Desc], [State_Req_Group], [Form_Level], [Next_State]) VALUES ('GENERIC', N'FL', N'FAILED', -1, 2, N'PA');
INSERT [dbo].[AssetFinFormState] ([Workflow], [State_Prefix], [State_Desc], [State_Req_Group], [Form_Level], [Next_State]) VALUES ('GENERIC', N'DC', N'DECLINED', -1, 5, NULL);


CREATE TABLE [dbo].[AssetFinForm](
	[Form_Nr] [int] NULL,
	[Form_Desc] [varchar](40) NULL,
	[BatchPrefix] [varchar](1) NULL
) ON [PRIMARY];
INSERT INTO [AssetFinForm] (Form_Nr, Form_Desc, BatchPrefix) VALUES (-1, 'Unknown Form', 'Z');
INSERT INTO [AssetFinForm] (Form_Nr, Form_Desc, BatchPrefix) VALUES (1, 'Component Recognition', 'P');
INSERT INTO [AssetFinForm] (Form_Nr, Form_Desc, BatchPrefix) VALUES (2, 'Derecognition of Components', 'D');
INSERT INTO [AssetFinForm] (Form_Nr, Form_Desc, BatchPrefix) VALUES (3, 'Update/Correction of Component', 'C');
INSERT INTO [AssetFinForm] (Form_Nr, Form_Desc, BatchPrefix) VALUES (4, 'Impairment of Components', 'I');
INSERT INTO [AssetFinForm] (Form_Nr, Form_Desc, BatchPrefix) VALUES (5, 'Reversal of Impairment', 'R');
INSERT INTO [AssetFinForm] (Form_Nr, Form_Desc, BatchPrefix) VALUES (7, 'Upgrade', 'U');

CREATE View [dbo].[InputFormView] AS
SELECT
	AssetFinFormRef.Form_Nr,
	AssetFinFormRef.Ext_Form_Reference,
	AssetFinFormRef.Creator,
	AssetFinFormRef.Form_Level,
	AssetFinFormInput.*,
	[Issue_DateTime], [Component_ID],	[Asset_Group_Name],	[Requested_Name], [Requested_Date],	[Authorised_Name],[Authorised_Date],
	[Custodian_Name], [Custodian_Date],	[ExManager_Name],[ExManager_Date],[Captured_Name],[Captured_Date],[Information],[Instructions],
	[Rec_Action],[Carrying_Value],[Value_in_Use],[Fair_Value_Less],[Recoverable_Amt],[Police_Report_Nr],[Take_on_Date],[Reason_Code],
	[form_timestamp] [timestamp]
FROM
	AssetFinFormInput
JOIN
	AssetFinFormRef on AssetFinFormInput.Form_Reference = AssetFinFormRef.Form_Reference
JOIN
	AssetFinForm on AssetFinForm.Form_Nr = AssetFinFormRef.Form_Nr
JOIN
	AssetFinFormState on AssetFinFormState.Form_Level = AssetFinFormRef.Form_Level AND AssetFinFormState.Workflow = 'GENERIC';
