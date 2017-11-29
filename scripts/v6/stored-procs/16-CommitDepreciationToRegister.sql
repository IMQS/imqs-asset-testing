CREATE PROCEDURE [dbo].CommitDepreciationToRegister(
@IMQSBatchID BIGINT
)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @SQL VARCHAR(MAX) = '';
	DECLARE @FinYear INT;
	DECLARE @FinRegister VARCHAR(MAX);
	SET @FinYear = (SELECT TOP 1 FinYear FROM SCOAJournal WHERE IMQSBatchID = @IMQSBatchID);
	SET @FinRegister = 'AssetRegisterIconFin' + CAST(@FinYear AS VARCHAR(4));
	SET @ARSQL = 'UPDATE ar SET
						ar.DateLastFinMonth = sj.EffectiveDate,
						ar.DepreciationFinYTD = ar.DepreciationFinYTD - sj.Amount
					FROM ' + @FinRegister + '  ar, SCOAJournal sj
					WHERE
						ar.ComponentID = sj.ComponentID AND
						sj.FinancialField = ''DepreciationFinYTD'' AND
						sj.IMQSBatchID = ' + CONVERT(VARCHAR,@IMQSBatchID);
	SET @SJSQL = 'UPDATE ScoaJournal SET CommittedToRegister = 1 WHERE IMQSBatchID = '+CONVERT(VARCHAR,@IMQSBatchID);
	EXEC SetFormLevelForImqsBatchId @IMQSBatchID, 3;
	EXEC(@ARSQL);
	EXEC(@SJSQL);
END