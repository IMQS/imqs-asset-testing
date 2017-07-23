-- SCOA Tables and functions that are used in the rollup of asset values to the National Treasury's Standard Chart Of Accounts

IF OBJECT_ID (N'SCOAClassification', N'U') IS NOT NULL DROP TABLE [SCOAClassification];
IF OBJECT_ID (N'SCOAJournal', N'U') IS NOT NULL DROP TABLE [SCOAJournal];
IF OBJECT_ID ('convertDateToInt') IS NOT NULL DROP FUNCTION convertDateToInt;

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
	CONSTRAINT [PK_SCOAClassification_Id] PRIMARY KEY CLUSTERED	([Id] ASC) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
ALTER TABLE [dbo].[SCOAClassification] ADD  CONSTRAINT [DF_SCOAClassification_Id]  DEFAULT (newid()) FOR [Id];
ALTER TABLE [dbo].[SCOAClassification] ADD  DEFAULT ((0)) FOR [Linkable];


-- This is where all the components go once they've been committed to the AR, or sent to the FS
CREATE TABLE [dbo].[SCOAJournal](
	[Form_Reference] [int] NOT NULL,
	[ComponentID] [varchar](40) NOT NULL,
	[FinancialField] [varchar](40) NOT NULL,
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
	[ID] [bigint] NOT NULL
	CONSTRAINT [PK_SCOAJournal] PRIMARY KEY CLUSTERED([Form_Reference] ASC, [ComponentID] ASC, [FinancialField] ASC) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
ALTER TABLE [dbo].[SCOAJournal] ADD DEFAULT ((0)) FOR [CommittedToRegister];

-- Used by the SCOA Rollup stored procs to easily convert to the expected date syntax
EXECUTE('CREATE FUNCTION convertDateToInt(@date DATE) RETURNS INT as
BEGIN
	RETURN CONVERT(INT, REPLACE(STR(YEAR(@date),4), '' '', ''0'')+REPLACE(STR(MONTH(@date),2), '' '', ''0'')+REPLACE(STR(DAY(@date),2), '' '', ''0''));
END');

CREATE TABLE [DepreciationStatus] (
	[rowID] [BIGINT] NOT NULL IDENTITY(1,1),
	[SCOAJourrnalID] [BIGINT] NOT NULL,
	[Status] [INT] NOT NULL,
	[Information] TEXT NULL,
	CONSTRAINT [PK_DepreciationStatus] PRIMARY KEY (rowID)
) ON [PRIMARY];
