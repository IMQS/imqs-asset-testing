CREATE TABLE [dbo].[AssetRegisterDerecognitions](
	[FinYear] [int] NULL,
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
	[FairValue] [numeric](18, 2) NULL,
	[CostOpening] [numeric](18, 2) NULL,
	[CarryingValueOpening] [numeric](18, 2) NULL,
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
	[AdditionsClosing]  AS ([AdditionsOpening]+[AdditionsFinYTD]),
	[AdditionsFundSourceID] [varchar](30) NULL,
	[AdditionsFundTypeID] [varchar](30) NULL,
	[AdditionsNature] [varchar](30) NULL,
	[TransferDate] [datetime] NULL,
	[TransferCost] [numeric](18, 2) NOT NULL,
	[TransferDepr] [numeric](18, 2) NOT NULL,
	[EUL] [int] NULL,
	[EUL_Adjusted] [int] NULL,
	[RUL] [numeric](18, 2) NULL,
	[ResidualPct] [numeric](18, 2) NOT NULL,
	[ResidualValue]  AS (([CostOpening]+[AdditionsFinYTD])*([ResidualPct]/(100.0))),
	[DepreciationMethodID] [varchar](4) NULL,
	[DepreciationOpening] [numeric](18, 2) NULL,
	[DepreciationFinYTD] [numeric](18, 2) NULL,
	[ProvisionOpening] [numeric](18, 2) NULL,
	[ProvisionAdjust] [numeric](18, 2) NULL,
	[ProvisionClosing]  AS ([ProvisionOpening]+[ProvisionAdjust]),
	[CashGenerating] [varchar](4) NULL,
	[DisposalMethodID] [varchar](4) NULL,
	[DisposalProceedCost] [numeric](18, 2) NULL,
	[DerecognitionDate] [datetime] NULL,
	[DerecognitionCost] [numeric](18, 2) NULL,
	[DerecognitionDepr] [numeric](18, 2) NULL,
	[ImpairmentAll] [numeric](18, 2) NULL,
	[ImpairmentFinYTD] [numeric](18, 2) NULL,
	[RevImpairmentAll] [numeric](18, 2) NULL,
	[RevImpairmentFinYTD] [numeric](18, 2) NULL,
	[RevImpairmentClose]  AS ([RevImpairmentFinYTD]+[RevImpairmentAll]),
	[RevaluationLastDate] [datetime] NULL,
	[RevaluationNextDate] [datetime] NULL,
	[RevaluationMethod] [varchar](4) NULL,
	[CRC] [numeric](18, 2) NULL,
	[RevaluedAmount] [numeric](18, 2) NULL,
	[ValueChangeFinYTD] [numeric](18, 2) NULL,
	[RevaluationReserve] [numeric](18, 2) NULL,
	[RevaluationRUL] [int] NULL,
	[RevaluedBy] [varchar](40) NULL,
	[RevaluationAccuracy] [int] NULL,
	[CriticalityGrade] [int] NULL,
	[ConditionGrade] [int] NULL,
	[PerformanceGrade] [int] NULL,
	[UtilisationGrade] [int] NULL,
	[OpsCostGrade] [int] NULL,
	[RiskExposure] [int] NULL,
	[ForecastReplYear]  AS (CONVERT([int],ceiling((2012)+[RUL]),(0))),
	[ForecastReplValue] [numeric](18, 2) NULL,
	[CRC_Adjusted] [numeric](18, 2) NULL,
	[DRC]  AS (case when isnull([EUL],(0))>(0) then ([CRC]-([CRC]*[ResidualPct])/(100.0))*([RUL]/[EUL])+([CRC]*[ResidualPct])/(100.0)  end),
	[AnnualisedMaintPct] [numeric](18, 2) NULL,
	[MaintenanceBudgetNeed] [numeric](18, 2) NULL,
	[MaintenanceBudgetPct] [numeric](18, 2) NULL,
	[MaintenanceExpenditure] [numeric](18, 2) NULL,
	[DateCreated] [datetime] NULL,
	[DateLastFinMonth] [datetime] NULL,
	[ImpairmentDerecog] [numeric](18, 2) NOT NULL,
	[ImpairmentClose]  AS (((isnull([ImpairmentAll],(0))+isnull([ImpairmentFinYTD],(0)))+isnull([RevImpairmentFinYTD],(0)))+isnull([ImpairmentDerecog],(0)))
) ON [PRIMARY]
SET ANSI_PADDING OFF
ALTER TABLE [dbo].[AssetRegisterDerecognitions] ADD [RefSuburbsCode] [varchar](20) NULL
ALTER TABLE [dbo].[AssetRegisterDerecognitions] ADD [CaseNumber] [varchar](40) NULL
ALTER TABLE [dbo].[AssetRegisterDerecognitions] ADD [InsuranceClaimed] [bit] NULL
ALTER TABLE [dbo].[AssetRegisterDerecognitions] ADD [InsuranceAmount] [numeric](18, 2) NULL
ALTER TABLE [dbo].[AssetRegisterDerecognitions] ADD [TransferredFrom] [varchar](40) NULL
ALTER TABLE [dbo].[AssetRegisterDerecognitions] ADD [TransferredTo] [varchar](40) NULL
ALTER TABLE [dbo].[AssetRegisterDerecognitions] ADD [ImpairmentTransfer] [numeric](18, 2) NOT NULL
SET ANSI_PADDING ON
ALTER TABLE [dbo].[AssetRegisterDerecognitions] ADD [FinHierarchyPath] [varchar](100) NULL
SET ANSI_PADDING OFF
ALTER TABLE [dbo].[AssetRegisterDerecognitions] ADD [MeasurementModelID] [varchar](4) NULL
ALTER TABLE [dbo].[AssetRegisterDerecognitions] ADD [UseStatusID] [varchar](4) NULL
ALTER TABLE [dbo].[AssetRegisterDerecognitions] ADD [SCOA_Item_Depreciation_Debit] [varchar](40) NULL
ALTER TABLE [dbo].[AssetRegisterDerecognitions] ADD [SCOA_Item_Depreciation_Credit] [varchar](40) NULL
ALTER TABLE [dbo].[AssetRegisterDerecognitions] ADD [RevaluationReserveFinYTDImp] [numeric](18, 2) NOT NULL
ALTER TABLE [dbo].[AssetRegisterDerecognitions] ADD [RevaluationReserveFinYTDDepr] [numeric](18, 2) NOT NULL
ALTER TABLE [dbo].[AssetRegisterDerecognitions] ADD [VerificationLastDate] [datetime] NULL
ALTER TABLE [dbo].[AssetRegisterDerecognitions] ADD [VerificationNextDate] [datetime] NULL
ALTER TABLE [dbo].[AssetRegisterDerecognitions] ADD [CostClosing]  AS ((((([CostOpening]+[AdditionsFinYTD])+[ProvisionAdjust])+[ValueChangeFinYTD])+[DerecognitionCost])+[TransferCost])
ALTER TABLE [dbo].[AssetRegisterDerecognitions] ADD [CarryingValueClosing]  AS (((((((((((((([CostOpening]+[AdditionsFinYTD])+[ProvisionAdjust])+[ValueChangeFinYTD])+[DerecognitionCost])+[TransferCost])+[DepreciationOpening])+[DepreciationFinYTD])+[DerecognitionDepr])+[TransferDepr])+[ImpairmentAll])+[ImpairmentFinYTD])+[RevImpairmentFinYTD])+[ImpairmentDerecog])+[ImpairmentTransfer])
ALTER TABLE [dbo].[AssetRegisterDerecognitions] ADD [DepreciationClosing]  AS ((([DepreciationOpening]+[DepreciationFinYTD])+[DerecognitionDepr])+[TransferDepr])
ALTER TABLE [dbo].[AssetRegisterDerecognitions] ADD [RevaluationReserveOpening] [numeric](18, 2) NOT NULL
ALTER TABLE [dbo].[AssetRegisterDerecognitions] ADD [RevaluationReserveFinYTD] [numeric](18, 2) NOT NULL
ALTER TABLE [dbo].[AssetRegisterDerecognitions] ADD [RevaluationReserveClosing] [numeric](18, 2) NOT NULL
ALTER TABLE [dbo].[AssetRegisterDerecognitions] ADD [BOQPath] [varchar](40) NULL
ALTER TABLE [dbo].[AssetRegisterDerecognitions] ADD [DepreciationBudgetNr_Debit] [varchar](40) NULL
ALTER TABLE [dbo].[AssetRegisterDerecognitions] ADD [DepreciationBudgetNr_Credit] [varchar](40) NULL
ALTER TABLE [dbo].[AssetRegisterDerecognitions] ADD [ReplacedComponents] [varchar](512) NULL
ALTER TABLE [dbo].[AssetRegisterDerecognitions] ADD [UpgradeDate] [datetime] NULL
ALTER TABLE [dbo].[AssetRegisterDerecognitions] ADD [LastMaintenanceDate] [datetime] NULL
ALTER TABLE [dbo].[AssetRegisterDerecognitions] ADD [SCOAAssignmentID] [int] NULL
ALTER TABLE [dbo].[AssetRegisterDerecognitions] ADD [DisposalProfitLoss]  AS ([DisposalProceedCost]-(([DerecognitionCost]+[DerecognitionDepr])+[ImpairmentDerecog]))
 CONSTRAINT [PK_AssetRegisterDerecognitions] PRIMARY KEY CLUSTERED 
(
	[ComponentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]


SET ANSI_PADDING OFF

ALTER TABLE [dbo].[AssetRegisterDerecognitions] ADD  CONSTRAINT [DF__AssetRegisterDerecognitions_Extent]  DEFAULT ((0)) FOR [Extent]
ALTER TABLE [dbo].[AssetRegisterDerecognitions] ADD  CONSTRAINT [DF__AssetRegisterDerecognitions_Unit_Rate]  DEFAULT ((0)) FOR [Extent_Unit_Rate]
ALTER TABLE [dbo].[AssetRegisterDerecognitions] ADD  CONSTRAINT [DF__AssetRegisterDerecognitions_FairValue]  DEFAULT ((0)) FOR [FairValue]
ALTER TABLE [dbo].[AssetRegisterDerecognitions] ADD  CONSTRAINT [DF__AssetRegisterDerecognitions_CostOpening]  DEFAULT ((0)) FOR [CostOpening]
ALTER TABLE [dbo].[AssetRegisterDerecognitions] ADD  CONSTRAINT [DF__AssetRegisterDerecognitions_InsuranceCover]  DEFAULT ((0)) FOR [InsuranceCover]
ALTER TABLE [dbo].[AssetRegisterDerecognitions] ADD  CONSTRAINT [DF__AssetRegisterDerecognitions_DebtSecurityApplicable]  DEFAULT ((0)) FOR [DebtSecurityApplicable]
ALTER TABLE [dbo].[AssetRegisterDerecognitions] ADD  CONSTRAINT [DF__AssetRegisterDerecognitions_AdditionsOpening]  DEFAULT ((0)) FOR [AdditionsOpening]
ALTER TABLE [dbo].[AssetRegisterDerecognitions] ADD  CONSTRAINT [DF__AssetRegisterDerecognitions_AdditionsFinYTD]  DEFAULT ((0)) FOR [AdditionsFinYTD]
ALTER TABLE [dbo].[AssetRegisterDerecognitions] ADD  CONSTRAINT [DF_AssetRegisterDerecognitions_TransferCost]  DEFAULT ((0)) FOR [TransferCost]
ALTER TABLE [dbo].[AssetRegisterDerecognitions] ADD  CONSTRAINT [DF_AssetRegisterDerecognitions_TransferDepr]  DEFAULT ((0)) FOR [TransferDepr]
ALTER TABLE [dbo].[AssetRegisterDerecognitions] ADD  CONSTRAINT [DF__AssetRegisterDerecognitions_ResidualPct]  DEFAULT (isnull(NULL,(0))) FOR [ResidualPct]
ALTER TABLE [dbo].[AssetRegisterDerecognitions] ADD  CONSTRAINT [DF__AssetRegisterDerecognitions_DepreciationOpening]  DEFAULT ((0)) FOR [DepreciationOpening]
ALTER TABLE [dbo].[AssetRegisterDerecognitions] ADD  CONSTRAINT [DF__AssetRegisterDerecognitions_DepreciationFinYTD]  DEFAULT ((0)) FOR [DepreciationFinYTD]
ALTER TABLE [dbo].[AssetRegisterDerecognitions] ADD  CONSTRAINT [DF__AssetRegisterDerecognitions_ProvisionOpening]  DEFAULT ((0)) FOR [ProvisionOpening]
ALTER TABLE [dbo].[AssetRegisterDerecognitions] ADD  CONSTRAINT [DF__AssetRegisterDerecognitions_ProvisionAdjust]  DEFAULT ((0)) FOR [ProvisionAdjust]
ALTER TABLE [dbo].[AssetRegisterDerecognitions] ADD  CONSTRAINT [DF__AssetRegisterDerecognitions_DisposalProceedCost]  DEFAULT ((0)) FOR [DisposalProceedCost]
ALTER TABLE [dbo].[AssetRegisterDerecognitions] ADD  CONSTRAINT [DF__AssetRegisterDerecognitions_DerecognitionCost]  DEFAULT ((0)) FOR [DerecognitionCost]
ALTER TABLE [dbo].[AssetRegisterDerecognitions] ADD  CONSTRAINT [DF__AssetRegisterDerecognitions_DerecognitionDepr]  DEFAULT ((0)) FOR [DerecognitionDepr]
ALTER TABLE [dbo].[AssetRegisterDerecognitions] ADD  CONSTRAINT [DF__AssetRegisterDerecognitions_ImpairmentAll]  DEFAULT ((0)) FOR [ImpairmentAll]
ALTER TABLE [dbo].[AssetRegisterDerecognitions] ADD  CONSTRAINT [DF__AssetRegisterDerecognitions_ImpairmentFinYTD]  DEFAULT ((0)) FOR [ImpairmentFinYTD]
ALTER TABLE [dbo].[AssetRegisterDerecognitions] ADD  CONSTRAINT [DF__AssetRegisterDerecognitions_RevImpairmentAll]  DEFAULT ((0)) FOR [RevImpairmentAll]
ALTER TABLE [dbo].[AssetRegisterDerecognitions] ADD  CONSTRAINT [DF__AssetRegisterDerecognitions_RevImpairmentFinYTD]  DEFAULT ((0)) FOR [RevImpairmentFinYTD]
ALTER TABLE [dbo].[AssetRegisterDerecognitions] ADD  CONSTRAINT [DF__AssetRegisterDerecognitions_CRC]  DEFAULT ((0)) FOR [CRC]
ALTER TABLE [dbo].[AssetRegisterDerecognitions] ADD  CONSTRAINT [DF__AssetRegisterDerecognitions_RevaluedAmount]  DEFAULT ((0)) FOR [RevaluedAmount]
ALTER TABLE [dbo].[AssetRegisterDerecognitions] ADD  CONSTRAINT [DF__AssetRegisterDerecognitions_ValueChangeFinYTD]  DEFAULT ((0)) FOR [ValueChangeFinYTD]
ALTER TABLE [dbo].[AssetRegisterDerecognitions] ADD  CONSTRAINT [DF__AssetRegisterDerecognitions_RevaluationReserve]  DEFAULT ((0)) FOR [RevaluationReserve]
ALTER TABLE [dbo].[AssetRegisterDerecognitions] ADD  CONSTRAINT [DF__AssetRegisterDerecognitions_CriticalityGrade]  DEFAULT ((3)) FOR [CriticalityGrade]
ALTER TABLE [dbo].[AssetRegisterDerecognitions] ADD  CONSTRAINT [DF__AssetRegisterDerecognitions_ConditionGrade]  DEFAULT ((3)) FOR [ConditionGrade]
ALTER TABLE [dbo].[AssetRegisterDerecognitions] ADD  CONSTRAINT [DF__AssetRegisterDerecognitions_PerformanceGrade]  DEFAULT ((3)) FOR [PerformanceGrade]
ALTER TABLE [dbo].[AssetRegisterDerecognitions] ADD  CONSTRAINT [DF__AssetRegisterDerecognitions_UtilisationGrade]  DEFAULT ((3)) FOR [UtilisationGrade]
ALTER TABLE [dbo].[AssetRegisterDerecognitions] ADD  CONSTRAINT [DF__AssetRegisterDerecognitions_OpsCostGrade]  DEFAULT ((3)) FOR [OpsCostGrade]
ALTER TABLE [dbo].[AssetRegisterDerecognitions] ADD  CONSTRAINT [DF__AssetRegisterDerecognitions_ForeCastReplValue]  DEFAULT ((0)) FOR [ForecastReplValue]
ALTER TABLE [dbo].[AssetRegisterDerecognitions] ADD  CONSTRAINT [DF__AssetRegisterDerecognitions_MaintenaceBudgetNeed]  DEFAULT ((0)) FOR [MaintenanceBudgetNeed]
ALTER TABLE [dbo].[AssetRegisterDerecognitions] ADD  CONSTRAINT [DF__AssetRegisterDerecognitions_MaintenanceExpenditure]  DEFAULT ((0)) FOR [MaintenanceExpenditure]
ALTER TABLE [dbo].[AssetRegisterDerecognitions] ADD  DEFAULT ((0)) FOR [ImpairmentDerecog]
ALTER TABLE [dbo].[AssetRegisterDerecognitions] ADD  DEFAULT ((0)) FOR [ImpairmentTransfer]
ALTER TABLE [dbo].[AssetRegisterDerecognitions] ADD  DEFAULT ((0)) FOR [RevaluationReserveFinYTDImp]
ALTER TABLE [dbo].[AssetRegisterDerecognitions] ADD  DEFAULT ((0)) FOR [RevaluationReserveFinYTDDepr]
ALTER TABLE [dbo].[AssetRegisterDerecognitions] ADD  DEFAULT ((0)) FOR [RevaluationReserveOpening]
ALTER TABLE [dbo].[AssetRegisterDerecognitions] ADD  DEFAULT ((0)) FOR [RevaluationReserveFinYTD]
ALTER TABLE [dbo].[AssetRegisterDerecognitions] ADD  DEFAULT ((0)) FOR [RevaluationReserveClosing]


