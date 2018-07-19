CREATE PROCEDURE [dbo].[SCOABudgetInsert]
	@BudgetNr VARCHAR(40),
	@Description VARCHAR(80),
	@SCOA_Costing VARCHAR(40),
	@SCOA_Function VARCHAR(40),
	@SCOA_Fund VARCHAR(40),
	@SCOA_Item VARCHAR(40),
	@SCOA_Mun_Classification VARCHAR(40) = NULL,
	@SCOA_Project VARCHAR(40),
	@SCOA_Region VARCHAR(40)
	
AS
BEGIN 
	DECLARE @Costing VARCHAR(40)
	DECLARE @Function VARCHAR(40)
	DECLARE @Fund VARCHAR(40)
	DECLARE @Item VARCHAR(40)
	DECLARE @Project VARCHAR(40)
	DECLARE @Region VARCHAR(40)
	DECLARE @BreakdownCosting VARCHAR(40)
	DECLARE @BreakdownFunction VARCHAR(40)
	DECLARE @BreakdownFund VARCHAR(40)
	DECLARE @BreakdownItem VARCHAR(40)
	DECLARE @BreakdownProject VARCHAR(40)
	DECLARE @BreakdownRegion VARCHAR(40)
	
	--SCOA Costing
	(SELECT	
		@Costing = CASE WHEN sc.IsBreakdown = 1 THEN sc.ParentSCOAId ELSE @SCOA_Costing END,
		@BreakdownCosting = CASE WHEN sc.IsBreakdown = 1 THEN sc.AccountNumber END	 
	 FROM SCOAClassification sc WHERE sc.SCOAId = @SCOA_Costing)
	 
	--SCOA Function
	(SELECT	
		@Function = CASE WHEN sc.IsBreakdown = 1 THEN sc.ParentSCOAId ELSE @SCOA_Function END,
		@BreakdownFunction = CASE WHEN sc.IsBreakdown = 1 THEN sc.AccountNumber END	 
	 FROM SCOAClassification sc WHERE sc.SCOAId = @SCOA_Function)
	 
	 --SCOA Fund
	(SELECT	
		@Fund = CASE WHEN sc.IsBreakdown = 1 THEN sc.ParentSCOAId ELSE @SCOA_Fund END,
		@BreakdownFund = CASE WHEN sc.IsBreakdown = 1 THEN sc.AccountNumber END	 
	 FROM SCOAClassification sc WHERE sc.SCOAId = @SCOA_Fund)
	 
	 --SCOA Item
	(SELECT	
		@Item = CASE WHEN sc.IsBreakdown = 1 THEN sc.ParentSCOAId ELSE @SCOA_Item END,
		@BreakdownItem = CASE WHEN sc.IsBreakdown = 1 THEN sc.AccountNumber END	 
	 FROM SCOAClassification sc WHERE sc.SCOAId = @SCOA_Item)
	
	--SCOA Project
	(SELECT	
		@Project = CASE WHEN sc.IsBreakdown = 1 THEN sc.ParentSCOAId ELSE @SCOA_Project END,
		@BreakdownProject = CASE WHEN sc.IsBreakdown = 1 THEN sc.AccountNumber END	 
	 FROM SCOAClassification sc WHERE sc.SCOAId = @SCOA_Project)
	
	--SCOA Region
	(SELECT	
		@Region = CASE WHEN sc.IsBreakdown = 1 THEN sc.ParentSCOAId ELSE @SCOA_Region END,
		@BreakdownRegion = CASE WHEN sc.IsBreakdown = 1 THEN sc.AccountNumber END	 
	 FROM SCOAClassification sc WHERE sc.SCOAId = @SCOA_Region)
	
	--Insert the record
	INSERT INTO SCOABudget 
		(BudgetNr, Description, SCOA_Mun_Classification, SCOA_Costing, SCOA_Function, SCOA_Fund, SCOA_Item, SCOA_Project, SCOA_Region,
		 BREAKDOWN_SCOA_Costing, BREAKDOWN_SCOA_Function, BREAKDOWN_SCOA_Fund, BREAKDOWN_SCOA_Item, BREAKDOWN_SCOA_Project, BREAKDOWN_SCOA_Region)
	VALUES
	(@BudgetNr, @Description, @SCOA_Mun_Classification, @Costing, @Function, @Fund, @Item, @Project, @Region,
	 @BreakdownCosting, @BreakdownFunction, @BreakdownFund, @BreakdownItem, @BreakdownProject, @BreakdownRegion)
	
END