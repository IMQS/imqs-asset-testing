-- Tables relating to the Bill of Quantities (BOQ), referred to the the asset policy in V6

IF OBJECT_ID (N'AssetPolicyGeneral', N'U') IS NOT NULL DROP TABLE [AssetPolicyGeneral];

-- Used by SP GetForecastReplYear that is used by the AssetRegisterIconFin table
CREATE TABLE [dbo].[AssetPolicyGeneral](
	[Section] [varchar](40) NOT NULL,
	[Identifier] [varchar](80) NOT NULL,
	[Value] [varchar](80) NULL,
	[Description] [varchar](160) NULL,
	[Modified_By] [varchar](40) NULL,
	[Modified_On] [datetime] NULL,
	CONSTRAINT [PK_AssetPolicyGeneral_CombKey] PRIMARY KEY CLUSTERED([Section] ASC, [Identifier] ASC) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];

-- SCOA AssetPolicytGeneral config options
INSERT INTO [AssetPolicyGeneral] ([Section], [Identifier], [Value], [Description], [Modified_By], [Modified_On]) values ('SCOA', 'SCOA Journal Location', 'c:\temp\scoa-exports', NULL, NULL, GETDATE());
INSERT INTO [AssetPolicyGeneral] ([Section], [Identifier], [Value], [Description], [Modified_By], [Modified_On]) values ('SCOA', 'SCOA Financial Year', '2015', 'The year for which we must roll up', NULL, GETDATE());
INSERT INTO [AssetPolicyGeneral] ([Section], [Identifier], [Value], [Description], [Modified_By], [Modified_On]) values ('SCOA', 'SCOA Batch Size', '6', 'The size of SCOA batches', NULL, GETDATE());
INSERT INTO [AssetPolicyGeneral] ([Section], [Identifier], [Value], [Description], [Modified_By], [Modified_On]) values ('SCOA', 'MunicipalDemarcationCode', 'WC032', 'Unique code by which to identify the municipality, supplied to us by the financial system', NULL, GETDATE());
INSERT INTO [AssetPolicyGeneral] ([Section], [Identifier], [Value], [Description], [Modified_By], [Modified_On]) values ('SCOA', 'Version', '6.1', 'The version of SCOA definitions used by this municipality', NULL, GETDATE());
