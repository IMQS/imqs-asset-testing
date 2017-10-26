CREATE PROCEDURE [dbo].[P_F_G_GET_SCOA_ITEM] (@chvFinYear INT, @chv1 VARCHAR = NULL, @chv2 VARCHAR = NULL)
AS
BEGIN
	SET NOCOUNT ON
	set @chv1 = '1'
	set @chv2 = '2'
	DECLARE @items TABLE (SEGMENT_ISN BIGINT, FINANCIAL_YEAR INT, SCOA_ITEM_TYPE VARCHAR(40), SCOA_ITEM_CODE VARCHAR(40), SCOA_ITEM_GUID VARCHAR(40), SCOA_SEGMENT_DESCRIPTION VARCHAR(40), SCOA_LEVEL_DESCRIPTION VARCHAR(40), SCOA_POSTING_LEVEL VARCHAR(40), ENTITY_SUB_ITEM_CODE VARCHAR(40), ENTITY_SUB_ITEM VARCHAR(40))

	INSERT INTO @items VALUES (443103,1718,'E','IE003003026000000000000000000000000000','2032e879-efa1-470a-8d86-cce9f493c275','EXPENDITURE:CONTRACTED SERVICES','MAINTENANCE OF EQUIPMENT','P','2283611','CONTR: MAINTENANCE OF EQUIPMENT')
	INSERT INTO @items VALUES (440938,1718,'A','IA002015002005001002000000000000000000','5d2f077e-73af-4494-952a-fd99bf04dca2','ASSETS:NON-CURRENT ASSETS','ACQUISITIONS','P','6538020','PPE RO: INF WASTE WTR - ACQUISTIONS')
	INSERT INTO @items VALUES (440938,1718,'A','IA002015002005001002000000000000000000','5d2f077e-73af-4494-952a-fd99bf04dca2','ASSETS:NON-CURRENT ASSETS','ACQUISITIONS','P','6538022','PPE RO: INF WASTE WTR - ACQUISTIONS')
	INSERT INTO @items VALUES (441316,1718,'A','IA002015002015001002000000000000000000','cc35aa71-8446-4fb2-905d-32933d49c0f2','ASSETS:NON-CURRENT ASSETS','ACQUISITIONS','P','6562420','ROADS INFRA - REVAL: ACQUISITION')
	INSERT INTO @items VALUES (441341,1718,'A','IA002015002016001002000000000000000000','963f82df-d423-4174-9b9d-3bf1784d8159','ASSETS:NON-CURRENT ASSETS','ACQUISITIONS','P','6563020','STORM WA INFRA - REVAL: ACQUISITION')
	INSERT INTO @items VALUES (443104,1718,'E','IE003003027000000000000000000000000000','8af603f4-1efc-471f-8efb-a4081255c8ee','EXPENDITURE:CONTRACTED SERVICES','MAINTENANCE OF UNSPECIFIED ASSETS','P','2283620','CONTR: MAINTENANCE OF UNSPECIFIED ASSETS')
	INSERT INTO @items VALUES (440838,1718,'A','IA002015002004006001002000000000000000','b084a59a-532f-4014-8aab-9d5ffe71c955','ASSETS:NON-CURRENT ASSETS','ACQUISITIONS','P','6536020','WA RVAL - RESERVOIRS: ACQUISITION')
	INSERT INTO @items VALUES (441316,1718,'A','IA002015002015001002000000000000000000','cc35aa71-8446-4fb2-905d-32933d49c0f2','ASSETS:NON-CURRENT ASSETS','ACQUISITIONS','P','6562421','ROADS INFRA - REVAL: ACQUISITION')


	SELECT SEGMENT_ISN, FINANCIAL_YEAR, SCOA_ITEM_TYPE, SCOA_ITEM_CODE, SCOA_ITEM_GUID, SCOA_SEGMENT_DESCRIPTION, SCOA_LEVEL_DESCRIPTION, SCOA_POSTING_LEVEL, ENTITY_SUB_ITEM_CODE, ENTITY_SUB_ITEM from @items
	SET NOCOUNT OFF
END;