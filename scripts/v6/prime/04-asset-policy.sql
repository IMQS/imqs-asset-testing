-- SCOA AssetPolicytGeneral config options
INSERT INTO [AssetPolicyGeneral] ([Section], [Identifier], [Value], [Description], [Modified_By], [Modified_On]) values ('SCOA', 'SCOA Journal Location', 'c:\temp\scoa-exports', NULL, NULL, GETDATE());
INSERT INTO [AssetPolicyGeneral] ([Section], [Identifier], [Value], [Description], [Modified_By], [Modified_On]) values ('SCOA', 'SCOA Financial Year', '2015', 'The year for which we must roll up', NULL, GETDATE());
INSERT INTO [AssetPolicyGeneral] ([Section], [Identifier], [Value], [Description], [Modified_By], [Modified_On]) values ('SCOA', 'SCOA Batch Size', '6', 'The size of SCOA batches', NULL, GETDATE());
INSERT INTO [AssetPolicyGeneral] ([Section], [Identifier], [Value], [Description], [Modified_By], [Modified_On]) values ('SCOA', 'MunicipalDemarcationCode', 'WC032', 'Unique code by which to identify the municipality, supplied to us by the financial system', NULL, GETDATE());
INSERT INTO [AssetPolicyGeneral] ([Section], [Identifier], [Value], [Description], [Modified_By], [Modified_On]) values ('SCOA', 'Version', '6.1', 'The version of SCOA definitions used by this municipality', NULL, GETDATE());
