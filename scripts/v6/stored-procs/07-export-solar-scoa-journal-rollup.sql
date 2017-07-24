CREATE PROCEDURE [dbo].[ExportSolarSCOAJournalRollUp]
	@batchSize INT, @depreciation BIT, @numberInputForms BIGINT OUTPUT, @imqsBatchId INT OUTPUT
AS
BEGIN

	SET NOCOUNT ON;

	EXECUTE CreateSCOABatch @batchSize, @depreciation, NULL, NULL, 'PUSH', @numberInputForms OUTPUT, @imqsBatchId OUTPUT;

	-- For the final coup d'etat, we select the new UNIQUE_IDENTIFIER values from the @postingBindings table,
	-- so as to post these values back to the Financial System when we send off our rollups.
	SELECT
		sj.PostingCreditID as UNIQUE_IDENTIFIER,
		STR(sj.FinYear,4) + REPLACE(STR(sj.Period, 2), ' ', '0') as FINANCIAL_PERIOD,
		'AK' as LEDGER_TRANSACTION_TYPE,
		'04' as VENDOR_CODE,
		'04' + case f.AssetMoveableID when 'IMM' then 'I' else 'M' end + right('00000000000' + (REPLACE(STR(sj.IMQSBatchID,10), ' ', '') + '-' + REPLACE(STR(sj.RollupID,10), ' ', '')), 11) as JOURNAL_REFERENCE,
		aff.Form_Desc as JOURNAL_DESCRIPTION_1,
		sj.FinancialField as JOURNAL_DESCRIPTION_2,
		'' as JOURNAL_DESCRIPTION_3,
		dbo.convertDateToInt(sj.EffectiveDate) as TRANSACTION_DATE,
		sj.SCOA_Function as SCOA_FUNCTION_GUID,
		sj.SCOA_Fund as SCOA_FUND_GUID,
		sj.SCOA_Item_Debit as SCOA_ITEM_GUID,
		sj.SCOA_Project as SCOA_PROJECT_GUID,
		sj.SCOA_Costing as SCOA_COST_GUID,
		sj.SCOA_Region as SCOA_REGION_GUID,
		sj.SCOA_Mun_Classification as ENTITY_COST_CENTRE,
		sj.BudgetID as ENTITY_SUB_ITEM,
		sj.ProjectID as ENTITY_PROJECT,
		SUM(sj.Amount) as DEBIT_AMOUNT,
		0 as CREDIT_AMOUNT,
		@imqsBatchId as IMQSBatchID
	FROM
		SCOAJournal sj
	INNER JOIN
		AssetFinFormInput f ON sj.Form_Reference = f.Form_Reference
	INNER JOIN
		AssetFinFormRef affr ON sj.Form_Reference = affr.Form_Reference
	INNER JOIN
		AssetFinForm aff ON affr.Form_Nr = aff.Form_Nr
	WHERE
		sj.IMQSBatchID = @imqsBatchId
	GROUP BY
		sj.PostingCreditID,
		aff.Form_Desc,
		STR(sj.FinYear,4) + REPLACE(STR(sj.Period, 2), ' ', '0'),
		(REPLACE(STR(sj.IMQSBatchID,10), ' ', '') + '-' + REPLACE(STR(sj.RollupID,10), ' ', '')),
		'04' + case f.AssetMoveableID when 'IMM' then 'I' else 'M' end + right('00000000000' + (REPLACE(STR(sj.IMQSBatchID,10), ' ', '') + '-' + REPLACE(STR(sj.RollupID,10), ' ', '')), 11),
		IMQSBatchID + '-' + RollupID,
		dbo.convertDateToInt(sj.EffectiveDate),
		sj.FinancialField,
		sj.FinYear,
		sj.BudgetID,
		sj.ProjectID,
		sj.SCOA_Fund,
		sj.SCOA_Function,
		sj.SCOA_Mun_Classification,
		sj.SCOA_Project,
		sj.SCOA_Costing,
		sj.SCOA_Region,
		sj.SCOA_Item_Debit

	UNION

	SELECT
		sj.PostingDebitID as UNIQUE_IDENTIFIER,
		STR(sj.FinYear,4) + REPLACE(STR(sj.Period, 2), ' ', '0') as FINANCIAL_PERIOD,
		'AK' as LEDGER_TRANSACTION_TYPE,
		'04' as VENDOR_CODE,
		'04' + case f.AssetMoveableID when 'IMM' then 'I' else 'M' end + right('00000000000' + (REPLACE(STR(sj.IMQSBatchID,10), ' ', '') + '-' + REPLACE(STR(sj.RollupID,10), ' ', '')), 11) as JOURNAL_REFERENCE,
		aff.Form_Desc as JOURNAL_DESCRIPTION_1,
		sj.FinancialField as JOURNAL_DESCRIPTION_2,
		'' as JOURNAL_DESCRIPTION_3,
		dbo.convertDateToInt(sj.EffectiveDate) as TRANSACTION_DATE,
		sj.SCOA_Function as SCOA_FUNCTION_GUID,
		sj.SCOA_Fund as SCOA_FUND_GUID,
		sj.SCOA_Item_Credit as SCOA_ITEM_GUID,
		sj.SCOA_Project as SCOA_PROJECT_GUID,
		sj.SCOA_Costing as SCOA_COST_GUID,
		sj.SCOA_Region as SCOA_REGION_GUID,
		sj.SCOA_Mun_Classification as ENTITY_COST_CENTRE,
		sj.BudgetID as ENTITY_SUB_ITEM,
		sj.ProjectID as ENTITY_PROJECT,
		0 as DEBIT_AMOUNT,
		SUM(sj.Amount) as CREDIT_AMOUNT,
		@imqsBatchId as IMQSBatchID
	FROM
		SCOAJournal sj
	INNER JOIN
		AssetFinFormInput f ON sj.Form_Reference = f.Form_Reference
	INNER JOIN
		AssetFinFormRef affr ON sj.Form_Reference = affr.Form_Reference
	INNER JOIN
		AssetFinForm aff ON affr.Form_Nr = aff.Form_Nr
	WHERE
		sj.IMQSBatchID = @imqsBatchId
	GROUP BY
		sj.PostingDebitID,
		aff.Form_Desc,
		STR(sj.FinYear,4) + REPLACE(STR(sj.Period, 2), ' ', '0'),
		(REPLACE(STR(sj.IMQSBatchID,10), ' ', '') + '-' + REPLACE(STR(sj.RollupID,10), ' ', '')),
		'04' + case f.AssetMoveableID when 'IMM' then 'I' else 'M' end + right('00000000000' + (REPLACE(STR(sj.IMQSBatchID,10), ' ', '') + '-' + REPLACE(STR(sj.RollupID,10), ' ', '')), 11),
		IMQSBatchID + '-' + RollupID,
		dbo.convertDateToInt(sj.EffectiveDate),
		sj.FinancialField,
		sj.FinYear,
		sj.BudgetID,
		sj.ProjectID,
		sj.SCOA_Fund,
		sj.SCOA_Function,
		sj.SCOA_Mun_Classification,
		sj.SCOA_Project,
		sj.SCOA_Costing,
		sj.SCOA_Region,
		sj.SCOA_Item_Credit;
END
