-- Unfortunately SQL Server expects view definitions in seperate "statements", and it seems that
-- any statements in the same file have to be separated by the SQL Server propietry GO keyword - which
-- fails when executed over JDBC. So, our hand is forced, and we have to include views in separate
-- files here.

CREATE VIEW [dbo].[AssetRegisterView] AS
SELECT
	   [AssetRegisterIconFin2017].*,
	   AssetRegisterIconMove.Asset_Barcode_Nr,
	   AssetRegisterIconMove.Room_Barcode_Nr,
	   AssetRegisterIconMove.Room_Number,
	   AssetRegisterIconMove.Building_Name,
	   AssetRegisterIconMove.Serial_Number,
	   AssetRegisterIconMove.Fleet_Number,
	   AssetRegisterIconMove.Fleet_Reg_Year,
	   AssetRegisterIconMove.Treasury_Code,
	   AssetRegisterIconMove.Cost_Centre,
	   AssetRegisterIconMove.Acquisition_Date
FROM
	[AssetRegisterIconFin2017]
	LEFT JOIN
	AssetRegisterIconMove ON [AssetRegisterIconFin2017].ComponentID = AssetRegisterIconMove.ComponentID;