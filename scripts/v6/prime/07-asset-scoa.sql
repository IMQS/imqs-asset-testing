INSERT INTO SCOABudgetLeg ([FinFormNr], [TransactionType], [FinancialField], [BudgetLeg]) VALUES (1,'Recognition','AdditionsFinYTD','DT');
INSERT INTO SCOABudgetLeg ([FinFormNr], [TransactionType], [FinancialField], [BudgetLeg]) VALUES (9,'Depreciation','DepreciationFinYTD','DT');
INSERT INTO SCOABudgetLeg ([FinFormNr], [TransactionType], [FinancialField], [BudgetLeg]) VALUES (2,'Derecognition','DerecognitionCost','DT');
INSERT INTO SCOABudgetLeg ([FinFormNr], [TransactionType], [FinancialField], [BudgetLeg]) VALUES (2,'Derecognition','DerecognitionDepr','CT');
INSERT INTO SCOABudgetLeg ([FinFormNr], [TransactionType], [FinancialField], [BudgetLeg]) VALUES (2,'Derecognition','ImpairmentDerecog','CT');
INSERT INTO SCOABudgetLeg ([FinFormNr], [TransactionType], [FinancialField], [BudgetLeg]) VALUES (4,'Impairment','ImpairmentFinYTD','DT');
INSERT INTO SCOABudgetLeg ([FinFormNr], [TransactionType], [FinancialField], [BudgetLeg]) VALUES (5,'RevImpairment','RevImpairmentFinYTD','CT');
INSERT INTO SCOABudgetLeg ([FinFormNr], [TransactionType], [FinancialField], [BudgetLeg]) VALUES (10,'Transfer','TransferCost','CT');
INSERT INTO SCOABudgetLeg ([FinFormNr], [TransactionType], [FinancialField], [BudgetLeg]) VALUES (10,'Transfer','TransferDepr','DT');
INSERT INTO SCOABudgetLeg ([FinFormNr], [TransactionType], [FinancialField], [BudgetLeg]) VALUES (10,'Transfer','ImpairmentTransfer','DT');
INSERT INTO SCOABudgetLeg ([FinFormNr], [TransactionType], [FinancialField], [BudgetLeg]) VALUES (11,'Revaluation','RevaluationReserveFinYTD','CT');
INSERT INTO SCOABudgetLeg ([FinFormNr], [TransactionType], [FinancialField], [BudgetLeg]) VALUES (11,'Revaluation','RevaluationReserveFinYTDDepr','DT');
INSERT INTO SCOABudgetLeg ([FinFormNr], [TransactionType], [FinancialField], [BudgetLeg]) VALUES (11,'Revaluation','RevaluationReserveFinYTDImp','DT');
INSERT INTO SCOABudgetLeg ([FinFormNr], [TransactionType], [FinancialField], [BudgetLeg]) VALUES (7,'ValueChange','ValueChangeFinYTD','DT');
INSERT INTO SCOABudgetLeg ([FinFormNr], [TransactionType], [FinancialField], [BudgetLeg]) VALUES (12,'Maintenance','MaintenanceExpenditure','DT');


--Get the current Financial Year
DECLARE @FinYear INT = (SELECT MAX(FinYear) FROM AssetFinYear);

IF (@FinYear IS NULL)
BEGIN
	SET @FinYear = (SELECT
					CASE
						WHEN (SELECT MONTH(GETDATE())) <= 6 THEN (SELECT YEAR(GETDATE())) ELSE (SELECT YEAR(GETDATE())) + 1
					END)
END;


--Add the defaults
IF NOT EXISTS (SELECT * FROM SCOASettings WHERE Identifier = 'DEFAULT_SCOA_FUND' AND FinYear = @FinYear)
BEGIN
	INSERT INTO SCOASettings (FinYear, Identifier, Value, "Description")
	VALUES (@FinYear,'DEFAULT_SCOA_FUND','5692f970-c29c-4044-80d7-1bcdbdd34348','Default SCOAId to be used for SCOA_FUND')
END;

IF NOT EXISTS (SELECT * FROM SCOASettings WHERE Identifier = 'DEFAULT_SCOA_PROJECT' AND FinYear = @FinYear)
BEGIN
	INSERT INTO SCOASettings (FinYear, Identifier, Value, "Description")
	VALUES (@FinYear,'DEFAULT_SCOA_PROJECT','2a79a136-fcdf-43bf-8c4e-8ed735d13905','Default SCOAId to be used for SCOA_PROJECT')
END;

IF NOT EXISTS (SELECT * FROM SCOASettings WHERE Identifier = 'DEFAULT_SCOA_COST' AND FinYear = @FinYear)
BEGIN
	INSERT INTO SCOASettings (FinYear, Identifier, Value, "Description")
	VALUES (@FinYear,'DEFAULT_SCOA_COST','47c7ba65-c270-4a7f-91ba-3842eb629ddf','Default SCOAId to be used for SCOA_COST')
END;

--REGION is client specific and must be set through IMQS SCOA setup
IF NOT EXISTS (SELECT * FROM SCOASettings WHERE Identifier = 'DEFAULT_SCOA_REGION' AND FinYear = @FinYear)
BEGIN
	INSERT INTO SCOASettings (FinYear, Identifier, Value, "Description")
	VALUES (@FinYear,'DEFAULT_SCOA_REGION','NO DEFAULT SET','Default SCOAId to be used for SCOA_REGION')
END;

IF NOT EXISTS (SELECT * FROM SCOASettings WHERE Identifier = 'WIPFROM_SCOA_ITEM' AND FinYear = @FinYear)
BEGIN
	INSERT INTO SCOASettings (FinYear, Identifier, Value, "Description")
	VALUES (@FinYear,'WIPFROM_SCOA_ITEM','NO DEFAULT SET','Default SCOAId to be used for WIP-From SCOA Item on rollover')
END;

IF NOT EXISTS (SELECT * FROM SCOASettings WHERE Identifier = 'WIPTO_SCOA_ITEM' AND FinYear = @FinYear)
BEGIN
	INSERT INTO SCOASettings (FinYear, Identifier, Value, "Description")
	VALUES (@FinYear,'WIPTO_SCOA_ITEM','NO DEFAULT SET','Default SCOAId to be used for WIP-To SCOA Item on rollover')
END;


--Delete old values from AssetPolicyGeneral
DELETE FROM AssetPolicyGeneral WHERE Section = 'SCOA' and Identifier = 'DEFAULT_SCOA_FUND';
DELETE FROM AssetPolicyGeneral WHERE Section = 'SCOA' and Identifier = 'DEFAULT_SCOA_PROJECT';
DELETE FROM AssetPolicyGeneral WHERE Section = 'SCOA' and Identifier = 'DEFAULT_SCOA_COST';
DELETE FROM AssetPolicyGeneral WHERE Section = 'SCOA' and Identifier = 'DEFAULT_SCOA_REGION';
DELETE FROM AssetPolicyGeneral WHERE Section = 'SCOA' and Identifier = 'OpenBalanceTransferItem';
DELETE FROM AssetPolicyGeneral WHERE Section = 'SCOA' and Identifier = 'SCOA Journal Frequency';
DELETE FROM AssetPolicyGeneral WHERE Section = 'SCOA' and Identifier = 'SCOA Journal Location';
DELETE FROM AssetPolicyGeneral WHERE Section = 'SCOA' and Identifier = 'SCOA Journal Roll-up';
DELETE FROM AssetPolicyGeneral WHERE Section = 'SCOA' and Identifier = 'Version';
