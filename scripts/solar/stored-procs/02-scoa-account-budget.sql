CREATE PROCEDURE P_F_G_GET_SCOA_ACCOUNT_BUDGET(
	@chvFinYear VARCHAR(4),
	@chvSCOAFunctionGUID Varchar(40) = NULL,
	@chvSCOAFundGUID Varchar(40) = NULL,
	@chvSCOAItemGUID Varchar(40) = NULL,
	@chvSCOAProjectGUID Varchar(40) = NULL,
	@chvSCOACostGUID Varchar(40) = NULL,
	@chvSCOARegionGUID Varchar(40) = NULL)
AS
BEGIN
DECLARE @sqlStr varchar(max)

SET @sqlStr = ' SELECT * FROM Budget WHERE FINANCIAL_YEAR = ''' + @chvFinYear +''''

IF(@chvSCOAFunctionGUID <> NULL OR @chvSCOAFunctionGUID <> '')
SET @sqlStr = CONCAT(@sqlStr, ' AND SCOA_FUNCTION_GUID = '''+ @chvSCOAFunctionGUID   +'''')

IF(@chvSCOAFundGUID <> NULL OR @chvSCOAFundGUID <> '')
SET @sqlStr = CONCAT(@sqlStr, ' AND SCOA_FUND_GUID = '''+ @chvSCOAFundGUID +'''')

IF(@chvSCOAItemGUID <> NULL OR @chvSCOAItemGUID <> '')
SET @sqlStr = CONCAT(@sqlStr, ' AND SCOA_ITEM_GUID = '''+ @chvSCOAItemGUID +'''')

IF(@chvSCOAProjectGUID <> NULL OR @chvSCOAProjectGUID <> '')
SET @sqlStr = CONCAT(@sqlStr, ' AND SCOA_PROJECT_GUID = '''+ @chvSCOAProjectGUID +'''')

IF(@chvSCOACostGUID <> NULL OR @chvSCOACostGUID <> '')
SET @sqlStr = CONCAT(@sqlStr, ' AND SCOA_COST_GUID = '''+ @chvSCOACostGUID +'''')

IF(@chvSCOARegionGUID <> NULL OR @chvSCOARegionGUID <> '')
SET @sqlStr = CONCAT(@sqlStr, ' AND SCOA_REGION_GUID = '''+ @chvSCOARegionGUID +'''')

EXECUTE(@sqlStr)

END;