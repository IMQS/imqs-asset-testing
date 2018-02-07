-- Unfortunately SQL Server expects view definitions in seperate "statements", and it seems that
-- any statements in the same file have to be separated by the SQL Server propietry GO keyword - which
-- fails when executed over JDBC. So, our hand is forced, and we have to include views in separate 
-- files here.

CREATE View [dbo].[InputFormView] AS
SELECT
	AssetFinFormRef.Form_Nr,
	AssetFinFormRef.Ext_Form_Reference,
	AssetFinFormRef.Creator,
	AssetFinFormRef.Form_Level,
	AssetFinFormInput.*,
	[Issue_DateTime], [Component_ID],	[Asset_Group_Name],	[Requested_Name], [Requested_Date],	[Authorised_Name],[Authorised_Date],
	[Custodian_Name], [Custodian_Date],	[ExManager_Name],[ExManager_Date],[Captured_Name],[Captured_Date],[Information],[Instructions],
	[Rec_Action],[Carrying_Value],[Value_in_Use],[Fair_Value_Less],[Recoverable_Amt],[Police_Report_Nr],[Take_on_Date],[Reason_Code],
	[form_timestamp] [timestamp]
FROM
	AssetFinFormInput
JOIN
	AssetFinFormRef on AssetFinFormInput.Form_Reference = AssetFinFormRef.Form_Reference
JOIN
	AssetFinForm on AssetFinForm.Form_Nr = AssetFinFormRef.Form_Nr
