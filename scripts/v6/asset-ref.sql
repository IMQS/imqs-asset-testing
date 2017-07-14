-- Reference tables for constant values that don't change much and are associated to AR fields via lookups

IF OBJECT_ID (N'AssetRefAccounting', N'U') IS NOT NULL DROP TABLE [AssetRefAccounting];
IF OBJECT_ID (N'AssetRefCategory', N'U') IS NOT NULL DROP TABLE [AssetRefCategory];
IF OBJECT_ID (N'AssetRefSubCategory', N'U') IS NOT NULL DROP TABLE [AssetRefSubCategory];

CREATE TABLE [dbo].[AssetRefAccounting](
	[AccountingGroupID] [varchar](4) NOT NULL,
	[AccountingGroupName] [varchar](40) NULL,
	[Colour] [int] NULL,
	[Visible] [bit] NULL,
	[Selected] [bit] NULL,
	CONSTRAINT [PK_AssetRefAccounting] PRIMARY KEY CLUSTERED([AccountingGroupID] ASC) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY];

CREATE TABLE [dbo].[AssetRefCategory](
	[AccountingGroupID] [varchar](4) NOT NULL,
	[AssetCategoryID] [varchar](4) NOT NULL,
	[AssetCategoryName] [varchar](40) NULL,
	[Colour] [int] NULL,
	[Visible] [bit] NULL,
	[Selected] [bit] NULL,
	[ExtraCategoryID] [varchar](8) NULL,
	CONSTRAINT [PK_AssetRefCategory] PRIMARY KEY CLUSTERED([AccountingGroupID] ASC, [AssetCategoryID] ASC) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY];

CREATE TABLE [dbo].[AssetRefSubCategory](
	[AssetCategoryID] [varchar](4) NOT NULL,
	[AssetSubCategoryID] [varchar](4) NOT NULL,
	[AssetSubCategoryName] [varchar](40) NULL,
	[Colour] [int] NULL,
	[Visible] [bit] NULL,
	[Selected] [bit] NULL,
	[ExtraSubCategoryID] [varchar](8) NULL,
	CONSTRAINT [PK_AssetRefSubCategory] PRIMARY KEY CLUSTERED([AssetCategoryID] ASC, [AssetSubCategoryID] ASC) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY];

ALTER TABLE [dbo].[AssetRefAccounting] ADD CONSTRAINT [DF_AssetRefAccounting_AccountingGroupID] DEFAULT ('') FOR [AccountingGroupID];
ALTER TABLE [dbo].[AssetRefAccounting] ADD CONSTRAINT [DF_AssetRefAccounting_AccountingGroupName] DEFAULT ('') FOR [AccountingGroupName];
ALTER TABLE [dbo].[AssetRefCategory] ADD CONSTRAINT [DF_AssetRefCategory_AccountingGroupID] DEFAULT ('') FOR [AccountingGroupID];
ALTER TABLE [dbo].[AssetRefCategory] ADD CONSTRAINT [DF_AssetRefCategory_AssetCategoryID] DEFAULT ('') FOR [AssetCategoryID];
ALTER TABLE [dbo].[AssetRefSubCategory] ADD CONSTRAINT [DF_AssetRefSubCategory_AssetCategoryID] DEFAULT ('') FOR [AssetCategoryID];
ALTER TABLE [dbo].[AssetRefSubCategory] ADD CONSTRAINT [DF_AssetRefSubCategory_AssetSubCategoryID] DEFAULT ('') FOR [AssetSubCategoryID];
ALTER TABLE [dbo].[AssetRefSubCategory] ADD CONSTRAINT [DF_AssetRefSubCategory_AssetSubCategoryName] DEFAULT ('') FOR [AssetSubCategoryName];

-- Financial System Classifications
INSERT [dbo].[AssetRefAccounting] ([AccountingGroupID], [AccountingGroupName], [Colour], [Visible], [Selected]) VALUES (N'HER', N'Heritage Assets', NULL, NULL, NULL)
INSERT [dbo].[AssetRefAccounting] ([AccountingGroupID], [AccountingGroupName], [Colour], [Visible], [Selected]) VALUES (N'INT', N'Intangible Assets', NULL, NULL, NULL)
INSERT [dbo].[AssetRefAccounting] ([AccountingGroupID], [AccountingGroupName], [Colour], [Visible], [Selected]) VALUES (N'INV', N'Investment Property', NULL, NULL, NULL)
INSERT [dbo].[AssetRefAccounting] ([AccountingGroupID], [AccountingGroupName], [Colour], [Visible], [Selected]) VALUES (N'PPE', N'Property Plant and Equipment', NULL, NULL, NULL)
INSERT [dbo].[AssetRefCategory] ([AccountingGroupID], [AssetCategoryID], [AssetCategoryName], [Colour], [Visible], [Selected], [ExtraCategoryID]) VALUES (N'HER', N'5EWX', N'Other Assets', NULL, NULL, NULL, NULL)
INSERT [dbo].[AssetRefCategory] ([AccountingGroupID], [AssetCategoryID], [AssetCategoryName], [Colour], [Visible], [Selected], [ExtraCategoryID]) VALUES (N'HER', N'AT2M', N'Land & Buildings', NULL, NULL, NULL, NULL)
INSERT [dbo].[AssetRefCategory] ([AccountingGroupID], [AssetCategoryID], [AssetCategoryName], [Colour], [Visible], [Selected], [ExtraCategoryID]) VALUES (N'INT', N'HFWE', N'Right', NULL, NULL, NULL, NULL)
INSERT [dbo].[AssetRefCategory] ([AccountingGroupID], [AssetCategoryID], [AssetCategoryName], [Colour], [Visible], [Selected], [ExtraCategoryID]) VALUES (N'INT', N'VJR0', N'Intangible Assets', NULL, NULL, NULL, NULL)
INSERT [dbo].[AssetRefCategory] ([AccountingGroupID], [AssetCategoryID], [AssetCategoryName], [Colour], [Visible], [Selected], [ExtraCategoryID]) VALUES (N'INT', N'Z7LI', N'Software', NULL, NULL, NULL, NULL)
INSERT [dbo].[AssetRefCategory] ([AccountingGroupID], [AssetCategoryID], [AssetCategoryName], [Colour], [Visible], [Selected], [ExtraCategoryID]) VALUES (N'INV', N'DNA4', N'Land & Buildings', NULL, NULL, NULL, NULL)
INSERT [dbo].[AssetRefCategory] ([AccountingGroupID], [AssetCategoryID], [AssetCategoryName], [Colour], [Visible], [Selected], [ExtraCategoryID]) VALUES (N'PPE', N'4LNZ', N'Other Assets', NULL, NULL, NULL, NULL)
INSERT [dbo].[AssetRefCategory] ([AccountingGroupID], [AssetCategoryID], [AssetCategoryName], [Colour], [Visible], [Selected], [ExtraCategoryID]) VALUES (N'PPE', N'U1A9', N'Infrastructure Assets', NULL, NULL, NULL, NULL)
INSERT [dbo].[AssetRefCategory] ([AccountingGroupID], [AssetCategoryID], [AssetCategoryName], [Colour], [Visible], [Selected], [ExtraCategoryID]) VALUES (N'PPE', N'UALW', N'Land & Buildings', NULL, NULL, NULL, NULL)
INSERT [dbo].[AssetRefSubCategory] ([AssetCategoryID], [AssetSubCategoryID], [AssetSubCategoryName], [Colour], [Visible], [Selected], [ExtraSubCategoryID]) VALUES (N'4LNZ', N'JJFT', N'Office equipment', NULL, 1, NULL, NULL)
INSERT [dbo].[AssetRefSubCategory] ([AssetCategoryID], [AssetSubCategoryID], [AssetSubCategoryName], [Colour], [Visible], [Selected], [ExtraSubCategoryID]) VALUES (N'4LNZ', N'UKOL', N'Motor vehicles', NULL, 1, NULL, NULL)
INSERT [dbo].[AssetRefSubCategory] ([AssetCategoryID], [AssetSubCategoryID], [AssetSubCategoryName], [Colour], [Visible], [Selected], [ExtraSubCategoryID]) VALUES (N'4LNZ', N'WIKO', N'Emergency equipment', NULL, 1, NULL, NULL)
INSERT [dbo].[AssetRefSubCategory] ([AssetCategoryID], [AssetSubCategoryID], [AssetSubCategoryName], [Colour], [Visible], [Selected], [ExtraSubCategoryID]) VALUES (N'4LNZ', N'XUCR', N'Plant and equipment', NULL, 1, NULL, NULL)
INSERT [dbo].[AssetRefSubCategory] ([AssetCategoryID], [AssetSubCategoryID], [AssetSubCategoryName], [Colour], [Visible], [Selected], [ExtraSubCategoryID]) VALUES (N'4LNZ', N'Z02Q', N'Furniture and fittings', NULL, 1, NULL, NULL)
INSERT [dbo].[AssetRefSubCategory] ([AssetCategoryID], [AssetSubCategoryID], [AssetSubCategoryName], [Colour], [Visible], [Selected], [ExtraSubCategoryID]) VALUES (N'5EWX', N'UO6A', N'Antiques and collections', NULL, 1, NULL, NULL)
INSERT [dbo].[AssetRefSubCategory] ([AssetCategoryID], [AssetSubCategoryID], [AssetSubCategoryName], [Colour], [Visible], [Selected], [ExtraSubCategoryID]) VALUES (N'5EWX', N'X07N', N'Jewellery', NULL, 1, NULL, NULL)
INSERT [dbo].[AssetRefSubCategory] ([AssetCategoryID], [AssetSubCategoryID], [AssetSubCategoryName], [Colour], [Visible], [Selected], [ExtraSubCategoryID]) VALUES (N'5EWX', N'XFU0', N'Works of art', NULL, 1, NULL, NULL)
INSERT [dbo].[AssetRefSubCategory] ([AssetCategoryID], [AssetSubCategoryID], [AssetSubCategoryName], [Colour], [Visible], [Selected], [ExtraSubCategoryID]) VALUES (N'AT2M', N'COM', N'Community Facility', NULL, NULL, NULL, NULL)
INSERT [dbo].[AssetRefSubCategory] ([AssetCategoryID], [AssetSubCategoryID], [AssetSubCategoryName], [Colour], [Visible], [Selected], [ExtraSubCategoryID]) VALUES (N'AT2M', N'MFUI', N'Land', NULL, 1, NULL, NULL)
INSERT [dbo].[AssetRefSubCategory] ([AssetCategoryID], [AssetSubCategoryID], [AssetSubCategoryName], [Colour], [Visible], [Selected], [ExtraSubCategoryID]) VALUES (N'AT2M', N'NKWR', N'Buildings', NULL, 1, NULL, NULL)
INSERT [dbo].[AssetRefSubCategory] ([AssetCategoryID], [AssetSubCategoryID], [AssetSubCategoryName], [Colour], [Visible], [Selected], [ExtraSubCategoryID]) VALUES (N'AT2M', N'OPR', N'Operational Buildings', NULL, NULL, NULL, NULL)
INSERT [dbo].[AssetRefSubCategory] ([AssetCategoryID], [AssetSubCategoryID], [AssetSubCategoryName], [Colour], [Visible], [Selected], [ExtraSubCategoryID]) VALUES (N'DNA4', N'0IJQ', N'Land', NULL, 1, NULL, NULL)
INSERT [dbo].[AssetRefSubCategory] ([AssetCategoryID], [AssetSubCategoryID], [AssetSubCategoryName], [Colour], [Visible], [Selected], [ExtraSubCategoryID]) VALUES (N'DNA4', N'IJCN', N'Buildings', NULL, 1, NULL, NULL)
INSERT [dbo].[AssetRefSubCategory] ([AssetCategoryID], [AssetSubCategoryID], [AssetSubCategoryName], [Colour], [Visible], [Selected], [ExtraSubCategoryID]) VALUES (N'HFWE', N'RXA4', N'Right', NULL, 1, NULL, NULL)
INSERT [dbo].[AssetRefSubCategory] ([AssetCategoryID], [AssetSubCategoryID], [AssetSubCategoryName], [Colour], [Visible], [Selected], [ExtraSubCategoryID]) VALUES (N'U1A9', N'1UEJ', N'Water and Sanitation', NULL, 1, NULL, NULL)
INSERT [dbo].[AssetRefSubCategory] ([AssetCategoryID], [AssetSubCategoryID], [AssetSubCategoryName], [Colour], [Visible], [Selected], [ExtraSubCategoryID]) VALUES (N'U1A9', N'K8IU', N'Electricity', NULL, 1, NULL, NULL)
INSERT [dbo].[AssetRefSubCategory] ([AssetCategoryID], [AssetSubCategoryID], [AssetSubCategoryName], [Colour], [Visible], [Selected], [ExtraSubCategoryID]) VALUES (N'U1A9', N'PXSO', N'Solid Waste', NULL, 1, NULL, NULL)
INSERT [dbo].[AssetRefSubCategory] ([AssetCategoryID], [AssetSubCategoryID], [AssetSubCategoryName], [Colour], [Visible], [Selected], [ExtraSubCategoryID]) VALUES (N'U1A9', N'R8YH', N'Roads and Stormwater', NULL, 1, NULL, NULL)
INSERT [dbo].[AssetRefSubCategory] ([AssetCategoryID], [AssetSubCategoryID], [AssetSubCategoryName], [Colour], [Visible], [Selected], [ExtraSubCategoryID]) VALUES (N'UALW', N'BGHQ', N'Community Facility', NULL, 1, NULL, NULL)
INSERT [dbo].[AssetRefSubCategory] ([AssetCategoryID], [AssetSubCategoryID], [AssetSubCategoryName], [Colour], [Visible], [Selected], [ExtraSubCategoryID]) VALUES (N'UALW', N'PXI8', N'Operational Buildings', NULL, 1, NULL, NULL)
INSERT [dbo].[AssetRefSubCategory] ([AssetCategoryID], [AssetSubCategoryID], [AssetSubCategoryName], [Colour], [Visible], [Selected], [ExtraSubCategoryID]) VALUES (N'UALW', N'YUIM', N'Land', NULL, 1, NULL, NULL)
INSERT [dbo].[AssetRefSubCategory] ([AssetCategoryID], [AssetSubCategoryID], [AssetSubCategoryName], [Colour], [Visible], [Selected], [ExtraSubCategoryID]) VALUES (N'VJR0', N'NSVN', N'Software', NULL, 1, NULL, NULL)
INSERT [dbo].[AssetRefSubCategory] ([AssetCategoryID], [AssetSubCategoryID], [AssetSubCategoryName], [Colour], [Visible], [Selected], [ExtraSubCategoryID]) VALUES (N'Z7LI', N'XFGV', N'Software', NULL, 1, NULL, NULL)
