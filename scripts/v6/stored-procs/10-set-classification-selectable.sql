CREATE PROCEDURE [dbo].[SetClassificationSelectable]
	@accountNumber VARCHAR(50)
AS
BEGIN

	DECLARE @selectables TABLE (SCOAId NVARCHAR(250), ParentSCOAId NVARCHAR(250), SCOAFile NVARCHAR(100), SCOAAccount NVARCHAR(1024), ShortDescription NVARCHAR(500), SCOALevel INT, AccountNumber NVARCHAR(250), bPostingLevel NVARCHAR(50), PostingLevelDescription NVARCHAR(250), BreakDownAllowed NVARCHAR(50), IsSelectable BIT, IsBreakdown BIT);

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

	INSERT INTO @selectables SELECT
		cte.SCOAId,
		cte.ParentSCOAId,
		IIF(CTE.IsBreakdown = 1, (select t.SCOAFile from cte t where t.SCOAId = cte.ParentSCOAId), CTE.SCOAFile),
		(select t.SCOAAccount from cte t where t.SCOAId = CTE.ParentSCOAId) + ':' + CTE.ShortDescription,
		cte.ShortDescription,
		IIF(CTE.IsBreakdown = 1, (select t.SCOALevel+1 from cte t where t.SCOAId = cte.ParentSCOAId), CTE.SCOALevel),
		cte.AccountNumber,
		1,
		cte.PostingLevelDescription,
		'No',
		1,
		cte.IsBreakdown
	FROM
		cte
	WHERE
		CTE.AccountNumber = @accountNumber AND 'Yes' = (select t.BreakDownAllowed from cte t where SCOAId = CTE.ParentSCOAId);

	UPDATE
		SCOAClassification
	SET
		IsSelectable = s.IsSelectable,
		SCOAAccount = s.SCOAAccount,
		SCOALevel = s.SCOALevel,
		SCOAFile = s.SCOAFile,
		bPostingLevel = s.bPostingLevel,
		BreakDownAllowed = s.BreakDownAllowed
	FROM
		@selectables s
	WHERE
		s.SCOAAccount = @accountNumber;
END;