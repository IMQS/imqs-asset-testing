CREATE PROCEDURE GetFinancialSystemWorkflowType
	@workflowType VARCHAR(4) OUTPUT
AS
BEGIN
	SET @workflowType = (SELECT Value FROM AssetPolicyGeneral WHERE Section = 'Integration' AND Identifier = 'IntegratedFinSys')

	IF @workflowType IS NULL OR LEN(RTRIM(LTRIM(@workflowType))) = 0
	BEGIN
	  THROW 18, 'IntegratedFinSys value in AssetPolicyGeneral cannot be NULL or blank', 1;
	END

	IF @workflowType NOT IN ('NONE', 'PUSH', 'PULL')
	BEGIN
	  THROW 18, 'Invalid IntegratedFinSys value. Correct values: NONE, PUSH OR PULL', 1;
	END
END;