CREATE TABLE [dbo].[AssetFinFormBatch](
[BatchNr] [int] IDENTITY(1,1) NOT NULL,
[DT_CREATED] [datetime] NOT NULL,
[CREATED_BY] [varchar](30) NULL,
[Information] [varchar](max) NULL,
[Instructions] [varchar](max) NULL,
CONSTRAINT [PK_AssetFinFormBatch] PRIMARY KEY CLUSTERED
(
[BatchNr] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY];

ALTER TABLE [dbo].[AssetFinFormBatch] ADD  CONSTRAINT [DF_AssetFinFormBatch_DT_CREATED]  DEFAULT (getdate()) FOR [DT_CREATED];


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
[YearRenewed_CG] [int] NULL,
[ImpairmentDerecog] [numeric](18, 2) NULL,
[FairValueLessCostSell] [numeric](18, 2) NULL,
[ValueInUse] [numeric](18, 2) NULL,
[ImpairmentDate] [datetime] NULL,
[RevImpairmentDate] [datetime] NULL
) ON [PRIMARY];
SET ANSI_PADDING OFF;
ALTER TABLE [dbo].[AssetFinFormInput] ADD [ImpairmentReason] [varchar](4) NULL;
ALTER TABLE [dbo].[AssetFinFormInput] ADD [RevImpairmentReason] [varchar](4) NULL;
ALTER TABLE [dbo].[AssetFinFormInput] ADD [TransferCost] [numeric](18, 2) NULL;
ALTER TABLE [dbo].[AssetFinFormInput] ADD [TransferDepr] [numeric](18, 2) NULL;
ALTER TABLE [dbo].[AssetFinFormInput] ADD [TransferDate] [datetime] NULL;
ALTER TABLE [dbo].[AssetFinFormInput] ADD [ImpairmentClose] [numeric](18, 2) NULL;
ALTER TABLE [dbo].[AssetFinFormInput] ADD [RevaluationReserveOpening] [numeric](18, 2) NOT NULL;
ALTER TABLE [dbo].[AssetFinFormInput] ADD [RevaluationReserveFinYTD] [numeric](18, 2) NOT NULL;
ALTER TABLE [dbo].[AssetFinFormInput] ADD [RevaluationReserveClosing] [numeric](18, 2) NOT NULL;
SET ANSI_PADDING ON;
ALTER TABLE [dbo].[AssetFinFormInput] ADD [RefSuburbsCode] [varchar](20) NULL;
ALTER TABLE [dbo].[AssetFinFormInput] ADD [CaseNumber] [varchar](40) NULL;
ALTER TABLE [dbo].[AssetFinFormInput] ADD [InsuranceClaimed] [bit] NULL;
ALTER TABLE [dbo].[AssetFinFormInput] ADD [InsuranceAmount] [numeric](18, 2) NULL;
ALTER TABLE [dbo].[AssetFinFormInput] ADD [TransferredFrom] [varchar](40) NULL;
ALTER TABLE [dbo].[AssetFinFormInput] ADD [TransferredTo] [varchar](40) NULL;
SET ANSI_PADDING OFF;
ALTER TABLE [dbo].[AssetFinFormInput] ADD [EquipmentNr] [varchar](18) NULL;
ALTER TABLE [dbo].[AssetFinFormInput] ADD [ImpairmentTransfer] [numeric](18, 2) NOT NULL;
SET ANSI_PADDING ON;
ALTER TABLE [dbo].[AssetFinFormInput] ADD [SCOA_Fund] [varchar](40) NULL;
ALTER TABLE [dbo].[AssetFinFormInput] ADD [SCOA_Function] [varchar](40) NULL;
ALTER TABLE [dbo].[AssetFinFormInput] ADD [SCOA_Mun_Classification] [varchar](40) NULL;
ALTER TABLE [dbo].[AssetFinFormInput] ADD [SCOA_Project] [varchar](40) NULL;
ALTER TABLE [dbo].[AssetFinFormInput] ADD [SCOA_Costing] [varchar](40) NULL;
ALTER TABLE [dbo].[AssetFinFormInput] ADD [SCOA_Region] [varchar](40) NULL;
ALTER TABLE [dbo].[AssetFinFormInput] ADD [SCOA_ItemAsset] [varchar](40) NULL;
ALTER TABLE [dbo].[AssetFinFormInput] ADD [SCOA_Item_Depreciation_Debit] [varchar](40) NULL;
ALTER TABLE [dbo].[AssetFinFormInput] ADD [SCOA_Item_Depreciation_Credit] [varchar](40) NULL;
SET ANSI_PADDING OFF;
ALTER TABLE [dbo].[AssetFinFormInput] ADD [MeasurementModelID] [varchar](4) NULL;
ALTER TABLE [dbo].[AssetFinFormInput] ADD [UseStatusID] [varchar](4) NULL;
ALTER TABLE [dbo].[AssetFinFormInput] ADD [FinHierarchyPath] [varchar](100) NULL;
ALTER TABLE [dbo].[AssetFinFormInput] ADD [RevaluationReserveFinYTDImp] [numeric](18, 2) NOT NULL;
ALTER TABLE [dbo].[AssetFinFormInput] ADD [RevaluationReserveFinYTDDepr] [numeric](18, 2) NOT NULL;
ALTER TABLE [dbo].[AssetFinFormInput] ADD [VerificationLastDate] [datetime] NULL;
ALTER TABLE [dbo].[AssetFinFormInput] ADD [VerificationNextDate] [datetime] NULL;
ALTER TABLE [dbo].[AssetFinFormInput] ADD [FinYear] [int] NULL;
ALTER TABLE [dbo].[AssetFinFormInput] ADD [UpgradeDate] [datetime] NULL;
ALTER TABLE [dbo].[AssetFinFormInput] ADD [BudgetNr] [varchar](40) NULL;
ALTER TABLE [dbo].[AssetFinFormInput] ADD [LastMaintenanceDate] [datetime] NULL,
CONSTRAINT [PK_AssetFinFormInput] PRIMARY KEY CLUSTERED
(
[Form_Reference] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];

SET ANSI_PADDING OFF;
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
CONSTRAINT [PK_AssetFinFormRef] PRIMARY KEY CLUSTERED
(
[Form_Reference] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY];


CREATE TABLE [dbo].[AssetFinFormState](
[State_ID] [int] IDENTITY(1,1) NOT NULL,
[Workflow] [varchar] (30) NOT NULL,
[State_Prefix] [varchar](2) NULL,
[State_Desc] [varchar](30) NULL,
[State_Req_Group] [int] NULL,
[Form_Level] [int] NULL,
[Next_State] [varchar](2) NULL,
CONSTRAINT [PK_AssetFinFormState] PRIMARY KEY CLUSTERED
(
[State_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
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

CREATE TABLE [dbo].[AssetRegisterIconFin2015](
[FAR_ID] [int] IDENTITY(1,1) NOT NULL,
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
[FairValue] [numeric](18, 2) NOT NULL,
[CostOpening] [numeric](18, 2) NOT NULL,
[CarryingValueOpening] [numeric](18, 2) NOT NULL,
[FundingSourceID] [varchar](30) NULL,
[FundingTypeID] [varchar](30) NULL,
[RespDepartmentID] [varchar](40) NULL,
[AssetCustodianID] [varchar](40) NULL,
[CustodianshipDate] [datetime] NULL,
[BasicMunService] [varchar](4) NULL,
[ApplicableContracts] [varchar](40) NULL,
[InsurancePolicyNr] [varchar](40) NULL,
[InsuranceCover] [numeric](18, 2) NOT NULL,
[DebtSecurityApplicable] [bit] NOT NULL,
[DebtSecurityExpiryDate] [datetime] NULL,
[YearConstruct] [int] NULL,
[YearConstruct_CG] [int] NULL,
[YearRenewed] [int] NULL,
[YearRenewed_CG] [int] NULL,
[DateLastRenewed] [datetime] NULL,
[AdditionsOpening] [numeric](18, 2) NOT NULL,
[AdditionsFinYTD] [numeric](18, 2) NOT NULL,
[AdditionsClosing]  AS ([AdditionsOpening]+[AdditionsFinYTD]),
[AdditionsFundSourceID] [varchar](20) NULL,
[AdditionsFundTypeID] [varchar](20) NULL,
[AdditionsNature] [varchar](20) NULL,
[EUL] [int] NULL,
[EUL_Adjusted] [int] NULL,
[RUL] [numeric](18, 2) NULL,
[ResidualPct] [numeric](18, 2) NOT NULL,
[ResidualValue]  AS (([CostOpening]+[AdditionsFinYTD])*([ResidualPct]/(100.0))),
[DepreciationMethodID] [varchar](4) NULL,
[DepreciationOpening] [numeric](18, 2) NOT NULL,
[DepreciationFinYTD] [numeric](18, 2) NOT NULL,
[ProvisionOpening] [numeric](18, 2) NOT NULL,
[ProvisionAdjust] [numeric](18, 2) NOT NULL,
[ProvisionClosing]  AS ([ProvisionOpening]+[ProvisionAdjust]),
[CashGenerating] [varchar](4) NULL,
[DisposalMethodID] [varchar](4) NULL,
[DisposalProceedCost] [numeric](18, 2) NOT NULL,
[DisposalProfitLoss]  AS (([DerecognitionDepr]+[DerecognitionCost])+[DisposalProceedCost]),
[DerecognitionDate] [datetime] NULL,
[DerecognitionCost] [numeric](18, 2) NOT NULL,
[DerecognitionDepr] [numeric](18, 2) NOT NULL,
[TransferDate] [datetime] NULL,
[TransferCost] [numeric](18, 2) NOT NULL,
[TransferDepr] [numeric](18, 2) NOT NULL,
[FairValueLessCostSell] [numeric](18, 2) NOT NULL,
[ValueInUse] [numeric](18, 2) NOT NULL,
[ImpairmentAll] [numeric](18, 2) NOT NULL,
[ImpairmentFinYTD] [numeric](18, 2) NOT NULL,
[RevImpairmentFinYTD] [numeric](18, 2) NOT NULL,
[ImpairmentDerecog] [numeric](18, 2) NOT NULL,
[ImpairmentClose]  AS (((([ImpairmentAll]+[ImpairmentFinYTD])+[RevImpairmentFinYTD])+[ImpairmentDerecog])+[ImpairmentTransfer]),
[RevImpairmentAll] [numeric](18, 2) NOT NULL,
[RevImpairmentClose]  AS ([RevImpairmentFinYTD]+[RevImpairmentAll]),
[ImpairmentDate] [datetime] NULL,
[RevImpairmentDate] [datetime] NULL,
[RevaluationLastDate] [datetime] NULL,
[RevaluationNextDate] [datetime] NULL,
[RevaluationMethod] [varchar](4) NULL,
[CRC] [numeric](18, 2) NOT NULL,
[RevaluedAmount] [numeric](18, 2) NOT NULL,
[ValueChangeFinYTD] [numeric](18, 2) NOT NULL,
[RevaluationReserveOpening] [numeric](18, 2) NOT NULL,
[RevaluationReserveFinYTD] [numeric](18, 2) NOT NULL,
[RevaluationReserveClosing]  AS ([RevaluationReserveOpening]+[RevaluationReserveFinYTD]),
[RevaluationRUL] [int] NULL,
[RevaluedBy] [varchar](40) NULL,
[RevaluationAccuracy] [int] NULL,
[CriticalityGrade] [int] NULL,
[CriticalityGrade_CG] [int] NULL,
[ConditionGrade] [int] NULL,
[ConditionGrade_CG] [int] NULL,
[PerformanceGrade] [int] NULL,
[PerformanceGrade_CG] [int] NULL,
[UtilisationGrade] [int] NULL,
[UtilisationGrade_CG] [int] NULL,
[OpsCostGrade] [int] NULL,
[OpsCostGrade_CG] [int] NULL,
[RiskExposure] [int] NULL,
[ForecastReplYear]  [int] DEFAULT 2015,
[ForecastReplValue] [numeric](18, 2) NULL,
[CRC_Adjusted] [numeric](18, 2) NULL,
[DRC]  AS (case when isnull([EUL],(0))>(0) then ([CRC]-([CRC]*[ResidualPct])/(100.0))*([RUL]/[EUL])+([CRC]*[ResidualPct])/(100.0)  end),
[AnnualisedMaintPct] [numeric](18, 2) NULL,
[MaintenanceBudgetNeed]  AS (isnull([CRC_Adjusted],(0))*(isnull([AnnualisedMaintPct],(0))/(100.0))),
[MaintenanceBudgetPct] [numeric](18, 2) NULL,
[MaintenanceExpenditure] [numeric](18, 2) NOT NULL,
[DateCreated] [datetime] NOT NULL,
[DateLastFinMonth] [datetime] NULL,
[ImpairmentReason] [varchar](4) NULL,
[RevImpairmentReason] [varchar](4) NULL,
[Impairment_Review_Date] [datetime] NULL,
[RefSuburbsCode] [varchar](20) NULL,
[CaseNumber] [varchar](40) NULL,
[InsuranceClaimed] [bit] NULL,
[InsuranceAmount] [numeric](18, 2) NULL,
[TransferredFrom] [varchar](40) NULL,
[TransferredTo] [varchar](40) NULL,
[ImpairmentTransfer] [numeric](18, 2) NOT NULL,
[SCOA_Fund] [varchar](40) NULL,
[SCOA_Function] [varchar](40) NULL,
[SCOA_Mun_Classification] [varchar](40) NULL,
[SCOA_Project] [varchar](40) NULL,
[SCOA_Costing] [varchar](40) NULL,
[SCOA_Region] [varchar](40) NULL,
[SCOA_ItemAsset] [varchar](40) NULL,
[DirtyFlag] [tinyint] NULL
) ON [PRIMARY];
SET ANSI_PADDING OFF;
ALTER TABLE [dbo].[AssetRegisterIconFin2015] ADD [MeasurementModelID] [varchar](4) NULL;
ALTER TABLE [dbo].[AssetRegisterIconFin2015] ADD [UseStatusID] [varchar](4) NULL;
ALTER TABLE [dbo].[AssetRegisterIconFin2015] ADD [FinHierarchyPath] [varchar](100) NULL;
ALTER TABLE [dbo].[AssetRegisterIconFin2015] ADD [CostClosing]  AS ((((([CostOpening]+[AdditionsFinYTD])+[ProvisionAdjust])+[ValueChangeFinYTD])+[DerecognitionCost])+[TransferCost]);
ALTER TABLE [dbo].[AssetRegisterIconFin2015] ADD [CarryingValueClosing]  AS (((((((((((((([CostOpening]+[AdditionsFinYTD])+[ProvisionAdjust])+[ValueChangeFinYTD])+[DerecognitionCost])+[TransferCost])+[DepreciationOpening])+[DepreciationFinYTD])+[DerecognitionDepr])+[TransferDepr])+[ImpairmentAll])+[ImpairmentFinYTD])+[RevImpairmentFinYTD])+[ImpairmentDerecog])+[ImpairmentTransfer]);
ALTER TABLE [dbo].[AssetRegisterIconFin2015] ADD [DepreciationClosing]  AS ((([DepreciationOpening]+[DepreciationFinYTD])+[DerecognitionDepr])+[TransferDepr]);
ALTER TABLE [dbo].[AssetRegisterIconFin2015] ADD  CONSTRAINT [PK_AssetRegisterIconFin2015] PRIMARY KEY CLUSTERED
(
[ComponentID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 70) ON [PRIMARY];
ALTER TABLE [dbo].[AssetRegisterIconFin2015] ADD  DEFAULT ((0)) FOR [Extent];
ALTER TABLE [dbo].[AssetRegisterIconFin2015] ADD  DEFAULT ((0)) FOR [Extent_Unit_Rate];
ALTER TABLE [dbo].[AssetRegisterIconFin2015] ADD  CONSTRAINT [DF_AssetRegisterIconFin2015_CostCentreCode]  DEFAULT ('Not Specified') FOR [CostCentreCode];
ALTER TABLE [dbo].[AssetRegisterIconFin2015] ADD  CONSTRAINT [DF_AssetRegisterIconFin2015_GeneralLedgerCode]  DEFAULT ('Not Specified') FOR [GeneralLedgerCode];
ALTER TABLE [dbo].[AssetRegisterIconFin2015] ADD  DEFAULT ((0)) FOR [FairValue];
ALTER TABLE [dbo].[AssetRegisterIconFin2015] ADD  DEFAULT ((0)) FOR [CostOpening];
ALTER TABLE [dbo].[AssetRegisterIconFin2015] ADD  DEFAULT ((0)) FOR [CarryingValueOpening];
ALTER TABLE [dbo].[AssetRegisterIconFin2015] ADD  CONSTRAINT [DF_AssetRegisterIconFin2015_RespDepartmentID]  DEFAULT ('Not Specified') FOR [RespDepartmentID];
ALTER TABLE [dbo].[AssetRegisterIconFin2015] ADD  DEFAULT ((0)) FOR [InsuranceCover];
ALTER TABLE [dbo].[AssetRegisterIconFin2015] ADD  DEFAULT ((0)) FOR [DebtSecurityApplicable];
ALTER TABLE [dbo].[AssetRegisterIconFin2015] ADD  DEFAULT ((0)) FOR [AdditionsOpening];
ALTER TABLE [dbo].[AssetRegisterIconFin2015] ADD  DEFAULT ((0)) FOR [AdditionsFinYTD];
ALTER TABLE [dbo].[AssetRegisterIconFin2015] ADD  DEFAULT ((0)) FOR [ResidualPct];
ALTER TABLE [dbo].[AssetRegisterIconFin2015] ADD  DEFAULT ((0)) FOR [DepreciationOpening];
ALTER TABLE [dbo].[AssetRegisterIconFin2015] ADD  DEFAULT ((0)) FOR [DepreciationFinYTD];
ALTER TABLE [dbo].[AssetRegisterIconFin2015] ADD  DEFAULT ((0)) FOR [ProvisionOpening];
ALTER TABLE [dbo].[AssetRegisterIconFin2015] ADD  DEFAULT ((0)) FOR [ProvisionAdjust];
ALTER TABLE [dbo].[AssetRegisterIconFin2015] ADD  DEFAULT ((0)) FOR [DisposalProceedCost];
ALTER TABLE [dbo].[AssetRegisterIconFin2015] ADD  DEFAULT ((0)) FOR [DerecognitionCost];
ALTER TABLE [dbo].[AssetRegisterIconFin2015] ADD  DEFAULT ((0)) FOR [DerecognitionDepr];
ALTER TABLE [dbo].[AssetRegisterIconFin2015] ADD  CONSTRAINT [DF_AssetRegisterIconFin2015_TransferCost]  DEFAULT ((0)) FOR [TransferCost];
ALTER TABLE [dbo].[AssetRegisterIconFin2015] ADD  CONSTRAINT [DF_AssetRegisterIconFin2015_TransferDepr]  DEFAULT ((0)) FOR [TransferDepr];
ALTER TABLE [dbo].[AssetRegisterIconFin2015] ADD  DEFAULT ((0)) FOR [FairValueLessCostSell];
ALTER TABLE [dbo].[AssetRegisterIconFin2015] ADD  DEFAULT ((0)) FOR [ValueInUse];
ALTER TABLE [dbo].[AssetRegisterIconFin2015] ADD  DEFAULT ((0)) FOR [ImpairmentAll];
ALTER TABLE [dbo].[AssetRegisterIconFin2015] ADD  DEFAULT ((0)) FOR [ImpairmentFinYTD];
ALTER TABLE [dbo].[AssetRegisterIconFin2015] ADD  DEFAULT ((0)) FOR [RevImpairmentFinYTD];
ALTER TABLE [dbo].[AssetRegisterIconFin2015] ADD  DEFAULT ((0)) FOR [ImpairmentDerecog];
ALTER TABLE [dbo].[AssetRegisterIconFin2015] ADD  DEFAULT ((0)) FOR [RevImpairmentAll];
ALTER TABLE [dbo].[AssetRegisterIconFin2015] ADD  DEFAULT ((0)) FOR [CRC];
ALTER TABLE [dbo].[AssetRegisterIconFin2015] ADD  DEFAULT ((0)) FOR [RevaluedAmount];
ALTER TABLE [dbo].[AssetRegisterIconFin2015] ADD  DEFAULT ((0)) FOR [ValueChangeFinYTD];
ALTER TABLE [dbo].[AssetRegisterIconFin2015] ADD  DEFAULT ((0)) FOR [RevaluationReserveOpening];
ALTER TABLE [dbo].[AssetRegisterIconFin2015] ADD  DEFAULT ((0)) FOR [RevaluationReserveFinYTD];
ALTER TABLE [dbo].[AssetRegisterIconFin2015] ADD  DEFAULT ((0)) FOR [ForecastReplValue];
ALTER TABLE [dbo].[AssetRegisterIconFin2015] ADD  DEFAULT ((0)) FOR [MaintenanceExpenditure];
ALTER TABLE [dbo].[AssetRegisterIconFin2015] ADD  DEFAULT (getdate()) FOR [DateCreated];
ALTER TABLE [dbo].[AssetRegisterIconFin2015] ADD  DEFAULT ((0)) FOR [ImpairmentTransfer];
ALTER TABLE [dbo].[AssetRegisterIconFin2015] ADD  DEFAULT ((0)) FOR [DirtyFlag];

CREATE TABLE [dbo].[AssetRegisterIconMove](
[ComponentID] [varchar](40) NOT NULL,
[Asset_Barcode_Nr] [varchar](40) NULL,
[Room_Barcode_Nr] [varchar](40) NULL,
[Room_Number] [varchar](40) NULL,
[Building_Name] [varchar](40) NULL,
[Serial_Number] [varchar](40) NULL,
[Fleet_Number] [varchar](32) NULL,
[Fleet_Reg_Year] [int] NULL,
[Treasury_Code] [varchar](30) NULL,
[Cost_Centre] [varchar](32) NULL,
[Acquisition_Date] [datetime] NULL,
CONSTRAINT [PK_AssetRegisterIconMove] PRIMARY KEY CLUSTERED
(
[ComponentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];


CREATE TABLE [dbo].[AssetChangeIconFin](
[ComponentID] [varchar](40) NOT NULL,
[Change_DateTime] [datetime] NOT NULL CONSTRAINT [DF_AssetChangeIconFin_Change_DateTime]  DEFAULT (getdate()),
[Attribute_Name] [varchar](32) NOT NULL,
[Changed_By] [varchar](32) NULL,
[Value_Before] [varchar](255) NULL,
[Value_After] [varchar](255) NULL,
[Change_Reason] [varchar](255) NULL,
[HostName] [varchar](max) NOT NULL CONSTRAINT [DF_AssetChangeIconFin_HostName]  DEFAULT (host_name()),
CONSTRAINT [PK_AssetChangeIconFin] PRIMARY KEY CLUSTERED
(
[ComponentID] ASC,
[Change_DateTime] ASC,
[Attribute_Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY];


CREATE TABLE [dbo].[AssetRefCounter](
[counter_name] [varchar](30) NOT NULL,
[counter_prev_id] [int] NULL,
[counter_current_id] [int] NULL,
[counter_next_id] [int] NULL,
CONSTRAINT [PK_AssetRefCounter] PRIMARY KEY CLUSTERED
(
[counter_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];

INSERT INTO AssetRefCounter (counter_name, counter_prev_id, counter_current_id, counter_next_id) VALUES ('assetfinformref', 0,1,2);
INSERT INTO AssetRefCounter (counter_name, counter_prev_id, counter_current_id, counter_next_id) VALUES ('componentidpostfix', 0,1,2);

-- Used by SP GetForecastReplYear that is used by teh AssetRegisterIconFin table
CREATE TABLE [dbo].[AssetPolicyGeneral](
[Section] [varchar](40) NOT NULL,
[Identifier] [varchar](80) NOT NULL,
[Value] [varchar](80) NULL,
[Description] [varchar](160) NULL,
[Modified_By] [varchar](40) NULL,
[Modified_On] [datetime] NULL,
CONSTRAINT [PK_AssetPolicyGeneral_CombKey] PRIMARY KEY CLUSTERED
(
[Section] ASC,
[Identifier] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];

SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;

CREATE TABLE [dbo].[SCOAClassification](
[Id] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
[SCOAId] [nvarchar](250) NULL,
[ParentSCOAId] [nvarchar](250) NULL,
[DefinitionDescription] [nvarchar](2048) NULL,
[SCOAFile] [nvarchar](100) NULL,
[SCOAAccount] [nvarchar](1024) NULL,
[SCOALevel] [int] NULL,
[ExcelRowNumber] [int] NULL,
[ShortDescription] [nvarchar](500) NULL,
[VATStatus] [nvarchar](50) NULL,
[BreakDownAllowed] [nvarchar](50) NULL,
[Principle] [nvarchar](250) NULL,
[ApplicableTo] [nvarchar](50) NULL,
[bPostingLevel] [nvarchar](50) NULL,
[PostingLevelDescription] [nvarchar](250) NULL,
[AccountNumber] [nvarchar](250) NULL,
[AccountNumberPrefix] [nvarchar](5) NULL,
[AccountNumber1] [int] NULL,
[AccountNumber2] [int] NULL,
[AccountNumber3] [int] NULL,
[AccountNumber4] [int] NULL,
[AccountNumber5] [int] NULL,
[AccountNumber6] [int] NULL,
[AccountNumber7] [int] NULL,
[AccountNumber8] [int] NULL,
[AccountNumber9] [int] NULL,
[AccountNumber10] [int] NULL,
[AccountNumber11] [int] NULL,
[AccountNumber12] [int] NULL,
[GFSCode] [int] NULL,
[Path] [nvarchar](450) NULL,
[SCOASegment] [nvarchar](20) NULL,
[Linkable] [bit] NULL,
CONSTRAINT [PK_SCOAClassification_Id] PRIMARY KEY CLUSTERED
(
[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
ALTER TABLE [dbo].[SCOAClassification] ADD  CONSTRAINT [DF_SCOAClassification_Id]  DEFAULT (newid()) FOR [Id];
ALTER TABLE [dbo].[SCOAClassification] ADD  DEFAULT ((0)) FOR [Linkable];

-------------------------
-- Extra stuff I added
-------------------------
ALTER TABLE [dbo].[AssetFinFormBatch] ADD [Ext_Batch_Reference] [varchar](40) NULL;
CREATE UNIQUE NONCLUSTERED INDEX [Idx_Ext_Batch_Reference] ON  [dbo].[AssetFinFormBatch] ([Ext_Batch_Reference]);

ALTER TABLE [dbo].[AssetFinFormRef] ADD [Ext_Form_Reference] [varchar](40) NULL;
CREATE UNIQUE NONCLUSTERED INDEX [Idx_Ext_Form_Reference] ON  [dbo].[AssetFinFormRef] ([Ext_Form_Reference]);
ALTER TABLE [dbo].[AssetFinFormRef] ADD [Creator] [varchar](40) NULL;

CREATE TABLE [dbo].[SCOAJournal](
[Form_Reference] [int] NOT NULL,
[ComponentID] [varchar](40) NOT NULL,
[FinancialField] [varchar](15) NOT NULL,
[Date] [datetime2](3) NULL,
[Amount] [decimal](18, 2) NULL,
[SCOA_Fund] [varchar](40) NULL,
[SCOA_Function] [varchar](40) NULL,
[SCOA_Mun_Classification] [varchar](40) NULL,
[SCOA_Project] [varchar](40) NULL,
[SCOA_Costing] [varchar](40) NULL,
[SCOA_Region] [varchar](40) NULL,
[SCOA_Item_Debit] [varchar](40) NULL,
[SCOA_Item_Credit] [varchar](40) NULL,
[SCOAFileName] [varchar](150) NULL,
[SCOAFileDate] [datetime] NULL,
[CommittedToRegister] [int] NOT NULL,
[FinYear] [int] NOT NULL,
[RollupID] [int] NULL,
[FinSysBatchID] [varchar](40) NULL,
[Period] [int] NULL,
[EffectiveDate] [datetime] NULL,
[BudgetID] [varchar](40) NULL,
[ProjectID] [varchar](40) NULL,
[IMQSBatchID] [bigint] NULL,
[PostingCreditID] [bigint] NULL,
[PostingDebitID] [bigint] NULL,
CONSTRAINT [PK_SCOAJournal] PRIMARY KEY CLUSTERED
(
[Form_Reference] ASC,
[ComponentID] ASC,
[FinancialField] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
ALTER TABLE [dbo].[SCOAJournal] ADD  DEFAULT ((0)) FOR [CommittedToRegister];


CREATE TABLE [dbo].[AssetProject2015](
[Project_ID] [varchar](40) NOT NULL,
[AccountingGroupID] [varchar](4) NULL,
[AssetCategoryID] [varchar](4) NULL,
[AssetSubCategoryID] [varchar](4) NULL,
[AssetGroupID] [varchar](4) NULL,
[Project_Number] [varchar](40) NULL,
[Project_Name] [varchar](100) NULL,
[Project_Nature] [varchar](80) NULL,
[Project_Descr] [text] NULL,
[Project_Location] [varchar](40) NULL,
[Map_Feature_ID] [varchar](32) NULL,
[Department] [varchar](40) NULL,
[TreasuryCode] [varchar](40) NULL,
[CostCentreCode] [varchar](40) NULL,
[GeneralLedgerCode] [varchar](40) NULL,
[Method_Construct] [varchar](16) NULL,
[Funding_Types] [varchar](16) NULL,
[Funding_Sources] [varchar](16) NULL,
[Supplier_ID] [varchar](40) NULL,
[Design_Supervision] [varchar](40) NULL,
[Capital_Cost_Open] [numeric](18, 2) NULL,
[Capital_Cost_Year] [numeric](18, 2) NULL,
[WIP_Capitalised] [numeric](18, 2) NULL,
[Additions_Capitalised] [numeric](18, 2) NULL,
[TransferCost] [numeric](18, 2) NOT NULL,
[ImpairmentAll] [numeric](18, 2) NOT NULL,
[ImpairmentFinYTD] [numeric](18, 2) NOT NULL,
[RevImpairmentOpening] [numeric](18, 2) NOT NULL,
[RevImpairmentFinYTD] [numeric](18, 2) NOT NULL,
[RevImpairmentClosing] [numeric](19, 2) NULL,
[Impairment_Date] [datetime] NULL,
[Impairment_Descr] [text] NULL,
[Is_Completed] [varchar](4) NULL,
[Date_Completed] [datetime] NULL,
[Date_Available] [datetime] NULL,
[Is_Capitalised] [varchar](4) NULL,
[Date_Capitalised] [datetime] NULL,
[Capitalised_By] [varchar](16) NULL,
[InvoiceOverride] [bit] NOT NULL,
[ImpairmentFinYTD_Capitalised] [numeric](18, 2) NULL,
[RevImpairmentFinYTD_Capitalised] [numeric](18, 2) NULL,
[PartialCapitalisation] [bit] NULL,
[Is_PartiallyCapitalised] [bit] NULL,
[Capital_Cost_Close] [numeric](21, 2) NULL,
[ImpairmentOpeningCapitalised] [numeric](18, 2) NOT NULL,
[ImpairmentClosing] [numeric](23, 2) NULL,
[CarryingValueClosing] [numeric](27, 2) NULL,
[SCOA_Fund] [varchar](40) NULL,
[SCOA_Function] [varchar](40) NULL,
[SCOA_Mun_Classification] [varchar](40) NULL,
[SCOA_Project] [varchar](40) NULL,
[SCOA_Costing] [varchar](40) NULL,
[SCOA_Region] [varchar](40) NULL,
[SCOA_ItemAsset] [varchar](40) NULL,
[TransferCost_Capitalised] [numeric](18, 2) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY];



CREATE TABLE [dbo].[AssetRefAccounting](
[AccountingGroupID] [varchar](4) NOT NULL,
[AccountingGroupName] [varchar](40) NULL,
[Colour] [int] NULL,
[Visible] [bit] NULL,
[Selected] [bit] NULL,
CONSTRAINT [PK_AssetRefAccounting] PRIMARY KEY CLUSTERED
(
[AccountingGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY];

CREATE TABLE [dbo].[AssetRefCategory](
[AccountingGroupID] [varchar](4) NOT NULL,
[AssetCategoryID] [varchar](4) NOT NULL,
[AssetCategoryName] [varchar](40) NULL,
[Colour] [int] NULL,
[Visible] [bit] NULL,
[Selected] [bit] NULL,
[ExtraCategoryID] [varchar](8) NULL,
CONSTRAINT [PK_AssetRefCategory] PRIMARY KEY CLUSTERED
(
[AccountingGroupID] ASC,
[AssetCategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY];

CREATE TABLE [dbo].[AssetRefSubCategory](
[AssetCategoryID] [varchar](4) NOT NULL,
[AssetSubCategoryID] [varchar](4) NOT NULL,
[AssetSubCategoryName] [varchar](40) NULL,
[Colour] [int] NULL,
[Visible] [bit] NULL,
[Selected] [bit] NULL,
[ExtraSubCategoryID] [varchar](8) NULL,
CONSTRAINT [PK_AssetRefSubCategory] PRIMARY KEY CLUSTERED
(
[AssetCategoryID] ASC,
[AssetSubCategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY];

ALTER TABLE [dbo].[AssetRefAccounting] ADD  CONSTRAINT [DF_AssetRefAccounting_AccountingGroupID]  DEFAULT ('') FOR [AccountingGroupID];
ALTER TABLE [dbo].[AssetRefAccounting] ADD  CONSTRAINT [DF_AssetRefAccounting_AccountingGroupName]  DEFAULT ('') FOR [AccountingGroupName];
ALTER TABLE [dbo].[AssetRefCategory] ADD  CONSTRAINT [DF_AssetRefCategory_AccountingGroupID]  DEFAULT ('') FOR [AccountingGroupID];
ALTER TABLE [dbo].[AssetRefCategory] ADD  CONSTRAINT [DF_AssetRefCategory_AssetCategoryID]  DEFAULT ('') FOR [AssetCategoryID];
ALTER TABLE [dbo].[AssetRefSubCategory] ADD  CONSTRAINT [DF_AssetRefSubCategory_AssetCategoryID]  DEFAULT ('') FOR [AssetCategoryID];
ALTER TABLE [dbo].[AssetRefSubCategory] ADD  CONSTRAINT [DF_AssetRefSubCategory_AssetSubCategoryID]  DEFAULT ('') FOR [AssetSubCategoryID];
ALTER TABLE [dbo].[AssetRefSubCategory] ADD  CONSTRAINT [DF_AssetRefSubCategory_AssetSubCategoryName]  DEFAULT ('') FOR [AssetSubCategoryName];

CREATE TABLE [dbo].[AssetFinYear](
[FinYearID] [int] IDENTITY(1,1) NOT NULL,
[FinYear] [int] NOT NULL,
[HasValRegister] [varchar](50) NULL,
[HasFinRegister] [varchar](50) NULL,
[DT_LastUpdate] [datetime] NULL,
[HasPolicyRates] [bit] NULL,
[IsFinLocked] [bit] NULL,
[IsValLocked] [bit] NULL,
[DT_Locked] [datetime] NULL,
[Locked_By] [varchar](30) NULL,
[Period] [int] NULL,
CONSTRAINT [PK_AssetFinYear_FinYear] PRIMARY KEY CLUSTERED
(
[FinYear] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[AssetFinYear] ADD  CONSTRAINT [DF_AssetFinyear_DTLastUpdate]  DEFAULT (getdate()) FOR [DT_LastUpdate]
ALTER TABLE [dbo].[AssetFinYear] ADD  CONSTRAINT [DF_AssetFinyear_HasPolicyRates]  DEFAULT ((0)) FOR [HasPolicyRates]
ALTER TABLE [dbo].[AssetFinYear] ADD  CONSTRAINT [DF_AssetFinyear_IsFinLocked]  DEFAULT ((0)) FOR [IsFinLocked]
ALTER TABLE [dbo].[AssetFinYear] ADD  CONSTRAINT [DF_AssetFinyear_IsValLocked]  DEFAULT ((0)) FOR [IsValLocked]