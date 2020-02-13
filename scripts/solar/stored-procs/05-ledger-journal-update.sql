CREATE PROCEDURE P_F_G_UPD_LEDGER_JOURNAL (@ttLedgerJournal TT_F_G_LEDGER_JOURNAL READONLY , @chvVendorCode Varchar(2), @bitTestRun BIT, 
@chvReturnStatus VARCHAR(50) OUTPUT, @intBatchNumber BIGINT OUTPUT, @intRecordsReceived INT OUTPUT, @intRecordsProcessed INT OUTPUT, @intRecordsFailed INT OUTPUT) 
AS
BEGIN
	SELECT @intRecordsReceived = COUNT(*) FROM @ttLedgerJournal
	SET @intRecordsProcessed = @intRecordsReceived
	SET @intRecordsFailed = 0
	SET @intBatchNumber = (SELECT CASE WHEN MAX(BATCH_NUMBER) IS NULL THEN 1 ELSE MAX(BATCH_NUMBER)+1 END FROM LedgerJournalSummary)
	SET @chvReturnStatus = 'PASS'
	DECLARE @currDateTime datetime2 = (SELECT GETDATE())
	BEGIN TRAN
		INSERT INTO LedgerJournalSummary(BATCH_NUMBER,VENDOR_CODE,BATCH_DATE,RECORDS_RECEIVED,RECORDS_VALIDATED,RECORDS_FAILED,RECORDS_UNAUTHORISED,RECORDS_AUTHORISED,RECORDS_AUTHORISATION_FAILED)
		VALUES (@intBatchNumber, '04', @currDateTime, @intRecordsReceived, @intRecordsReceived, 0, 0, 0, 0)	
		INSERT INTO LedgerJournal SELECT * FROM @ttLedgerJournal
		IF @bitTestRun != 1 
		BEGIN
			COMMIT
		END
		ELSE 
		BEGIN
			PRINT 'Test run detected - after successfully creating journals, the MOCK BCX database will now roll back the changes made'
			ROLLBACK
		END
END