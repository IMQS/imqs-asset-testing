IF OBJECT_ID (N'Budget', N'U') IS NOT NULL DROP TABLE [Budget];
IF OBJECT_ID (N'ProjectSCOASegment', N'U') IS NOT NULL DROP TABLE [ProjectSCOASegment];
IF OBJECT_ID (N'LedgerJournalSummary', N'U') IS NOT NULL DROP TABLE [LedgerJournalSummary];
IF OBJECT_ID (N'LedgerJournalErrorLog', N'U') IS NOT NULL DROP TABLE [LedgerJournalErrorLog];
IF TYPE_ID (N'TT_F_G_LEDGER_JOURNAL') IS NOT NULL DROP TYPE [TT_F_G_LEDGER_JOURNAL];
IF OBJECT_ID (N'LedgerJournal', N'U') IS NOT NULL DROP TABLE [LedgerJournal];
IF OBJECT_ID (N'OpenPeriods', N'U') IS NOT NULL DROP TABLE [OpenPeriods];
IF OBJECT_ID (N'PeriodStatus', N'U') IS NOT NULL DROP TABLE [PeriodStatus];
IF OBJECT_ID (N'Item', N'U') IS NOT NULL DROP TABLE [Item];
