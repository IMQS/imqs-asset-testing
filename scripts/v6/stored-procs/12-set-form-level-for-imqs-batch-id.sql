CREATE PROCEDURE [dbo].[SetFormLevelForImqsBatchId]
	@imqsBatchId INT, @formState INT
AS
BEGIN
	UPDATE
		AssetFinFormRef SET Form_Level = @formState
	WHERE
		Form_Reference IN (
			select
				sj.Form_Reference
			from
				SCOAJournal sj
			inner join
				AssetFinFormRef fr on fr.Form_Reference = sj.Form_Reference
			where
				sj.IMQSBatchID = @imqsBatchId
		)
END
