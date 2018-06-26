--CREATE PROCEDURE usp_StopStartSQLAgentJob

--@DBName NVARCHAR(255),
--@StartStop INT -- 0 = Stop, 1 = Start, 2 = Start first time (all three)

--AS

---------------------------------------------------------------------------------------------------------------------------------------
--
-- Description :	Step nn - SP to identify the replication SQL Agents and either Start them or Stop them as necessary
--
-- Author :			Andy G
--
-- Created :		22/06/2018
--
-- History :
--
---------------------------------------------------------------------------------------------------------------------------------------


--BEGIN

SET NOCOUNT ON
--set transaction isolation level read uncommitted 

/*
Make sure your agents are in the correct category 
i.e Merge agents under REPL-Merge, 
Distribution agents under REPL-Distribution 
and LogReader agent under REPL-LogReader
*/

-- testing start

DECLARE @DBName NVARCHAR(255),
		@StartStop INT -- 0 = Stop, 1 = Start, 2 = Start first time (all three)

SET @DBName = 'HZN_CITRUS'
SET @StartStop = 0

-- testing end

DECLARE 
	@ReturnCode tinyint, -- 0 (success) or 1 (failure)
	@JobName NVARCHAR(255)

SELECT 
	s.job_id,
	s.name,
	s.enabled,
	c.name AS categoryname 
INTO #JobList 
FROM msdb.dbo.sysjobs s 
INNER JOIN msdb.dbo.syscategories c ON s.category_id = c.category_id
WHERE c.name IN ('REPL-Snapshot','REPL-Distribution','REPL-LogReader') --REPL-Merge
AND s.name LIKE '%' + @DBName + '%'
--REPL-LogReader
--REPL-Snapshot
--REPL-Distribution

CREATE TABLE #xp_results  
   (job_id                UNIQUEIDENTIFIER NOT NULL,
    last_run_date         INT              NOT NULL,
    last_run_time         INT              NOT NULL,
    next_run_date         INT              NOT NULL,
    next_run_time         INT              NOT NULL,
    next_run_schedule_id  INT              NOT NULL,
    requested_to_run      INT              NOT NULL, 
    request_source        INT              NOT NULL,
    request_source_id     sysname          COLLATE database_default NULL,
    running               INT              NOT NULL,
    current_step          INT              NOT NULL,
    current_retry_attempt INT              NOT NULL,
    job_state             INT              NOT NULL)

INSERT INTO #xp_results 
EXEC master.dbo.xp_sqlagent_enum_jobs 1, ''

/*
SELECT 
j.name,
j.categoryname,
j.enabled, 
AgentStatus = CASE WHEN r.running =1 THEN 'Running' else 'Stopped' END
,msdb.dbo.agent_datetime(last_run_date, last_run_time) AS LastRunDateTime
--,job_state
, CASE WHEN job_state = 1 THEN 'Executing.'
	   WHEN job_state = 2 THEN 'Waiting for thread.'
	   WHEN job_state = 3 THEN 'Between retries.'
	   WHEN job_state = 4 THEN 'Idle.'
	   WHEN job_state = 5 THEN 'Suspended.'
	   WHEN job_state = 6 THEN 'Performing completion actions'
	   ELSE 'Error' END AS job_state
FROM #JobList j 
INNER JOIN #xp_results r ON j.job_id=r.job_id
*/

DECLARE @Table1 TABLE
(
	Job_Name NVARCHAR(255),
	Category_Name NVARCHAR(255),
	job_state INT,
	Completed INT DEFAULT(0)
)
INSERT INTO @Table1 (Job_Name,Category_Name,job_state)
SELECT 
j.name,
j.categoryname AS Category_Name,
job_state
FROM #JobList j 
INNER JOIN #xp_results r ON j.job_id=r.job_id

--END

IF @StartStop = 0
BEGIN
	WHILE EXISTS (SELECT TOP 1 Job_Name FROM @Table1 WHERE Completed = 0 AND job_state <> 4)
	BEGIN
		SELECT TOP 1 
			@JobName = Job_Name 
		FROM @Table1 
		WHERE Completed = 0
		AND job_state <> 4

 		EXEC @ReturnCode=msdb.dbo.sp_stop_job @job_name=@JobName;

		UPDATE @Table1
		SET Completed = 1
		WHERE Job_Name = @JobName
	END
END

IF @StartStop = 1
BEGIN
	WHILE EXISTS (SELECT TOP 1 Job_Name FROM @Table1 WHERE Completed = 0 AND job_state = 4)
	BEGIN
		SELECT TOP 1 
			@JobName = Job_Name 
		FROM @Table1 
		WHERE Completed = 0
		AND job_state = 4

 		EXEC @ReturnCode=msdb.dbo.sp_start_job @job_name=@JobName;

		UPDATE @Table1
		SET Completed = 1
		WHERE Job_Name = @JobName
	END
END

IF @StartStop = 2
BEGIN
	WHILE EXISTS (SELECT TOP 1 Job_Name FROM @Table1 WHERE Completed = 0 AND Category_Name <> 'REPL-Snapshot' AND job_state = 4)
	BEGIN
		SELECT TOP 1 
			@JobName = Job_Name 
		FROM @Table1 
		WHERE Completed = 0
		AND Category_Name <> 'REPL-Snapshot'
		AND job_state = 4

 		EXEC @ReturnCode=msdb.dbo.sp_start_job @job_name=@JobName;

		UPDATE @Table1
		SET Completed = 1
		WHERE Job_Name = @JobName
	END
END











-- Last Step
DROP TABLE #JobList,#xp_results



-- 	EXEC @ReturnCode=msdb.dbo.sp_stop_job @job_name=@JobName;
/*

	0 Returns only those jobs that are not idle or suspended.  
		1 Executing. 
		2 Waiting for thread. 
		3 Between retries. 
		4 Idle. 
		5 Suspended. 
		7 Performing completion actions 
*/
