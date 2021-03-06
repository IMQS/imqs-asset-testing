-- Various tables used to maintain metadata, or manage components within th eWIP or AR.

IF OBJECT_ID (N'AssetDBVersion', N'U') IS NOT NULL DROP TABLE [AssetDBVersion];
IF OBJECT_ID (N'AssetRefCounter', N'U') IS NOT NULL DROP TABLE [AssetRefCounter];
IF OBJECT_ID (N'AssetFinYear', N'U') IS NOT NULL DROP TABLE [AssetFinYear];

CREATE TABLE [dbo].[AssetDBVersion](
	[DBVersionNr] [varchar](15) NOT NULL,
	[ARRevision] [int] NOT NULL,
	[LastUpdated] [datetime] NOT NULL,
	[LastScriptName] [varchar](100) NULL,
 CONSTRAINT [PK_AssetDBVersion] PRIMARY KEY CLUSTERED
(
	[DBVersionNr] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY];
INSERT INTO AssetDBVersion (DBVersionNr, ARRevision, LastUpdated) VALUES ('6.27.0.0', '62700', GetDate());

CREATE TABLE [dbo].[AssetRefCounter](
	[counter_name] [varchar](30) NOT NULL,
	[counter_prev_id] [int] NULL,
	[counter_current_id] [int] NULL,
	[counter_next_id] [int] NULL,
	CONSTRAINT [PK_AssetRefCounter] PRIMARY KEY CLUSTERED([counter_name] ASC) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];


CREATE TABLE [dbo].[AssetFinYear](
	[FinYearID] [int] IDENTITY(1,1) NOT NULL,
	[FinYear] [int] NOT NULL,
	[HasValRegister] [varchar](50) NULL,
	[HasFinRegister] [varchar](50) NULL,
	[DT_LastUpdate] [datetime] NULL,
	[HasPolicyRates] [bit] NULL,
	[IsFinLocked] [bit] NULL,
	[IsValLocked] [bit] NULL,
	[DT_Locked] [datetime] NULL,
	[Locked_By] [varchar](30) NULL,
	[Period] [int] NULL,
	[SCOAVersion] [varchar](5) NULL
	CONSTRAINT [PK_AssetFinYear_FinYear] PRIMARY KEY CLUSTERED([FinYear] ASC) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
ALTER TABLE [dbo].[AssetFinYear] ADD  CONSTRAINT [DF_AssetFinyear_DTLastUpdate]  DEFAULT (getdate()) FOR [DT_LastUpdate];
ALTER TABLE [dbo].[AssetFinYear] ADD  CONSTRAINT [DF_AssetFinyear_HasPolicyRates]  DEFAULT ((0)) FOR [HasPolicyRates];
ALTER TABLE [dbo].[AssetFinYear] ADD  CONSTRAINT [DF_AssetFinyear_IsFinLocked]  DEFAULT ((0)) FOR [IsFinLocked];
ALTER TABLE [dbo].[AssetFinYear] ADD  CONSTRAINT [DF_AssetFinyear_IsValLocked]  DEFAULT ((0)) FOR [IsValLocked];

-- IMQSBatchId Sequence (for tracking batches sent to 3rd-party financial systems)
IF OBJECT_ID (N'IMQSBatchID_Seq', N'U') IS NOT NULL DROP SEQUENCE [dbo].[IMQSBatchID_Seq];
CREATE SEQUENCE [dbo].[IMQSBatchID_Seq] AS [bigint] START WITH 1 INCREMENT BY 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE  3;
