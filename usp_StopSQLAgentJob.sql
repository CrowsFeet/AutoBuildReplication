USE HostedMaintenance
GO

CREATE PROCEDURE dbo.usp_StopSQLAgentJob

@DBName NVARCHAR(255)

AS

------------------------------------------------------------------------------------------------------------------------------------------------------------
--
-- Description :	Step nn - SP that identifies the replication SQL Agent jobs and stops them
--
-- Author :			Andy G
--
-- Created :		21/06/2018
--
-- History :
--
------------------------------------------------------------------------------------------------------------------------------------------------------------

SET NOCOUNT ON;

DECLARE --@DBName NVARCHAR(255),
		@JobName NVARCHAR(255)

--SET @DBName = 'HZN_CITRUS'

DECLARE @Table1 TABLE
(
	Job_id NVARCHAR(50),
	Job_Name NVARCHAR(255),
	Completed INT DEFAULT(0)
)
INSERT INTO @Table1 (Job_id,Job_Name)
SELECT job_id,name as Job_Name FROM msdb..sysjobs sj
WHERE 
--sj.date_created >= CONVERT(DATETIME,CONVERT(NVARCHAR(12),GETDATE()))
--   AND 
sj.name LIKE '%' + @DBName + '%'

/*
SELECT TOP 1 @JobName =	t1.Job_Name
--	,sj.name
--, CASE WHEN sja.run_requested_date IS NOT NULL THEN 'Job Running' ELSE 'Job Not Running' END AS Job_Status
--   , sja.*
FROM @Table1 t1
INNER JOIN msdb.dbo.sysjobactivity AS sja ON sja.job_id = t1.Job_id
INNER JOIN msdb.dbo.sysjobs AS sj ON sja.job_id = sj.job_id
WHERE 
sja.run_requested_date IS NULL 
--sja.start_execution_date IS NOT NULL
--   AND sja.stop_execution_date IS NULL
--   AND 
AND sj.name LIKE '%' + @DBName + '%'
*/

DECLARE @ReturnCode tinyint -- 0 (success) or 1 (failure)
--EXEC @ReturnCode=msdb.dbo.sp_start_job @job_name=@MyJobName;
--RETURN (@ReturnCode)

WHILE EXISTS (SELECT TOP 1 * FROM @Table1 WHERE Completed = 0)
BEGIN
--EXEC master.dbo.sp_start_job N'Weekly Sales Data Backup' ;  
	SELECT TOP 1 @JobName = Job_Name
	FROM @Table1 WHERE Completed = 0

	--EXEC msdb.dbo.sp_start_job @JobName;
	EXEC @ReturnCode=msdb.dbo.sp_start_job @job_name=@JobName;

	UPDATE @Table1
	SET Completed = 1
	WHERE Job_Name = @JobName

END  

/*


--SELECT * FROM @Table1

--SELECT * 
--FROM msdb..sysjobsteps sjs
--WHERE sjs.job_id IN (
--SELECT job_id FROM msdb..sysjobs
--WHERE date_created >= CONVERT(DATETIME,CONVERT(NVARCHAR(12),GETDATE()))) 

--DECLARE @DBName NVARCHAR(255)
--SET @DBName = 'HZN_CITRUS'


*/