CREATE PROCEDURE [dbo].[SetClassificationSelectable]
	@accountNumber VARCHAR(50)
AS
BEGIN
	WITH CTE
	AS (
		SELECT
			c.SCOAId, c.ParentSCOAId, c.SCOAFile, c.SCOAAccount, c.ShortDescription, c.SCOALevel, c.AccountNumber, c.bPostingLevel, c.PostingLevelDescription, c.AccountNumberPrefix, c.VATStatus, c.BreakDownAllowed, c.DefinitionDescription, c.IsSelectable, c.IsBreakdown
		FROM
			SCOAClassification c
		WHERE
			AccountNumber = @accountNumber

		UNION ALL

		SELECT
			c.SCOAId,
			c.ParentSCOAId,
			c.SCOAFile,
			c.SCOAAccount,
			c.ShortDescription,
			c.SCOALevel,
			c.AccountNumber,
			c.bPostingLevel,
			c.PostingLevelDescription,
			c.AccountNumberPrefix,
			c.VATStatus,
			c.BreakDownAllowed,
			c.DefinitionDescription,
			c.IsSelectable,
			c.IsBreakdown
		FROM
			CTE p, SCOAClassification c
		WHERE
			c.SCOAId = p.ParentSCOAId
	)

	UPDATE
		SCOAClassification
	SET
		IsSelectable = 1,
		SCOAAccount = (select t.SCOAAccount from cte t where t.SCOAId = CTE.ParentSCOAId) + ':' + CTE.ShortDescription,
		SCOALevel = IIF(CTE.IsBreakdown = 1, (select t.SCOALevel+1 from cte t where t.SCOAId = cte.ParentSCOAId), CTE.SCOALevel),
		SCOAFile = IIF(CTE.IsBreakdown = 1, (select t.SCOAFile from cte t where t.SCOAId = cte.ParentSCOAId), CTE.SCOAFile),
		bPostingLevel = 1,
		BreakDownAllowed = 'No'
	FROM
		CTE
		INNER JOIN
		SCOAClassification sc ON sc.AccountNumber = CTE.AccountNumber
	WHERE
		CTE.AccountNumber = @accountNumber;

	UPDATE
		SCOAClassification
	SET
		bPostingLevel = 0
	WHERE
		SCOAId = (select ParentSCOAId from SCOAClassification where AccountNumber = @accountNumber);
END;