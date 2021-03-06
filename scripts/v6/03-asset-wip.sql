-- WIP related tables
IF OBJECT_ID (N'AssetProject2015', N'U') IS NOT NULL DROP TABLE [AssetProject2015];

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

ALTER TABLE [dbo].[AssetProject2015] ADD  CONSTRAINT [DF_AssetProject2015_Department]  DEFAULT ('Not Specified') FOR [Department];

ALTER TABLE [dbo].[AssetProject2015] ADD  CONSTRAINT [DF_AssetProject2015_CostCentreCode]  DEFAULT ('Not Specified') FOR [CostCentreCode];

ALTER TABLE [dbo].[AssetProject2015] ADD  CONSTRAINT [DF_AssetProject2015_GeneralLedgerCode]  DEFAULT ('Not Specified') FOR [GeneralLedgerCode];

ALTER TABLE [dbo].[AssetProject2015] ADD  CONSTRAINT [DF_AssetProject2015_TransferCost]  DEFAULT ((0)) FOR [TransferCost];

ALTER TABLE [dbo].[AssetProject2015] ADD  CONSTRAINT [DF_AssetProject2015_ImpairmentAll]  DEFAULT ((0)) FOR [ImpairmentAll];

ALTER TABLE [dbo].[AssetProject2015] ADD  CONSTRAINT [DF_AssetProject2015_ImpairmentFinYTD]  DEFAULT ((0)) FOR [ImpairmentFinYTD];

ALTER TABLE [dbo].[AssetProject2015] ADD  CONSTRAINT [DF_AssetProject2015_RevImpairmentOpening]  DEFAULT ((0)) FOR [RevImpairmentOpening];

ALTER TABLE [dbo].[AssetProject2015] ADD  CONSTRAINT [DF_AssetProject2015_RevImpairmentFinYTD]  DEFAULT ((0)) FOR [RevImpairmentFinYTD];

ALTER TABLE [dbo].[AssetProject2015] ADD  CONSTRAINT [DF_AssetProject2015_InvoiceOverride]  DEFAULT ((0)) FOR [InvoiceOverride];

ALTER TABLE [dbo].[AssetProject2015] ADD  CONSTRAINT [DF_AssetProject2015_ImpairmentOpeningCapitalised]  DEFAULT ((0)) FOR [ImpairmentOpeningCapitalised];

ALTER TABLE [dbo].[AssetProject2015] ADD  CONSTRAINT [DF_AssetProject2015_TransferCost_Capitalised]  DEFAULT ((0)) FOR [TransferCost_Capitalised];