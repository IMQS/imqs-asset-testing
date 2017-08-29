-- SCOA Tables and functions that are used in the rollup of asset values to the National Treasury's Standard Chart Of Accounts

IF OBJECT_ID (N'SCOAClassification', N'U') IS NOT NULL DROP TABLE [SCOAClassification];
IF OBJECT_ID (N'SCOAJournal', N'U') IS NOT NULL DROP TABLE [SCOAJournal];
IF OBJECT_ID (N'SCOADepreciationStatus', N'U') IS NOT NULL DROP TABLE [SCOADepreciationStatus];
IF OBJECT_ID ('convertDateToInt') IS NOT NULL DROP FUNCTION convertDateToInt;
IF OBJECT_ID ('isCreditLeg') IS NOT NULL DROP FUNCTION isCreditLeg;
IF OBJECT_ID ('isDebitLeg') IS NOT NULL DROP FUNCTION isDebitLeg;

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
	[ROWID] [bigint] IDENTITY(1,1) NOT NULL,
	[IsBreakdown] [bit] NULL,
	[IsSelectable] [bit] NULL,
	[SCOAVersion] [varchar](10) NULL,
	CONSTRAINT [PK_SCOAClassification_Id] PRIMARY KEY CLUSTERED ([Id] ASC) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
ALTER TABLE [dbo].[SCOAClassification] ADD  CONSTRAINT [DF_SCOAClassification_Id]  DEFAULT (newid()) FOR [Id];
ALTER TABLE [dbo].[SCOAClassification] ADD  DEFAULT ((0)) FOR [Linkable];
ALTER TABLE [dbo].[SCOAClassification] ADD  CONSTRAINT [DF_SCOAClassification_IsBreakdown]  DEFAULT ((0)) FOR [IsBreakdown];
ALTER TABLE [dbo].[SCOAClassification] ADD  CONSTRAINT [DF_SCOAClassification_IsSelectable]  DEFAULT ((1)) FOR [IsSelectable];


-- This is where all the components go once they've been committed to the AR, or sent to the FS
CREATE TABLE [dbo].[SCOAJournal](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Form_Reference] [varchar](40) NOT NULL,
	[ComponentID] [varchar](40) NOT NULL,
	[FinancialField] [varchar](40) NOT NULL,
	[Amount] [numeric](18, 2) NOT NULL,
	[EffectiveDate] [datetime] NULL,
	[FinYear] [int] NULL,
	[Period] [int] NULL,
	[Date] [datetime] NOT NULL,

	--Debit fields
	[SCOA_Fund] [varchar](40) NULL,
	[SCOA_Function] [varchar](40) NULL,
	[SCOA_Mun_Classification] [varchar](40) NULL,
	[SCOA_Project] [varchar](40) NULL,
	[SCOA_Costing] [varchar](40) NULL,
	[SCOA_Region] [varchar](40) NULL,
	[SCOA_Item_Debit] [varchar](40) NULL,

	--Breakdown Debit fields
	[BREAKDOWN_SCOA_Fund] [varchar](40) NULL,
	[BREAKDOWN_SCOA_Function] [varchar](40) NULL,
	[BREAKDOWN_SCOA_Project] [varchar](40) NULL,
	[BREAKDOWN_SCOA_Costing] [varchar](40) NULL,
	[BREAKDOWN_SCOA_Region] [varchar](40) NULL,
	[BREAKDOWN_SCOA_Item_Debit] [varchar](40) NULL,

	--Credit fields
	[SCOA_Fund_Credit] [varchar](40) NULL,
	[SCOA_Function_Credit] [varchar](40) NULL,
	[SCOA_Mun_Classification_Credit] [varchar](40) NULL,
	[SCOA_Project_Credit] [varchar](40) NULL,
	[SCOA_Costing_Credit] [varchar](40) NULL,
	[SCOA_Region_Credit] [varchar](40) NULL,
	[SCOA_Item_Credit] [varchar](40) NULL,

	--Breakdown Credit fields
	[BREAKDOWN_SCOA_Fund_Credit] [varchar](40) NULL,
	[BREAKDOWN_SCOA_Function_Credit] [varchar](40) NULL,
	[BREAKDOWN_SCOA_Project_Credit] [varchar](40) NULL,
	[BREAKDOWN_SCOA_Costing_Credit] [varchar](40) NULL,
	[BREAKDOWN_SCOA_Region_Credit] [varchar](40) NULL,
	[BREAKDOWN_SCOA_Item_Credit] [varchar](40) NULL,

	[BudgetID] [varchar](40) NULL,
	[RollupID] [bigint] NULL,
	[FinSysBatchID] [varchar](40) NULL,
	[IMQSBatchID] [bigint] NULL,
	[PostingDebitID] [bigint] NULL,
	[PostingCreditID] [bigint] NULL,
	[SCOAFileName] [varchar](150) NULL,
	[SCOAFileDate] [datetime] NULL,
	[CommittedToRegister] [bit] NULL,

 CONSTRAINT [PK_SCOAJournal] PRIMARY KEY CLUSTERED ([ID] ASC) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY];

ALTER TABLE [dbo].[SCOAJournal] ADD  CONSTRAINT [DF_SCOAJOURNAL_CommittedToRegister]  DEFAULT ((0)) FOR [CommittedToRegister];

-- Used by the SCOA Rollup stored procs to easily convert to the expected date syntax
EXECUTE('CREATE FUNCTION convertDateToInt(@date DATE) RETURNS INT as
BEGIN
	RETURN CONVERT(INT, REPLACE(STR(YEAR(@date),4), '' '', ''0'')+REPLACE(STR(MONTH(@date),2), '' '', ''0'')+REPLACE(STR(DAY(@date),2), '' '', ''0''));
END');

EXECUTE('CREATE FUNCTION isCreditLeg(@formNr INT) RETURNS INT as
BEGIN
	RETURN CASE @formNr
	WHEN 1 THEN 1
	WHEN 5 THEN 1
	WHEN 7 THEN 1
	WHEN 11 THEN 1
  ELSE 0 END
END;');

EXECUTE('CREATE FUNCTION isDebitLeg(@formNr INT) RETURNS INT as
BEGIN
	RETURN IIF(dbo.isCreditLeg(@formNr) = 1, 0, 1);
END;');

CREATE TABLE [SCOADepreciationStatus] (
	[RowID] [BIGINT] NOT NULL IDENTITY(1,1),
	[SCOAJournalID] [BIGINT] NOT NULL,
	[Status] [INT] NOT NULL,
	[Information] TEXT NULL,
	CONSTRAINT [PK_SCOADepreciationStatus] PRIMARY KEY (rowID)
) ON [PRIMARY];
