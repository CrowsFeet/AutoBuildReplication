--Select your publication database
USE Adventureworks2012
GO

DECLARE @publication AS sysname;
DECLARE @subscriber AS sysname;

--enter your publication name
SET @publication = N'AdventureWorksPub';

--enter subscriber name
SET @subscriber = N'AdventureWorksSub';

USE [AdventureWorks2012]

EXEC sp_dropsubscription
@publication = @publication,
@article = N'all',
@subscriber = @subscriber
,@ignore_distributor=1;
GO

/*
--Here is the script to remove publisher forcefully.
DECLARE @publicationDB AS sysname;
DECLARE @publication AS sysname;

--set your publication database here
SET @publicationDB = N'AdventureWorks2012';

--set your publication name here
SET @publication = N'AdventureWorksPub';

-- Remove a transactional publication.
USE [AdventureWorks2012]

EXEC sp_droppublication
@publication = @publication
,@ignore_distributor=1;

-- Remove replication objects from the database.
USE [master]

EXEC sp_replicationdboption
@dbname = @publicationDB,
@optname = N'publish',
@value = N'false';
GO

--If Distributor database available and you wanted to remove it forcefully, have a look at following script:

--execute following command on distributor server

USE master
GO

EXEC sp_dropdistributor @no_checks = 1, @ignore_distributor = 1
GO
*/

