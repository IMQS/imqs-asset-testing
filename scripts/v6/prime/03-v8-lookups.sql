DELETE FROM "refActual_ExpenditureType";
INSERT INTO "refActual_ExpenditureType" (k, v) VALUES ('NONE', 'N/A');
INSERT INTO "refActual_ExpenditureType" (k, v) VALUES ('CRN', 'Credit Note');
INSERT INTO "refActual_ExpenditureType" (k, v) VALUES ('DTN', 'Debit Note');
INSERT INTO "refActual_ExpenditureType" (k, v) VALUES ('JRN', 'Journal');
INSERT INTO "refActual_ExpenditureType" (k, v) VALUES ('VAT', 'VAT Journal');
INSERT INTO "refActual_ExpenditureType" (k, v) VALUES ('SIN', 'Stock Issue Note');
INSERT INTO "refActual_ExpenditureType" (k, v) VALUES ('GRT', 'Goods Receipt');
INSERT INTO "refActual_ExpenditureType" (k, v) VALUES ('REV', 'Reversal of Payment');


DELETE FROM "refComponent_DepreciationMethod";
INSERT INTO "refComponent_DepreciationMethod" (k, v) VALUES ('STR', 'Straight Line');
INSERT INTO "refComponent_DepreciationMethod" (k, v) VALUES ('DEC', 'Declining Balance (10%)');

DELETE FROM "refComponent_MeasurementModel";
-- idata|ImqsServerMirror|AssetRefMeasurementModel ?????
INSERT INTO "refComponent_MeasurementModel" (k, v) VALUES ('FV', 'Fair Value');
INSERT INTO "refComponent_MeasurementModel" (k, v) VALUES ('HC', 'Historcal Cost');
INSERT INTO "refComponent_MeasurementModel" (k, v) VALUES ('RE', 'Revaluation');

DELETE FROM "refComponent_OwnedLeased" ;
-- idata|ImqsServerMirror|AssetMethodOwned ?????
INSERT INTO "refComponent_OwnedLeased" (k, v) VALUES ('LEA', 'Leased');
INSERT INTO "refComponent_OwnedLeased" (k, v) VALUES ('OWN', 'Owned');

DELETE FROM "refComponent_UseStatus";
-- idata|ImqsServerMirror|AssetRefUseStatus ?????
INSERT INTO "refComponent_UseStatus" (k, v) VALUES ('FU', 'Future Use');
INSERT INTO "refComponent_UseStatus" (k, v) VALUES ('IU', 'In-Use');
INSERT INTO "refComponent_UseStatus" (k, v) VALUES ('LO', 'Leased to Others');



-- Client specific data
DELETE FROM "refComponent_Department";
INSERT INTO "refComponent_Department" (k, v) VALUES ('DP01', 'Dummy - Dept 01');
INSERT INTO "refComponent_Department" (k, v) VALUES ('DP02', 'Dummy - Dept 02');
INSERT INTO "refComponent_Department" (k, v) VALUES ('DP03', 'Dummy - Dept 03');
INSERT INTO "refComponent_Department" (k, v) VALUES ('DP04', 'Dummy - Dept 04');

DELETE FROM "refComponent_Facility" ;
INSERT INTO "refComponent_Facility" (k, v) VALUES ('0001', 'Dummy - Facility 01');
INSERT INTO "refComponent_Facility" (k, v) VALUES ('0002', 'Dummy - Facility 02');
INSERT INTO "refComponent_Facility" (k, v) VALUES ('0003', 'Dummy - Facility 03');
INSERT INTO "refComponent_Facility" (k, v) VALUES ('0004', 'Dummy - Facility 04');

DELETE FROM "refComponent_Region";
INSERT INTO "refComponent_Region" (k, v) VALUES ('RG01', 'Dummy - Region 01');
INSERT INTO "refComponent_Region" (k, v) VALUES ('RG02', 'Dummy - Region 02');
INSERT INTO "refComponent_Region" (k, v) VALUES ('RG03', 'Dummy - Region 03');
INSERT INTO "refComponent_Region" (k, v) VALUES ('RG04', 'Dummy - Region 04');


DELETE FROM "refComponent_Supplier" ;
INSERT INTO "refComponent_Supplier" (k, v) VALUES ('SP01', 'Dummy Supplier 01');
INSERT INTO "refComponent_Supplier" (k, v) VALUES ('SP02', 'Dummy Supplier 02');
INSERT INTO "refComponent_Supplier" (k, v) VALUES ('SP03', 'Dummy Supplier 03');
INSERT INTO "refComponent_Supplier" (k, v) VALUES ('SP04', 'Dummy Supplier 04');
INSERT INTO "refComponent_Supplier" (k, v) VALUES ('SP05', 'Dummy Supplier 05');


DELETE FROM "refComponent_Suburb" ;
INSERT INTO "refComponent_Suburb" (k, v) VALUES ('SU01', 'Dummy Suburb 01');
INSERT INTO "refComponent_Suburb" (k, v) VALUES ('SU02', 'Dummy Suburb 02');
INSERT INTO "refComponent_Suburb" (k, v) VALUES ('SU03', 'Dummy Suburb 03');
INSERT INTO "refComponent_Suburb" (k, v) VALUES ('SU04', 'Dummy Suburb 04');
INSERT INTO "refComponent_Suburb" (k, v) VALUES ('SU05', 'Dummy Suburb 05');

DELETE FROM "refComponent_Suburb" ;
INSERT INTO "refComponent_Suburb" (k, v) VALUES ('SU01', 'Dummy Suburb 01');
INSERT INTO "refComponent_Suburb" (k, v) VALUES ('SU02', 'Dummy Suburb 02');
INSERT INTO "refComponent_Suburb" (k, v) VALUES ('SU03', 'Dummy Suburb 03');
INSERT INTO "refComponent_Suburb" (k, v) VALUES ('SU04', 'Dummy Suburb 04');
INSERT INTO "refComponent_Suburb" (k, v) VALUES ('SU05', 'Dummy Suburb 05');


-- not included
-- Project: Project Nature
-- Project: Project Type






