CREATE PROCEDURE [dbo].[RunAnnualDepreciation_SCOA] (
@FinYear INT,
@Period INT,
@ToDate DATETIME,
@ComponentID VARCHAR(40) = NULL
)

AS

BEGIN
SET NOCOUNT ON
DECLARE @StartOfYear VARCHAR(MAX)
DECLARE @EndOfYear VARCHAR(MAX)
DECLARE @SQL VARCHAR(MAX)
DECLARE @DAYS VARCHAR(MAX)
DECLARE @Factor FLOAT

SET @StartOfYear = '01-JUL-'+ CAST(@FinYear-1 AS VARCHAR(4))
SET @EndOfYear   = '30-JUN-'+CAST(@FinYear AS VARCHAR(4))

--Striaght Line
EXECUTE InterimDepreciationStraightLine_SCOA @FinYear, @Period, @ToDate, @StartOfYear, @EndOfYear, @ComponentID;

--Declining Balance
EXECUTE InterimDepreciationDBalMonth_SCOA @FinYear, @Period, @ToDate, @StartOfYear, @EndOfYear, @ComponentID;

END