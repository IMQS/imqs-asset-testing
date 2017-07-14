EXECUTE('IF OBJECT_ID (''ExportVenusSCOAJournalRollUp'') IS NOT NULL DROP PROCEDURE ExportVenusSCOAJournalRollUp');

CREATE PROCEDURE [dbo].[ExportVenusSCOAJournalRollUp]
		@batchSize INT, @numberInputForms BIGINT OUTPUT, @imqsBatchId INT OUTPUT
AS
BEGIN

	SET NOCOUNT ON;

	execute CreateSCOABatch @batchSize, NULL, NULL, 0, @numberInputForms OUTPUT, @imqsBatchId OUTPUT;

	-- For the final coup d'etat, we select the new UNIQUE_IDENTIFIER values from the @postingBindings table,
	-- so as to post these values back to the Financial System when we send off our rollups. For venus there is
	-- no field that can be used to store this value yet, but we are leaving it here for when the opportunity arises
	SELECT
		'AK' as [GL-TYPE],
		'04' + case f.AssetMoveableID when 'IMM' then 'I' else 'M' end + right('00000000000' + (REPLACE(STR(sj.IMQSBatchID,10), ' ', '') + '-' + REPLACE(STR(sj.RollupID,10), ' ', '')), 11) as [REFERENCE-NO],
		aff.Form_Desc as [DESCRIPTION],
		dbo.convertDateToInt(EffectiveDate) as [DATE],
		sj.SCOA_Function as [SCOA-FUNCTION],
		sj.SCOA_Fund as [SCOA-FUND],
		sj.SCOA_Item_Debit as [SCOA-ITEM],
		sj.SCOA_Project as [SCOA-PROJECT],
		sj.SCOA_Costing as [SCOA-COST],
		sj.SCOA_Region as [SCOA-REGION],
		sj.SCOA_Mun_Classification as [DEPT-COST],
		sj.BudgetID as [SUB-ITEM],
		'' as [VOTE],
		SUM(sj.Amount) as [DEBIT_AMOUNT],
		0 as [CREDIT_AMOUNT],
		'' as [FLEET_READING],
		'' as [QTY]
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
		aff.Form_Desc,
		STR(sj.FinYear,4) + REPLACE(STR(sj.Period, 2), ' ', '0'),
		'04' + case f.AssetMoveableID when 'IMM' then 'I' else 'M' end + right('00000000000' + (REPLACE(STR(sj.IMQSBatchID,10), ' ', '') + '-' + REPLACE(STR(sj.RollupID,10), ' ', '')), 11),
		dbo.convertDateToInt(EffectiveDate),
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
		'AK' as [GL-TYPE],
		'04' + case f.AssetMoveableID when 'IMM' then 'I' else 'M' end + right('00000000000' + (REPLACE(STR(sj.IMQSBatchID,10), ' ', '') + '-' + REPLACE(STR(sj.RollupID,10), ' ', '')), 11) as [REFERENCE-NO],
		aff.Form_Desc as [DESCRIPTION],
		dbo.convertDateToInt(EffectiveDate) as [DATE],
		sj.SCOA_Function as [SCOA-FUNCTION],
		sj.SCOA_Fund as [SCOA-FUND],
		sj.SCOA_Item_Credit as [SCOA-ITEM],
		sj.SCOA_Project as [SCOA-PROJECT],
		sj.SCOA_Costing as [SCOA-COST],
		sj.SCOA_Region as [SCOA-REGION],
		sj.SCOA_Mun_Classification as [DEPT-COST],
		sj.BudgetID as [SUB-ITEM],
		'' as [VOTE],
		0 as [DEBIT_AMOUNT],
		SUM(sj.Amount) as [CREDIT_AMOUNT],
		'' as [FLEET_READING],
		'' as [QTY]
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
		aff.Form_Desc,
		STR(sj.FinYear,4) + REPLACE(STR(sj.Period, 2), ' ', '0'),
		'04' + case f.AssetMoveableID when 'IMM' then 'I' else 'M' end + right('00000000000' + (REPLACE(STR(sj.IMQSBatchID,10), ' ', '') + '-' + REPLACE(STR(sj.RollupID,10), ' ', '')), 11),
		dbo.convertDateToInt(EffectiveDate),
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