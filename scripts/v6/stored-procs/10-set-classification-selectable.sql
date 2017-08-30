CREATE PROCEDURE [dbo].[SetClassificationSelectable]
	@accountNumber VARCHAR(50)
AS
	BEGIN

		WITH [CTE] (SCOAId, ParentSCOAId, SCOAFile, SCOAAccount, ShortDescription, SCOALevel, AccountNumber, bPostingLevel, PostingLevelDescription, AccountNumberPrefix, VATStatus, BreakDownAllowed, DefinitionDescription, IsSelectable, isBreakdown)
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
			SCOAAccount = (select SCOAAccount from SCOAClassification sc2 where sc2.SCOAId = sc.ParentSCOAId) + ':' + sc.ShortDescription,
			SCOALevel = IIF(cte.IsBreakdown = 1, (select sc2.SCOALevel+1 from SCOAClassification sc2 where sc2.SCOAId = cte.ParentSCOAId), cte.SCOALevel),
			SCOAFile = IIF(cte.IsBreakdown = 1, (select sc2.SCOAFile from SCOAClassification sc2 where sc2.SCOAId = cte.ParentSCOAId), cte.SCOAFile),
			bPostingLevel = 1,
			BreakDownAllowed = 'No'
		FROM
			SCOAClassification sc
		WHERE
			sc.AccountNumber = @accountNumber AND 'Yes' = (select BreakDownAllowed from SCOAClassification where SCOAId = sc.ParentSCOAId);

		--UPDATE
			--SCOAClassification
		--SET
			--bPostingLevel = 0
		--WHERE
			--SCOAId = (select ParentSCOAId from SCOAClassification where AccountNumber = @accountNumber);
END;