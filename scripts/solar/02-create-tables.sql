
-- Budget details (only fields used by imqs)
CREATE TABLE [dbo].[Budget](
  [LEDGER_BUDGET_ISN] NUMERIC (38, 0) NOT NULL,
  [ENTITY_ACCOUNT_NUMBER] [VARCHAR] (20) NOT NULL,
	[ENTITY_SUB_ITEM_CODE] [VARCHAR](10) NOT NULL,
	[ENTITY_PROJECT_CODE] [VARCHAR](10) NOT NULL,
	[ENTITY_COST_CENTRE_CODE] [VARCHAR](10) NOT NULL,
	[FINANCIAL_YEAR] [VARCHAR](4) NOT NULL,
	[SCOA_FUNCTION_GUID] [VARCHAR](40) NOT NULL,
	[SCOA_FUND_GUID] [VARCHAR](40) NOT NULL,
	[SCOA_ITEM_GUID] [VARCHAR](40) NOT NULL,
	[SCOA_PROJECT_GUID] [VARCHAR](40) NOT NULL,
	[SCOA_REGION_GUID] [VARCHAR](40) NOT NULL,
	[SCOA_COST_GUID] [VARCHAR](40) NOT NULL,
	[AVAILABLE_BUDGET] [NUMERIC](25,2) NOT NULL,
	[TOTAL_ACTUAL_EXPENDITURE] [NUMERIC](25,2) NOT NULL,
	CONSTRAINT [PK_Budget] PRIMARY KEY CLUSTERED
(
	[ENTITY_ACCOUNT_NUMBER] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];


-- Project details (only fields used by imqs)
CREATE TABLE [dbo].[ProjectSCOASegment](
	[ENTITY_PROJECT_CODE] [VARCHAR](10) NOT NULL,
	[ENTITY_PROJECT] [VARCHAR](50) NOT NULL,
	[IDP_PROJECT_CODE] [VARCHAR](20) NOT NULL,
	[IDP_PROJECT] [VARCHAR](75) NOT NULL,
	[FINANCIAL_YEAR] [VARCHAR](4) NOT NULL,
	[SCOA_SEGMENT_DESCRIPTION] [VARCHAR] (255) NULL,
	[SCOA_PROJECT_GUID] [VARCHAR] (40) NULL,
 CONSTRAINT [PK_ProjectSCOASegment] PRIMARY KEY CLUSTERED
(
	[IDP_PROJECT_CODE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];

-- A table that keeps processed journals
CREATE TABLE [dbo].[LedgerJournalSummary](
	[BATCH_NUMBER] [BIGINT] NOT NULL,
	[VENDOR_CODE] [VARCHAR](2) NOT NULL,
	[BATCH_DATE] [DATETIME2] NOT NULL,
	[RECORDS_RECEIVED] [INT] NOT NULL DEFAULT 0,
	[RECORDS_VALIDATED] [INT] NOT NULL DEFAULT 0,
	[RECORDS_FAILED] [INT] NOT NULL DEFAULT 0,
	[RECORDS_UNAUTHORISED] [INT] NOT NULL DEFAULT 0,
	[RECORDS_AUTHORISED] [INT] NOT NULL DEFAULT 0,
	[RECORDS_AUTHORISATION_FAILED] [INT] NOT NULL DEFAULT 0,
 CONSTRAINT [PK_LedgerJournalSummary] PRIMARY KEY CLUSTERED
(
	[BATCH_NUMBER], [VENDOR_CODE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];

-- A table that stores journal validation errors
CREATE TABLE [dbo].[LedgerJournalErrorLog](
	[BATCH_NUMBER] [BIGINT] NOT NULL,
	[VENDOR_CODE] [VARCHAR](2) NOT NULL,
	[BATCH_DATE] [DATETIME2] NOT NULL,
	[UNIQUE_IDENTIFIER] [BIGINT] NOT NULL,
	[ATTRIBUTE] [VARCHAR] (100) NOT NULL,
	[ATTRIBUTE_VALUE] [VARCHAR] (500) NOT NULL,
	[ERROR_MESSAGE] [VARCHAR] (500) NOT NULL,
 CONSTRAINT [PK_LedgerJournalErrorLog] PRIMARY KEY CLUSTERED
(
	[BATCH_NUMBER], [VENDOR_CODE], [UNIQUE_IDENTIFIER] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];


-- A user defined table type that is used to store rolled up journals to be sent to SOLAR
CREATE TYPE [dbo].[TT_F_G_LEDGER_JOURNAL] AS TABLE(
	[UNIQUE_IDENTIFIER] [bigint] NULL,
	[FINANCIAL_PERIOD] [varchar](6) NULL,
	[LEDGER_TRANSACTION_TYPE] [varchar](2) NULL,
	[VENDOR_CODE] [varchar](2) NULL,
	[JOURNAL_REFERENCE] [varchar](14) NULL,
	[JOURNAL_DESCRIPTION_1] [varchar](60) NULL,
	[JOURNAL_DESCRIPTION_2] [varchar](60) NULL,
	[JOURNAL_DESCRIPTION_3] [varchar](60) NULL,
	[TRANSACTION_DATE] [int] NULL,
	[SCOA_FUNCTION_GUID] [varchar](40) NULL,
	[SCOA_FUND_GUID] [varchar](40) NULL,
	[SCOA_ITEM_GUID] [varchar](40) NULL,
	[SCOA_PROJECT_GUID] [varchar](40) NULL,
	[SCOA_COST_GUID] [varchar](40) NULL,
	[SCOA_REGION_GUID] [varchar](40) NULL,
	[ENTITY_COST_CENTRE_CODE] [varchar](10) NULL,
	[ENTITY_SUB_ITEM_CODE] [varchar](10) NULL,
	[ENTITY_PROJECT_CODE] [varchar](10) NULL,
	[FLEET_UNIT_CODE] [varchar](6) NULL,
	[FLEET_EXPENDITURE_INCOME_CODE] [varchar](2) NULL,
	[FLEET_READING] [NUMERIC](25, 2) NULL,
	[JOB_NUMBER] [varchar](7) NULL,
	[JOB_ACTIVITY_CODE] [varchar](2) NULL,
	[JOB_CATEGORY_CODE] [varchar](4) NULL,
	[QUANTITY] [numeric](25, 2) NULL,
	[DEBIT_AMOUNT] [numeric](25, 2) NULL,
	[CREDIT_AMOUNT] [numeric](25, 2) NULL,
	[REPLACE_WITH_DEFAULT] [bit] NOT NULL DEFAULT 0
);

