IF OBJECT_ID ('ExportSamrasSCOAJournalRollUp') IS NOT NULL DROP PROCEDURE ExportSamrasSCOAJournalRollUp;
IF OBJECT_ID ('ExportSamrasSCOAMasterDataForBatch') IS NOT NULL DROP PROCEDURE ExportSamrasSCOAMasterDataForBatch;
IF OBJECT_ID ('ExportSCOAJournalRollUp') IS NOT NULL DROP PROCEDURE ExportSCOAJournalRollUp;
IF OBJECT_ID ('UpdateSCOAJournalSCOAFileName') IS NOT NULL DROP PROCEDURE UpdateSCOAJournalSCOAFileName;
IF OBJECT_ID (N'SetClassificationSelectable', N'P') IS NOT NULL DROP PROCEDURE [SetClassificationSelectable];
IF OBJECT_ID (N'NextValueFor', N'P') IS NOT NULL DROP PROCEDURE [NextValueFor];
IF OBJECT_ID (N'SetValueFor', N'P') IS NOT NULL DROP PROCEDURE [SetValueFor];
IF OBJECT_ID (N'RunAnnualDepreciation_SCOA', N'P') IS NOT NULL DROP PROCEDURE [RunAnnualDepreciation_SCOA];
IF OBJECT_ID (N'UpdateOpeningBalances', N'P') IS NOT NULL DROP PROCEDURE [UpdateOpeningBalances];
IF OBJECT_ID (N'InterimDepreciationStraightLine_SCOA', N'P') IS NOT NULL DROP PROCEDURE [InterimDepreciationStraightLine_SCOA];
IF OBJECT_ID (N'InterimDepreciationDBalMonth_SCOA', N'P') IS NOT NULL DROP PROCEDURE [InterimDepreciationDBalMonth_SCOA];
IF OBJECT_ID (N'SCOABudgetInsert', N'P') IS NOT NULL DROP PROCEDURE [SCOABudgetInsert];
IF OBJECT_ID (N'RollOverComponent', N'P') IS NOT NULL DROP PROCEDURE [RollOverComponent];
IF OBJECT_ID (N'DerecogniseComponent', N'P') IS NOT NULL DROP PROCEDURE [DerecogniseComponent];
IF OBJECT_ID (N'ReverseDerecogniseComponent', N'P') IS NOT NULL DROP PROCEDURE [ReverseDerecogniseComponent];
IF OBJECT_ID (N'roll_over_rul_month', N'P') IS NOT NULL DROP PROCEDURE [roll_over_rul_month];
IF OBJECT_ID (N'roll_over_rul_year', N'P') IS NOT NULL DROP PROCEDURE [roll_over_rul_year];
IF OBJECT_ID (N'InterimDepreciationStraightLine_SCOA', N'P') IS NOT NULL DROP PROCEDURE [InterimDepreciationStraightLine_SCOA];
