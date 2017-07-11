CREATE View [dbo].[AssetRegisterView] AS
SELECT
  [AssetRegisterIconFin2015].*,
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
FROM [AssetRegisterIconFin2015]
  LEFT JOIN AssetRegisterIconMove
    ON [AssetRegisterIconFin2015].ComponentID = AssetRegisterIconMove.ComponentID;

