CREATE PROCEDURE [dbo].[UpdateOpeningBalances](
@FinYear INT,
@ComponentID VARCHAR(40) = NULL
)
AS
BEGIN
DECLARE @FinRegister VARCHAR(MAX) = 'AssetRegisterIconFin' + CAST((@FinYear) AS VARCHAR(4));
DECLARE @NewFinRegister VARCHAR(MAX) = 'AssetRegisterIconFin' + CAST((@FinYear + 1) AS VARCHAR(4));

DECLARE @SQL VARCHAR(MAX)=''
SET @SQL ='UPDATE ' + @NewFinRegister +
' SET DepreciationOpening = a.DepreciationClosing ' +
',ImpairmentAll = ISNULL(a.ImpairmentClose,0) ' +
',RevaluationReserveOpening = ISNULL(a.RevaluationReserveClosing,0) ' +
',CarryingValueOpening = a.CarryingValueClosing' +
',CostOpening = a.CostClosing ' +
',ProvisionOpening = a.ProvisionClosing ' +
'FROM '  + @FinRegister + ' a ' +
'WHERE ' + @NewFinRegister + '.ComponentID = a.ComponentID ';

if @ComponentID IS NOT NULL
SET @SQL = @SQL + ' and (a.ComponentID = ''' + @ComponentID + ''')';

EXEC(@SQL);
END