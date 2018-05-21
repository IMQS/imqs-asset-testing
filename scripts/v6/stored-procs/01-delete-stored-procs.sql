IF OBJECT_ID ('ExportSamrasSCOAJournalRollUp') IS NOT NULL DROP PROCEDURE ExportSamrasSCOAJournalRollUp;
IF OBJECT_ID ('ExportSamrasSCOAMasterDataForBatch') IS NOT NULL DROP PROCEDURE ExportSamrasSCOAMasterDataForBatch;
IF OBJECT_ID ('ExportSCOAJournalRollUp') IS NOT NULL DROP PROCEDURE ExportSCOAJournalRollUp;
IF OBJECT_ID ('UpdateSCOAJournalSCOAFileName') IS NOT NULL DROP PROCEDURE UpdateSCOAJournalSCOAFileName;
IF OBJECT_ID (N'SetClassificationSelectable', N'P') IS NOT NULL DROP PROCEDURE [SetClassificationSelectable];
IF OBJECT_ID (N'NextValueFor', N'P') IS NOT NULL DROP PROCEDURE [NextValueFor];
IF OBJECT_ID (N'SetValueFor', N'P') IS NOT NULL DROP PROCEDURE [SetValueFor];