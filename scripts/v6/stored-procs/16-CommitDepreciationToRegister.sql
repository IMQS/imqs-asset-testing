CREATE PROCEDURE [dbo].CommitDepreciationToRegister(
@IMQSBatchID BIGINT
)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @FinYear INT;
	DECLARE @FinRegister VARCHAR(MAX);
	SET @FinYear = (SELECT TOP 1 FinYear FROM SCOAJournal WHERE IMQSBatchID = @IMQSBatchID);
	SET @FinRegister = 'AssetRegisterIconFin' + CAST(@FinYear AS VARCHAR(4));
	DECLARE @ARSQL VARCHAR(MAX) = 'UPDATE ar SET
						ar.DateLastFinMonth = sj.EffectiveDate,
						ar.DepreciationFinYTD = ar.DepreciationFinYTD - sj.Amount
					FROM ' + @FinRegister + '  ar, SCOAJournal sj
					WHERE
						ar.ComponentID = sj.ComponentID AND
						sj.FinancialField = ''DepreciationFinYTD'' AND
						sj.IMQSBatchID = ' + CONVERT(VARCHAR,@IMQSBatchID);
	DECLARE @SJSQL VARCHAR(MAX) = 'UPDATE ScoaJournal SET CommittedToRegister = 1 WHERE IMQSBatchID = '+CONVERT(VARCHAR,@IMQSBatchID);
	EXEC SetFormLevelForImqsBatchId @IMQSBatchID, 3;
	EXEC(@ARSQL);
	EXEC(@SJSQL);
END