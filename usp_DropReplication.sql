/*
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
*/
CREATE PROCEDURE dbo.usp_DropRe

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

