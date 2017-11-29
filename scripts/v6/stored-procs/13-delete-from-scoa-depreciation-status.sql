CREATE PROCEDURE [dbo].[DeleteFromScoaDepreciationStatus]
	@imqsBatchId INT
AS
BEGIN
	DELETE FROM SCOADepreciationStatus WHERE SCOAJournalID IN (select ID from SCOAJournal where IMQSBatchID = @imqsBatchId);
END
