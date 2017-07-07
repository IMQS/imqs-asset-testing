CREATE View [dbo].[InputFormView] AS
select
  AssetFinFormRef.Form_Nr,
  AssetFinFormRef.Ext_Form_Reference,
  AssetFinFormRef.Creator,
  AssetFinFormRef.Form_Level,
  AssetFinformInput.*,
[Issue_DateTime], [Component_ID],	[Asset_Group_Name],	[Requested_Name], [Requested_Date],	[Authorised_Name],[Authorised_Date],
[Custodian_Name], [Custodian_Date],	[ExManager_Name],[ExManager_Date],[Captured_Name],[Captured_Date],[Information],[Instructions],
[Rec_Action],[Carrying_Value],[Value_in_Use],[Fair_Value_Less],[Recoverable_Amt],[Police_Report_Nr],[Take_on_Date],[Reason_Code],
[form_timestamp] [timestamp]
from AssetFinFormInput
join AssetFinFormRef on AssetFinFormInput.Form_Reference = AssetFinFormRef.Form_Reference
join AssetFinForm on AssetFinForm.Form_Nr = AssetFinFormRef.Form_Nr
join AssetFinFormState on AssetFinFormState.Form_Level = AssetFinFormRef.Form_Level AND AssetFinFormState.Workflow = 'GENERIC';
