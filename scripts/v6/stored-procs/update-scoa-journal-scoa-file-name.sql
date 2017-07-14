EXECUTE('IF OBJECT_ID (''UpdateSCOAJournalSCOAFileName'') IS NOT NULL DROP PROCEDURE UpdateSCOAJournalSCOAFileName');

CREATE PROCEDURE [dbo].[UpdateSCOAJournalSCOAFileName]
  @FileName VARCHAR(150),
  @FromTranDate DATE,
  @ToTranDate DATE
AS
BEGIN
UPDATE
  SCOAJournal
SET
  SCOAFileName = @FileName,
  SCOAFileDate = GETDATE()
WHERE
  SCOAFileName IS NULL AND
  CommittedToRegister = 1 AND
  CONVERT(DATE,[Date]) >= CONVERT(DATE,(@FromTranDate)) AND
  CONVERT(DATE,[Date]) <= CONVERT(DATE,(@ToTranDate)) AND
  SCOA_Item_Debit IS NOT NULL AND
  SCOA_Item_Credit IS NOT NULL
END