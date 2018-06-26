USE HostedMaintenance
GO

--CREATE PROCEDURE dbo.usp_Drop_Replication

--@DBName NVARCHAR(255)

--AS

----------------------------------------------------------------------------------------------------
--
-- Description :	Step 1 - Does what it says on the tin. Locates the specific db and drops the 
--					subscriptions and publication. but stores the data first.
--
-- Author :			Andy G
--
-- Created :		27/07/2017
--
-- History :	
--
----------------------------------------------------------------------------------------------------

-- Drop and recreate replication steps
-- 1 - usp_Drop_Replication. this SP stored the articles in a table (HostedMaintenance.[dbo].[tbl_StoreTablesForReplication])
--	   then we identify the specific database and drop the subscription and then the publication.
-- 2 - updaterer does it thang.
-- 3 - we now recreate the replication (usp_CreateReplication).
--	   this will need to use the binary value when creating the articles (@schema_option)
-- 4 - start the SQL Agent snapshot to complete it all.

/*

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

--GO






*/


SET NOCOUNT ON;

DECLARE @SQL NVARCHAR(4000),
		@Replication_Active INT

-- Testing Start
DECLARE @DBName NVARCHAR(255)

SET @DBName = 'HZN_CITRUS'

-- Testing End

-- Check if the specific DB is replicating
SELECT @Replication_Active  = COUNT(*) FROM sys.databases 
WHERE (is_published=1 or is_subscribed=1 or is_merge_published=1)
AND name = '' + @DBName + ''

IF @Replication_Active > 0
BEGIN

	-- Check if this replication is already in the table. if So remove it so we can reload it.
	IF EXISTS (SELECT COUNT(*) FROM HostedMaintenance.[dbo].[tbl_StoreTablesForReplication] WHERE PublisherDB = @DBName) 
		DELETE FROM HostedMaintenance.[dbo].[tbl_StoreTablesForReplication] WHERE PublisherDB = @DBName

	-- Part 1 - Get a list of tables,views and whatever that is being replicated.
	-- issue with this is that you only see the tables in sysarticless, so you need to get anything else from other sources
	SET @SQL = '
USE [' + @DBName + '] 
;With ReplicationObjects as
(Select pubid,artID,dest_object,''filter_clause'' AS Filter_clause,dest_owner,objid,name from sysschemaarticles
union
Select pubid,artID,dest_table,CONVERT(NVARCHAR(4000),filter_clause) AS filter_clause,dest_owner,objid,name from sysarticles)

INSERT INTO HostedMaintenance.[dbo].[tbl_StoreTablesForReplication] (PublisherServer,PublisherName,PublisherDB,PublisherTableName,Type_desc,SubscriberTableName,SubscriberDB,SubscriberServer,Filter_clause)
Select CONVERT(NVARCHAR(255),Serverproperty(''ServerName'')) as [PublisherServer],
B.name as [PublisherName],DB_Name() as [PublisherDB],
E.Name+''.''+A.Name as [PublisherTableName],D.Type_desc,
A.dest_owner+''.''+A.dest_Object as [SubscriberTableName],
C.dest_db as [SubscriberDB],C.srvname as [SubscriberServer],
a.Filter_clause
From ReplicationObjects A
Inner Join syspublications B on A.pubid=B.pubid
Inner Join dbo.syssubscriptions C on C.artid=A.artid
Inner Join sys.objects D on A.objid=D.Object_id
Inner Join sys.schemas E on E.Schema_id=D.Schema_id
Where dest_db not in (''Virtual'')'

-- above Dynamic SQL wont work locally as the WHERE Clause filters out the 'Virtual' bit. 
-- it works fine on SQL04

Print @sql
	EXEC sp_executeSQL @SQL


END

SELECT * FROM HostedMaintenance.[dbo].[tbl_StoreTablesForReplication] 

/*

	PublisherServer NVARCHAR(255),
	PublisherName NVARCHAR(255),
	PublisherDB NVARCHAR(255),
	PublisherTableName NVARCHAR(255),
	Type_desc NVARCHAR(50),
	SubscriberTableName NVARCHAR(255),
	SubscriberDB NVARCHAR(255),
	SubscriberServer NVARCHAR(255),
	Filter_clause NVARCHAR(4000)


;With ReplicationObjects as
(Select pubid,artID,dest_object,'filter_clause' AS Filter_clause,dest_owner,objid,name from sysschemaarticles
union
Select pubid,artID,dest_table,CONVERT(NVARCHAR(4000),filter_clause) AS filter_clause,dest_owner,objid,name from sysarticles)

Select Serverproperty('ServerName') as [PublisherServer],
B.name as [PublisherName],DB_Name() as [PublisherDB],
E.Name+'.'+A.Name as [PublisherTableName],D.Type_desc,
A.dest_owner+'.'+A.dest_Object as [SubscriberTableName],
C.dest_db as [SubscriberDB],C.srvname as [SubscriberServer],
a.Filter_clause
From ReplicationObjects A
Inner Join syspublications B on A.pubid=B.pubid
Inner Join dbo.syssubscriptions C on C.artid=A.artid
Inner Join sys.objects D on A.objid=D.Object_id
Inner Join sys.schemas E on E.Schema_id=D.Schema_id
Where dest_db not in ('Virtual')


	SELECT ''' + 
		@DBName + ''' AS DatabaseName,
		sp.name AS Replication_Name,
		dest_table AS TableName,
		1 AS Replication_Type,
		CONVERT(NVARCHAR(4000),filter_Clause) AS Filter
	FROM [' + @DBName + '].dbo.sysarticles sa
	LEFT OUTER JOIN [' + @DBName + '].dbo.SysPublications sp on sp.pubid = sa.pubid
	UNION
	SELECT ''' + 
		@DBName + ''' AS DatabaseName,
		a.Replication_Name as Replication_Name,
		CONVERT(NVARCHAR(128), sv.name) AS TableName,
		2 AS Replication_Type,
		NULL AS Filter
	FROM [' + @DBName + '].sys.views sv 
	CROSS APPLY (SELECT sp.name AS Replication_Name FROM [' + @DBName + '].dbo.SysPublications sp EXCEPT SELECT sp1.name FROM [HZN_CITRUS].dbo.sysarticles sa LEFT OUTER JOIN [' + @DBName + '].dbo.SysPublications sp1 on sp1.pubid = sa.pubid) a
	WHERE is_schema_published = 1 




*/
-----------------------------------------------------------------------------------------------
 /*
 -- Main Start

	-- Drop Subscription
	EXEC sp_dropsubscription
	@publication= 'reptest', @subscriber = 'REXGBAD-BLQGV4J\SECONDARY' , @article = 'all'


	-----------------------------------------------

	
	-- Steps to do prior to dropping subscriptions and publications
	-- 1. check db is set for replication -- usp_CheckForReplication '<Database Name>' -- 1 = set for replication, 0 = not set for replication
	-- 2. store tables (articles) in temp table ready to rebuild the replication after Horizon update
	--	usp_GetReplicationTables '<Database Name>'
	-- Prism database has 2 publications and subscriptions. one for tables, the other for views. however, to get the list of articles and views,
	-- you get the information from 2 seperate sources.
	-- Tables - <Database Name>.dbo.sysarticles
	-- Views - SELECT Name FROM sys.views WHERE is_schema_published = 1 ORDER BY Name --WHERE is_replicated = 1 
	-- 3. Store all publications and subscriptions for specified database
	-- Select * From SysPublications -- Lists all publications
	

	-- Drop Subscription
	DECLARE @publication AS sysname;
	DECLARE @subscriber AS sysname;
	SET @publication = N'CITRUS_Replication';
	SET @subscriber = @@SERVERNAME

	USE [HZN_CITRUS]
	EXEC sp_dropsubscription 
	  @publication = @publication, 
	  @article = N'all',
	  @subscriber = @subscriber;

	-- Drop Publication
	DECLARE @publicationDB AS sysname;
	SET @publicationDB = N'HZN_CITRUS'; 

	-- Remove a transactional publication.
	--USE [HZN_CITRUS]
	EXEC sp_droppublication @publication = @publication;

	-- Remove replication objects from the database.
	USE [master]
	EXEC sp_replicationdboption 
	  @dbname = @publicationDB, 
	  @optname = N'publish', 
	  @value = N'false';
	GO















	-------------------------------------------------

	-- This script uses sqlcmd scripting variables. They are in the form
	-- $(MyVariable). For information about how to use scripting variables  
	-- on the command line and in SQL Server Management Studio, see the 
	-- "Executing Replication Scripts" section in the topic
	-- "Programming Replication Using System Stored Procedures".

	-- This batch is executed at the Publisher to remove 
	-- a pull or push subscription to a transactional publication.
	--DECLARE @publication AS sysname;
	--DECLARE @subscriber AS sysname;
	--SET @publication = N'AdvWorksProductTran';
	--SET @subscriber = $(SubServer);

	--USE [AdventureWorks2008R2;]
	--EXEC sp_dropsubscription 
	--  @publication = @publication, 
	--  @article = N'all',
	--  @subscriber = @subscriber;
	--GO














	---------------------------------------
	-- Remove replication objects from the subscription database on MYSUB.
	DECLARE @subscriptionDB AS sysname
	SET @subscriptionDB = N'AdventureWorks2012Replica'

	-- Remove replication objects from a subscription database (if necessary).
	USE master
	EXEC sp_removedbreplication @subscriptionDB
	GO

	---------------------------------------------------------------------------------

	


	CREATE TABLE [dbo].[tbl_StoreTablesForReplication](
		[DatabaseName] [nvarchar](255) NOT NULL,
		[Replication_Name] [nvarchar](255) NOT NULL,
		[TableName] [nvarchar](255) NULL,
		Replication_Type INT, -- 1 = Tables 2 = SPs,Views and so on
		[Filter] [nvarchar](3000) NULL
	) ON [PRIMARY]

	GO


--SELECT * FROM HostedMaintenance.[dbo].[tbl_StoreTablesForReplication] 
	
*/ --Main End


