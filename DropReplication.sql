-- Step - 1 Drop Subscription
SET NOCOUNT ON

-- Testing
DECLARE @DBName NVARCHAR(255)
SET @DBName = '<Add_DB_Name_Here>'

DECLARE @PublicationName NVARCHAR(255),
		@PublisherDB NVARCHAR(255),
		@SubscriberServerName NVARCHAR(255),
		@SQL1 NVARCHAR(4000)

SELECT TOP 1
	@PublicationName = PublisherName,
	@PublisherDB = PublisherDB,
	@SubscriberServerName = SubscriberServer
FROM HostedMaintenance.[dbo].[tbl_StoreTablesForReplication] 
WHERE PublisherDB = @DBName


DECLARE @publication sysname,
		@subscriber sysname

SET @publication = @PublicationName --'<Add_DB_Name_Here>_Replication'
SET @subscriber = @SubscriberServerName --'<Add_Subscriber_DB_Name_Here>'

SET @SQL1 = '
USE '  + @DBName + ' -- <Add_DB_Name_Here>
EXEC sp_dropsubscription 
  @publication = ''' + @publication + ''', 
  @article = N''all'',
  @subscriber = ''' + @subscriber +''';'

EXEC sp_executeSQL @SQL1

--DECLARE @publicationDB AS sysname;
--DECLARE @publication AS sysname;

--SET @publicationDB = N'<Add_DB_Name_Here>'; 
--SET @publication = N'<Add_DB_Name_Here>_Replication'; 

SET @SQL1 = ''

SET @SQL1 = '
DECLARE @publicationDB AS sysname;
DECLARE @publication AS sysname;

SET @publicationDB = ''' + @PublisherDB + ''' 
SET @publication = ''' + @PublicationName + ''' 

-- Remove a transactional publication.
USE ' + @DBName  + ' --<Add_DB_Name_Here>
EXEC sp_droppublication @publication = @publication;
'

EXEC sp_executeSQL @SQL1

SET @SQL1 = ''

-- Remove replication objects from the database.
USE [master]
EXEC sp_replicationdboption 
  @dbname = @DBName, -- @publicationDB, 
  @optname = N'publish', 
  @value = N'false';
GO

