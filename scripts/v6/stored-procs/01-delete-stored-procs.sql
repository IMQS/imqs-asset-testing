IF OBJECT_ID ('CreateSCOABatch') IS NOT NULL DROP PROCEDURE CreateSCOABatch;
IF OBJECT_ID ('ExportSamrasSCOAJournalRollUp') IS NOT NULL DROP PROCEDURE ExportSamrasSCOAJournalRollUp;
IF OBJECT_ID ('ExportSamrasSCOAMasterDataForBatch') IS NOT NULL DROP PROCEDURE ExportSamrasSCOAMasterDataForBatch;
IF OBJECT_ID ('ExportSCOAJournalNoRollup') IS NOT NULL DROP PROCEDURE ExportSCOAJournalNoRollup;
IF OBJECT_ID ('ExportSCOAJournalRollUp') IS NOT NULL DROP PROCEDURE ExportSCOAJournalRollUp;
IF OBJECT_ID ('ExportSolarSCOAJournalRollUp') IS NOT NULL DROP PROCEDURE ExportSolarSCOAJournalRollUp;
IF OBJECT_ID ('ExportVenusSCOAJournalRollUp') IS NOT NULL DROP PROCEDURE ExportVenusSCOAJournalRollUp;
IF OBJECT_ID ('ExportBcxSCOAJournalRollUp') IS NOT NULL DROP PROCEDURE ExportBcxSCOAJournalRollUp;
IF OBJECT_ID ('UpdateSCOAJournalSCOAFileName') IS NOT NULL DROP PROCEDURE UpdateSCOAJournalSCOAFileName;
IF OBJECT_ID (N'SetClassificationSelectable', N'P') IS NOT NULL DROP PROCEDURE [SetClassificationSelectable];
IF OBJECT_ID (N'NextValueFor', N'P') IS NOT NULL DROP PROCEDURE [NextValueFor];
IF OBJECT_ID (N'SetFormLevelForImqsBatchId', N'P') IS NOT NULL DROP PROCEDURE [SetFormLevelForImqsBatchId];
IF OBJECT_ID (N'SetImqsScoaBatchCommitted', N'P') IS NOT NULL DROP PROCEDURE [SetImqsScoaBatchCommitted];
IF OBJECT_ID (N'DeleteFromScoaDepreciationStatus', N'P') IS NOT NULL DROP PROCEDURE [DeleteFromScoaDepreciationStatus];
IF OBJECT_ID(N'[dbo].[CommitDepreciationToRegister]', N'P') IS NOT NULL DROP PROCEDURE [dbo].CommitDepreciationToRegister;