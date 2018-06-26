USE HostedMaintenance
GO

------------------------------------------------------------------------------------------------------------------------------------------------------
-- OBSOLETE. I THINK
------------------------------------------------------------------------------------------------------------------------------------------------------



--ALTER PROCEDURE dbo.usp_GetReplicationTables

--@DBName NVARCHAR(255)

--AS

----------------------------------------------------------------------------------------------------
--
-- Description :	Gather specific table that are being replicated and store them so that
--					usp_CreateReplication can retrieve them and generate the publication once
--					the updater tool has completed updating the database
--
-- Author :			Andy G
--
-- Created :		26/07/2017
--
-- History :	
--
----------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------
-- This has to run on the source server and against the source DB
----------------------------------------------------------------------------------------------------


SET NOCOUNT ON;

-- Testing Start
DECLARE @DBName NVARCHAR(255)

SET @DBName = 'HZN_CITRUS'
-- Testing End

DECLARE @SQL1 NVARCHAR(4000)

SET @SQL1 = ''

SET @SQL1 = '
INSERT INTO HostedMaintenance.dbo.tbl_StoreTablesForReplication (DatabaseName,Replication_Name,TableName,Filter)
SELECT 
	''' + @DBName + ''' AS DatabaseName,
	Replication_Name,
	dest_table AS TableName,
	filter_Clause AS Filter
FROM [' + @DBName + '].dbo.sysarticles;'

PRINT @SQL1





--Select * From msdb..SysPublications -- Lists all publications
