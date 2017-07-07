IF OBJECT_ID (N'AssetFinFormBatch', N'U') IS NOT NULL DROP TABLE [AssetFinFormBatch];
IF OBJECT_ID (N'AssetFinFormRef', N'U') IS NOT NULL DROP TABLE [AssetFinFormRef];
IF OBJECT_ID (N'AssetFinFormInput', N'U') IS NOT NULL DROP TABLE [AssetFinFormInput];
IF OBJECT_ID (N'AssetFinFormState', N'U') IS NOT NULL DROP TABLE [AssetFinFormState];
IF OBJECT_ID (N'AssetFinForm', N'U') IS NOT NULL DROP TABLE [AssetFinForm];

IF OBJECT_ID (N'AssetRegisterIconMove', N'U') IS NOT NULL DROP TABLE [AssetRegisterIconMove];
IF OBJECT_ID (N'AssetRegisterIconFin2015', N'U') IS NOT NULL DROP TABLE [AssetRegisterIconFin2015];

IF OBJECT_ID (N'AssetChangeIconFin', N'U') IS NOT NULL DROP TABLE [AssetChangeIconFin];
IF OBJECT_ID (N'AssetRefCounter', N'U') IS NOT NULL DROP TABLE [AssetRefCounter];

IF OBJECT_ID (N'AssetRegisterView', N'V') IS NOT NULL DROP View [AssetRegisterView];
IF OBJECT_ID (N'InputFormView', N'V') IS NOT NULL DROP View [dbo].[InputFormView];
IF OBJECT_ID (N'AssetPolicyGeneral', N'U') IS NOT NULL DROP TABLE [AssetPolicyGeneral];
IF OBJECT_ID (N'SCOAClassification', N'U') IS NOT NULL DROP TABLE [SCOAClassification];
IF OBJECT_ID (N'SCOAJournal', N'U') IS NOT NULL DROP TABLE [SCOAJournal];
IF OBJECT_ID (N'AssetRefAccounting', N'U') IS NOT NULL DROP TABLE [AssetRefAccounting];
IF OBJECT_ID (N'AssetRefCategory', N'U') IS NOT NULL DROP TABLE [AssetRefCategory];
IF OBJECT_ID (N'AssetRefSubCategory', N'U') IS NOT NULL DROP TABLE [AssetRefSubCategory];
IF OBJECT_ID (N'AssetProject2015', N'U') IS NOT NULL DROP TABLE [AssetProject2015];

IF OBJECT_ID ('CreateSCOABatch') IS NOT NULL DROP PROCEDURE CreateSCOABatch;
IF OBJECT_ID ('ExportSamrasSCOAJournalRollUp') IS NOT NULL DROP PROCEDURE ExportSamrasSCOAJournalRollUp;
IF OBJECT_ID ('ExportSamrasSCOAMasterDataForBatch') IS NOT NULL DROP PROCEDURE ExportSamrasSCOAMasterDataForBatch;
IF OBJECT_ID ('ExportSolarSCOAJournalRollUp') IS NOT NULL DROP PROCEDURE ExportSolarSCOAJournalRollUp;
IF OBJECT_ID ('UpdateSCOAJournalSCOAFileName') IS NOT NULL DROP PROCEDURE UpdateSCOAJournalSCOAFileName;
IF OBJECT_ID ('ExportVenusSCOAJournalRollUp') IS NOT NULL DROP PROCEDURE ExportVenusSCOAJournalRollUp;
IF OBJECT_ID ('ExportSCOAJournalRollUp') IS NOT NULL DROP PROCEDURE ExportSCOAJournalRollUp;
IF OBJECT_ID ('ExportSCOAJournalNoRollup') IS NOT NULL DROP PROCEDURE ExportSCOAJournalNoRollup;


IF OBJECT_ID ('convertDateToInt') IS NOT NULL DROP FUNCTION convertDateToInt;