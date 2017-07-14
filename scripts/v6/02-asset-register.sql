-- Asset Register tables are for committed assets that have been capitalized and are in use.

IF OBJECT_ID (N'AssetRegisterView', N'V') IS NOT NULL DROP View [AssetRegisterView];
IF OBJECT_ID (N'AssetRegisterIconMove', N'U') IS NOT NULL DROP TABLE [AssetRegisterIconMove];
IF OBJECT_ID (N'AssetRegisterIconFin2015', N'U') IS NOT NULL DROP TABLE [AssetRegisterIconFin2015];
IF OBJECT_ID (N'AssetRefAccounting', N'U') IS NOT NULL DROP TABLE [AssetRefAccounting];
IF OBJECT_ID (N'AssetRefCategory', N'U') IS NOT NULL DROP TABLE [AssetRefCategory];
IF OBJECT_ID (N'AssetRefSubCategory', N'U') IS NOT NULL DROP TABLE [AssetRefSubCategory];
IF OBJECT_ID (N'AssetChangeIconFin', N'U') IS NOT NULL DROP TABLE [AssetChangeIconFin];

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
	[ForecastReplYear] [int] NULL,
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
	[DirtyFlag] [tinyint] NULL,
	[MeasurementModelID] [varchar](4) NULL,
	[UseStatusID] [varchar](4) NULL,
	[FinHierarchyPath] [varchar](100) NULL,
	[CostClosing]  AS ((((([CostOpening]+[AdditionsFinYTD])+[ProvisionAdjust])+[ValueChangeFinYTD])+[DerecognitionCost])+[TransferCost]),
	[CarryingValueClosing]  AS (((((((((((((([CostOpening]+[AdditionsFinYTD])+[ProvisionAdjust])+[ValueChangeFinYTD])+[DerecognitionCost])+[TransferCost])+[DepreciationOpening])+[DepreciationFinYTD])+[DerecognitionDepr])+[TransferDepr])+[ImpairmentAll])+[ImpairmentFinYTD])+[RevImpairmentFinYTD])+[ImpairmentDerecog])+[ImpairmentTransfer]),
	[DepreciationClosing]  AS ((([DepreciationOpening]+[DepreciationFinYTD])+[DerecognitionDepr])+[TransferDepr]),
	CONSTRAINT [PK_AssetRegisterIconFin2015] PRIMARY KEY CLUSTERED([ComponentID] ASC)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 70) ON [PRIMARY]
) ON [PRIMARY];
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
ALTER TABLE [dbo].[AssetRegisterIconFin2015] ADD  DEFAULT ((2015)) FOR [ForecastReplYear];
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
	CONSTRAINT [PK_AssetRegisterIconMove] PRIMARY KEY CLUSTERED ([ComponentID] ASC)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
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
	CONSTRAINT [PK_AssetChangeIconFin] PRIMARY KEY CLUSTERED([ComponentID] ASC,[Change_DateTime] ASC,[Attribute_Name] ASC)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY];

-- Reference tables for constant values that don't change much and are associated to AR fields via lookups
CREATE TABLE [dbo].[AssetRefAccounting](
[AccountingGroupID] [varchar](4) NOT NULL,
[AccountingGroupName] [varchar](40) NULL,
[Colour] [int] NULL,
[Visible] [bit] NULL,
[Selected] [bit] NULL,
CONSTRAINT [PK_AssetRefAccounting] PRIMARY KEY CLUSTERED([AccountingGroupID] ASC) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY];

CREATE TABLE [dbo].[AssetRefCategory](
[AccountingGroupID] [varchar](4) NOT NULL,
[AssetCategoryID] [varchar](4) NOT NULL,
[AssetCategoryName] [varchar](40) NULL,
[Colour] [int] NULL,
[Visible] [bit] NULL,
[Selected] [bit] NULL,
[ExtraCategoryID] [varchar](8) NULL,
CONSTRAINT [PK_AssetRefCategory] PRIMARY KEY CLUSTERED([AccountingGroupID] ASC, [AssetCategoryID] ASC) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY];

CREATE TABLE [dbo].[AssetRefSubCategory](
[AssetCategoryID] [varchar](4) NOT NULL,
[AssetSubCategoryID] [varchar](4) NOT NULL,
[AssetSubCategoryName] [varchar](40) NULL,
[Colour] [int] NULL,
[Visible] [bit] NULL,
[Selected] [bit] NULL,
[ExtraSubCategoryID] [varchar](8) NULL,
CONSTRAINT [PK_AssetRefSubCategory] PRIMARY KEY CLUSTERED([AssetCategoryID] ASC, [AssetSubCategoryID] ASC) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY];

ALTER TABLE [dbo].[AssetRefAccounting] ADD CONSTRAINT [DF_AssetRefAccounting_AccountingGroupID] DEFAULT ('') FOR [AccountingGroupID];
ALTER TABLE [dbo].[AssetRefAccounting] ADD CONSTRAINT [DF_AssetRefAccounting_AccountingGroupName] DEFAULT ('') FOR [AccountingGroupName];
ALTER TABLE [dbo].[AssetRefCategory] ADD CONSTRAINT [DF_AssetRefCategory_AccountingGroupID] DEFAULT ('') FOR [AccountingGroupID];
ALTER TABLE [dbo].[AssetRefCategory] ADD CONSTRAINT [DF_AssetRefCategory_AssetCategoryID] DEFAULT ('') FOR [AssetCategoryID];
ALTER TABLE [dbo].[AssetRefSubCategory] ADD CONSTRAINT [DF_AssetRefSubCategory_AssetCategoryID] DEFAULT ('') FOR [AssetCategoryID];
ALTER TABLE [dbo].[AssetRefSubCategory] ADD CONSTRAINT [DF_AssetRefSubCategory_AssetSubCategoryID] DEFAULT ('') FOR [AssetSubCategoryID];
ALTER TABLE [dbo].[AssetRefSubCategory] ADD CONSTRAINT [DF_AssetRefSubCategory_AssetSubCategoryName] DEFAULT ('') FOR [AssetSubCategoryName];