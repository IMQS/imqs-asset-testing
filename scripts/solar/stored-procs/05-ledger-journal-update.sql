CREATE PROCEDURE [dbo].[P_F_G_UPD_LEDGER_JOURNAL] (@ttLedgerJournal TT_F_G_LEDGER_JOURNAL READONLY , @chvVendorCode Varchar(2),
@chvReturnStatus VARCHAR(50) OUTPUT, @intBatchNumber BIGINT OUTPUT, @intRecordsReceived INT OUTPUT, @intRecordsProcessed INT OUTPUT, @intRecordsFailed INT OUTPUT)
AS
BEGIN
	SELECT @intRecordsReceived = COUNT(*) FROM @ttLedgerJournal
	SET @intRecordsProcessed = @intRecordsReceived
	SET @intRecordsFailed = 0
	SET @intBatchNumber = (SELECT CASE WHEN MAX(BATCH_NUMBER) IS NULL THEN 1 ELSE MAX(BATCH_NUMBER)+1 END FROM LedgerJournalSummary)
	SET @chvReturnStatus = 'PASS'

	DECLARE @currDateTime datetime2 = (SELECT GETDATE())

	INSERT INTO LedgerJournalSummary(BATCH_NUMBER,VENDOR_CODE,BATCH_DATE,RECORDS_RECEIVED,RECORDS_VALIDATED,RECORDS_FAILED,RECORDS_UNAUTHORISED,RECORDS_AUTHORISED,RECORDS_AUTHORISATION_FAILED)
	VALUES (@intBatchNumber, '04', @currDateTime, @intRecordsReceived, @intRecordsReceived, 0, 0, 0, 0);

END;