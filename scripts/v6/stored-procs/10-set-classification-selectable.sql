CREATE PROCEDURE [dbo].[SetClassificationSelectable]
		@accountNumber VARCHAR(50)
AS
	BEGIN
		WITH [CTE] (SCOAId, ParentSCOAId, SCOAFile, SCOAAccount, ShortDescription, SCOALevel, AccountNumber, bPostingLevel, PostingLevelDescription, AccountNumberPrefix, VATStatus, BreakDownAllowed, DefinitionDescription, IsSelectable)
		AS (
			SELECT
				c.SCOAId, c.ParentSCOAId, c.SCOAFile, c.SCOAAccount, c.ShortDescription, c.SCOALevel, c.AccountNumber, c.bPostingLevel, c.PostingLevelDescription, c.AccountNumberPrefix, c.VATStatus, c.BreakDownAllowed, c.DefinitionDescription, c.IsSelectable
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
				c.IsSelectable
			FROM
				[CTE] p, SCOAClassification c
			WHERE
				c.SCOAId = p.ParentSCOAId
		)
		UPDATE
			SCOAClassification
		SET
			IsSelectable = 1
		FROM
			CTE
		WHERE
			SCOAClassification.SCOAId = CTE.SCOAId
	END;
