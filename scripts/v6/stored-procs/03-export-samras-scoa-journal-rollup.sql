CREATE PROCEDURE [dbo].[ExportSamrasSCOAJournalRollUp]
	@batchSize INT, @depreciation BIT, @numberInputForms BIGINT OUTPUT, @imqsBatchId INT OUTPUT
AS
BEGIN

	EXECUTE CreateSCOABatch @batchSize, @depreciation, NULL, NULL, 'NONE', @numberInputForms OUTPUT, @imqsBatchId OUTPUT;

	SELECT
		sj.FinYear as N_FIN_YEAR,
		(select Value from AssetPolicyGeneral where Section = 'SCOA' and Identifier = 'Version') as C_NT_Mscoa_version,
		(select Value from AssetPolicyGeneral where Section = 'SCOA' and Identifier = 'MunicipalDemarcationCode') as [C_Municipal demarcation code],
		f.WIP_Project_ID as C_PROJECT_CODE,
		'ASSET' as C_ACC,
		'OPERATIONAL' as C_TRANSACTION,
		dbo.convertDateToInt(sj.[Date]) as D_DUE,
		dbo.convertDateToInt(sj.[EffectiveDate]) D_EFFECTIVE,
		dbo.convertDateToInt(sj.[EffectiveDate]) as D_TRANSACTION,
		SUM(sj.Amount) as A_TOTAL,
		SUM(sj.Amount) as A_BUDGET_1,
		0 as A_BUDGET_2,
		0 as A_BUDGET_3,
		0 as A_BUDGET_4,
		0 as A_BUDGET_5,
		0 as A_BUDGET_6,
		0 as A_BUDGET_7,
		0 as A_BUDGET_8,
		0 as A_BUDGET_9,
		0 as A_BUDGET_10,
		0 as A_BUDGET_11,
		0 as A_BUDGET_12,
		sj.SCOA_Project as T_PROJECT_GUID,
		sj.SCOA_Function as T_FUNCTION_GUID,
		sj.SCOA_Item_Debit as T_ITEM_GUID,
		sj.SCOA_Fund as T_FUND_GUID,
		sj.SCOA_Region as T_REGION_GUID,
		sj.SCOA_Costing as T_COSTING_GUID,
		sj.SCOA_Mun_Classification as T_OWN,
		b.CREATED_BY as C_USER_ID,
		'' as C_AUTH_USER_ID,
		'' as T_UDPV_CASHFLOW_TYPE,
		NULL as S_SOURCE_TIMESTAMP,
		f.AccountingGroupID + '-' + f.AssetCategoryID + '-' + f.AssetSubCategoryID as C_ASSET,
		'' as C_POST,
		'' as C_TRANSACTION_REFERENCE,
		'' as C_TRANSACTION_LINKED_REFERENCE
	FROM
		SCOAJournal sj
	INNER JOIN
		AssetFinFormInput f ON sj.Form_Reference = f.Form_Reference
	INNER JOIN
		AssetFinFormBatch b on SUBSTRING(f.Batch_Reference, 2, LEN(f.Batch_Reference)) = REPLACE(STR(b.BatchNr, 9),' ', '0')
	WHERE
		sj.IMQSBatchID = @imqsBatchId
	GROUP BY
		sj.FinancialField,
		sj.FinYear,
		dbo.convertDateToInt(sj.[Date]),
		dbo.convertDateToInt(sj.[EffectiveDate]),
		f.WIP_Project_ID,
		sj.SCOA_Fund,
		sj.SCOA_Function,
		sj.SCOA_Mun_Classification,
		sj.SCOA_Project,
		sj.SCOA_Costing,
		sj.SCOA_Region,
		sj.SCOA_Item_Debit,
		b.CREATED_BY,
		f.AccountingGroupID + '-' + f.AssetCategoryID + '-' + f.AssetSubCategoryID

	UNION

	SELECT
		sj.FinYear as N_FIN_YEAR,
		(select Value from AssetPolicyGeneral where Section = 'SCOA' and Identifier = 'Version') as C_NT_Mscoa_version,
		(select Value from AssetPolicyGeneral where Section = 'SCOA' and Identifier = 'MunicipalDemarcationCode') as [C_Municipal demarcation code],
		f.WIP_Project_ID as C_PROJECT_CODE,
		'ASSET' as C_ACC,
		'OPERATIONAL' as C_TRANSACTION,
		dbo.convertDateToInt(sj.[Date]) as D_DUE,
		dbo.convertDateToInt(sj.[EffectiveDate]) D_EFFECTIVE,
		dbo.convertDateToInt(sj.[EffectiveDate]) as D_TRANSACTION,
		SUM(sj.Amount) as A_TOTAL,
		SUM(sj.Amount) as A_BUDGET_1,
		0 as A_BUDGET_2,
		0 as A_BUDGET_3,
		0 as A_BUDGET_4,
		0 as A_BUDGET_5,
		0 as A_BUDGET_6,
		0 as A_BUDGET_7,
		0 as A_BUDGET_8,
		0 as A_BUDGET_9,
		0 as A_BUDGET_10,
		0 as A_BUDGET_11,
		0 as A_BUDGET_12,
		sj.SCOA_Project as T_PROJECT_GUID,
		sj.SCOA_Function as T_FUNCTION_GUID,
		sj.SCOA_Item_Credit as T_ITEM_GUID,
		sj.SCOA_Fund as T_FUND_GUID,
		sj.SCOA_Region as T_REGION_GUID,
		sj.SCOA_Costing as T_COSTING_GUID,
		sj.SCOA_Mun_Classification as T_OWN,
		b.CREATED_BY as C_USER_ID,
		'' as C_AUTH_USER_ID,
		'' as T_UDPV_CASHFLOW_TYPE,
		NULL as S_SOURCE_TIMESTAMP,
		f.AccountingGroupID + '-' + f.AssetCategoryID + '-' + f.AssetSubCategoryID as C_ASSET,
		'' as C_POST,
		'' as C_TRANSACTION_REFERENCE,
		'' as C_TRANSACTION_LINKED_REFERENCE
	FROM
		SCOAJournal sj
	INNER JOIN
		AssetFinFormInput f ON sj.Form_Reference = f.Form_Reference
	INNER JOIN
		AssetFinFormBatch b on SUBSTRING(f.Batch_Reference, 2, LEN(f.Batch_Reference)) = REPLACE(STR(b.BatchNr, 9), ' ', '0')
	WHERE
		sj.IMQSBatchID = @imqsBatchId
	GROUP BY
		sj.FinancialField,
		sj.FinYear,
		dbo.convertDateToInt(sj.[Date]),
		dbo.convertDateToInt(sj.[EffectiveDate]),
		f.WIP_Project_ID,
		sj.SCOA_Fund,
		sj.SCOA_Function,
		sj.SCOA_Mun_Classification,
		sj.SCOA_Project,
		sj.SCOA_Costing,
		sj.SCOA_Region,
		sj.SCOA_Item_Credit,
		b.CREATED_BY,
		f.AccountingGroupID + '-' + f.AssetCategoryID + '-' + f.AssetSubCategoryID

	EXECUTE ExportSamrasSCOAMasterDataForBatch @imqsBatchId;

END;