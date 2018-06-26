-- Enabling the replication database
USE master;
EXEC sp_replicationdboption @dbname = N'HZN_QUALITY', @optname = N'publish',
    @value = N'true';
GO

EXEC [HZN_QUALITY].sys.sp_addlogreader_agent @job_login = NULL,
    @job_password = NULL, @publisher_security_mode = 1;
GO
-- Adding the transactional publication
USE [HZN_QUALITY];
EXEC sp_addpublication @publication = N'QUALITY_Repl',
    @description = N'Transactional publication of database ''HZN_QUALITY'' from Publisher ''ECIC-SQL07''.',
    @sync_method = N'concurrent', @retention = 0, @allow_push = N'true',
    @allow_pull = N'true', @allow_anonymous = N'true',
    @enabled_for_internet = N'false', @snapshot_in_defaultfolder = N'true',
    @compress_snapshot = N'false', @ftp_port = 21, @ftp_login = N'anonymous',
    @allow_subscription_copy = N'false', @add_to_active_directory = N'false',
    @repl_freq = N'continuous', @status = N'active',
    @independent_agent = N'true', @immediate_sync = N'true',
    @allow_sync_tran = N'false', @autogen_sync_procs = N'false',
    @allow_queued_tran = N'false', @allow_dts = N'false', @replicate_ddl = 1,
    @allow_initialize_from_backup = N'false', @enabled_for_p2p = N'false',
    @enabled_for_het_sub = N'false';
GO


EXEC sp_addpublication_snapshot @publication = N'QUALITY_Repl',
    @frequency_type = 1, @frequency_interval = 0,
    @frequency_relative_interval = 0, @frequency_recurrence_factor = 0,
    @frequency_subday = 0, @frequency_subday_interval = 0,
    @active_start_time_of_day = 0, @active_end_time_of_day = 235959,
    @active_start_date = 0, @active_end_date = 0, @job_login = NULL,
    @job_password = NULL, @publisher_security_mode = 1;
EXEC sp_grant_publication_access @publication = N'QUALITY_Repl',
    @login = N'sa';
GO
EXEC sp_grant_publication_access @publication = N'QUALITY_Repl',
    @login = N'ECICLOUD\Domain Admins';
GO
EXEC sp_grant_publication_access @publication = N'QUALITY_Repl',
    @login = N'ECICLOUD\Mark.Barnes';
GO
EXEC sp_grant_publication_access @publication = N'QUALITY_Repl',
    @login = N'ECICLOUD\mike.rawson';
GO
EXEC sp_grant_publication_access @publication = N'QUALITY_Repl',
    @login = N'ECICLOUD\andrew.gazdowicz';
GO
EXEC sp_grant_publication_access @publication = N'QUALITY_Repl',
    @login = N'ECICLOUD\tony.adams';
GO
EXEC sp_grant_publication_access @publication = N'QUALITY_Repl',
    @login = N'ECICLOUD\oliver.garside';
GO
EXEC sp_grant_publication_access @publication = N'QUALITY_Repl',
    @login = N'ECICLOUD\andrew.dams';
GO
EXEC sp_grant_publication_access @publication = N'QUALITY_Repl',
    @login = N'ECICLOUD\Steve.Kidd';
GO
EXEC sp_grant_publication_access @publication = N'QUALITY_Repl',
    @login = N'ECICLOUD\ECi SQL Admin Users';
GO
EXEC sp_grant_publication_access @publication = N'QUALITY_Repl',
    @login = N'NT SERVICE\Winmgmt';
GO
EXEC sp_grant_publication_access @publication = N'QUALITY_Repl',
    @login = N'NT SERVICE\SQLWriter';
GO
EXEC sp_grant_publication_access @publication = N'QUALITY_Repl',
    @login = N'NT SERVICE\SQLSERVERAGENT';
GO
EXEC sp_grant_publication_access @publication = N'QUALITY_Repl',
    @login = N'NT Service\MSSQLSERVER';
GO
EXEC sp_grant_publication_access @publication = N'QUALITY_Repl',
    @login = N'distributor_admin';
GO
EXEC sp_grant_publication_access @publication = N'QUALITY_Repl',
    @login = N'AGTest';
GO

-- Adding the transactional articles
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl',
    @article = N'ACTION_OUTCOME', @source_owner = N'dbo',
    @source_object = N'ACTION_OUTCOME', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x00000000080350DF, -- 0x000000000803509F
    @identityrangemanagementoption = N'manual',
    @destination_table = N'ACTION_OUTCOME', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboACTION_OUTCOME]',
    @del_cmd = N'CALL [sp_MSdel_dboACTION_OUTCOME]',
    @upd_cmd = N'SCALL [sp_MSupd_dboACTION_OUTCOME]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'ACTION_STAGE',
    @source_owner = N'dbo', @source_object = N'ACTION_STAGE',
    @type = N'logbased', @description = N'', @creation_script = N'',
    @pre_creation_cmd = N'drop', @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'ACTION_STAGE', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboACTION_STAGE]',
    @del_cmd = N'CALL [sp_MSdel_dboACTION_STAGE]',
    @upd_cmd = N'SCALL [sp_MSupd_dboACTION_STAGE]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'ADDRESS',
    @source_owner = N'dbo', @source_object = N'ADDRESS', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'ADDRESS', @destination_owner = N'dbo', @status = 24,
    @vertical_partition = N'false', @ins_cmd = N'CALL [sp_MSins_dboADDRESS]',
    @del_cmd = N'CALL [sp_MSdel_dboADDRESS]',
    @upd_cmd = N'SCALL [sp_MSupd_dboADDRESS]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'ALERT',
    @source_owner = N'dbo', @source_object = N'ALERT', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual', @destination_table = N'ALERT',
    @destination_owner = N'dbo', @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboALERT]',
    @del_cmd = N'CALL [sp_MSdel_dboALERT]',
    @upd_cmd = N'SCALL [sp_MSupd_dboALERT]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'ALLOCATION',
    @source_owner = N'dbo', @source_object = N'ALLOCATION',
    @type = N'logbased', @description = N'', @creation_script = N'',
    @pre_creation_cmd = N'drop', @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'none',
    @destination_table = N'ALLOCATION', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboALLOCATION]',
    @del_cmd = N'CALL [sp_MSdel_dboALLOCATION]',
    @upd_cmd = N'SCALL [sp_MSupd_dboALLOCATION]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'ALLOCATIONS',
    @source_owner = N'dbo', @source_object = N'ALLOCATIONS',
    @type = N'logbased', @description = N'', @creation_script = N'',
    @pre_creation_cmd = N'drop', @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'ALLOCATIONS', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboALLOCATIONS]',
    @del_cmd = N'CALL [sp_MSdel_dboALLOCATIONS]',
    @upd_cmd = N'SCALL [sp_MSupd_dboALLOCATIONS]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'ANALYSIS',
    @source_owner = N'dbo', @source_object = N'ANALYSIS', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'ANALYSIS', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboANALYSIS]',
    @del_cmd = N'CALL [sp_MSdel_dboANALYSIS]',
    @upd_cmd = N'SCALL [sp_MSupd_dboANALYSIS]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'ANALYSIS_DEF',
    @source_owner = N'dbo', @source_object = N'ANALYSIS_DEF',
    @type = N'logbased', @description = N'', @creation_script = N'',
    @pre_creation_cmd = N'drop', @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'none',
    @destination_table = N'ANALYSIS_DEF', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboANALYSIS_DEF]',
    @del_cmd = N'CALL [sp_MSdel_dboANALYSIS_DEF]',
    @upd_cmd = N'SCALL [sp_MSupd_dboANALYSIS_DEF]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'AREA',
    @source_owner = N'dbo', @source_object = N'AREA', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual', @destination_table = N'AREA',
    @destination_owner = N'dbo', @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboAREA]',
    @del_cmd = N'CALL [sp_MSdel_dboAREA]',
    @upd_cmd = N'SCALL [sp_MSupd_dboAREA]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'ATTRIBUTE',
    @source_owner = N'dbo', @source_object = N'ATTRIBUTE', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'ATTRIBUTE', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboATTRIBUTE]',
    @del_cmd = N'CALL [sp_MSdel_dboATTRIBUTE]',
    @upd_cmd = N'SCALL [sp_MSupd_dboATTRIBUTE]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl',
    @article = N'ATTRIBUTE_LIST', @source_owner = N'dbo',
    @source_object = N'ATTRIBUTE_LIST', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'ATTRIBUTE_LIST', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboATTRIBUTE_LIST]',
    @del_cmd = N'CALL [sp_MSdel_dboATTRIBUTE_LIST]',
    @upd_cmd = N'SCALL [sp_MSupd_dboATTRIBUTE_LIST]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl',
    @article = N'ATTRIBUTE_VALUE', @source_owner = N'dbo',
    @source_object = N'ATTRIBUTE_VALUE', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'ATTRIBUTE_VALUE', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboATTRIBUTE_VALUE]',
    @del_cmd = N'CALL [sp_MSdel_dboATTRIBUTE_VALUE]',
    @upd_cmd = N'SCALL [sp_MSupd_dboATTRIBUTE_VALUE]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'AUDIT',
    @source_owner = N'dbo', @source_object = N'AUDIT', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual', @destination_table = N'AUDIT',
    @destination_owner = N'dbo', @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboAUDIT]',
    @del_cmd = N'CALL [sp_MSdel_dboAUDIT]',
    @upd_cmd = N'SCALL [sp_MSupd_dboAUDIT]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'AUTO_DETAIL',
    @source_owner = N'dbo', @source_object = N'AUTO_DETAIL',
    @type = N'logbased', @description = N'', @creation_script = N'',
    @pre_creation_cmd = N'drop', @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'AUTO_DETAIL', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboAUTO_DETAIL]',
    @del_cmd = N'CALL [sp_MSdel_dboAUTO_DETAIL]',
    @upd_cmd = N'SCALL [sp_MSupd_dboAUTO_DETAIL]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'BANK',
    @source_owner = N'dbo', @source_object = N'BANK', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual', @destination_table = N'BANK',
    @destination_owner = N'dbo', @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboBANK]',
    @del_cmd = N'CALL [sp_MSdel_dboBANK]',
    @upd_cmd = N'SCALL [sp_MSupd_dboBANK]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'BANK_METHOD',
    @source_owner = N'dbo', @source_object = N'BANK_METHOD',
    @type = N'logbased', @description = N'', @creation_script = N'',
    @pre_creation_cmd = N'drop', @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'BANK_METHOD', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboBANK_METHOD]',
    @del_cmd = N'CALL [sp_MSdel_dboBANK_METHOD]',
    @upd_cmd = N'SCALL [sp_MSupd_dboBANK_METHOD]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl',
    @article = N'BANK_STATEMENT', @source_owner = N'dbo',
    @source_object = N'BANK_STATEMENT', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'BANK_STATEMENT', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboBANK_STATEMENT]',
    @del_cmd = N'CALL [sp_MSdel_dboBANK_STATEMENT]',
    @upd_cmd = N'SCALL [sp_MSupd_dboBANK_STATEMENT]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'BATCH',
    @source_owner = N'dbo', @source_object = N'BATCH', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual', @destination_table = N'BATCH',
    @destination_owner = N'dbo', @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboBATCH]',
    @del_cmd = N'CALL [sp_MSdel_dboBATCH]',
    @upd_cmd = N'SCALL [sp_MSupd_dboBATCH]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'BIN',
    @source_owner = N'dbo', @source_object = N'BIN', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual', @destination_table = N'BIN',
    @destination_owner = N'dbo', @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboBIN]', @del_cmd = N'CALL [sp_MSdel_dboBIN]',
    @upd_cmd = N'SCALL [sp_MSupd_dboBIN]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'Bookings',
    @source_owner = N'dbo', @source_object = N'Bookings', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'Bookings', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboBookings]',
    @del_cmd = N'CALL [sp_MSdel_dboBookings]',
    @upd_cmd = N'SCALL [sp_MSupd_dboBookings]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'BSINFO',
    @source_owner = N'dbo', @source_object = N'BSINFO', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual', @destination_table = N'BSINFO',
    @destination_owner = N'dbo', @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboBSINFO]',
    @del_cmd = N'CALL [sp_MSdel_dboBSINFO]',
    @upd_cmd = N'SCALL [sp_MSupd_dboBSINFO]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'BUDGET',
    @source_owner = N'dbo', @source_object = N'BUDGET', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual', @destination_table = N'BUDGET',
    @destination_owner = N'dbo', @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboBUDGET]',
    @del_cmd = N'CALL [sp_MSdel_dboBUDGET]',
    @upd_cmd = N'SCALL [sp_MSupd_dboBUDGET]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl',
    @article = N'BUDGET_HISTORY', @source_owner = N'dbo',
    @source_object = N'BUDGET_HISTORY', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'BUDGET_HISTORY', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboBUDGET_HISTORY]',
    @del_cmd = N'CALL [sp_MSdel_dboBUDGET_HISTORY]',
    @upd_cmd = N'SCALL [sp_MSupd_dboBUDGET_HISTORY]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl',
    @article = N'BUSINESS_SUBTYPE', @source_owner = N'dbo',
    @source_object = N'BUSINESS_SUBTYPE', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'BUSINESS_SUBTYPE', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboBUSINESS_SUBTYPE]',
    @del_cmd = N'CALL [sp_MSdel_dboBUSINESS_SUBTYPE]',
    @upd_cmd = N'SCALL [sp_MSupd_dboBUSINESS_SUBTYPE]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'BUSINESS_TYPE',
    @source_owner = N'dbo', @source_object = N'BUSINESS_TYPE',
    @type = N'logbased', @description = N'', @creation_script = N'',
    @pre_creation_cmd = N'drop', @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'BUSINESS_TYPE', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboBUSINESS_TYPE]',
    @del_cmd = N'CALL [sp_MSdel_dboBUSINESS_TYPE]',
    @upd_cmd = N'SCALL [sp_MSupd_dboBUSINESS_TYPE]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'CALL',
    @source_owner = N'dbo', @source_object = N'CALL', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual', @destination_table = N'CALL',
    @destination_owner = N'dbo', @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboCALL]',
    @del_cmd = N'CALL [sp_MSdel_dboCALL]',
    @upd_cmd = N'SCALL [sp_MSupd_dboCALL]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'CALL_HISTORY',
    @source_owner = N'dbo', @source_object = N'CALL_HISTORY',
    @type = N'logbased', @description = N'', @creation_script = N'',
    @pre_creation_cmd = N'drop', @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'CALL_HISTORY', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboCALL_HISTORY]',
    @del_cmd = N'CALL [sp_MSdel_dboCALL_HISTORY]',
    @upd_cmd = N'SCALL [sp_MSupd_dboCALL_HISTORY]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'CALL_REASON',
    @source_owner = N'dbo', @source_object = N'CALL_REASON',
    @type = N'logbased', @description = N'', @creation_script = N'',
    @pre_creation_cmd = N'drop', @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'CALL_REASON', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboCALL_REASON]',
    @del_cmd = N'CALL [sp_MSdel_dboCALL_REASON]',
    @upd_cmd = N'SCALL [sp_MSupd_dboCALL_REASON]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'CALL_SUBJECT',
    @source_owner = N'dbo', @source_object = N'CALL_SUBJECT',
    @type = N'logbased', @description = N'', @creation_script = N'',
    @pre_creation_cmd = N'drop', @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'CALL_SUBJECT', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboCALL_SUBJECT]',
    @del_cmd = N'CALL [sp_MSdel_dboCALL_SUBJECT]',
    @upd_cmd = N'SCALL [sp_MSupd_dboCALL_SUBJECT]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'CALL_TYPE',
    @source_owner = N'dbo', @source_object = N'CALL_TYPE', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'CALL_TYPE', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboCALL_TYPE]',
    @del_cmd = N'CALL [sp_MSdel_dboCALL_TYPE]',
    @upd_cmd = N'SCALL [sp_MSupd_dboCALL_TYPE]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'CAMPAIGN',
    @source_owner = N'dbo', @source_object = N'CAMPAIGN', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'CAMPAIGN', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboCAMPAIGN]',
    @del_cmd = N'CALL [sp_MSdel_dboCAMPAIGN]',
    @upd_cmd = N'SCALL [sp_MSupd_dboCAMPAIGN]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl',
    @article = N'CAMPAIGN_SELECTION', @source_owner = N'dbo',
    @source_object = N'CAMPAIGN_SELECTION', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'CAMPAIGN_SELECTION', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboCAMPAIGN_SELECTION]',
    @del_cmd = N'CALL [sp_MSdel_dboCAMPAIGN_SELECTION]',
    @upd_cmd = N'SCALL [sp_MSupd_dboCAMPAIGN_SELECTION]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl',
    @article = N'CAMPAIGN_TRADERS', @source_owner = N'dbo',
    @source_object = N'CAMPAIGN_TRADERS', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'CAMPAIGN_TRADERS', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboCAMPAIGN_TRADERS]',
    @del_cmd = N'CALL [sp_MSdel_dboCAMPAIGN_TRADERS]',
    @upd_cmd = N'SCALL [sp_MSupd_dboCAMPAIGN_TRADERS]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'CATALOGUE',
    @source_owner = N'dbo', @source_object = N'CATALOGUE', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'CATALOGUE', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboCATALOGUE]',
    @del_cmd = N'CALL [sp_MSdel_dboCATALOGUE]',
    @upd_cmd = N'SCALL [sp_MSupd_dboCATALOGUE]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl',
    @article = N'CATALOGUE_VISIBILITY', @source_owner = N'dbo',
    @source_object = N'CATALOGUE_VISIBILITY', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'CATALOGUE_VISIBILITY', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboCATALOGUE_VISIBILITY]',
    @del_cmd = N'CALL [sp_MSdel_dboCATALOGUE_VISIBILITY]',
    @upd_cmd = N'SCALL [sp_MSupd_dboCATALOGUE_VISIBILITY]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl',
    @article = N'COMMS_DOC_TYPE', @source_owner = N'dbo',
    @source_object = N'COMMS_DOC_TYPE', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'COMMS_DOC_TYPE', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboCOMMS_DOC_TYPE]',
    @del_cmd = N'CALL [sp_MSdel_dboCOMMS_DOC_TYPE]',
    @upd_cmd = N'SCALL [sp_MSupd_dboCOMMS_DOC_TYPE]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'COMMS_TYPE',
    @source_owner = N'dbo', @source_object = N'COMMS_TYPE',
    @type = N'logbased', @description = N'', @creation_script = N'',
    @pre_creation_cmd = N'drop', @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'none',
    @destination_table = N'COMMS_TYPE', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboCOMMS_TYPE]',
    @del_cmd = N'CALL [sp_MSdel_dboCOMMS_TYPE]',
    @upd_cmd = N'SCALL [sp_MSupd_dboCOMMS_TYPE]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl',
    @article = N'COMP_ATTRIBUTES', @source_owner = N'dbo',
    @source_object = N'COMP_ATTRIBUTES', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'COMP_ATTRIBUTES', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboCOMP_ATTRIBUTES]',
    @del_cmd = N'CALL [sp_MSdel_dboCOMP_ATTRIBUTES]',
    @upd_cmd = N'SCALL [sp_MSupd_dboCOMP_ATTRIBUTES]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'COMPANY',
    @source_owner = N'dbo', @source_object = N'COMPANY', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'COMPANY', @destination_owner = N'dbo', @status = 24,
    @vertical_partition = N'false', @ins_cmd = N'CALL [sp_MSins_dboCOMPANY]',
    @del_cmd = N'CALL [sp_MSdel_dboCOMPANY]',
    @upd_cmd = N'SCALL [sp_MSupd_dboCOMPANY]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'CONFIG',
    @source_owner = N'dbo', @source_object = N'CONFIG', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual', @destination_table = N'CONFIG',
    @destination_owner = N'dbo', @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboCONFIG]',
    @del_cmd = N'CALL [sp_MSdel_dboCONFIG]',
    @upd_cmd = N'SCALL [sp_MSupd_dboCONFIG]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'CONSUMABLES',
    @source_owner = N'dbo', @source_object = N'CONSUMABLES',
    @type = N'logbased', @description = N'', @creation_script = N'',
    @pre_creation_cmd = N'drop', @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'CONSUMABLES', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboCONSUMABLES]',
    @del_cmd = N'CALL [sp_MSdel_dboCONSUMABLES]',
    @upd_cmd = N'SCALL [sp_MSupd_dboCONSUMABLES]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'CONTACT',
    @source_owner = N'dbo', @source_object = N'CONTACT', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'CONTACT', @destination_owner = N'dbo', @status = 24,
    @vertical_partition = N'false', @ins_cmd = N'CALL [sp_MSins_dboCONTACT]',
    @del_cmd = N'CALL [sp_MSdel_dboCONTACT]',
    @upd_cmd = N'SCALL [sp_MSupd_dboCONTACT]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl',
    @article = N'CONTACT_DETAILS', @source_owner = N'dbo',
    @source_object = N'CONTACT_DETAILS', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'CONTACT_DETAILS', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboCONTACT_DETAILS]',
    @del_cmd = N'CALL [sp_MSdel_dboCONTACT_DETAILS]',
    @upd_cmd = N'SCALL [sp_MSupd_dboCONTACT_DETAILS]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl',
    @article = N'CONTACT_DISTRIBUTION', @source_owner = N'dbo',
    @source_object = N'CONTACT_DISTRIBUTION', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'CONTACT_DISTRIBUTION', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboCONTACT_DISTRIBUTION]',
    @del_cmd = N'CALL [sp_MSdel_dboCONTACT_DISTRIBUTION]',
    @upd_cmd = N'SCALL [sp_MSupd_dboCONTACT_DISTRIBUTION]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'CONTACT_TYPE',
    @source_owner = N'dbo', @source_object = N'CONTACT_TYPE',
    @type = N'logbased', @description = N'', @creation_script = N'',
    @pre_creation_cmd = N'drop', @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'CONTACT_TYPE', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboCONTACT_TYPE]',
    @del_cmd = N'CALL [sp_MSdel_dboCONTACT_TYPE]',
    @upd_cmd = N'SCALL [sp_MSupd_dboCONTACT_TYPE]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'COST_CENTRE',
    @source_owner = N'dbo', @source_object = N'COST_CENTRE',
    @type = N'logbased', @description = N'', @creation_script = N'',
    @pre_creation_cmd = N'drop', @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'COST_CENTRE', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboCOST_CENTRE]',
    @del_cmd = N'CALL [sp_MSdel_dboCOST_CENTRE]',
    @upd_cmd = N'SCALL [sp_MSupd_dboCOST_CENTRE]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'COST_TYPE',
    @source_owner = N'dbo', @source_object = N'COST_TYPE', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'none',
    @destination_table = N'COST_TYPE', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboCOST_TYPE]',
    @del_cmd = N'CALL [sp_MSdel_dboCOST_TYPE]',
    @upd_cmd = N'SCALL [sp_MSupd_dboCOST_TYPE]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'COUNTRY',
    @source_owner = N'dbo', @source_object = N'COUNTRY', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'COUNTRY', @destination_owner = N'dbo', @status = 24,
    @vertical_partition = N'false', @ins_cmd = N'CALL [sp_MSins_dboCOUNTRY]',
    @del_cmd = N'CALL [sp_MSdel_dboCOUNTRY]',
    @upd_cmd = N'SCALL [sp_MSupd_dboCOUNTRY]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'CREDIT_CARD',
    @source_owner = N'dbo', @source_object = N'CREDIT_CARD',
    @type = N'logbased', @description = N'', @creation_script = N'',
    @pre_creation_cmd = N'drop', @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'CREDIT_CARD', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboCREDIT_CARD]',
    @del_cmd = N'CALL [sp_MSdel_dboCREDIT_CARD]',
    @upd_cmd = N'SCALL [sp_MSupd_dboCREDIT_CARD]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'CURRENCY',
    @source_owner = N'dbo', @source_object = N'CURRENCY', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'CURRENCY', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboCURRENCY]',
    @del_cmd = N'CALL [sp_MSdel_dboCURRENCY]',
    @upd_cmd = N'SCALL [sp_MSupd_dboCURRENCY]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'CUST_FORMS',
    @source_owner = N'dbo', @source_object = N'CUST_FORMS',
    @type = N'logbased', @description = N'', @creation_script = N'',
    @pre_creation_cmd = N'drop', @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'none',
    @destination_table = N'CUST_FORMS', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboCUST_FORMS]',
    @del_cmd = N'CALL [sp_MSdel_dboCUST_FORMS]',
    @upd_cmd = N'SCALL [sp_MSupd_dboCUST_FORMS]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl',
    @article = N'DATABASE_VERSION', @source_owner = N'dbo',
    @source_object = N'DATABASE_VERSION', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'DATABASE_VERSION', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboDATABASE_VERSION]',
    @del_cmd = N'CALL [sp_MSdel_dboDATABASE_VERSION]',
    @upd_cmd = N'SCALL [sp_MSupd_dboDATABASE_VERSION]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'DATE_RANGE',
    @source_owner = N'dbo', @source_object = N'DATE_RANGE',
    @type = N'logbased', @description = N'', @creation_script = N'',
    @pre_creation_cmd = N'drop', @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'DATE_RANGE', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboDATE_RANGE]',
    @del_cmd = N'CALL [sp_MSdel_dboDATE_RANGE]',
    @upd_cmd = N'SCALL [sp_MSupd_dboDATE_RANGE]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'DAYBOOK',
    @source_owner = N'dbo', @source_object = N'DAYBOOK', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'none', @destination_table = N'DAYBOOK',
    @destination_owner = N'dbo', @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboDAYBOOK]',
    @del_cmd = N'CALL [sp_MSdel_dboDAYBOOK]',
    @upd_cmd = N'SCALL [sp_MSupd_dboDAYBOOK]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'DAYBOOK_ENTRY',
    @source_owner = N'dbo', @source_object = N'DAYBOOK_ENTRY',
    @type = N'logbased', @description = N'', @creation_script = N'',
    @pre_creation_cmd = N'drop', @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'none',
    @destination_table = N'DAYBOOK_ENTRY', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboDAYBOOK_ENTRY]',
    @del_cmd = N'CALL [sp_MSdel_dboDAYBOOK_ENTRY]',
    @upd_cmd = N'SCALL [sp_MSupd_dboDAYBOOK_ENTRY]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'DEAL_METHOD',
    @source_owner = N'dbo', @source_object = N'DEAL_METHOD',
    @type = N'logbased', @description = N'', @creation_script = N'',
    @pre_creation_cmd = N'drop', @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'DEAL_METHOD', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboDEAL_METHOD]',
    @del_cmd = N'CALL [sp_MSdel_dboDEAL_METHOD]',
    @upd_cmd = N'SCALL [sp_MSupd_dboDEAL_METHOD]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'DEAL_SCOPE',
    @source_owner = N'dbo', @source_object = N'DEAL_SCOPE',
    @type = N'logbased', @description = N'', @creation_script = N'',
    @pre_creation_cmd = N'drop', @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'DEAL_SCOPE', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboDEAL_SCOPE]',
    @del_cmd = N'CALL [sp_MSdel_dboDEAL_SCOPE]',
    @upd_cmd = N'SCALL [sp_MSupd_dboDEAL_SCOPE]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'DEALS',
    @source_owner = N'dbo', @source_object = N'DEALS', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual', @destination_table = N'DEALS',
    @destination_owner = N'dbo', @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboDEALS]',
    @del_cmd = N'CALL [sp_MSdel_dboDEALS]',
    @upd_cmd = N'SCALL [sp_MSupd_dboDEALS]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl',
    @article = N'DELIVERY_METHOD', @source_owner = N'dbo',
    @source_object = N'DELIVERY_METHOD', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'DELIVERY_METHOD', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboDELIVERY_METHOD]',
    @del_cmd = N'CALL [sp_MSdel_dboDELIVERY_METHOD]',
    @upd_cmd = N'SCALL [sp_MSupd_dboDELIVERY_METHOD]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'DEPARTMENT',
    @source_owner = N'dbo', @source_object = N'DEPARTMENT',
    @type = N'logbased', @description = N'', @creation_script = N'',
    @pre_creation_cmd = N'drop', @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'DEPARTMENT', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboDEPARTMENT]',
    @del_cmd = N'CALL [sp_MSdel_dboDEPARTMENT]',
    @upd_cmd = N'SCALL [sp_MSupd_dboDEPARTMENT]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'DETAIL',
    @source_owner = N'dbo', @source_object = N'DETAIL', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual', @destination_table = N'DETAIL',
    @destination_owner = N'dbo', @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboDETAIL]',
    @del_cmd = N'CALL [sp_MSdel_dboDETAIL]',
    @upd_cmd = N'SCALL [sp_MSupd_dboDETAIL]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'DETAIL_TYPE',
    @source_owner = N'dbo', @source_object = N'DETAIL_TYPE',
    @type = N'logbased', @description = N'', @creation_script = N'',
    @pre_creation_cmd = N'drop', @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'none',
    @destination_table = N'DETAIL_TYPE', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboDETAIL_TYPE]',
    @del_cmd = N'CALL [sp_MSdel_dboDETAIL_TYPE]',
    @upd_cmd = N'SCALL [sp_MSupd_dboDETAIL_TYPE]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'DISTRIBUTION',
    @source_owner = N'dbo', @source_object = N'DISTRIBUTION',
    @type = N'logbased', @description = N'', @creation_script = N'',
    @pre_creation_cmd = N'drop', @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'DISTRIBUTION', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboDISTRIBUTION]',
    @del_cmd = N'CALL [sp_MSdel_dboDISTRIBUTION]',
    @upd_cmd = N'SCALL [sp_MSupd_dboDISTRIBUTION]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'DOCUMENT',
    @source_owner = N'dbo', @source_object = N'DOCUMENT', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'none', @destination_table = N'DOCUMENT',
    @destination_owner = N'dbo', @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboDOCUMENT]',
    @del_cmd = N'CALL [sp_MSdel_dboDOCUMENT]',
    @upd_cmd = N'SCALL [sp_MSupd_dboDOCUMENT]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl',
    @article = N'DOCUMENT_DISTRIBUTION', @source_owner = N'dbo',
    @source_object = N'DOCUMENT_DISTRIBUTION', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'DOCUMENT_DISTRIBUTION', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboDOCUMENT_DISTRIBUTION]',
    @del_cmd = N'CALL [sp_MSdel_dboDOCUMENT_DISTRIBUTION]',
    @upd_cmd = N'SCALL [sp_MSupd_dboDOCUMENT_DISTRIBUTION]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'ED_LOG',
    @source_owner = N'dbo', @source_object = N'ED_LOG', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual', @destination_table = N'ED_LOG',
    @destination_owner = N'dbo', @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboED_LOG]',
    @del_cmd = N'CALL [sp_MSdel_dboED_LOG]',
    @upd_cmd = N'SCALL [sp_MSupd_dboED_LOG]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'ENQUIRY',
    @source_owner = N'dbo', @source_object = N'ENQUIRY', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'ENQUIRY', @destination_owner = N'dbo', @status = 24,
    @vertical_partition = N'false', @ins_cmd = N'CALL [sp_MSins_dboENQUIRY]',
    @del_cmd = N'CALL [sp_MSdel_dboENQUIRY]',
    @upd_cmd = N'SCALL [sp_MSupd_dboENQUIRY]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'ENQUIRY_REF',
    @source_owner = N'dbo', @source_object = N'ENQUIRY_REF',
    @type = N'logbased', @description = N'', @creation_script = N'',
    @pre_creation_cmd = N'drop', @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'ENQUIRY_REF', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboENQUIRY_REF]',
    @del_cmd = N'CALL [sp_MSdel_dboENQUIRY_REF]',
    @upd_cmd = N'SCALL [sp_MSupd_dboENQUIRY_REF]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'ENTRY',
    @source_owner = N'dbo', @source_object = N'ENTRY', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual', @destination_table = N'ENTRY',
    @destination_owner = N'dbo', @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboENTRY]',
    @del_cmd = N'CALL [sp_MSdel_dboENTRY]',
    @upd_cmd = N'SCALL [sp_MSupd_dboENTRY]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'ENTRY_CONTACT',
    @source_owner = N'dbo', @source_object = N'ENTRY_CONTACT',
    @type = N'logbased', @description = N'', @creation_script = N'',
    @pre_creation_cmd = N'drop', @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'ENTRY_CONTACT', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboENTRY_CONTACT]',
    @del_cmd = N'CALL [sp_MSdel_dboENTRY_CONTACT]',
    @upd_cmd = N'SCALL [sp_MSupd_dboENTRY_CONTACT]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'ENTRY_EXTRA',
    @source_owner = N'dbo', @source_object = N'ENTRY_EXTRA',
    @type = N'logbased', @description = N'', @creation_script = N'',
    @pre_creation_cmd = N'drop', @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'ENTRY_EXTRA', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboENTRY_EXTRA]',
    @del_cmd = N'CALL [sp_MSdel_dboENTRY_EXTRA]',
    @upd_cmd = N'SCALL [sp_MSupd_dboENTRY_EXTRA]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'ENTRY_LABEL',
    @source_owner = N'dbo', @source_object = N'ENTRY_LABEL',
    @type = N'logbased', @description = N'', @creation_script = N'',
    @pre_creation_cmd = N'drop', @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'none',
    @destination_table = N'ENTRY_LABEL', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboENTRY_LABEL]',
    @del_cmd = N'CALL [sp_MSdel_dboENTRY_LABEL]',
    @upd_cmd = N'SCALL [sp_MSupd_dboENTRY_LABEL]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'ENTRY_PRINT',
    @source_owner = N'dbo', @source_object = N'ENTRY_PRINT',
    @type = N'logbased', @description = N'', @creation_script = N'',
    @pre_creation_cmd = N'drop', @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'ENTRY_PRINT', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboENTRY_PRINT]',
    @del_cmd = N'CALL [sp_MSdel_dboENTRY_PRINT]',
    @upd_cmd = N'SCALL [sp_MSupd_dboENTRY_PRINT]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'ENTRY_TYPE',
    @source_owner = N'dbo', @source_object = N'ENTRY_TYPE',
    @type = N'logbased', @description = N'', @creation_script = N'',
    @pre_creation_cmd = N'drop', @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'ENTRY_TYPE', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboENTRY_TYPE]',
    @del_cmd = N'CALL [sp_MSdel_dboENTRY_TYPE]',
    @upd_cmd = N'SCALL [sp_MSupd_dboENTRY_TYPE]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'EXTRA',
    @source_owner = N'dbo', @source_object = N'EXTRA', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual', @destination_table = N'EXTRA',
    @destination_owner = N'dbo', @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboEXTRA]',
    @del_cmd = N'CALL [sp_MSdel_dboEXTRA]',
    @upd_cmd = N'SCALL [sp_MSupd_dboEXTRA]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'FEATURES',
    @source_owner = N'dbo', @source_object = N'FEATURES', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'FEATURES', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboFEATURES]',
    @del_cmd = N'CALL [sp_MSdel_dboFEATURES]',
    @upd_cmd = N'SCALL [sp_MSupd_dboFEATURES]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'FIELD_TEXT',
    @source_owner = N'dbo', @source_object = N'FIELD_TEXT',
    @type = N'logbased', @description = N'', @creation_script = N'',
    @pre_creation_cmd = N'drop', @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'none',
    @destination_table = N'FIELD_TEXT', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboFIELD_TEXT]',
    @del_cmd = N'CALL [sp_MSdel_dboFIELD_TEXT]',
    @upd_cmd = N'SCALL [sp_MSupd_dboFIELD_TEXT]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'FIFO',
    @source_owner = N'dbo', @source_object = N'FIFO', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual', @destination_table = N'FIFO',
    @destination_owner = N'dbo', @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboFIFO]',
    @del_cmd = N'CALL [sp_MSdel_dboFIFO]',
    @upd_cmd = N'SCALL [sp_MSupd_dboFIFO]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'FileDetails',
    @source_owner = N'dbo', @source_object = N'FileDetails',
    @type = N'logbased', @description = N'', @creation_script = N'',
    @pre_creation_cmd = N'drop', @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'FileDetails', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboFileDetails]',
    @del_cmd = N'CALL [sp_MSdel_dboFileDetails]',
    @upd_cmd = N'SCALL [sp_MSupd_dboFileDetails]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'FILTER_LIST',
    @source_owner = N'dbo', @source_object = N'FILTER_LIST',
    @type = N'logbased', @description = N'', @creation_script = N'',
    @pre_creation_cmd = N'drop', @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'FILTER_LIST', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboFILTER_LIST]',
    @del_cmd = N'CALL [sp_MSdel_dboFILTER_LIST]',
    @upd_cmd = N'SCALL [sp_MSupd_dboFILTER_LIST]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'GRID_SETTINGS',
    @source_owner = N'dbo', @source_object = N'GRID_SETTINGS',
    @type = N'logbased', @description = N'', @creation_script = N'',
    @pre_creation_cmd = N'drop', @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'GRID_SETTINGS', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboGRID_SETTINGS]',
    @del_cmd = N'CALL [sp_MSdel_dboGRID_SETTINGS]',
    @upd_cmd = N'SCALL [sp_MSupd_dboGRID_SETTINGS]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'GROUP_DEFS',
    @source_owner = N'dbo', @source_object = N'GROUP_DEFS',
    @type = N'logbased', @description = N'', @creation_script = N'',
    @pre_creation_cmd = N'drop', @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'GROUP_DEFS', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboGROUP_DEFS]',
    @del_cmd = N'CALL [sp_MSdel_dboGROUP_DEFS]',
    @upd_cmd = N'SCALL [sp_MSupd_dboGROUP_DEFS]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'GROUP_LINKS',
    @source_owner = N'dbo', @source_object = N'GROUP_LINKS',
    @type = N'logbased', @description = N'', @creation_script = N'',
    @pre_creation_cmd = N'drop', @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'GROUP_LINKS', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboGROUP_LINKS]',
    @del_cmd = N'CALL [sp_MSdel_dboGROUP_LINKS]',
    @upd_cmd = N'SCALL [sp_MSupd_dboGROUP_LINKS]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl',
    @article = N'HORIZONWEB_LOGIN_ATTEMPTS', @source_owner = N'dbo',
    @source_object = N'HORIZONWEB_LOGIN_ATTEMPTS', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'none',
    @destination_table = N'HORIZONWEB_LOGIN_ATTEMPTS',
    @destination_owner = N'dbo', @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboHORIZONWEB_LOGIN_ATTEMPTS]',
    @del_cmd = N'CALL [sp_MSdel_dboHORIZONWEB_LOGIN_ATTEMPTS]',
    @upd_cmd = N'SCALL [sp_MSupd_dboHORIZONWEB_LOGIN_ATTEMPTS]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl',
    @article = N'HORIZONWEB_PWD_LINKS', @source_owner = N'dbo',
    @source_object = N'HORIZONWEB_PWD_LINKS', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'HORIZONWEB_PWD_LINKS', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboHORIZONWEB_PWD_LINKS]',
    @del_cmd = N'CALL [sp_MSdel_dboHORIZONWEB_PWD_LINKS]',
    @upd_cmd = N'SCALL [sp_MSupd_dboHORIZONWEB_PWD_LINKS]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl',
    @article = N'INVOICE_METHOD', @source_owner = N'dbo',
    @source_object = N'INVOICE_METHOD', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'none',
    @destination_table = N'INVOICE_METHOD', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboINVOICE_METHOD]',
    @del_cmd = N'CALL [sp_MSdel_dboINVOICE_METHOD]',
    @upd_cmd = N'SCALL [sp_MSupd_dboINVOICE_METHOD]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'INVOICE_TYPE',
    @source_owner = N'dbo', @source_object = N'INVOICE_TYPE',
    @type = N'logbased', @description = N'', @creation_script = N'',
    @pre_creation_cmd = N'drop', @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'none',
    @destination_table = N'INVOICE_TYPE', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboINVOICE_TYPE]',
    @del_cmd = N'CALL [sp_MSdel_dboINVOICE_TYPE]',
    @upd_cmd = N'SCALL [sp_MSupd_dboINVOICE_TYPE]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'ITEM',
    @source_owner = N'dbo', @source_object = N'ITEM', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual', @destination_table = N'ITEM',
    @destination_owner = N'dbo', @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboITEM]',
    @del_cmd = N'CALL [sp_MSdel_dboITEM]',
    @upd_cmd = N'SCALL [sp_MSupd_dboITEM]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'ITEM_HISTORY',
    @source_owner = N'dbo', @source_object = N'ITEM_HISTORY',
    @type = N'logbased', @description = N'', @creation_script = N'',
    @pre_creation_cmd = N'drop', @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'ITEM_HISTORY', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboITEM_HISTORY]',
    @del_cmd = N'CALL [sp_MSdel_dboITEM_HISTORY]',
    @upd_cmd = N'SCALL [sp_MSupd_dboITEM_HISTORY]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'LABEL_TYPE',
    @source_owner = N'dbo', @source_object = N'LABEL_TYPE',
    @type = N'logbased', @description = N'', @creation_script = N'',
    @pre_creation_cmd = N'drop', @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'LABEL_TYPE', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboLABEL_TYPE]',
    @del_cmd = N'CALL [sp_MSdel_dboLABEL_TYPE]',
    @upd_cmd = N'SCALL [sp_MSupd_dboLABEL_TYPE]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'LEDGER_STATUS',
    @source_owner = N'dbo', @source_object = N'LEDGER_STATUS',
    @type = N'logbased', @description = N'', @creation_script = N'',
    @pre_creation_cmd = N'drop', @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'none',
    @destination_table = N'LEDGER_STATUS', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboLEDGER_STATUS]',
    @del_cmd = N'CALL [sp_MSdel_dboLEDGER_STATUS]',
    @upd_cmd = N'SCALL [sp_MSupd_dboLEDGER_STATUS]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'LOGIN',
    @source_owner = N'dbo', @source_object = N'LOGIN', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual', @destination_table = N'LOGIN',
    @destination_owner = N'dbo', @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboLOGIN]',
    @del_cmd = N'CALL [sp_MSdel_dboLOGIN]',
    @upd_cmd = N'SCALL [sp_MSupd_dboLOGIN]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'LOOKUP',
    @source_owner = N'dbo', @source_object = N'LOOKUP', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual', @destination_table = N'LOOKUP',
    @destination_owner = N'dbo', @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboLOOKUP]',
    @del_cmd = N'CALL [sp_MSdel_dboLOOKUP]',
    @upd_cmd = N'SCALL [sp_MSupd_dboLOOKUP]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'MACHINE',
    @source_owner = N'dbo', @source_object = N'MACHINE', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'MACHINE', @destination_owner = N'dbo', @status = 24,
    @vertical_partition = N'false', @ins_cmd = N'CALL [sp_MSins_dboMACHINE]',
    @del_cmd = N'CALL [sp_MSdel_dboMACHINE]',
    @upd_cmd = N'SCALL [sp_MSupd_dboMACHINE]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'MACHINE_PARTS',
    @source_owner = N'dbo', @source_object = N'MACHINE_PARTS',
    @type = N'logbased', @description = N'', @creation_script = N'',
    @pre_creation_cmd = N'drop', @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'MACHINE_PARTS', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboMACHINE_PARTS]',
    @del_cmd = N'CALL [sp_MSdel_dboMACHINE_PARTS]',
    @upd_cmd = N'SCALL [sp_MSupd_dboMACHINE_PARTS]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'MACHINE_TYPE',
    @source_owner = N'dbo', @source_object = N'MACHINE_TYPE',
    @type = N'logbased', @description = N'', @creation_script = N'',
    @pre_creation_cmd = N'drop', @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'MACHINE_TYPE', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboMACHINE_TYPE]',
    @del_cmd = N'CALL [sp_MSdel_dboMACHINE_TYPE]',
    @upd_cmd = N'SCALL [sp_MSupd_dboMACHINE_TYPE]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'MEDIA_LINKS',
    @source_owner = N'dbo', @source_object = N'MEDIA_LINKS',
    @type = N'logbased', @description = N'', @creation_script = N'',
    @pre_creation_cmd = N'drop', @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'MEDIA_LINKS', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboMEDIA_LINKS]',
    @del_cmd = N'CALL [sp_MSdel_dboMEDIA_LINKS]',
    @upd_cmd = N'SCALL [sp_MSupd_dboMEDIA_LINKS]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'METER',
    @source_owner = N'dbo', @source_object = N'METER', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual', @destination_table = N'METER',
    @destination_owner = N'dbo', @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboMETER]',
    @del_cmd = N'CALL [sp_MSdel_dboMETER]',
    @upd_cmd = N'SCALL [sp_MSupd_dboMETER]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'METERCLICK',
    @source_owner = N'dbo', @source_object = N'METERCLICK',
    @type = N'logbased', @description = N'', @creation_script = N'',
    @pre_creation_cmd = N'drop', @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'METERCLICK', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboMETERCLICK]',
    @del_cmd = N'CALL [sp_MSdel_dboMETERCLICK]',
    @upd_cmd = N'SCALL [sp_MSupd_dboMETERCLICK]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'MONTH_NUMBERS',
    @source_owner = N'dbo', @source_object = N'MONTH_NUMBERS',
    @type = N'logbased', @description = N'', @creation_script = N'',
    @pre_creation_cmd = N'drop', @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'MONTH_NUMBERS', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboMONTH_NUMBERS]',
    @del_cmd = N'CALL [sp_MSdel_dboMONTH_NUMBERS]',
    @upd_cmd = N'SCALL [sp_MSupd_dboMONTH_NUMBERS]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'NEEDSHOP',
    @source_owner = N'dbo', @source_object = N'NEEDSHOP', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'none', @destination_table = N'NEEDSHOP',
    @destination_owner = N'dbo', @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboNEEDSHOP]',
    @del_cmd = N'CALL [sp_MSdel_dboNEEDSHOP]',
    @upd_cmd = N'SCALL [sp_MSupd_dboNEEDSHOP]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'NOMINAL',
    @source_owner = N'dbo', @source_object = N'NOMINAL', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'NOMINAL', @destination_owner = N'dbo', @status = 24,
    @vertical_partition = N'false', @ins_cmd = N'CALL [sp_MSins_dboNOMINAL]',
    @del_cmd = N'CALL [sp_MSdel_dboNOMINAL]',
    @upd_cmd = N'SCALL [sp_MSupd_dboNOMINAL]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl',
    @article = N'NOMINAL_HISTORY', @source_owner = N'dbo',
    @source_object = N'NOMINAL_HISTORY', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'NOMINAL_HISTORY', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboNOMINAL_HISTORY]',
    @del_cmd = N'CALL [sp_MSdel_dboNOMINAL_HISTORY]',
    @upd_cmd = N'SCALL [sp_MSupd_dboNOMINAL_HISTORY]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'OP_EXTRA',
    @source_owner = N'dbo', @source_object = N'OP_EXTRA', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'OP_EXTRA', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboOP_EXTRA]',
    @del_cmd = N'CALL [sp_MSdel_dboOP_EXTRA]',
    @upd_cmd = N'SCALL [sp_MSupd_dboOP_EXTRA]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'PARTS_LIST',
    @source_owner = N'dbo', @source_object = N'PARTS_LIST',
    @type = N'logbased', @description = N'', @creation_script = N'',
    @pre_creation_cmd = N'drop', @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'PARTS_LIST', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboPARTS_LIST]',
    @del_cmd = N'CALL [sp_MSdel_dboPARTS_LIST]',
    @upd_cmd = N'SCALL [sp_MSupd_dboPARTS_LIST]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'PAY_TYPE',
    @source_owner = N'dbo', @source_object = N'PAY_TYPE', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'none', @destination_table = N'PAY_TYPE',
    @destination_owner = N'dbo', @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboPAY_TYPE]',
    @del_cmd = N'CALL [sp_MSdel_dboPAY_TYPE]',
    @upd_cmd = N'SCALL [sp_MSupd_dboPAY_TYPE]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'PERIOD',
    @source_owner = N'dbo', @source_object = N'PERIOD', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'none', @destination_table = N'PERIOD',
    @destination_owner = N'dbo', @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboPERIOD]',
    @del_cmd = N'CALL [sp_MSdel_dboPERIOD]',
    @upd_cmd = N'SCALL [sp_MSupd_dboPERIOD]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'POSTING',
    @source_owner = N'dbo', @source_object = N'POSTING', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'POSTING', @destination_owner = N'dbo', @status = 24,
    @vertical_partition = N'false', @ins_cmd = N'CALL [sp_MSins_dboPOSTING]',
    @del_cmd = N'CALL [sp_MSdel_dboPOSTING]',
    @upd_cmd = N'SCALL [sp_MSupd_dboPOSTING]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'PRINTERS',
    @source_owner = N'dbo', @source_object = N'PRINTERS', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'PRINTERS', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboPRINTERS]',
    @del_cmd = N'CALL [sp_MSdel_dboPRINTERS]',
    @upd_cmd = N'SCALL [sp_MSupd_dboPRINTERS]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'PROCESS_TYPE',
    @source_owner = N'dbo', @source_object = N'PROCESS_TYPE',
    @type = N'logbased', @description = N'', @creation_script = N'',
    @pre_creation_cmd = N'drop', @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'PROCESS_TYPE', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboPROCESS_TYPE]',
    @del_cmd = N'CALL [sp_MSdel_dboPROCESS_TYPE]',
    @upd_cmd = N'SCALL [sp_MSupd_dboPROCESS_TYPE]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'PRODUCT',
    @source_owner = N'dbo', @source_object = N'PRODUCT', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'PRODUCT', @destination_owner = N'dbo', @status = 24,
    @vertical_partition = N'false', @ins_cmd = N'CALL [sp_MSins_dboPRODUCT]',
    @del_cmd = N'CALL [sp_MSdel_dboPRODUCT]',
    @upd_cmd = N'SCALL [sp_MSupd_dboPRODUCT]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl',
    @article = N'PRODUCT_COMPATIBLE', @source_owner = N'dbo',
    @source_object = N'PRODUCT_COMPATIBLE', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'none',
    @destination_table = N'PRODUCT_COMPATIBLE', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboPRODUCT_COMPATIBLE]',
    @del_cmd = N'CALL [sp_MSdel_dboPRODUCT_COMPATIBLE]',
    @upd_cmd = N'SCALL [sp_MSupd_dboPRODUCT_COMPATIBLE]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'PRODUCT_GROUP',
    @source_owner = N'dbo', @source_object = N'PRODUCT_GROUP',
    @type = N'logbased', @description = N'', @creation_script = N'',
    @pre_creation_cmd = N'drop', @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'none',
    @destination_table = N'PRODUCT_GROUP', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboPRODUCT_GROUP]',
    @del_cmd = N'CALL [sp_MSdel_dboPRODUCT_GROUP]',
    @upd_cmd = N'SCALL [sp_MSupd_dboPRODUCT_GROUP]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'PRODUCT_RANGE',
    @source_owner = N'dbo', @source_object = N'PRODUCT_RANGE',
    @type = N'logbased', @description = N'', @creation_script = N'',
    @pre_creation_cmd = N'drop', @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'none',
    @destination_table = N'PRODUCT_RANGE', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboPRODUCT_RANGE]',
    @del_cmd = N'CALL [sp_MSdel_dboPRODUCT_RANGE]',
    @upd_cmd = N'SCALL [sp_MSupd_dboPRODUCT_RANGE]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl',
    @article = N'PRODUCT_SECTOR', @source_owner = N'dbo',
    @source_object = N'PRODUCT_SECTOR', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'none',
    @destination_table = N'PRODUCT_SECTOR', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboPRODUCT_SECTOR]',
    @del_cmd = N'CALL [sp_MSdel_dboPRODUCT_SECTOR]',
    @upd_cmd = N'SCALL [sp_MSupd_dboPRODUCT_SECTOR]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl',
    @article = N'PRODUCT_SUBGROUP', @source_owner = N'dbo',
    @source_object = N'PRODUCT_SUBGROUP', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'none',
    @destination_table = N'PRODUCT_SUBGROUP', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboPRODUCT_SUBGROUP]',
    @del_cmd = N'CALL [sp_MSdel_dboPRODUCT_SUBGROUP]',
    @upd_cmd = N'SCALL [sp_MSupd_dboPRODUCT_SUBGROUP]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl',
    @article = N'PRODUCT_SUPPLY', @source_owner = N'dbo',
    @source_object = N'PRODUCT_SUPPLY', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'none',
    @destination_table = N'PRODUCT_SUPPLY', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboPRODUCT_SUPPLY]',
    @del_cmd = N'CALL [sp_MSdel_dboPRODUCT_SUPPLY]',
    @upd_cmd = N'SCALL [sp_MSupd_dboPRODUCT_SUPPLY]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'QTY_BREAK',
    @source_owner = N'dbo', @source_object = N'QTY_BREAK', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'QTY_BREAK', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboQTY_BREAK]',
    @del_cmd = N'CALL [sp_MSdel_dboQTY_BREAK]',
    @upd_cmd = N'SCALL [sp_MSupd_dboQTY_BREAK]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'RB_FIELD',
    @source_owner = N'dbo', @source_object = N'RB_FIELD', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'none', @destination_table = N'RB_FIELD',
    @destination_owner = N'dbo', @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboRB_FIELD]',
    @del_cmd = N'CALL [sp_MSdel_dboRB_FIELD]',
    @upd_cmd = N'SCALL [sp_MSupd_dboRB_FIELD]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'RB_FOLDER',
    @source_owner = N'dbo', @source_object = N'RB_FOLDER', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'RB_FOLDER', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboRB_FOLDER]',
    @del_cmd = N'CALL [sp_MSdel_dboRB_FOLDER]',
    @upd_cmd = N'SCALL [sp_MSupd_dboRB_FOLDER]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'RB_ITEM',
    @source_owner = N'dbo', @source_object = N'RB_ITEM', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'RB_ITEM', @destination_owner = N'dbo', @status = 24,
    @vertical_partition = N'false', @ins_cmd = N'CALL [sp_MSins_dboRB_ITEM]',
    @del_cmd = N'CALL [sp_MSdel_dboRB_ITEM]',
    @upd_cmd = N'SCALL [sp_MSupd_dboRB_ITEM]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'RB_JOIN',
    @source_owner = N'dbo', @source_object = N'RB_JOIN', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'none', @destination_table = N'RB_JOIN',
    @destination_owner = N'dbo', @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboRB_JOIN]',
    @del_cmd = N'CALL [sp_MSdel_dboRB_JOIN]',
    @upd_cmd = N'SCALL [sp_MSupd_dboRB_JOIN]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'RB_TABLE',
    @source_owner = N'dbo', @source_object = N'RB_TABLE', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'RB_TABLE', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboRB_TABLE]',
    @del_cmd = N'CALL [sp_MSdel_dboRB_TABLE]',
    @upd_cmd = N'SCALL [sp_MSupd_dboRB_TABLE]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'REP',
    @source_owner = N'dbo', @source_object = N'REP', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual', @destination_table = N'REP',
    @destination_owner = N'dbo', @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboREP]', @del_cmd = N'CALL [sp_MSdel_dboREP]',
    @upd_cmd = N'SCALL [sp_MSupd_dboREP]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'REPORT_PARAMS',
    @source_owner = N'dbo', @source_object = N'REPORT_PARAMS',
    @type = N'logbased', @description = N'', @creation_script = N'',
    @pre_creation_cmd = N'drop', @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'REPORT_PARAMS', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboREPORT_PARAMS]',
    @del_cmd = N'CALL [sp_MSdel_dboREPORT_PARAMS]',
    @upd_cmd = N'SCALL [sp_MSupd_dboREPORT_PARAMS]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'RESULTS',
    @source_owner = N'dbo', @source_object = N'RESULTS', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'RESULTS', @destination_owner = N'dbo', @status = 24,
    @vertical_partition = N'false', @ins_cmd = N'CALL [sp_MSins_dboRESULTS]',
    @del_cmd = N'CALL [sp_MSdel_dboRESULTS]',
    @upd_cmd = N'SCALL [sp_MSupd_dboRESULTS]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'RETRO_TYPE',
    @source_owner = N'dbo', @source_object = N'RETRO_TYPE',
    @type = N'logbased', @description = N'', @creation_script = N'',
    @pre_creation_cmd = N'drop', @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'RETRO_TYPE', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboRETRO_TYPE]',
    @del_cmd = N'CALL [sp_MSdel_dboRETRO_TYPE]',
    @upd_cmd = N'SCALL [sp_MSupd_dboRETRO_TYPE]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'RETURN_REASON',
    @source_owner = N'dbo', @source_object = N'RETURN_REASON',
    @type = N'logbased', @description = N'', @creation_script = N'',
    @pre_creation_cmd = N'drop', @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'RETURN_REASON', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboRETURN_REASON]',
    @del_cmd = N'CALL [sp_MSdel_dboRETURN_REASON]',
    @upd_cmd = N'SCALL [sp_MSupd_dboRETURN_REASON]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'SAVED_QUERY',
    @source_owner = N'dbo', @source_object = N'SAVED_QUERY',
    @type = N'logbased', @description = N'', @creation_script = N'',
    @pre_creation_cmd = N'drop', @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'SAVED_QUERY', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboSAVED_QUERY]',
    @del_cmd = N'CALL [sp_MSdel_dboSAVED_QUERY]',
    @upd_cmd = N'SCALL [sp_MSupd_dboSAVED_QUERY]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'SERIAL',
    @source_owner = N'dbo', @source_object = N'SERIAL', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual', @destination_table = N'SERIAL',
    @destination_owner = N'dbo', @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboSERIAL]',
    @del_cmd = N'CALL [sp_MSdel_dboSERIAL]',
    @upd_cmd = N'SCALL [sp_MSupd_dboSERIAL]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl',
    @article = N'SERIAL_HISTORY', @source_owner = N'dbo',
    @source_object = N'SERIAL_HISTORY', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'SERIAL_HISTORY', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboSERIAL_HISTORY]',
    @del_cmd = N'CALL [sp_MSdel_dboSERIAL_HISTORY]',
    @upd_cmd = N'SCALL [sp_MSupd_dboSERIAL_HISTORY]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'SERVICE_CODE',
    @source_owner = N'dbo', @source_object = N'SERVICE_CODE',
    @type = N'logbased', @description = N'', @creation_script = N'',
    @pre_creation_cmd = N'drop', @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'none',
    @destination_table = N'SERVICE_CODE', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboSERVICE_CODE]',
    @del_cmd = N'CALL [sp_MSdel_dboSERVICE_CODE]',
    @upd_cmd = N'SCALL [sp_MSupd_dboSERVICE_CODE]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl',
    @article = N'SERVICE_MATRIX', @source_owner = N'dbo',
    @source_object = N'SERVICE_MATRIX', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'SERVICE_MATRIX', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboSERVICE_MATRIX]',
    @del_cmd = N'CALL [sp_MSdel_dboSERVICE_MATRIX]',
    @upd_cmd = N'SCALL [sp_MSupd_dboSERVICE_MATRIX]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'SHOPLINK',
    @source_owner = N'dbo', @source_object = N'SHOPLINK', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'none', @destination_table = N'SHOPLINK',
    @destination_owner = N'dbo', @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboSHOPLINK]',
    @del_cmd = N'CALL [sp_MSdel_dboSHOPLINK]',
    @upd_cmd = N'SCALL [sp_MSupd_dboSHOPLINK]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'SHOPPING',
    @source_owner = N'dbo', @source_object = N'SHOPPING', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'SHOPPING', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboSHOPPING]',
    @del_cmd = N'CALL [sp_MSdel_dboSHOPPING]',
    @upd_cmd = N'SCALL [sp_MSupd_dboSHOPPING]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'SOR_COSTING',
    @source_owner = N'dbo', @source_object = N'SOR_COSTING',
    @type = N'logbased', @description = N'', @creation_script = N'',
    @pre_creation_cmd = N'drop', @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'SOR_COSTING', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboSOR_COSTING]',
    @del_cmd = N'CALL [sp_MSdel_dboSOR_COSTING]',
    @upd_cmd = N'SCALL [sp_MSupd_dboSOR_COSTING]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'SOURCE',
    @source_owner = N'dbo', @source_object = N'SOURCE', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual', @destination_table = N'SOURCE',
    @destination_owner = N'dbo', @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboSOURCE]',
    @del_cmd = N'CALL [sp_MSdel_dboSOURCE]',
    @upd_cmd = N'SCALL [sp_MSupd_dboSOURCE]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'SPOOLER',
    @source_owner = N'dbo', @source_object = N'SPOOLER', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'SPOOLER', @destination_owner = N'dbo', @status = 24,
    @vertical_partition = N'false', @ins_cmd = N'CALL [sp_MSins_dboSPOOLER]',
    @del_cmd = N'CALL [sp_MSdel_dboSPOOLER]',
    @upd_cmd = N'SCALL [sp_MSupd_dboSPOOLER]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'STOCK',
    @source_owner = N'dbo', @source_object = N'STOCK', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'none', @destination_table = N'STOCK',
    @destination_owner = N'dbo', @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboSTOCK]',
    @del_cmd = N'CALL [sp_MSdel_dboSTOCK]',
    @upd_cmd = N'SCALL [sp_MSupd_dboSTOCK]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'STOCK_AUDIT',
    @source_owner = N'dbo', @source_object = N'STOCK_AUDIT',
    @type = N'logbased', @description = N'', @creation_script = N'',
    @pre_creation_cmd = N'drop', @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'STOCK_AUDIT', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboSTOCK_AUDIT]',
    @del_cmd = N'CALL [sp_MSdel_dboSTOCK_AUDIT]',
    @upd_cmd = N'SCALL [sp_MSupd_dboSTOCK_AUDIT]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'STOCKTAKE',
    @source_owner = N'dbo', @source_object = N'STOCKTAKE', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'STOCKTAKE', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboSTOCKTAKE]',
    @del_cmd = N'CALL [sp_MSdel_dboSTOCKTAKE]',
    @upd_cmd = N'SCALL [sp_MSupd_dboSTOCKTAKE]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'SUMMARY',
    @source_owner = N'dbo', @source_object = N'SUMMARY', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'none', @destination_table = N'SUMMARY',
    @destination_owner = N'dbo', @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboSUMMARY]',
    @del_cmd = N'CALL [sp_MSdel_dboSUMMARY]',
    @upd_cmd = N'SCALL [sp_MSupd_dboSUMMARY]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'SWAP',
    @source_owner = N'dbo', @source_object = N'SWAP', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual', @destination_table = N'SWAP',
    @destination_owner = N'dbo', @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboSWAP]',
    @del_cmd = N'CALL [sp_MSdel_dboSWAP]',
    @upd_cmd = N'SCALL [sp_MSupd_dboSWAP]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'SWAP_CLASS',
    @source_owner = N'dbo', @source_object = N'SWAP_CLASS',
    @type = N'logbased', @description = N'', @creation_script = N'',
    @pre_creation_cmd = N'drop', @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'SWAP_CLASS', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboSWAP_CLASS]',
    @del_cmd = N'CALL [sp_MSdel_dboSWAP_CLASS]',
    @upd_cmd = N'SCALL [sp_MSupd_dboSWAP_CLASS]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl',
    @article = N'SWITCH_EXCEPTION', @source_owner = N'dbo',
    @source_object = N'SWITCH_EXCEPTION', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'SWITCH_EXCEPTION', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboSWITCH_EXCEPTION]',
    @del_cmd = N'CALL [sp_MSdel_dboSWITCH_EXCEPTION]',
    @upd_cmd = N'SCALL [sp_MSupd_dboSWITCH_EXCEPTION]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl',
    @article = N'SYSTEM_FUNCTION', @source_owner = N'dbo',
    @source_object = N'SYSTEM_FUNCTION', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'none',
    @destination_table = N'SYSTEM_FUNCTION', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboSYSTEM_FUNCTION]',
    @del_cmd = N'CALL [sp_MSdel_dboSYSTEM_FUNCTION]',
    @upd_cmd = N'SCALL [sp_MSupd_dboSYSTEM_FUNCTION]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'TERMS',
    @source_owner = N'dbo', @source_object = N'TERMS', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual', @destination_table = N'TERMS',
    @destination_owner = N'dbo', @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboTERMS]',
    @del_cmd = N'CALL [sp_MSdel_dboTERMS]',
    @upd_cmd = N'SCALL [sp_MSupd_dboTERMS]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'TEXT_SEARCH',
    @source_owner = N'dbo', @source_object = N'TEXT_SEARCH',
    @type = N'logbased', @description = N'', @creation_script = N'',
    @pre_creation_cmd = N'drop', @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'none',
    @destination_table = N'TEXT_SEARCH', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboTEXT_SEARCH]',
    @del_cmd = N'CALL [sp_MSdel_dboTEXT_SEARCH]',
    @upd_cmd = N'SCALL [sp_MSupd_dboTEXT_SEARCH]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'TILL',
    @source_owner = N'dbo', @source_object = N'TILL', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual', @destination_table = N'TILL',
    @destination_owner = N'dbo', @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboTILL]',
    @del_cmd = N'CALL [sp_MSdel_dboTILL]',
    @upd_cmd = N'SCALL [sp_MSupd_dboTILL]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'TRADER',
    @source_owner = N'dbo', @source_object = N'TRADER', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual', @destination_table = N'TRADER',
    @destination_owner = N'dbo', @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboTRADER]',
    @del_cmd = N'CALL [sp_MSdel_dboTRADER]',
    @upd_cmd = N'SCALL [sp_MSupd_dboTRADER]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'TRADER_CLASS',
    @source_owner = N'dbo', @source_object = N'TRADER_CLASS',
    @type = N'logbased', @description = N'', @creation_script = N'',
    @pre_creation_cmd = N'drop', @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'TRADER_CLASS', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboTRADER_CLASS]',
    @del_cmd = N'CALL [sp_MSdel_dboTRADER_CLASS]',
    @upd_cmd = N'SCALL [sp_MSupd_dboTRADER_CLASS]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl',
    @article = N'TRADER_COMMS_PATH', @source_owner = N'dbo',
    @source_object = N'TRADER_COMMS_PATH', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'TRADER_COMMS_PATH', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboTRADER_COMMS_PATH]',
    @del_cmd = N'CALL [sp_MSdel_dboTRADER_COMMS_PATH]',
    @upd_cmd = N'SCALL [sp_MSupd_dboTRADER_COMMS_PATH]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'TRADER_NOTES',
    @source_owner = N'dbo', @source_object = N'TRADER_NOTES',
    @type = N'logbased', @description = N'', @creation_script = N'',
    @pre_creation_cmd = N'drop', @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'TRADER_NOTES', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboTRADER_NOTES]',
    @del_cmd = N'CALL [sp_MSdel_dboTRADER_NOTES]',
    @upd_cmd = N'SCALL [sp_MSupd_dboTRADER_NOTES]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'TRADER_SWAP',
    @source_owner = N'dbo', @source_object = N'TRADER_SWAP',
    @type = N'logbased', @description = N'', @creation_script = N'',
    @pre_creation_cmd = N'drop', @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'none',
    @destination_table = N'TRADER_SWAP', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboTRADER_SWAP]',
    @del_cmd = N'CALL [sp_MSdel_dboTRADER_SWAP]',
    @upd_cmd = N'SCALL [sp_MSupd_dboTRADER_SWAP]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'TRADER_TYPE',
    @source_owner = N'dbo', @source_object = N'TRADER_TYPE',
    @type = N'logbased', @description = N'', @creation_script = N'',
    @pre_creation_cmd = N'drop', @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'none',
    @destination_table = N'TRADER_TYPE', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboTRADER_TYPE]',
    @del_cmd = N'CALL [sp_MSdel_dboTRADER_TYPE]',
    @upd_cmd = N'SCALL [sp_MSupd_dboTRADER_TYPE]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'TS$LINK',
    @source_owner = N'dbo', @source_object = N'TS$LINK', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'none', @destination_table = N'TS$LINK',
    @destination_owner = N'dbo', @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboTS$LINK]',
    @del_cmd = N'CALL [sp_MSdel_dboTS$LINK]',
    @upd_cmd = N'SCALL [sp_MSupd_dboTS$LINK]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'TS$OBJ',
    @source_owner = N'dbo', @source_object = N'TS$OBJ', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'none', @destination_table = N'TS$OBJ',
    @destination_owner = N'dbo', @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboTS$OBJ]',
    @del_cmd = N'CALL [sp_MSdel_dboTS$OBJ]',
    @upd_cmd = N'SCALL [sp_MSupd_dboTS$OBJ]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'TS$OPT',
    @source_owner = N'dbo', @source_object = N'TS$OPT', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual', @destination_table = N'TS$OPT',
    @destination_owner = N'dbo', @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboTS$OPT]',
    @del_cmd = N'CALL [sp_MSdel_dboTS$OPT]',
    @upd_cmd = N'SCALL [sp_MSupd_dboTS$OPT]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'TS$QUERY',
    @source_owner = N'dbo', @source_object = N'TS$QUERY', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'none', @destination_table = N'TS$QUERY',
    @destination_owner = N'dbo', @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboTS$QUERY]',
    @del_cmd = N'CALL [sp_MSdel_dboTS$QUERY]',
    @upd_cmd = N'SCALL [sp_MSupd_dboTS$QUERY]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'TS$VOCAB',
    @source_owner = N'dbo', @source_object = N'TS$VOCAB', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'none', @destination_table = N'TS$VOCAB',
    @destination_owner = N'dbo', @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboTS$VOCAB]',
    @del_cmd = N'CALL [sp_MSdel_dboTS$VOCAB]',
    @upd_cmd = N'SCALL [sp_MSupd_dboTS$VOCAB]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'USER_ACCESS',
    @source_owner = N'dbo', @source_object = N'USER_ACCESS',
    @type = N'logbased', @description = N'', @creation_script = N'',
    @pre_creation_cmd = N'drop', @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'none',
    @destination_table = N'USER_ACCESS', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboUSER_ACCESS]',
    @del_cmd = N'CALL [sp_MSdel_dboUSER_ACCESS]',
    @upd_cmd = N'SCALL [sp_MSupd_dboUSER_ACCESS]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'USER_REPORTS',
    @source_owner = N'dbo', @source_object = N'USER_REPORTS',
    @type = N'logbased', @description = N'', @creation_script = N'',
    @pre_creation_cmd = N'drop', @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'USER_REPORTS', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboUSER_REPORTS]',
    @del_cmd = N'CALL [sp_MSdel_dboUSER_REPORTS]',
    @upd_cmd = N'SCALL [sp_MSupd_dboUSER_REPORTS]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'VAN',
    @source_owner = N'dbo', @source_object = N'VAN', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual', @destination_table = N'VAN',
    @destination_owner = N'dbo', @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboVAN]', @del_cmd = N'CALL [sp_MSdel_dboVAN]',
    @upd_cmd = N'SCALL [sp_MSupd_dboVAN]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'VAN_AREA',
    @source_owner = N'dbo', @source_object = N'VAN_AREA', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'VAN_AREA', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboVAN_AREA]',
    @del_cmd = N'CALL [sp_MSdel_dboVAN_AREA]',
    @upd_cmd = N'SCALL [sp_MSupd_dboVAN_AREA]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'VAT_PERIOD',
    @source_owner = N'dbo', @source_object = N'VAT_PERIOD',
    @type = N'logbased', @description = N'', @creation_script = N'',
    @pre_creation_cmd = N'drop', @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'VAT_PERIOD', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboVAT_PERIOD]',
    @del_cmd = N'CALL [sp_MSdel_dboVAT_PERIOD]',
    @upd_cmd = N'SCALL [sp_MSupd_dboVAT_PERIOD]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'VAT_RATE',
    @source_owner = N'dbo', @source_object = N'VAT_RATE', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'none', @destination_table = N'VAT_RATE',
    @destination_owner = N'dbo', @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboVAT_RATE]',
    @del_cmd = N'CALL [sp_MSdel_dboVAT_RATE]',
    @upd_cmd = N'SCALL [sp_MSupd_dboVAT_RATE]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl',
    @article = N'VISION_CONVERT', @source_owner = N'dbo',
    @source_object = N'VISION_CONVERT', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'none',
    @destination_table = N'VISION_CONVERT', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboVISION_CONVERT]',
    @del_cmd = N'CALL [sp_MSdel_dboVISION_CONVERT]',
    @upd_cmd = N'SCALL [sp_MSupd_dboVISION_CONVERT]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'WEB_CONTACT',
    @source_owner = N'dbo', @source_object = N'WEB_CONTACT',
    @type = N'logbased', @description = N'', @creation_script = N'',
    @pre_creation_cmd = N'drop', @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'WEB_CONTACT', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboWEB_CONTACT]',
    @del_cmd = N'CALL [sp_MSdel_dboWEB_CONTACT]',
    @upd_cmd = N'SCALL [sp_MSupd_dboWEB_CONTACT]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl',
    @article = N'WEB_PAYMENT_TYPE', @source_owner = N'dbo',
    @source_object = N'WEB_PAYMENT_TYPE', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'WEB_PAYMENT_TYPE', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboWEB_PAYMENT_TYPE]',
    @del_cmd = N'CALL [sp_MSdel_dboWEB_PAYMENT_TYPE]',
    @upd_cmd = N'SCALL [sp_MSupd_dboWEB_PAYMENT_TYPE]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'WEB_STATS',
    @source_owner = N'dbo', @source_object = N'WEB_STATS', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'WEB_STATS', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboWEB_STATS]',
    @del_cmd = N'CALL [sp_MSdel_dboWEB_STATS]',
    @upd_cmd = N'SCALL [sp_MSupd_dboWEB_STATS]';
GO
USE [HZN_QUALITY];
EXEC sp_addarticle @publication = N'QUALITY_Repl', @article = N'WORDS',
    @source_owner = N'dbo', @source_object = N'WORDS', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x00000000080350DF,
    @identityrangemanagementoption = N'manual', @destination_table = N'WORDS',
    @destination_owner = N'dbo', @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboWORDS]',
    @del_cmd = N'CALL [sp_MSdel_dboWORDS]',
    @upd_cmd = N'SCALL [sp_MSupd_dboWORDS]';
GO

-- Adding the transactional subscriptions
USE [HZN_QUALITY];
EXEC sp_addsubscription @publication = N'QUALITY_Repl',
    @subscriber = N'SBS01\SQLSERVER', @destination_db = N'HZN_QUALITY',
    @subscription_type = N'Push', @sync_type = N'automatic', @article = N'all',
    @update_mode = N'read only', @subscriber_type = 0;
EXEC sp_addpushsubscription_agent @publication = N'QUALITY_Repl',
    @subscriber = N'SBS01\SQLSERVER', @subscriber_db = N'HZN_QUALITY',
    @job_login = NULL, @job_password = NULL, @subscriber_security_mode = 0,
    @subscriber_login = N'database_rep', @subscriber_password = NULL,
    @frequency_type = 64, @frequency_interval = 1,
    @frequency_relative_interval = 1, @frequency_recurrence_factor = 0,
    @frequency_subday = 4, @frequency_subday_interval = 5,
    @active_start_time_of_day = 0, @active_end_time_of_day = 235959,
    @active_start_date = 0, @active_end_date = 0,
    @dts_package_location = N'Distributor';
GO

