-- Various tables used to maintain metadata, or manage components within th eWIP or AR.

IF OBJECT_ID (N'AssetRefCounter', N'U') IS NOT NULL DROP TABLE [AssetRefCounter];
IF OBJECT_ID (N'AssetChangeIconFin', N'U') IS NOT NULL DROP TABLE [AssetChangeIconFin];
IF OBJECT_ID (N'AssetProject2015', N'U') IS NOT NULL DROP TABLE [AssetProject2015];
IF OBJECT_ID (N'AssetFinYear', N'U') IS NOT NULL DROP TABLE [AssetFinYear];


CREATE TABLE [dbo].[AssetRefCounter](
	[counter_name] [varchar](30) NOT NULL,
	[counter_prev_id] [int] NULL,
	[counter_current_id] [int] NULL,
	[counter_next_id] [int] NULL,
	CONSTRAINT [PK_AssetRefCounter] PRIMARY KEY CLUSTERED([counter_name] ASC) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
INSERT INTO AssetRefCounter (counter_name, counter_prev_id, counter_current_id, counter_next_id) VALUES ('assetfinformref', 0,1,2);
INSERT INTO AssetRefCounter (counter_name, counter_prev_id, counter_current_id, counter_next_id) VALUES ('componentidpostfix', 0,1,2);


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
-- Add the test project
INSERT [dbo].[AssetProject2015] ([Project_ID], [AccountingGroupID], [AssetCategoryID], [AssetSubCategoryID], [AssetGroupID], [Project_Number], [Project_Name], [Project_Nature], [Project_Descr], [Project_Location], [Map_Feature_ID], [Department], [TreasuryCode], [CostCentreCode], [GeneralLedgerCode], [Method_Construct], [Funding_Types], [Funding_Sources], [Supplier_ID], [Design_Supervision], [Capital_Cost_Open], [Capital_Cost_Year], [WIP_Capitalised], [Additions_Capitalised], [TransferCost], [ImpairmentAll], [ImpairmentFinYTD], [RevImpairmentOpening], [RevImpairmentFinYTD], [RevImpairmentClosing], [Impairment_Date], [Impairment_Descr], [Is_Completed], [Date_Completed], [Date_Available], [Is_Capitalised], [Date_Capitalised], [Capitalised_By], [InvoiceOverride], [ImpairmentFinYTD_Capitalised], [RevImpairmentFinYTD_Capitalised], [PartialCapitalisation], [Is_PartiallyCapitalised], [Capital_Cost_Close], [ImpairmentOpeningCapitalised], [ImpairmentClosing], [CarryingValueClosing], [SCOA_Fund], [SCOA_Function], [SCOA_Mun_Classification], [SCOA_Project], [SCOA_Costing], [SCOA_Region], [SCOA_ItemAsset], [TransferCost_Capitalised]) VALUES (N'{C39D211F-3756-4CE6-B1B6-D49CE37BF74F}', N'PPE', N'INF', N'OPB', N'DEP', N'D01', N'Project Lego 01', N'NEW', N'Test project for automated testing', NULL, NULL, N'Not Specified', NULL, N'Not Specified', N'Not Specified', NULL, NULL, NULL, NULL, NULL, CAST(0.00 AS Numeric(18, 2)), CAST(150000.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(19, 2)), NULL, NULL, N'YES', CAST(N'2017-06-08T00:00:00.000' AS DateTime), CAST(N'2017-06-08T00:00:00.000' AS DateTime), N'SUB', CAST(N'2017-06-08T00:00:00.000' AS DateTime), N'IMQSAdmin', 0, CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(18, 2)), 0, 0, CAST(150000.00 AS Numeric(21, 2)), CAST(0.00 AS Numeric(18, 2)), CAST(0.00 AS Numeric(23, 2)), CAST(150000.00 AS Numeric(27, 2)), NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(0.00 AS Numeric(18, 2)))


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
	CONSTRAINT [PK_AssetFinYear_FinYear] PRIMARY KEY CLUSTERED([FinYear] ASC) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
ALTER TABLE [dbo].[AssetFinYear] ADD  CONSTRAINT [DF_AssetFinyear_DTLastUpdate]  DEFAULT (getdate()) FOR [DT_LastUpdate];
ALTER TABLE [dbo].[AssetFinYear] ADD  CONSTRAINT [DF_AssetFinyear_HasPolicyRates]  DEFAULT ((0)) FOR [HasPolicyRates];
ALTER TABLE [dbo].[AssetFinYear] ADD  CONSTRAINT [DF_AssetFinyear_IsFinLocked]  DEFAULT ((0)) FOR [IsFinLocked];
ALTER TABLE [dbo].[AssetFinYear] ADD  CONSTRAINT [DF_AssetFinyear_IsValLocked]  DEFAULT ((0)) FOR [IsValLocked];
-- AssetFinYear inserts
INSERT INTO AssetFinYear (FinYear, Period) VALUES(2015,1);
INSERT INTO AssetFinYear (FinYear, Period) VALUES(2016,1);
INSERT INTO AssetFinYear (FinYear, Period) VALUES(2017,1);