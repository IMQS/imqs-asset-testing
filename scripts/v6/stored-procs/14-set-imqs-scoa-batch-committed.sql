CREATE PROCEDURE [dbo].[SetImqsScoaBatchCommitted]
	@imqsBatchId INT
AS
BEGIN
	UPDATE ScoaJournal SET CommittedToRegister = 1 WHERE IMQSBatchID = @IMQSBatchID
END