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