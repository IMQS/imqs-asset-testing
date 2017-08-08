CREATE PROCEDURE [dbo].[ExportSCOAJournalRollUp]
	@finYear INT,
	@depreciation BIT,
	@FromTranDate DATE,
	@ToTranDate DATE,
	@numberInputForms BIGINT OUTPUT,
	@imqsBatchId INT OUTPUT
AS
BEGIN

	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	EXECUTE CreateSCOABatch @finYear, NULL, @depreciation, @FromTranDate, @ToTranDate, 'NONE', @numberInputForms OUTPUT, @imqsBatchId OUTPUT;

	SELECT
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
				FinancialField,
				CONVERT(DATE,[Date]) as TranDate,
				SUM(Amount) as Amount,
				SCOA_Fund,
				SCOA_Function,
				SCOA_Mun_Classification,
				SCOA_Project,
				SCOA_Costing,
				SCOA_Region,
				SCOA_Item_Debit as SCOA_ITEM,
				'D' as DebitCredit
			FROM
				SCOAJournal
			WHERE
				SCOAFileName IS NULL AND
				CommittedToRegister = 1 AND
				(CONVERT(DATE,[Date]) >= @FromTranDate) AND
				(CONVERT(DATE,[Date]) <= @ToTranDate) AND
				SCOA_Item_Debit IS NOT NULL AND
				SCOA_Item_Credit IS NOT NULL AND
				IMQSBatchID = @imqsBatchId
			GROUP BY
				FinancialField,
				CONVERT(DATE,[Date]),
				SCOA_Fund,
				SCOA_Function,
				SCOA_Mun_Classification,
				SCOA_Project,
				SCOA_Costing,
				SCOA_Region,
				SCOA_Item_Debit

			UNION

			SELECT
				FinancialField,
				CONVERT(DATE,[Date]) as TranDate,
				SUM(Amount)as Amount,
				SCOA_Fund, SCOA_Function,
				SCOA_Mun_Classification,
				SCOA_Project,
				SCOA_Costing,
				SCOA_Region,
				SCOA_Item_Credit as SCOA_ITEM,
				'C' as DebitCredit
			FROM
				SCOAJournal
			WHERE
				SCOAFileName IS NULL AND
				CommittedToRegister = 1 AND
				(CONVERT(DATE,[Date]) >= @FromTranDate) AND
				(CONVERT(DATE,[Date]) <= @ToTranDate) AND
				SCOA_Item_Debit IS NOT NULL AND
				SCOA_Item_Credit IS NOT NULL AND
				IMQSBatchID = @imqsBatchId
			GROUP BY
				FinancialField,
				CONVERT(DATE,[Date]),
				SCOA_Fund,
				SCOA_Function,
				SCOA_Mun_Classification,
				SCOA_Project,
				SCOA_Costing,
				SCOA_Region,
				SCOA_Item_Credit
		) as b

		ORDER BY
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
