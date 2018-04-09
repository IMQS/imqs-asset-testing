-- SCOA Tables and functions that are used in the rollup of asset values to the National Treasury's Standard Chart Of Accounts

IF OBJECT_ID (N'SCOAClassification', N'U') IS NOT NULL DROP TABLE [SCOAClassification];
IF OBJECT_ID (N'SCOAJournal', N'U') IS NOT NULL DROP TABLE [SCOAJournal];
IF OBJECT_ID (N'SCOADepreciationStatus', N'U') IS NOT NULL DROP TABLE [SCOADepreciationStatus];
IF OBJECT_ID (N'SCOABudget', N'U') IS NOT NULL DROP TABLE [SCOABudget];
IF OBJECT_ID (N'SCOABudgetLeg', N'U') IS NOT NULL DROP TABLE [SCOABudgetLeg];
IF OBJECT_ID ('convertDateToInt') IS NOT NULL DROP FUNCTION convertDateToInt;
IF OBJECT_ID ('isCreditLeg') IS NOT NULL DROP FUNCTION isCreditLeg;
IF OBJECT_ID ('isDebitLeg') IS NOT NULL DROP FUNCTION isDebitLeg;
IF OBJECT_ID ('getSolarFinancialPeriod') IS NOT NULL DROP FUNCTION getSolarFinancialPeriod;
IF OBJECT_ID ('getLedgerTransactionType') IS NOT NULL DROP FUNCTION getLedgerTransactionType;

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
	[CorrelationRef] [varchar](40) NULL,
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

CREATE TABLE [SCOADepreciationStatus] (
	[RowID] [BIGINT] NOT NULL IDENTITY(1,1),
	[SCOAJournalID] [BIGINT] NOT NULL,
	[Status] [INT] NOT NULL,
	[Information] TEXT NULL,
	CONSTRAINT [PK_SCOADepreciationStatus] PRIMARY KEY (rowID)
) ON [PRIMARY];

EXECUTE('CREATE FUNCTION getSolarFinancialPeriod(@imqsFinPeriod VARCHAR(6)) RETURNS VARCHAR(6) AS
BEGIN
	DECLARE @PERIODS_IN_YEAR INT = 12;
	DECLARE @SOLAR_ROLLOVER_PERIOD INT = 7;

	DECLARE @imqsYear INT = CAST(SUBSTRING(@imqsFinPeriod, 2, 3) AS INT);
	DECLARE @imqsPeriod INT = CAST(SUBSTRING(@imqsFinPeriod, 5, 2) AS INT);
	DECLARE @solarYear1 VARCHAR(2) = CAST(@imqsYear-1 AS VARCHAR(2));
	DECLARE @solarYear2 VARCHAR(2) = CAST(@imqsYear AS VARCHAR(2));
	DECLARE @diff INT = @SOLAR_ROLLOVER_PERIOD - @imqsPeriod;
	DECLARE @solarYear VARCHAR(4) = SUBSTRING(@imqsFinPeriod, 1, 2) + CASE WHEN @diff > 0 THEN @solarYear1 ELSE @solarYear2 END;

	DECLARE @solarPeriodStr VARCHAR(2) = CAST(CASE WHEN @diff > 0 THEN @PERIODS_IN_YEAR - @diff + 1 ELSE ABS(@diff)+1 END AS VARCHAR(2));
	DECLARE @solarPeriod VARCHAR(2) = REPLACE(STR(@solarPeriodStr, 2), '' '', ''0'');

	return @solarYear + @solarPeriod;
END;');


EXECUTE('CREATE FUNCTION getLedgerTransactionType(@financialField VARCHAR(40)) RETURNS VARCHAR(2) AS
BEGIN
	RETURN CASE @financialField
    WHEN ''AdditionsFinYTD'' THEN ''AK''
    WHEN ''DerecognitionCost'' THEN ''AM''
    WHEN ''DerecognitionDepr'' THEN ''AR''
    WHEN ''ImpairmentDerecog'' THEN ''AT''
    WHEN ''ImpairmentFinYTD'' THEN ''AS''
    WHEN ''RevImpairmentFinYTD'' THEN ''AT''
    WHEN ''ValueChangeFinYTD'' THEN ''AP''
    WHEN ''DepreciationFinYTD'' THEN ''AQ''
    WHEN ''TransferCost'' THEN ''AV''
    WHEN ''TransferDepr'' THEN ''AQ''
    WHEN ''ImpairmentTransfer'' THEN ''AS''
    WHEN ''RevaluationReserveFinYTD'' THEN ''AN''
    WHEN ''RevaluationReserveFinYTDImp'' THEN ''AT''
    WHEN ''RevaluationReserveFinYTDDepr'' THEN ''AR''
    ELSE NULL END
END;');

CREATE TABLE [dbo].[SCOABudget](
	[BudgetNr] [varchar](40) NOT NULL,
	[Description] [varchar](80) NULL,
	[SCOA_Costing] [varchar](40) NULL,
	[SCOA_Function] [varchar](40) NULL,
	[SCOA_Fund] [varchar](40) NULL,
	[SCOA_Item] [varchar](40) NULL,
	[SCOA_Mun_Classification] [varchar](40) NULL,
	[SCOA_Project] [varchar](40) NULL,
	[SCOA_Region] [varchar](40) NULL,
	[BREAKDOWN_SCOA_Item] [varchar](40) NULL,
	[BREAKDOWN_SCOA_Project] [varchar](40) NULL,
	[BREAKDOWN_SCOA_Costing] [varchar](40) NULL,
	[BREAKDOWN_SCOA_Function] [varchar](40) NULL,
	[BREAKDOWN_SCOA_Fund] [varchar](40) NULL,
	[BREAKDOWN_SCOA_Region] [varchar](40) NULL,
 CONSTRAINT [PK_SCOABudget] PRIMARY KEY CLUSTERED([BudgetNr] ASC) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];

IF OBJECT_ID (N'SCOABudgetLeg', N'U') IS NOT NULL DROP TABLE [SCOABudgetLeg];
CREATE TABLE [dbo].[SCOABudgetLeg](
	[FinFormNr] [bigint] NOT NULL,
	[FinancialField] [varchar](40) NOT NULL,
	[BudgetLeg] [varchar](6) NOT NULL,
	CONSTRAINT [PK_SCOABudgetLeg] PRIMARY KEY CLUSTERED([FinFormNr] ASC,[FinancialField] ASC) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY];