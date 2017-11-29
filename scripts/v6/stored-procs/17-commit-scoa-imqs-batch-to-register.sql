CREATE PROCEDURE [dbo].CommitScoaImqsBatchToRegister (
	@IMQSBatchID BIGINT
) AS
BEGIN
	SET NOCOUNT ON;
	EXEC SetFormLevelForImqsBatchId @IMQSBatchID, 3;
	EXEC SetImqsScoaBatchCommitted @IMQSBatchID;
END