CREATE PROCEDURE [dbo].[ExportSCOAJournalNoRollup]
	@FromTranDate DATE,
	@ToTranDate DATE
AS
BEGIN

	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT
		b.ComponentID,
		b.FinancialField,
		b.TranDate,
		b.Amount,
		b.SCOA_Fund,
		b.SCOA_Function,
		b.SCOA_Mun_Classification,
		b.SCOA_Project,
		b.SCOA_Costing,
		b.SCOA_Region,
		b.SCOA_ITEM,
		b.DebitCredit
	FROM
		(
			SELECT
				ComponentID,
				FinancialField,
				CONVERT(DATE,[Date]) as TranDate,
				Amount,
				SCOA_Fund,
				SCOA_Function,
				SCOA_Mun_Classification,
				SCOA_Project,
				SCOA_Costing,
				SCOA_Region,
				SCOA_Item_Debit as SCOA_Item,
				'D' as DebitCredit
			FROM
				SCOAJournal
			WHERE
				SCOAFileName IS NULL AND
				CommittedToRegister = 1 AND
				(CONVERT(DATE,[Date]) >= @FromTranDate) AND
				(CONVERT(DATE,[Date]) <= @ToTranDate) AND
				SCOA_Item_Debit IS NOT NULL AND
				SCOA_Item_Credit IS NOT NULL

			UNION

			SELECT
				ComponentID,
				FinancialField,
				CONVERT(DATE,[Date]) as TranDate,
				Amount,
				SCOA_Fund,
				SCOA_Function,
				SCOA_Mun_Classification,
				SCOA_Project,
				SCOA_Costing,
				SCOA_Region,
				SCOA_Item_Credit as SCOA_Item,
				'C' as DebitCredit
			FROM
				SCOAJournal
			WHERE
				SCOAFileName IS NULL AND
				CommittedToRegister = 1 AND
				(CONVERT(DATE,[Date]) >= @FromTranDate) AND
				(CONVERT(DATE,[Date]) <= @ToTranDate) AND
				SCOA_Item_Debit IS NOT NULL AND
				SCOA_Item_Credit IS NOT NULL
		) as b

	ORDER BY
		ComponentID,
		FinancialField,
		TranDate,
		SCOA_Fund,
		SCOA_Function,
		SCOA_Mun_Classification,
		SCOA_Project,
		SCOA_Costing,
		SCOA_Region,
		DebitCredit DESC
END