DECLARE @JOB_NAME SYSNAME = N'%HZN_CITRUS%'; 
 
IF NOT EXISTS(     
        select 1 
        from msdb.dbo.sysjobs_view job  
        inner join msdb.dbo.sysjobactivity activity on job.job_id = activity.job_id 
        where  
            activity.run_Requested_date is not null  
        and activity.stop_execution_date is null  
        and job.name = @JOB_NAME 
		and category_id IN (10,13,15)
        ) 
BEGIN      
    PRINT 'Starting job ''' + @JOB_NAME + ''''; 
--    EXEC msdb.dbo.sp_start_job @JOB_NAME; 
END 
ELSE 
BEGIN 
    PRINT 'Job ''' + @JOB_NAME + ''' is already started '; 
END 


/*

SELECT sj.name AS [JobName], [enabled], sj.category_id,
sc.name AS [CategoryName]
FROM msdb.dbo.sysjobs AS sj
INNER JOIN msdb.dbo.syscategories AS sc
ON sj.category_id = sc.category_id
ORDER BY sj.name;

*/