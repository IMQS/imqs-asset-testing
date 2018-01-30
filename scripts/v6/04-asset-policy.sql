-- Tables and functions relating to V6 Policy

IF OBJECT_ID (N'AssetPolicyGeneral', N'U') IS NOT NULL DROP TABLE [AssetPolicyGeneral];
IF OBJECT_ID ('GetForecastReplYear') IS NOT NULL DROP FUNCTION GetForecastReplYear;

CREATE TABLE [dbo].[AssetPolicyGeneral](
	[Section] [varchar](40) NOT NULL,
	[Identifier] [varchar](80) NOT NULL,
	[Value] [varchar](80) NULL,
	[Description] [varchar](160) NULL,
	[Modified_By] [varchar](40) NULL,
	[Modified_On] [datetime] NULL,
	CONSTRAINT [PK_AssetPolicyGeneral_CombKey] PRIMARY KEY CLUSTERED([Section] ASC, [Identifier] ASC) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];

EXECUTE ('CREATE FUNCTION [dbo].[GetForecastReplYear](@RUL NUMERIC(18,2), @FinYear INT)
  RETURNS INT
  AS
  BEGIN
    DECLARE @Result INT
    DECLARE @ULM varchar(80)

    SET @ULM = (SELECT UPPER(Value) FROM AssetPolicyGeneral WHERE Identifier = ''Useful Life Measure'');

    IF (@ULM = ''MONTHS'') or (@ULM = ''MONTH'')
       SET @Result = (CONVERT([int],FLOOR((@FinYear)+@RUL/12),(0)))
    ELSE IF (@ULM = ''DAYS'') or (@ULM = ''DAY'')
       SET @Result = (CONVERT([int],FLOOR((@FinYear)+@RUL/365),(0)))
    ELSE
       SET @Result = (CONVERT([int],FLOOR((@FinYear)+@RUL),(0)))

    RETURN @Result
  END;');