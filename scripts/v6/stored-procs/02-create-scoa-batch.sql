-- ====================================================================================================================
-- === NB: Please keep the documentation for the CreateSCOABatch & related Export* Stored Procedures up to date at: ===
-- ===     https://imqssoftware.atlassian.net/wiki/spaces/AMT/pages/168689760/SCOA+Journal+Rollups                  ===
-- ====================================================================================================================

CREATE PROCEDURE [dbo].[CreateSCOABatch]
	@finPeriod VARCHAR(6), @batchSize BIGINT, @depreciation BIT, @fromDate DATE, @toDate DATE, @workflowType VARCHAR(4), @numberInputForms BIGINT OUTPUT, @imqsBatchId INT OUTPUT
AS
BEGIN

	-- ===================================
	-- === STEP 1: Metadata Collection ===
	-- ===================================

	DECLARE @year VARCHAR(4) = SUBSTRING(@finPeriod, 1, 4);
	DECLARE @period VARCHAR(2) = SUBSTRING(@finPeriod, 5, 2);

	-- Determine a new imqs batch id for this batch
	EXECUTE NextValueFor 'imqsBatchId', @imqsBatchId OUTPUT;

	-- Determine the new current postingID. PostingIDs are created to specify uniquness across both debit & credit journal posting rows, that we post to the financial system.
	-- We save these values (PostingCreditID & PostingDebitID) in all SCOAJournal rows that make up a rolled up posting row
	DECLARE @postingSeed BIGINT = (select counter_current_id from AssetRefCounter where counter_name = 'scoaPostingId');

	-- ===============================
	-- === STEP 2: Journal Rollups ===
	-- ===============================

	-- We create a virtual table to allocate scoa-journal rows into batches and rollups:
	--   > A batch (IMQSBatchID) represents all scoa-journal rows selected for this batch
	--   > A rollup (RollupID) represents all scoa-journal rows that make up a posting-journal pair (i.e. the DR & CR legs of a single post)
	DECLARE @rollups TABLE (RollupID BIGINT, IMQSBatchID INT, ID BIGINT);

	-- The workflowType indicates what type of a financial system we're integrating with, and thus the Form_Level (i.e. form status)
	-- at which we must create SCOA rollups. We use this determined form level value to select the appropriate SCOAJournal entries to process
	DECLARE @formLevelValue INT;
	IF @workflowType = 'NONE' SET @formLevelValue = 3
	ELSE IF @depreciation = 1 SET @formLevelValue = 4
	ELSE IF @workflowType = 'PULL' SET @formLevelValue = 3
	ELSE SET @formLevelValue = 4;

	-- From the batch rows in the SCOAJournal, we create a @rollups virtual table, and allocate each
	-- batch row with a rollup id (using the rank() windowed function), grouped across each separate rollup value
	DECLARE @assetRegisterTable VARCHAR(50) = CASE @depreciation WHEN 1 THEN 'AssetRegisterIconFin'+@year ELSE 'AssetFinFormInput' END;
	DECLARE @hasDates BIT = case when @fromDate IS NULL then 0 else (case when @toDate IS NULL then 0 else 1 end) end
	DECLARE @dynamicSql VARCHAR(MAX) =
		'select '+case when @batchSize IS NULL then '' else 'top('+CONVERT(VARCHAR, @batchSize)+')' end +'
			rank() over (order by sj.FinancialField, sj.SCOA_Fund, sj.SCOA_Function, sj.SCOA_Mun_Classification, sj.SCOA_Project, sj.SCOA_Costing, sj.SCOA_Region, sj.SCOA_Item_Debit, sj.BREAKDOWN_SCOA_Project, sj.BREAKDOWN_SCOA_Item_Debit, sj.SCOA_Fund_Credit, sj.SCOA_Function_Credit, sj.SCOA_Mun_Classification_Credit, sj.SCOA_Project_Credit, sj.SCOA_Costing_Credit, sj.SCOA_Region_Credit, sj.SCOA_Item_Credit, sj.BREAKDOWN_SCOA_Project_Credit, sj.BREAKDOWN_SCOA_Item_Credit, far.AssetMoveableID) as RollupID,
			'+CONVERT(VARCHAR, @imqsBatchId)+' as IMQSBatchID,
			sj.ID
		from
			SCOAJournal sj  inner join '+@assetRegisterTable+' far on sj.ComponentID = far.ComponentID '+case @depreciation when 1 then 'inner join SCOADepreciationStatus sds on sj.ID = sds.SCOAJournalID ' else 'inner join AssetFinFormRef affr on sj.Form_Reference = affr.Form_Reference ' end +'
		where
			sj.FinYear = '+@year+' AND sj.Period = '+@period+' AND '+case @depreciation when 1 then 'sj.FinancialField = ''DepreciationFinYTD'' AND sds.Status = '+CONVERT(VARCHAR, @formLevelValue)+ '' else 'affr.Form_Level = '+CONVERT(VARCHAR, @formLevelValue)+' AND sj.FinancialField != ''DepreciationFinYTD''' end +' AND sj.IMQSBatchID is null '+case @hasDates when 1 then 'AND Date >= '''+LEFT(CONVERT(VARCHAR, @fromDate, 120), 10)+''' AND Date <= '''+LEFT(CONVERT(VARCHAR, @toDate, 120), 10)+'''' else '' end;
	INSERT INTO @rollups EXEC(@dynamicSql)

	-- We write the new IMQSBatch- and Rollup- IDs into the SCOAJournal
	UPDATE
		sj
	SET
		sj.RollupID = [@rollups].RollupID,
		sj.IMQSBatchID = [@rollups].IMQSBatchID
	FROM
		@rollups
	INNER JOIN
		SCOAJournal sj ON sj.ID = [@rollups].ID;

	SET @numberInputForms = @@ROWCOUNT;

	-- =============================
	-- === STEP 3: Posting Nodes ===
	-- =============================

	-- We create another virtual table for determining actual posting-journal rows
	DECLARE @postings TABLE (
		FINANCIAL_PERIOD VARCHAR(6),
		FINANCIAL_FIELD VARCHAR(40), 
		CREDIT_AMOUNT NUMERIC(25,2),
		batchRollup VARCHAR(20)
	);

	-- We populate the virtual table with the rolled-up rows that will be sent to the Financial System.
	-- These are not yet given a uniqueness value (i.e. UNIQUE_IDENTIFIER = NULL).
	INSERT INTO @postings
		SELECT
			STR(sj.FinYear,4) + REPLACE(STR(sj.Period, 2), ' ', '0'),
			sj.FinancialField, 
			0 as CREDIT_AMOUNT,
			(REPLACE(STR(sj.IMQSBatchID,10), ' ', '') + '-' + REPLACE(STR(sj.RollupID,10), ' ', ''))
		FROM
			SCOAJournal sj
		WHERE
			sj.IMQSBatchID = @imqsBatchId
		GROUP BY
			STR(sj.FinYear,4) + REPLACE(STR(sj.Period, 2), ' ', '0'),
			(REPLACE(STR(sj.IMQSBatchID,10), ' ', '') + '-' + REPLACE(STR(sj.RollupID,10), ' ', '')),
			sj.EffectiveDate,
			sj.FinancialField,
			sj.FinYear,
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
			STR(sj.FinYear,4) + REPLACE(STR(sj.Period, 2), ' ', '0'),
			sj.FinancialField, 
			SUM(sj.Amount) as CREDIT_AMOUNT,
			(REPLACE(STR(sj.IMQSBatchID,10), ' ', '') + '-' + REPLACE(STR(sj.RollupID,10), ' ', ''))
		FROM
			SCOAJournal sj
		WHERE
			sj.IMQSBatchID = @imqsBatchId
		GROUP BY
			STR(sj.FinYear,4) + REPLACE(STR(sj.Period, 2), ' ', '0'),
			(REPLACE(STR(sj.IMQSBatchID,10), ' ', '') + '-' + REPLACE(STR(sj.RollupID,10), ' ', '')),
			sj.EffectiveDate,
			sj.FinancialField,
			sj.FinYear,
			sj.BudgetID,
			sj.SCOA_Fund,
			sj.SCOA_Function,
			sj.SCOA_Mun_Classification,
			sj.SCOA_Project,
			sj.SCOA_Costing,
			sj.SCOA_Region,
			sj.SCOA_Item_Credit;

	-- We create a virtual table called @postingBindings, to create unique IDs over each of the posting rows.
	-- By adding the @postingSeed (last used id) to the row_number() windowing function, we achieve a new unique sequence.
	DECLARE @postingBindings TABLE (UNIQUE_IDENTIFIER BIGINT, batchRollup VARCHAR(20), CRDR VARCHAR(2));
	INSERT INTO @postingBindings
		SELECT
			row_number() over (order by FINANCIAL_PERIOD, FINANCIAL_FIELD) + @postingSeed,
			batchRollup,
			case CREDIT_AMOUNT when 0 then 'DR' else 'CR' end as CRDR
		FROM
			@postings;
	SET @postingSeed = (select MAX(UNIQUE_IDENTIFIER) from @postingBindings);
	EXECUTE SetValueFor 'scoaPostingId', @postingSeed;

	-- Now that we have established unique ids across all posting rows, we need to persist them to our SCOAJournal.
	-- We do so with 2 updates, one each for CR and DR
	UPDATE
		SCOAJournal
	SET
		PostingCreditID = pb.UNIQUE_IDENTIFIER
	FROM
		@postingBindings pb
	WHERE
		SCOAJournal.IMQSBatchID = cast(substring(pb.batchRollup, 0, CHARINDEX('-', pb.batchRollup) ) as BIGINT) AND
		SCOAJournal.RollupID = cast(substring(pb.batchRollup, CHARINDEX('-', pb.batchRollup)+1, LEN(pb.batchRollup)) as BIGINT) AND
		pb.CRDR = 'CR';

	UPDATE
		SCOAJournal
	SET
		PostingDebitID = pb.UNIQUE_IDENTIFIER
	FROM
		@postingBindings pb
	WHERE
		SCOAJournal.IMQSBatchID = cast(substring(pb.batchRollup, 0, CHARINDEX('-', pb.batchRollup) ) as BIGINT) AND
		SCOAJournal.RollupID = cast(substring(pb.batchRollup, CHARINDEX('-', pb.batchRollup)+1, LEN(pb.batchRollup)) as BIGINT) AND
		pb.CRDR = 'DR';
END
