CREATE PROCEDURE [dbo].[ExportVenusSCOAJournalRollUp]
		@finYear INT, @batchSize INT, @depreciation BIT, @numberInputForms BIGINT OUTPUT, @imqsBatchId INT OUTPUT
AS
BEGIN

	SET NOCOUNT ON;

	execute CreateSCOABatch @finYear, @batchSize, @depreciation, NULL, NULL, 'PUSH', @numberInputForms OUTPUT, @imqsBatchId OUTPUT;

	-- For the final coup d'etat, we select the new UNIQUE_IDENTIFIER values from the @postingBindings table,
	-- so as to post these values back to the Financial System when we send off our rollups. For venus there is
	-- no field that can be used to store this value yet, but we are leaving it here for when the opportunity arises
	DECLARE @sql VARCHAR(MAX) = 'SELECT
		''AK'' as [GL-TYPE],
		''04'' + case f.AssetMoveableID when ''IMM'' then ''I'' else ''M'' end + right(''00000000000'' + (REPLACE(STR(sj.IMQSBatchID,10), '' '', '''') + ''-'' + REPLACE(STR(sj.RollupID,10), '' '', '''')), 11) as [REFERENCE-NO],
		'+case @depreciation when 1 then '''Depreciation''' else 'aff.Form_Desc' end +' as JOURNAL_DESCRIPTION_1,
		dbo.convertDateToInt(EffectiveDate) as [DATE],
		sj.SCOA_Function as [SCOA-FUNCTION],
		sj.SCOA_Fund as [SCOA-FUND],
		sj.SCOA_Item_Debit as [SCOA-ITEM],
		sj.SCOA_Project as [SCOA-PROJECT],
		sj.SCOA_Costing as [SCOA-COST],
		sj.SCOA_Region as [SCOA-REGION],
		sj.SCOA_Mun_Classification as [DEPT-COST],
		sj.BREAKDOWN_SCOA_Item_Debit as [SUB-ITEM],
		sj.BudgetID as [VOTE],
		SUM(sj.Amount) as [DEBIT_AMOUNT],
		0 as [CREDIT_AMOUNT],
		dbo.isCreditLeg('+case @depreciation when 1 then '9' else 'aff.Form_Nr' end+') as REPLACE_WITH_DEFAULT,
		'''' as [FLEET_READING],
		'''' as [QTY]
	FROM
		SCOAJournal sj '+case @depreciation when 1 then 
	'INNER JOIN
		AssetRegisterIconFin'+STR(@finYear,4)+' f ON sj.ComponentID = f.ComponentID' else 
	'INNER JOIN
		AssetFinFormInput f ON sj.Form_Reference = f.Form_Reference
	INNER JOIN
		AssetFinFormRef affr ON sj.Form_Reference = affr.Form_Reference
	INNER JOIN
		AssetFinForm aff ON affr.Form_Nr = aff.Form_Nr' end +'
	WHERE
		sj.IMQSBatchID = '+CONVERT(VARCHAR, @imqsBatchId)+'
	GROUP BY
		'+ case @depreciation when 1 then '' else 'aff.Form_Desc, aff.Form_Nr,' end+'
		STR(sj.FinYear,4) + REPLACE(STR(sj.Period, 2), '' '', ''0''),
		''04''+ case f.AssetMoveableID when ''IMM'' then ''I'' else ''M'' end + right(''00000000000'' + (REPLACE(STR(sj.IMQSBatchID,10), '' '', '''') + ''-'' + REPLACE(STR(sj.RollupID,10), '' '', '''')), 11),
		dbo.convertDateToInt(EffectiveDate),
		sj.FinancialField,
		sj.FinYear,
		sj.BREAKDOWN_SCOA_Item_Debit,
		sj.BudgetID,
		sj.SCOA_Fund,
		sj.SCOA_Function,
		sj.SCOA_Mun_Classification,
		sj.SCOA_Project,
		sj.SCOA_Costing,
		sj.SCOA_Region,
		sj.SCOA_Item_Debit

	UNION

	SELECT
		''AK'' as [GL-TYPE],
		''04'' + case f.AssetMoveableID when ''IMM'' then ''I'' else ''M'' end + right(''00000000000'' + (REPLACE(STR(sj.IMQSBatchID,10), '' '', '''') + ''-'' + REPLACE(STR(sj.RollupID,10), '' '', '''')), 11) as [REFERENCE-NO],
		'+ case @depreciation when 1 then '''Depreciation''' else 'aff.Form_Desc' end +' as JOURNAL_DESCRIPTION_1,
		dbo.convertDateToInt(EffectiveDate) as [DATE],
		sj.SCOA_Function_Credit as [SCOA-FUNCTION],
		sj.SCOA_Fund_Credit as [SCOA-FUND],
		sj.SCOA_Item_Credit as [SCOA-ITEM],
		sj.SCOA_Project_Credit as [SCOA-PROJECT],
		sj.SCOA_Costing_Credit as [SCOA-COST],
		sj.SCOA_Region_Credit as [SCOA-REGION],
		sj.SCOA_Mun_Classification_Credit as [DEPT-COST],
		sj.BREAKDOWN_SCOA_Item_Credit as [SUB-ITEM],
		sj.BudgetID as [VOTE],
		0 as [DEBIT_AMOUNT],
		SUM(sj.Amount) as [CREDIT_AMOUNT],
		dbo.isDebitLeg('+case @depreciation when 1 then '9' else 'aff.Form_Nr' end +') as REPLACE_WITH_DEFAULT,
		'''' as [FLEET_READING],
		'''' as [QTY]
	FROM
		SCOAJournal sj '+ case @depreciation when 1 then 
	'INNER JOIN
		AssetRegisterIconFin'+STR(@finYear,4)+' f ON sj.ComponentID = f.ComponentID' else 
	'INNER JOIN
		AssetFinFormInput f ON sj.Form_Reference = f.Form_Reference
	INNER JOIN
		AssetFinFormRef affr ON sj.Form_Reference = affr.Form_Reference
	INNER JOIN
		AssetFinForm aff ON affr.Form_Nr = aff.Form_Nr' end +'
	WHERE
		sj.IMQSBatchID = '+CONVERT(VARCHAR, @imqsBatchId)+'
	GROUP BY
		'+case @depreciation when 1 then '' else 'aff.Form_Desc, aff.Form_Nr,' end+'
		STR(sj.FinYear,4) + REPLACE(STR(sj.Period, 2), '' '', ''0''),
		''04'' + case f.AssetMoveableID when ''IMM'' then ''I'' else ''M'' end + right(''00000000000'' + (REPLACE(STR(sj.IMQSBatchID,10), '' '', '''') + ''-'' + REPLACE(STR(sj.RollupID,10), '' '', '''')), 11),
		dbo.convertDateToInt(EffectiveDate),
		sj.FinancialField,
		sj.FinYear,
		sj.BREAKDOWN_SCOA_Item_Credit,
		sj.BudgetID,
		sj.SCOA_Fund_Credit,
		sj.SCOA_Function_Credit,
		sj.SCOA_Mun_Classification_Credit,
		sj.SCOA_Project_Credit,
		sj.SCOA_Costing_Credit,
		sj.SCOA_Region_Credit,
		sj.SCOA_Item_Credit';

	EXEC(@sql);
END