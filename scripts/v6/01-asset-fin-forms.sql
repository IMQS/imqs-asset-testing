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
	[SCOA_Item_Depreciation_Debit] [varchar](40) NULL,
  [SCOA_Item_Depreciation_Credit] [varchar](40) NULL,
	[DepreciationBudgetNr_Debit] [varchar](40) NULL,
	[DepreciationBudgetNr_Credit] [varchar](40) NULL,
	CONSTRAINT [PK_AssetFinFormInput] PRIMARY KEY CLUSTERED ([Form_Reference] ASC) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
ALTER TABLE [dbo].[AssetFinFormInput] ADD [ImpairmentReason] [varchar](4) NULL;
ALTER TABLE [dbo].[AssetFinFormInput] ADD [RevImpairmentReason] [varchar](4) NULL;
ALTER TABLE [dbo].[AssetFinFormInput] ADD [TransferCost] [numeric](18, 2) NULL;
ALTER TABLE [dbo].[AssetFinFormInput] ADD [TransferDepr] [numeric](18, 2) NULL;
ALTER TABLE [dbo].[AssetFinFormInput] ADD [TransferDate] [datetime] NULL;
ALTER TABLE [dbo].[AssetFinFormInput] ADD [RevaluationReserveOpening] [numeric](18, 2) NOT NULL;
ALTER TABLE [dbo].[AssetFinFormInput] ADD [RevaluationReserveFinYTD] [numeric](18, 2) NOT NULL;
ALTER TABLE [dbo].[AssetFinFormInput] ADD [RevaluationReserveClosing] [numeric](18, 2) NOT NULL;
ALTER TABLE [dbo].[AssetFinFormInput] ADD [RefSuburbsCode] [varchar](20) NULL;
ALTER TABLE [dbo].[AssetFinFormInput] ADD [CaseNumber] [varchar](40) NULL;
ALTER TABLE [dbo].[AssetFinFormInput] ADD [InsuranceClaimed] [bit] NULL;
ALTER TABLE [dbo].[AssetFinFormInput] ADD [InsuranceAmount] [numeric](18, 2) NULL;
ALTER TABLE [dbo].[AssetFinFormInput] ADD [TransferredFrom] [varchar](40) NULL;
ALTER TABLE [dbo].[AssetFinFormInput] ADD [TransferredTo] [varchar](40) NULL;
ALTER TABLE [dbo].[AssetFinFormInput] ADD [EquipmentNr] [varchar](18) NULL;
ALTER TABLE [dbo].[AssetFinFormInput] ADD [ImpairmentTransfer] [numeric](18, 2) NOT NULL;
ALTER TABLE [dbo].[AssetFinFormInput] ADD [SCOA_ItemAsset] [varchar](40) NULL;
ALTER TABLE [dbo].[AssetFinFormInput] ADD [MeasurementModelID] [varchar](4) NULL;
ALTER TABLE [dbo].[AssetFinFormInput] ADD [UseStatusID] [varchar](4) NULL;
ALTER TABLE [dbo].[AssetFinFormInput] ADD [FinHierarchyPath] [varchar](100) NULL;
ALTER TABLE [dbo].[AssetFinFormInput] ADD [RevaluationReserveFinYTDImp] [numeric](18, 2) NOT NULL;
ALTER TABLE [dbo].[AssetFinFormInput] ADD [RevaluationReserveFinYTDDepr] [numeric](18, 2) NOT NULL;
ALTER TABLE [dbo].[AssetFinFormInput] ADD [VerificationLastDate] [datetime] NULL;
ALTER TABLE [dbo].[AssetFinFormInput] ADD [VerificationNextDate] [datetime] NULL;
ALTER TABLE [dbo].[AssetFinFormInput] ADD [FinYear] [int] NULL;
ALTER TABLE [dbo].[AssetFinFormInput] ADD [BudgetNr] [varchar](40) NULL;
ALTER TABLE [dbo].[AssetFinFormInput] ADD [BOQPath] [varchar](40) NULL;
ALTER TABLE [dbo].[AssetFinFormInput] ADD [DepreciationBudgetNr] [varchar](40) NULL;
ALTER TABLE [dbo].[AssetFinFormInput] ADD [ReplacedComponents] [varchar](512) NULL;
ALTER TABLE [dbo].[AssetFinFormInput] ADD [UpgradeDate] [datetime] NULL;
ALTER TABLE [dbo].[AssetFinFormInput] ADD [LastMaintenanceDate] [datetime] NULL;
ALTER TABLE [dbo].[AssetFinFormInput] ADD [ImpairmentClose] [numeric](18, 2) NULL;
ALTER TABLE [dbo].[AssetFinFormInput] ADD [SoldTo] [varchar](40) NULL;
ALTER TABLE [dbo].[AssetFinFormInput] ADD [ReclassifiedComponentID] [varchar](40) NULL;
ALTER TABLE [dbo].[AssetFinFormInput] ADD [ReclassifiedClientAssetID] [varchar](40) NULL;

ALTER TABLE [dbo].[AssetFinFormInput] ADD  CONSTRAINT [DF_AssetFinFormInput_CostCentreCode]  DEFAULT ('Not Specified') FOR [CostCentreCode];
ALTER TABLE [dbo].[AssetFinFormInput] ADD  CONSTRAINT [DF_AssetFinFormInput_GeneralLedgerCode]  DEFAULT ('Not Specified') FOR [GeneralLedgerCode];
ALTER TABLE [dbo].[AssetFinFormInput] ADD  CONSTRAINT [DF_AssetFinFormInput_RespDepartmentID]  DEFAULT ('Not Specified') FOR [RespDepartmentID];
ALTER TABLE [dbo].[AssetFinFormInput] ADD  DEFAULT ((0)) FOR [RevaluationReserveOpening];
ALTER TABLE [dbo].[AssetFinFormInput] ADD  DEFAULT ((0)) FOR [RevaluationReserveFinYTD];
ALTER TABLE [dbo].[AssetFinFormInput] ADD  DEFAULT ((0)) FOR [RevaluationReserveClosing];
ALTER TABLE [dbo].[AssetFinFormInput] ADD  DEFAULT ((0)) FOR [ImpairmentTransfer];
ALTER TABLE [dbo].[AssetFinFormInput] ADD  DEFAULT ((0)) FOR [RevaluationReserveFinYTDImp];
ALTER TABLE [dbo].[AssetFinFormInput] ADD  DEFAULT ((0)) FOR [RevaluationReserveFinYTDDepr];

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
CREATE UNIQUE NONCLUSTERED INDEX [Idx_Ext_Form_Reference] ON  [dbo].[AssetFinFormRef] ([Ext_Form_Reference]);


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


CREATE TABLE [dbo].[AssetFinForm](
	[Form_Nr] [int] NULL,
	[Form_Desc] [varchar](40) NULL,
	[BatchPrefix] [varchar](1) NULL
) ON [PRIMARY];
