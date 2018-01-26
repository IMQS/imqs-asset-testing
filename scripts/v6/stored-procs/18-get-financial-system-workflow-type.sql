CREATE PROCEDURE GetFinancialSystemWorkflowType
	@workflowType VARCHAR(4) OUTPUT
AS
BEGIN
	SET @workflowType = (SELECT Value FROM AssetPolicyGeneral WHERE Section = 'Integration' AND Identifier = 'IntegratedFinSys')
END;