CREATE PROCEDURE [dbo].[ExportBcxSCOAJournalRollUp]
	@finPeriod VARCHAR(6), @batchSize INT, @depreciation BIT, @numberInputForms BIGINT OUTPUT, @imqsBatchId INT OUTPUT
AS
BEGIN

	SET NOCOUNT ON;

	EXECUTE CreateSCOABatch @finPeriod, @batchSize, @depreciation, NULL, NULL, 'PUSH', @numberInputForms OUTPUT, @imqsBatchId OUTPUT;

	DECLARE @solarFinPeriod VARCHAR(6) = [dbo].[getSolarFinancialPeriod](@finPeriod);
	DECLARE @finYear VARCHAR(4)= SUBSTRING(@finPeriod, 1, 4);

	-- We create the correlation reference as per the Solar-defined syntax format, and assign it to each line item in the SCOAJournal
	DECLARE @assetTable VARCHAR(50) = CASE @depreciation WHEN 1 THEN 'AssetRegisterIconFin'+@finYear ELSE 'AssetFinFormInput' END;
	DECLARE @updateSql VARCHAR(MAX) = 'UPDATE
				SCOAJournal
			SET
				CorrelationRef = ''04'' + case f.AssetMoveableID when ''IMM'' then ''I'' else ''M'' end + right(''00000000000'' + (REPLACE(STR(sj.IMQSBatchID,10), '' '', '''') + ''-'' + REPLACE(STR(sj.RollupID,10), '' '', '''')), 11)
			FROM
				SCOAJournal sj
			INNER JOIN
				'+@assetTable+' f ON sj.ComponentID = f.ComponentID
			WHERE
				sj.IMQSBatchId = '+STR(@imqsBatchId);
	EXEC(@updateSql);

	-- For the final coup d'etat, we select the new UNIQUE_IDENTIFIER values from the @postingBindings table,
	-- so as to post these values back to the Financial System when we send off our rollups.
	DECLARE @sql VARCHAR(MAX) = 'SELECT
				sj.PostingDebitID as UNIQUE_IDENTIFIER,
				'+@solarFinPeriod+' as FINANCIAL_PERIOD,
				dbo.getLedgerTransactionType(sj.FinancialField) as LEDGER_TRANSACTION_TYPE,
				''04'' as VENDOR_CODE,
				sj.CorrelationRef as JOURNAL_REFERENCE,
				'+ case @depreciation when 1 then '''Depreciation''' else 'aff.Form_Desc' end +' as JOURNAL_DESCRIPTION_1,
				sj.FinancialField as JOURNAL_DESCRIPTION_2,
				'''' as JOURNAL_DESCRIPTION_3,
				dbo.convertDateToInt(sj.EffectiveDate) as TRANSACTION_DATE,
				sj.SCOA_Function as SCOA_FUNCTION_GUID,
				sj.SCOA_Fund as SCOA_FUND_GUID,
				(CASE WHEN scItem.IsBreakdown = 1 THEN scItem.ParentSCOAId ELSE scItem.SCOAId END) as SCOA_ITEM_GUID,
				(CASE WHEN scProject.IsBreakdown = 1 THEN scProject.ParentSCOAId ELSE scProject.SCOAId END) as SCOA_PROJECT_GUID,
				sj.SCOA_Costing as SCOA_COST_GUID,
				sj.SCOA_Region as SCOA_REGION_GUID,
				sj.SCOA_Mun_Classification as ENTITY_COST_CENTRE,
				(CASE WHEN scItem.IsBreakdown = 1 THEN scItem.AccountNumber ELSE '''' END) as ENTITY_SUB_ITEM,
				(CASE WHEN scProject.IsBreakdown = 1 THEN scProject.AccountNumber ELSE '''' END) as ENTITY_PROJECT,
				SUM(sj.Amount) as DEBIT_AMOUNT,
				0 as CREDIT_AMOUNT,
				dbo.isCreditLeg('+case @depreciation when 1 then '9' else 'aff.Form_Nr' end +') as REPLACE_WITH_DEFAULT
			FROM
				SCOAJournal sj '+case @depreciation when 1 then
			'INNER JOIN
				AssetRegisterIconFin'+@finYear+' f ON sj.ComponentID = f.ComponentID' else
			'INNER JOIN
				AssetFinFormInput f ON sj.Form_Reference = f.Form_Reference
			INNER JOIN
				AssetFinFormRef affr ON sj.Form_Reference = affr.Form_Reference
			INNER JOIN
				AssetFinForm aff ON affr.Form_Nr = aff.Form_Nr' end +'
			LEFT JOIN 
				SCOAClassification scItem ON sj.BREAKDOWN_SCOA_Item_Debit = scItem.SCOAId
			LEFT JOIN 
				SCOAClassification scProject ON sj.BREAKDOWN_SCOA_Project = scProject.SCOAId
			WHERE
				sj.IMQSBatchID = '+CONVERT(VARCHAR, @imqsBatchId)+'
			GROUP BY
				sj.PostingDebitID,
				sj.PostingCreditID,
				'+case @depreciation when 1 then '' else 'aff.Form_Desc, aff.Form_Nr,' end +'
				STR(sj.FinYear,4) + REPLACE(STR(sj.Period, 2), '' '', ''0''),
				(REPLACE(STR(sj.IMQSBatchID,10), '' '', '''') + ''-'' + REPLACE(STR(sj.RollupID,10), '' '', '''')),
				sj.CorrelationRef,
				dbo.convertDateToInt(sj.EffectiveDate),
				sj.FinancialField,
				sj.SCOA_Fund,
				sj.SCOA_Function,
				sj.SCOA_Mun_Classification,
				sj.SCOA_Costing,
				sj.SCOA_Region,
				scItem.ParentSCOAId,
				scProject.ParentSCOAId,
				scItem.SCOAId,
				scProject.SCOAId,
				scItem.AccountNumber,
				scProject.AccountNumber,
				scItem.IsBreakdown,
				scProject.IsBreakdown

			UNION

			SELECT
				sj.PostingCreditID as UNIQUE_IDENTIFIER,
				'+@solarFinPeriod+' as FINANCIAL_PERIOD,
				dbo.getLedgerTransactionType(sj.FinancialField) as LEDGER_TRANSACTION_TYPE,
				''04'' as VENDOR_CODE,
				sj.CorrelationRef as JOURNAL_REFERENCE,
				'+ case @depreciation when 1 then '''Depreciation''' else 'aff.Form_Desc' end +' as JOURNAL_DESCRIPTION_1,
				sj.FinancialField as JOURNAL_DESCRIPTION_2,
				'''' as JOURNAL_DESCRIPTION_3,
				dbo.convertDateToInt(sj.EffectiveDate) as TRANSACTION_DATE,
				sj.SCOA_Function_Credit as SCOA_FUNCTION_GUID,
				sj.SCOA_Fund_Credit as SCOA_FUND_GUID,
				(CASE WHEN scItem.IsBreakdown = 1 THEN scItem.ParentSCOAId ELSE scItem.SCOAId END) as SCOA_ITEM_GUID,
				(CASE WHEN scProject.IsBreakdown = 1 THEN scProject.ParentSCOAId ELSE scProject.SCOAId END) as SCOA_PROJECT_GUID,
				sj.SCOA_Costing_Credit as SCOA_COST_GUID,
				sj.SCOA_Region_Credit as SCOA_REGION_GUID,
				sj.SCOA_Mun_Classification_Credit as ENTITY_COST_CENTRE,
				(CASE WHEN scItem.IsBreakdown = 1 THEN scItem.AccountNumber ELSE '''' END) as ENTITY_SUB_ITEM,
				(CASE WHEN scProject.IsBreakdown = 1 THEN scProject.AccountNumber ELSE '''' END) as ENTITY_PROJECT,
				0 as DEBIT_AMOUNT,
				SUM(sj.Amount) as CREDIT_AMOUNT,
				dbo.isDebitLeg('+case @depreciation when 1 then '9' else 'aff.Form_Nr' end +') as REPLACE_WITH_DEFAULT
			FROM
				SCOAJournal sj '+case @depreciation when 1 then
			'INNER JOIN
				AssetRegisterIconFin'+@finYear+' f ON sj.ComponentID = f.ComponentID' else
			'INNER JOIN
				AssetFinFormInput f ON sj.Form_Reference = f.Form_Reference
			INNER JOIN
				AssetFinFormRef affr ON sj.Form_Reference = affr.Form_Reference
			INNER JOIN
				AssetFinForm aff ON affr.Form_Nr = aff.Form_Nr' end +'
			LEFT JOIN 
				SCOAClassification scItem ON sj.BREAKDOWN_SCOA_Item_Credit = scItem.SCOAId
			LEFT JOIN 
				SCOAClassification scProject ON sj.BREAKDOWN_SCOA_Project_Credit = scProject.SCOAId
			WHERE
				sj.IMQSBatchID = '+CONVERT(VARCHAR, @imqsBatchId)+'
			GROUP BY
				sj.PostingDebitID,
				sj.PostingCreditID,
				'+case @depreciation when 1 then '' else 'aff.Form_Desc, aff.Form_Nr, ' end +'
				STR(sj.FinYear,4) + REPLACE(STR(sj.Period, 2), '' '', ''0''),
				(REPLACE(STR(sj.IMQSBatchID,10), '' '', '''') + ''-'' + REPLACE(STR(sj.RollupID,10), '' '', '''')),
				sj.CorrelationRef,
				dbo.convertDateToInt(sj.EffectiveDate),
				sj.FinancialField,
				sj.FinYear,
				sj.SCOA_Fund_Credit,
				sj.SCOA_Function_Credit,
				sj.SCOA_Mun_Classification_Credit,
				sj.SCOA_Costing_Credit,
				sj.SCOA_Region_Credit,
				scItem.ParentSCOAId,
				scProject.ParentSCOAId,
				scItem.SCOAId,
				scProject.SCOAId,
				scItem.AccountNumber,
				scProject.AccountNumber,
				scItem.IsBreakdown,
				scProject.IsBreakdown';
	EXEC(@sql);
END