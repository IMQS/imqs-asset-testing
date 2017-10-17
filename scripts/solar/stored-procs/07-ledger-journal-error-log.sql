CREATE PROCEDURE P_F_G_GET_LEDGER_JOURNAL_ERROR_LOG (@chvVendorCode Varchar(2), @intBatchNumber Bigint)
AS
BEGIN
SELECT * FROM LedgerJournalErrorLog WHERE BATCH_NUMBER = @intBatchNumber AND VENDOR_CODE = @chvVendorCode
END;