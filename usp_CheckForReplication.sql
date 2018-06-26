--USE HostedMaintenance
--GO
--ALTER PROCEDURE dbo.usp_CheckForReplication

--@DBName NVARCHAR(255)

--AS

----------------------------------------------------------------------------------------------------
--
-- Description :	Step 1 - Check if a database is marked for replication
--
-- Author :			Andy G
--
-- Created :		26/07/2017
--
-- History :	
--
----------------------------------------------------------------------------------------------------

SET NOCOUNT ON;

-- Testing Start
DECLARE @DBName NVARCHAR(255)

SET @DBName = 'HZN_CITRUS'

-- Testing End

--DECLARE @SQL1 NVARCHAR(4000)

--DECLARE @Table1 TABLE
--(
--	ReplicationCount INT
--)


--SET @SQL1 = '
--SELECT COUNT(*) AS CountOfReplicatedDBs FROM sys.databases 
--WHERE (is_published=1 or is_subscribed=1 or is_merge_published=1)
--AND name = ''' + @DBName + '''
--'

--PRINT @SQL1

--INSERT INTO @Table1 EXEC sp_executesql @SQL1

--IF EXISTS(SELECT * FROM @Table1 WHERE ReplicationCount >0)
--	Print 'yay'

--INSERT INTO @Table1 (ReplicationCount)
SELECT COUNT(*) AS ReplicationCount FROM sys.databases 
WHERE (is_published=1 or is_subscribed=1 or is_merge_published=1)
AND name = '' + @DBName + ''


--SELECT ReplicationCount
--FROM @Table1


