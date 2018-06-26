
SET NOCOUNT ON;

-- Testing Start
DECLARE @DBName NVARCHAR(255)

SET @DBName = 'HZN_CITRUS'
-- Testing End

DECLARE @SQL1 NVARCHAR(4000),
		@PublcationName NVARCHAR(255),
		@ServerName NVARCHAR(255),
		@ID INT,
		@LoginName NVARCHAR(255),
		@TableName NVARCHAR(255),
		@Filter NVARCHAR(3000)

------------------------------------------------------------------------------------------
-- I have a feeling that xp_cmdshell may need to be enabled when this is done for real
------------------------------------------------------------------------------------------

-- Eventually, @Table1 data will be added to the tbl_DBUpdater table. I have a feeling a few more columns will be added during the building of the script
DECLARE @Table1 TABLE
(
	ID INT IDENTITY(1,1),
	ServerName NVARCHAR(255),
	DatabaseName NVARCHAR(255),
	PublicationName NVARCHAR(255)
-- Add destination database
-- add desctination server name 
)

INSERT INTO @Table1 (ServerName,DatabaseName,PublicationName)
VALUES ('UKCB-ANDYG','HZN_CITRUS','CITRUS_Replication')
--VALUES ('ECIC-SQL04','HZN_CITRUS','CITRUS_Replication') -- for use in live and will need to be picked up from the HostedMaintenance.[dbo].[tbl_StoreTablesForReplication] table

-- this will require a second table creating to store this information
DECLARE @Table2 TABLE
(
	ID INT,
	LoginName NVARCHAR(255)
)
-- commented out a few for local testing
INSERT INTO @Table2 (ID,LoginName) VALUES(1,'sa')
--INSERT INTO @Table2 (ID,LoginName) VALUES(1,'NT AUTHORITY\SYSTEM')
--INSERT INTO @Table2 (ID,LoginName) VALUES(1,'ECICLOUD\Domain Admins')
--INSERT INTO @Table2 (ID,LoginName) VALUES(1,'ECICLOUD\andrew.gazdowicz')
--INSERT INTO @Table2 (ID,LoginName) VALUES(1,'ECICLOUD\tony.adams')
--INSERT INTO @Table2 (ID,LoginName) VALUES(1,'ECICLOUD\andrew.dams')
--INSERT INTO @Table2 (ID,LoginName) VALUES(1,'ECICLOUD\eci staff admins')
INSERT INTO @Table2 (ID,LoginName) VALUES(1,'NT SERVICE\Winmgmt')
INSERT INTO @Table2 (ID,LoginName) VALUES(1,'NT SERVICE\SQLWriter')
--INSERT INTO @Table2 (ID,LoginName) VALUES(1,'NT Service\MSSQLSERVER')
INSERT INTO @Table2 (ID,LoginName) VALUES(1,'distributor_admin')
--INSERT INTO @Table2 (ID,LoginName) VALUES(1,'Horizon')
--INSERT INTO @Table2 (ID,LoginName) VALUES(1,'AWHouse_Horizon')

-- this will be another table that is gathered from select * from sysarticles ORDER BY dest_table in the Source Database
-- HostedMaintenance.[dbo].[tbl_StoreTablesForReplication] 
DECLARE @Table4 TABLE
(
	ID INT,
	TableName NVARCHAR(255),
	Filter NVARCHAR(3000),
	Completed INT DEFAULT(0)
)
INSERT INTO @Table4 (ID,TableName,Filter) 
SELECT 
	1 AS ID,
	REPLACE(PublisherTableName,'dbo.','') AS TableName,
	CASE WHEN Filter_clause IS NULL THEN NULL ELSE Filter_clause END AS Filter
FROM HostedMaintenance.[dbo].[tbl_StoreTablesForReplication] 

--INSERT INTO @Table4 (ID,TableName,Filter,Completed) VALUES(1,'CATALOGUE',NULL,0)
--INSERT INTO @Table4 (ID,TableName,Filter,Completed) VALUES(1,'CONSUMABLES',NULL,0)
--INSERT INTO @Table4 (ID,TableName,Filter,Completed) VALUES(1,'CONTACT',NULL,0)
--INSERT INTO @Table4 (ID,TableName,Filter,Completed) VALUES(1,'DEALS',NULL,0)
--INSERT INTO @Table4 (ID,TableName,Filter,Completed) VALUES(1,'DEPARTMENT',NULL,0)
--INSERT INTO @Table4 (ID,TableName,Filter,Completed) VALUES(1,'DETAIL','DETAIL.ENTRY_ID IN (SELECT ENTRY.ENTRY_ID FROM ENTRY WHERE ENTRY.DAYBOOK_ID IN (100,130,140))',0)
--INSERT INTO @Table4 (ID,TableName,Filter,Completed) VALUES(1,'ENTRY','[DAYBOOK_ID] in (100,130,140)',0)
--INSERT INTO @Table4 (ID,TableName,Filter,Completed) VALUES(1,'EXTRA',NULL,0)
--INSERT INTO @Table4 (ID,TableName,Filter,Completed) VALUES(1,'GROUP_DEFS',NULL,0)
--INSERT INTO @Table4 (ID,TableName,Filter,Completed) VALUES(1,'GROUP_LINKS',NULL,0)
--INSERT INTO @Table4 (ID,TableName,Filter,Completed) VALUES(1,'ITEM',NULL,0)
--INSERT INTO @Table4 (ID,TableName,Filter,Completed) VALUES(1,'LOOKUP',NULL,0)
--INSERT INTO @Table4 (ID,TableName,Filter,Completed) VALUES(1,'PROCESS_TYPE',NULL,0)
--INSERT INTO @Table4 (ID,TableName,Filter,Completed) VALUES(1,'PRODUCT',NULL,0)
--INSERT INTO @Table4 (ID,TableName,Filter,Completed) VALUES(1,'PRODUCT_GROUP',NULL,0)
--INSERT INTO @Table4 (ID,TableName,Filter,Completed) VALUES(1,'PRODUCT_RANGE',NULL,0)
--INSERT INTO @Table4 (ID,TableName,Filter,Completed) VALUES(1,'PRODUCT_SECTOR',NULL,0)
--INSERT INTO @Table4 (ID,TableName,Filter,Completed) VALUES(1,'PRODUCT_SUBGROUP',NULL,0)
--INSERT INTO @Table4 (ID,TableName,Filter,Completed) VALUES(1,'STOCK',NULL,0)
--INSERT INTO @Table4 (ID,TableName,Filter,Completed) VALUES(1,'TRADER',NULL,0)
--INSERT INTO @Table4 (ID,TableName,Filter,Completed) VALUES(1,'VAT_RATE',NULL,0)

-----------------
-- Create replication option and log reader agent

SET @SQL1 = ''

SET @SQL1 = '
USE master;
EXEC sp_replicationdboption @dbname = N''' + @DBName + '''
                           ,@optname = N''publish''
                           ,@value = N''true'';
						   '
PRINT @SQL1
EXEC sp_executesql @SQL1

SET @SQL1 = ''

SET @SQL1 = '
EXEC [' + @DBName + '].sys.sp_addlogreader_agent @job_login = NULL
                                           ,@job_password = NULL
                                           ,@publisher_security_mode = 1;
'
PRINT @SQL1
EXEC sp_executesql @SQL1


-----------------
-- Create Publication

SELECT 
@ServerName = t1.ServerName,
@PublcationName = t1.PublicationName
FROM @Table1 t1
WHERE t1.DatabaseName = @DBName

SET @SQL1 = ''

SET @SQL1 = '
USE ' + @DBName + '
EXEC sp_addpublication @publication = ''' + @PublcationName + '''
                      ,@description = N''Transactional publication of database ''''' + @DBName + ''''' from Publisher ''''' + @ServerName + '''''.''
                      ,@sync_method = N''concurrent''
                      ,@retention = 0
                      ,@allow_push = N''true''
                      ,@allow_pull = N''true''
                      ,@allow_anonymous = N''true''
                      ,@enabled_for_internet = N''false''
                      ,@snapshot_in_defaultfolder = N''true''
                      ,@compress_snapshot = N''false''
                      ,@ftp_port = 21
                      ,@ftp_login = N''anonymous''
                      ,@allow_subscription_copy = N''false''
                      ,@add_to_active_directory = N''false''
                      ,@repl_freq = N''continuous''
                      ,@status = N''active''
                      ,@independent_agent = N''true''
                      ,@immediate_sync = N''true''
                      ,@allow_sync_tran = N''false''
                      ,@autogen_sync_procs = N''false''
                      ,@allow_queued_tran = N''false''
                      ,@allow_dts = N''false''
                      ,@replicate_ddl = 1
                      ,@allow_initialize_from_backup = N''false''
                      ,@enabled_for_p2p = N''false''
                      ,@enabled_for_het_sub = N''false'';

'

PRINT @SQL1
EXEC sp_executesql @SQL1

------------------
-- Create publication snapshot

SET @SQL1 = ''

SET @SQL1 = 'EXEC sp_addpublication_snapshot @publication = ''' + @PublcationName + '''
                               ,@frequency_type = 1
                               ,@frequency_interval = 0
                               ,@frequency_relative_interval = 0
                               ,@frequency_recurrence_factor = 0
                               ,@frequency_subday = 0
                               ,@frequency_subday_interval = 0
                               ,@active_start_time_of_day = 0
                               ,@active_end_time_of_day = 235959
                               ,@active_start_date = 0
                               ,@active_end_date = 0
                               ,@job_login = NULL
                               ,@job_password = NULL
                               ,@publisher_security_mode = 1;

'

PRINT @SQL1
EXEC sp_executesql @SQL1

---------------------
-- Create publication access

DECLARE @Table3 TABLE
(
	ID INT,
	LoginName NVARCHAR(255),
	PublicationName NVARCHAR(255),
	Completed INT DEFAULT(0)
)
INSERT INTO @Table3 (ID,LoginName,PublicationName,Completed)
SELECT
	t1.ID,
	t2.LoginName,
	t1.PublicationName,
	0 AS Completed
FROM @Table1 t1
LEFT OUTER JOIN @Table2 t2 ON t2.ID = t2.ID
WHERE t1.DatabaseName = @DBName

SET @SQL1 = ''

WHILE EXISTS(SELECT TOP 1 LoginName FROM @Table3 WHERE Completed = 0)
BEGIN
	SELECT TOP 1 @ID = t3.ID,
				 @LoginName = t3.LoginName
	FROM @Table3 t3
	WHERE t3.Completed = 0
				 
	SET @SQL1 = 'EXEC sp_grant_publication_access @publication =  N''' + @PublcationName + ''',@login = N''' + @LoginName + ''';'

	PRINT @SQL1
EXEC sp_executesql @SQL1

	UPDATE @Table3
	SET Completed = 1
	WHERE ID = @ID
	AND LoginName = @LoginName

END

------------------------
-- Create Articles

SET @SQL1 = ''

WHILE EXISTS(SELECT TOP 1 TableName FROM @Table4 WHERE Completed = 0)
BEGIN
	SELECT TOP 1 
		@TableName = TableName,
		@Filter = Filter
	FROM @Table4
	WHERE Completed = 0

	SET @SQL1 = '
	EXEC sp_addarticle @publication = N''' + @PublcationName + '''
                  ,@article = N''' + @TableName + '''
                  ,@source_owner = N''dbo''
                  ,@source_object = N''' + @TableName + '''
                  ,@type = N''logbased''
                  ,@description = N''''
                  ,@creation_script = N''''
                  ,@pre_creation_cmd = N''drop''
                  ,@schema_option = 0x000000000803509F
                  ,@identityrangemanagementoption = N''manual''
                  ,@destination_table = N''' + @TableName + '''
                  ,@destination_owner = N''dbo''
                  ,@status = 24
                  ,@vertical_partition = N''false''
                  ,@ins_cmd = N''CALL [sp_MSins_dboDETAIL]''
                  ,@del_cmd = N''CALL [sp_MSdel_dboDETAIL]''
                  ,@upd_cmd = N''SCALL [sp_MSupd_dboDETAIL]''
	'
	IF @Filter IS NOT NULL
		SET @SQL1 += '			  ,@filter_clause = N''' + @Filter + ''''

PRINT @SQL1
EXEC sp_executesql @SQL1

	IF @Filter IS NOT NULL
	BEGIN
		DECLARE @FilterName NVARCHAR(255)
		SET @FilterName = @TableName + '_' + REPLACE(CONVERT(NVARCHAR(12),GETDATE(),103),'/','')

		SET @SQL1 = ''

		SET @SQL1 = '
			-- Adding the article filter
			EXEC sp_articlefilter @publication = N''' + @PublcationName + '''
								 ,@article = N''' + @TableName + '''
--								 ,@filter_name = N''FLTR_DETAIL_1__134''
								 ,@filter_name = N''FLTR_' + @FilterName + '''
								 ,@filter_clause = N''' + @Filter + '''
								 ,@force_invalidate_snapshot = 1
								 ,@force_reinit_subscription = 1;
		
		'
		PRINT @SQL1
		EXEC sp_executesql @SQL1
--	END

--	IF @Filter IS NOT NULL
--	BEGIN
		SET @SQL1 = ''

		SET @SQL1 = '
			-- Adding the article synchronization object
			EXEC sp_articleview @publication = N''' + @PublcationName + '''
							   ,@article = N''' + @TableName + '''
--							   ,@view_name = N''SYNC_DETAIL_1__134''
							   ,@view_name = N''SYNC_' + @FilterName + '''
							   ,@filter_clause = N''' + @Filter + '''
--							   ,@filter_clause = N''' + @TableName + ''' -- wrong
							   ,@force_invalidate_snapshot = 1
							   ,@force_reinit_subscription = 1;

		'
		PRINT @SQL1
		EXEC sp_executesql @SQL1
	END


	UPDATE @Table4
	SET Completed = 1
	WHERE TableName = @TableName

END

-------------------------------------
-- Create Subscription
-- Adding the transactional subscriptions

SET @SQL1 = ''

SET @SQL1 = '
EXEC sp_addsubscription @publication = N''' + @PublcationName + '''
                       ,@subscriber = N''UKCB-ANDYG'' -- this needs to be stored in tbl_DBUpdater
                       ,@destination_db = N''HZN_CITRUS_Repl'' -- this needs to be stored in tbl_DBUpdater
                       ,@subscription_type = N''Push''
                       ,@sync_type = N''automatic''
                       ,@article = N''all''
                       ,@update_mode = N''read only''
                       ,@subscriber_type = 0;
					   '
PRINT @SQL1
EXEC sp_executesql @SQL1

---------------------------
-- Create subscription agent
SET @SQL1 = ''

-- replication for local build
SET @SQL1 = '
exec sp_addpushsubscription_agent @publication = N''' + @PublcationName + '''
                                 ,@subscriber = N''UKCB-ANDYG'' -- this needs to be stored in tbl_DBUpdater
                                 ,@subscriber_db = N''HZN_CITRUS_Repl'' -- this needs to be stored in tbl_DBUpdater
								 ,@job_login = null
								 ,@job_password = null
								 ,@subscriber_security_mode = 1
								 ,@frequency_type = 64
								 ,@frequency_interval = 1
								 ,@frequency_relative_interval = 1
								 ,@frequency_recurrence_factor = 0
								 ,@frequency_subday = 4
								 ,@frequency_subday_interval = 5
								 ,@active_start_time_of_day = 0
								 ,@active_end_time_of_day = 235959
								 ,@active_start_date = 0
								 ,@active_end_date = 0
								 ,@dts_package_location = N''Distributor'';
'
-- replication for remote build. will need connection details.
--SET @SQL1 = '
--EXEC sp_addpushsubscription_agent @publication = N''' + @PublcationName + '''
--                                 ,@subscriber = N''UKCB-ANDYG'' -- this needs to be stored in tbl_DBUpdater
--                                 ,@subscriber_db = N''HZN_CITRUS_Repl'' -- this needs to be stored in tbl_DBUpdater
--                                 ,@job_login = NULL
--                                 ,@job_password = NULL
--                                 ,@subscriber_security_mode = 0
--                                 ,@subscriber_login = N''citrus'' -- this needs to be stored in tbl_DBUpdater
--                                 ,@subscriber_password = NULL -- this needs to be stored in tbl_DBUpdater
--                                 ,@frequency_type = 64
--                                 ,@frequency_interval = 1
--                                 ,@frequency_relative_interval = 1
--                                 ,@frequency_recurrence_factor = 0
--                                 ,@frequency_subday = 4
--                                 ,@frequency_subday_interval = 5
--                                 ,@active_start_time_of_day = 0
--                                 ,@active_end_time_of_day = 235959
--                                 ,@active_start_date = 0
--                                 ,@active_end_date = 0
--                                 ,@dts_package_location = N''Distributor'';
--								 '
PRINT @SQL1
EXEC sp_executesql @SQL1

-- Annnnnnnnnnnnnnnnd Done

-- Adding the transactional subscriptions
--use [HZN_CITRUS]
--exec sp_addsubscription @publication = N'CITRUS_Replication', @subscriber = N'UKCB-ANDYG', @destination_db = N'HZN_CITRUS_Repl', @subscription_type = N'Push', @sync_type = N'automatic', @article = N'all', @update_mode = N'read only', @subscriber_type = 0
--exec sp_addpushsubscription_agent @publication = N'CITRUS_Replication', @subscriber = N'UKCB-ANDYG', @subscriber_db = N'HZN_CITRUS_Repl', @job_login = null, @job_password = null, @subscriber_security_mode = 1, @frequency_type = 64, @frequency_interval = 1, @frequency_relative_interval = 1, @frequency_recurrence_factor = 0, @frequency_subday = 4, @frequency_subday_interval = 5, @active_start_time_of_day = 0, @active_end_time_of_day = 235959, @active_start_date = 0, @active_end_date = 0, @dts_package_location = N'Distributor'
--GO
