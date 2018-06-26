USE [DBA_DB_Name]
GO

/****** Object:  Table [dbo].[tbl_StoreTablesForReplication]    Script Date: 26/06/2018 10:17:20 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tbl_StoreTablesForReplication](
	[PublisherServer] [nvarchar](255) NULL,
	[PublisherName] [nvarchar](255) NULL,
	[PublisherDB] [nvarchar](255) NULL,
	[PublisherTableName] [nvarchar](255) NULL,
	[Type_desc] [nvarchar](50) NULL,
	[SubscriberTableName] [nvarchar](255) NULL,
	[SubscriberDB] [nvarchar](255) NULL,
	[SubscriberServer] [nvarchar](255) NULL,
	[Filter_clause] [nvarchar](4000) NULL
) ON [PRIMARY]

GO


