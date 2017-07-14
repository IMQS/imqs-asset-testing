CREATE PROCEDURE [dbo].[CreateSCOABatch]
	@batchSize BIGINT, @fromDate DATE, @toDate DATE, @committedToRegisterValue INT, @numberInputForms BIGINT OUTPUT, @imqsBatchId INT OUTPUT
AS
BEGIN

	-- Determine a new imqs batch id for this batch
	SET @imqsBatchId = (select case when max(IMQSBatchID) is NULL then 1 else max(IMQSBatchID)+1 end as BatchId from SCOAJournal);

	-- Determine the new current postingID. PostingIDs are created to specify uniquness across both debit & credit journal posting rows, that we post to the financial system.
	-- We save these values (PostingCreditID & PostingDebitID) in all SCOAJournal rows that make up a rolled up posting row
	DECLARE @postingCreditSeed BIGINT = (select case when max(PostingCreditID) is NULL then 0 else max(PostingCreditID) end from SCOAJournal);
	DECLARE @postingDebitSeed BIGINT = (select case when max(PostingDebitID) is NULL then 0 else max(PostingDebitID) end from SCOAJournal);
	DECLARE @postingSeed BIGINT
	IF (@postingCreditSeed > @postingDebitSeed)
		SET @postingSeed = @postingCreditSeed;
	ELSE
		SET @postingSeed = @postingDebitSeed;

	-- We create a virtual table to allocate scoa-journal rows into batches and rollups:
	--   > A batch (IMQSBatchID) represents all scoa-journal rows selected for this batch
	--   > A rollup (RollupID) represents all scoa-journal rows that make up a posting-journal pair (i.e. the DR & CR legs of a single post)
	DECLARE @rollups TABLE (RollupID BIGINT, IMQSBatchID INT, ComponentID varchar(40));

	-- From the batch rows in the SCOAJournal, we create a @rollups virtual table, and allocate each
	-- batch row with a rollup id (using the rank() windowed function), grouped across each separate rollup value
	IF (@batchSize IS NOT NULL AND @fromDate IS NOT NULL AND @toDate IS NOT NULL)
		INSERT INTO @rollups
			select top(@batchSize)
				rank() over (order by sj.SCOA_Fund, sj.SCOA_Function, sj.SCOA_Mun_Classification, sj.SCOA_Project, sj.SCOA_Costing, sj.SCOA_Region, sj.SCOA_Item_Debit, sj.SCOA_Item_Credit) as RollupID,
				@imqsBatchId as IMQSBatchID,
				sj.ComponentID
			from
				SCOAJournal sj inner join AssetFinFormInput f on sj.Form_Reference = f.Form_Reference inner join AssetFinFormRef affr on sj.Form_Reference = affr.Form_Reference inner join AssetFinForm aff on affr.Form_Nr = aff.Form_Nr
			where
				sj.CommittedToRegister = @committedToRegisterValue and sj.IMQSBatchID is null AND Date >= @fromDate AND Date <= @toDate;
	ELSE IF (@fromDate IS NOT NULL AND @toDate IS NOT NULL)
		INSERT INTO @rollups
			select
				rank() over (order by sj.SCOA_Fund, sj.SCOA_Function, sj.SCOA_Mun_Classification, sj.SCOA_Project, sj.SCOA_Costing, sj.SCOA_Region, sj.SCOA_Item_Debit, sj.SCOA_Item_Credit) as RollupID,
				@imqsBatchId as IMQSBatchID,
				sj.ComponentID
			from
				SCOAJournal sj inner join AssetFinFormInput f on sj.Form_Reference = f.Form_Reference inner join AssetFinFormRef affr on sj.Form_Reference = affr.Form_Reference inner join AssetFinForm aff on affr.Form_Nr = aff.Form_Nr
			where
				sj.CommittedToRegister = @committedToRegisterValue and sj.IMQSBatchID is null AND Date >= @fromDate AND Date <= @toDate;
	ELSE IF (@batchSize IS NOT NULL)
		INSERT INTO @rollups
			select top(@batchSize)
				rank() over (order by sj.SCOA_Fund, sj.SCOA_Function, sj.SCOA_Mun_Classification, sj.SCOA_Project, sj.SCOA_Costing, sj.SCOA_Region, sj.SCOA_Item_Debit, sj.SCOA_Item_Credit) as RollupID,
				@imqsBatchId as IMQSBatchID,
				sj.ComponentID
			from
				SCOAJournal sj inner join AssetFinFormInput f on sj.Form_Reference = f.Form_Reference inner join AssetFinFormRef affr on sj.Form_Reference = affr.Form_Reference inner join AssetFinForm aff on affr.Form_Nr = aff.Form_Nr
			where
				sj.CommittedToRegister = @committedToRegisterValue and sj.IMQSBatchID is null;

	-- We write the new IMQSBatch- and Rollup- IDs into the SCOAJournal
	UPDATE
		sj
	SET
		sj.RollupID = [@rollups].RollupID,
		sj.IMQSBatchID = [@rollups].IMQSBatchID
	FROM
		@rollups
	INNER JOIN
		SCOAJournal sj ON sj.ComponentID = [@rollups].ComponentID;

	SET @numberInputForms = @@ROWCOUNT;

	-- We create another virtual table for determining actual posting-journal rows
	DECLARE @postings TABLE (
		FINANCIAL_PERIOD VARCHAR(6),
		CREDIT_AMOUNT NUMERIC(25,2),
		batchRollup VARCHAR(20)
	);

	-- We populate the virtual table with the rolled-up rows that will be sent to the Financial System.
	-- These are not yet given a uniqueness value (i.e. UNIQUE_IDENTIFIER = NULL).
	INSERT INTO @postings
		SELECT
			STR(sj.FinYear,4) + REPLACE(STR(sj.Period, 2), ' ', '0'),
			0 as CREDIT_AMOUNT,
			(REPLACE(STR(sj.IMQSBatchID,10), ' ', '') + '-' + REPLACE(STR(sj.RollupID,10), ' ', ''))
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
			(REPLACE(STR(sj.IMQSBatchID,10), ' ', '') + '-' + REPLACE(STR(sj.RollupID,10), ' ', '')),
			sj.EffectiveDate,
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
			STR(sj.FinYear,4) + REPLACE(STR(sj.Period, 2), ' ', '0'),
			SUM(sj.Amount) as CREDIT_AMOUNT,
			(REPLACE(STR(sj.IMQSBatchID,10), ' ', '') + '-' + REPLACE(STR(sj.RollupID,10), ' ', ''))
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
			(REPLACE(STR(sj.IMQSBatchID,10), ' ', '') + '-' + REPLACE(STR(sj.RollupID,10), ' ', '')),
			sj.EffectiveDate,
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

	-- We create a virtual table called @postingBindings, to create unique IDs over each of the posting rows.
	-- By adding the @postingSeed (last used id) to the row_number() windowing function, we achieve a new unique sequence.
	DECLARE @postingBindings TABLE (UNIQUE_IDENTIFIER BIGINT, batchRollup VARCHAR(20), CRDR VARCHAR(2));
	INSERT INTO @postingBindings
		SELECT
			row_number() over (order by FINANCIAL_PERIOD) + @postingSeed,
			batchRollup,
			case CREDIT_AMOUNT when 0 then 'DR' else 'CR' end as CRDR
		FROM
			@postings;

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