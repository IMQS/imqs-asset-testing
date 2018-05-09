
--Generic Financial System Integration workflow
INSERT [dbo].[AssetFinFormState] ([Workflow], [State_Prefix], [State_Desc], [State_Req_Group], [Form_Level], [Next_State]) VALUES ('GENERIC', N'CT', N'CREATED', -1, 0, N'SM');
INSERT [dbo].[AssetFinFormState] ([Workflow], [State_Prefix], [State_Desc], [State_Req_Group], [Form_Level], [Next_State]) VALUES ('GENERIC', N'SM', N'SUBMITTED', -1, 1, N'PA');
INSERT [dbo].[AssetFinFormState] ([Workflow], [State_Prefix], [State_Desc], [State_Req_Group], [Form_Level], [Next_State]) VALUES ('GENERIC', N'CO', N'COMMITTED', -1, 3, NULL);
INSERT [dbo].[AssetFinFormState] ([Workflow], [State_Prefix], [State_Desc], [State_Req_Group], [Form_Level], [Next_State]) VALUES ('GENERIC', N'PA', N'PENDING AUTHORISATION', -1, 4, N'CO');
INSERT [dbo].[AssetFinFormState] ([Workflow], [State_Prefix], [State_Desc], [State_Req_Group], [Form_Level], [Next_State]) VALUES ('GENERIC', N'FL', N'FAILED', -1, 2, N'PA');
INSERT [dbo].[AssetFinFormState] ([Workflow], [State_Prefix], [State_Desc], [State_Req_Group], [Form_Level], [Next_State]) VALUES ('GENERIC', N'DC', N'DECLINED', -1, 5, NULL);

INSERT INTO [AssetFinForm] (Form_Nr, Form_Desc, BatchPrefix) VALUES (-1, 'Unknown Form', 'Z');
INSERT INTO [AssetFinForm] (Form_Nr, Form_Desc, BatchPrefix) VALUES (1, 'Component Recognition', 'P');
INSERT INTO [AssetFinForm] (Form_Nr, Form_Desc, BatchPrefix) VALUES (2, 'Derecognition of Components', 'D');
INSERT INTO [AssetFinForm] (Form_Nr, Form_Desc, BatchPrefix) VALUES (3, 'Update/Correction of Component', 'C');
INSERT INTO [AssetFinForm] (Form_Nr, Form_Desc, BatchPrefix) VALUES (4, 'Impairment of Components', 'I');
INSERT INTO [AssetFinForm] (Form_Nr, Form_Desc, BatchPrefix) VALUES (5, 'Reversal of Impairment', 'R');
INSERT INTO [AssetFinForm] (Form_Nr, Form_Desc, BatchPrefix) VALUES (7, 'Upgrade', 'U');

INSERT INTO [AssetFinForm] (Form_Nr, Form_Desc, BatchPrefix) VALUES (8,'Verification','V');
INSERT INTO [AssetFinForm] (Form_Nr, Form_Desc, BatchPrefix) VALUES (9,'Depreciation','T');
INSERT INTO [AssetFinForm] (Form_Nr, Form_Desc, BatchPrefix) VALUES (10,'Reclassification','S');
INSERT INTO [AssetFinForm] (Form_Nr, Form_Desc, BatchPrefix) VALUES (11,'Revaluation','N');
INSERT INTO [AssetFinForm] (Form_Nr, Form_Desc, BatchPrefix) VALUES (12,'Maintenance','M');
INSERT INTO [AssetFinForm] (Form_Nr, Form_Desc, BatchPrefix) VALUES (13,'Reversal of Derecognition','X');