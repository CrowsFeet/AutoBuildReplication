-- Enabling the replication database
USE master;
EXEC sp_replicationdboption @dbname = N'HZN_CITRUS', @optname = N'publish',
    @value = N'true';
GO

EXEC [HZN_CITRUS].sys.sp_addlogreader_agent @job_login = NULL,
    @job_password = NULL, @publisher_security_mode = 1;
GO
-- Adding the transactional publication
USE [HZN_CITRUS];
EXEC sp_addpublication @publication = N'CITRUS_Replication',
    @description = N'Transactional publication of database ''HZN_CITRUS'' from Publisher ''ECIC-SQL04''.',
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


EXEC sp_addpublication_snapshot @publication = N'CITRUS_Replication',
    @frequency_type = 1, @frequency_interval = 0,
    @frequency_relative_interval = 0, @frequency_recurrence_factor = 0,
    @frequency_subday = 0, @frequency_subday_interval = 0,
    @active_start_time_of_day = 0, @active_end_time_of_day = 235959,
    @active_start_date = 0, @active_end_date = 0, @job_login = NULL,
    @job_password = NULL, @publisher_security_mode = 1;
EXEC sp_grant_publication_access @publication = N'CITRUS_Replication',
    @login = N'sa';
GO
EXEC sp_grant_publication_access @publication = N'CITRUS_Replication',
    @login = N'NT AUTHORITY\SYSTEM';
GO
EXEC sp_grant_publication_access @publication = N'CITRUS_Replication',
    @login = N'ECICLOUD\Domain Admins';
GO
EXEC sp_grant_publication_access @publication = N'CITRUS_Replication',
    @login = N'ECICLOUD\mike.rawson';
GO
EXEC sp_grant_publication_access @publication = N'CITRUS_Replication',
    @login = N'ECICLOUD\andrew.gazdowicz';
GO
EXEC sp_grant_publication_access @publication = N'CITRUS_Replication',
    @login = N'ECICLOUD\tony.adams';
GO
EXEC sp_grant_publication_access @publication = N'CITRUS_Replication',
    @login = N'ECICLOUD\oliver.garside';
GO
EXEC sp_grant_publication_access @publication = N'CITRUS_Replication',
    @login = N'ECICLOUD\andrew.dams';
GO
EXEC sp_grant_publication_access @publication = N'CITRUS_Replication',
    @login = N'ECICLOUD\eci staff admins';
GO
EXEC sp_grant_publication_access @publication = N'CITRUS_Replication',
    @login = N'ECICLOUD\Steve.Kidd';
GO
EXEC sp_grant_publication_access @publication = N'CITRUS_Replication',
    @login = N'NT SERVICE\Winmgmt';
GO
EXEC sp_grant_publication_access @publication = N'CITRUS_Replication',
    @login = N'NT SERVICE\SQLWriter';
GO
EXEC sp_grant_publication_access @publication = N'CITRUS_Replication',
    @login = N'NT SERVICE\SQLSERVERAGENT';
GO
EXEC sp_grant_publication_access @publication = N'CITRUS_Replication',
    @login = N'NT Service\MSSQLSERVER';
GO
EXEC sp_grant_publication_access @publication = N'CITRUS_Replication',
    @login = N'distributor_admin';
GO
EXEC sp_grant_publication_access @publication = N'CITRUS_Replication',
    @login = N'Horizon';
GO
EXEC sp_grant_publication_access @publication = N'CITRUS_Replication',
    @login = N'AGTest';
GO
EXEC sp_grant_publication_access @publication = N'CITRUS_Replication',
    @login = N'AWHouse_Horizon';
GO

-- Adding the transactional articles
USE [HZN_CITRUS];
EXEC sp_addarticle @publication = N'CITRUS_Replication',
    @article = N'CATALOGUE', @source_owner = N'dbo',
    @source_object = N'CATALOGUE', @type = N'logbased', @description = N'',
    @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x000000000803509F,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'CATALOGUE', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboCATALOGUE]',
    @del_cmd = N'CALL [sp_MSdel_dboCATALOGUE]',
    @upd_cmd = N'SCALL [sp_MSupd_dboCATALOGUE]';
GO
USE [HZN_CITRUS];
EXEC sp_addarticle @publication = N'CITRUS_Replication',
    @article = N'CONSUMABLES', @source_owner = N'dbo',
    @source_object = N'CONSUMABLES', @type = N'logbased', @description = N'',
    @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x000000000803509F,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'CONSUMABLES', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboCONSUMABLES]',
    @del_cmd = N'CALL [sp_MSdel_dboCONSUMABLES]',
    @upd_cmd = N'SCALL [sp_MSupd_dboCONSUMABLES]';
GO
USE [HZN_CITRUS];
EXEC sp_addarticle @publication = N'CITRUS_Replication', @article = N'CONTACT',
    @source_owner = N'dbo', @source_object = N'CONTACT', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x000000000803509F,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'CONTACT', @destination_owner = N'dbo', @status = 24,
    @vertical_partition = N'false', @ins_cmd = N'CALL [sp_MSins_dboCONTACT]',
    @del_cmd = N'CALL [sp_MSdel_dboCONTACT]',
    @upd_cmd = N'SCALL [sp_MSupd_dboCONTACT]';
GO
USE [HZN_CITRUS];
EXEC sp_addarticle @publication = N'CITRUS_Replication', @article = N'DEALS',
    @source_owner = N'dbo', @source_object = N'DEALS', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x000000000803509F,
    @identityrangemanagementoption = N'manual', @destination_table = N'DEALS',
    @destination_owner = N'dbo', @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboDEALS]',
    @del_cmd = N'CALL [sp_MSdel_dboDEALS]',
    @upd_cmd = N'SCALL [sp_MSupd_dboDEALS]';
GO
USE [HZN_CITRUS];
EXEC sp_addarticle @publication = N'CITRUS_Replication',
    @article = N'DEPARTMENT', @source_owner = N'dbo',
    @source_object = N'DEPARTMENT', @type = N'logbased', @description = N'',
    @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x000000000803509F,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'DEPARTMENT', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboDEPARTMENT]',
    @del_cmd = N'CALL [sp_MSdel_dboDEPARTMENT]',
    @upd_cmd = N'SCALL [sp_MSupd_dboDEPARTMENT]';
GO
USE [HZN_CITRUS];
EXEC sp_addarticle @publication = N'CITRUS_Replication', @article = N'DETAIL',
    @source_owner = N'dbo', @source_object = N'DETAIL', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x000000000803509F,
    @identityrangemanagementoption = N'manual', @destination_table = N'DETAIL',
    @destination_owner = N'dbo', @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboDETAIL]',
    @del_cmd = N'CALL [sp_MSdel_dboDETAIL]',
    @upd_cmd = N'SCALL [sp_MSupd_dboDETAIL]',
    @filter_clause = N'DETAIL.ENTRY_ID IN (SELECT ENTRY.ENTRY_ID FROM ENTRY WHERE ENTRY.DAYBOOK_ID IN (100,130,140))';

-- Adding the article filter
EXEC sp_articlefilter @publication = N'CITRUS_Replication',
    @article = N'DETAIL', @filter_name = N'FLTR_DETAIL_1__134',
    @filter_clause = N'DETAIL.ENTRY_ID IN (SELECT ENTRY.ENTRY_ID FROM ENTRY WHERE ENTRY.DAYBOOK_ID IN (100,130,140))',
    @force_invalidate_snapshot = 1, @force_reinit_subscription = 1;

-- Adding the article synchronization object
EXEC sp_articleview @publication = N'CITRUS_Replication', @article = N'DETAIL',
    @view_name = N'SYNC_DETAIL_1__134',
    @filter_clause = N'DETAIL.ENTRY_ID IN (SELECT ENTRY.ENTRY_ID FROM ENTRY WHERE ENTRY.DAYBOOK_ID IN (100,130,140))',
    @force_invalidate_snapshot = 1, @force_reinit_subscription = 1;
GO
USE [HZN_CITRUS];
EXEC sp_addarticle @publication = N'CITRUS_Replication', @article = N'ENTRY',
    @source_owner = N'dbo', @source_object = N'ENTRY', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x000000000803509F,
    @identityrangemanagementoption = N'manual', @destination_table = N'ENTRY',
    @destination_owner = N'dbo', @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboENTRY]',
    @del_cmd = N'CALL [sp_MSdel_dboENTRY]',
    @upd_cmd = N'SCALL [sp_MSupd_dboENTRY]',
    @filter_clause = N'[DAYBOOK_ID] in (100,130,140)';

-- Adding the article filter
EXEC sp_articlefilter @publication = N'CITRUS_Replication',
    @article = N'ENTRY', @filter_name = N'FLTR_ENTRY_1__134',
    @filter_clause = N'[DAYBOOK_ID] in (100,130,140)',
    @force_invalidate_snapshot = 1, @force_reinit_subscription = 1;

-- Adding the article synchronization object
EXEC sp_articleview @publication = N'CITRUS_Replication', @article = N'ENTRY',
    @view_name = N'SYNC_ENTRY_1__134',
    @filter_clause = N'[DAYBOOK_ID] in (100,130,140)',
    @force_invalidate_snapshot = 1, @force_reinit_subscription = 1;
GO
USE [HZN_CITRUS];
EXEC sp_addarticle @publication = N'CITRUS_Replication', @article = N'EXTRA',
    @source_owner = N'dbo', @source_object = N'EXTRA', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x000000000803509F,
    @identityrangemanagementoption = N'manual', @destination_table = N'EXTRA',
    @destination_owner = N'dbo', @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboEXTRA]',
    @del_cmd = N'CALL [sp_MSdel_dboEXTRA]',
    @upd_cmd = N'SCALL [sp_MSupd_dboEXTRA]';
GO
USE [HZN_CITRUS];
EXEC sp_addarticle @publication = N'CITRUS_Replication',
    @article = N'GROUP_DEFS', @source_owner = N'dbo',
    @source_object = N'GROUP_DEFS', @type = N'logbased', @description = N'',
    @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x000000000803509F,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'GROUP_DEFS', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboGROUP_DEFS]',
    @del_cmd = N'CALL [sp_MSdel_dboGROUP_DEFS]',
    @upd_cmd = N'SCALL [sp_MSupd_dboGROUP_DEFS]';
GO
USE [HZN_CITRUS];
EXEC sp_addarticle @publication = N'CITRUS_Replication',
    @article = N'GROUP_LINKS', @source_owner = N'dbo',
    @source_object = N'GROUP_LINKS', @type = N'logbased', @description = N'',
    @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x000000000803509F,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'GROUP_LINKS', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboGROUP_LINKS]',
    @del_cmd = N'CALL [sp_MSdel_dboGROUP_LINKS]',
    @upd_cmd = N'SCALL [sp_MSupd_dboGROUP_LINKS]';
GO
USE [HZN_CITRUS];
EXEC sp_addarticle @publication = N'CITRUS_Replication', @article = N'ITEM',
    @source_owner = N'dbo', @source_object = N'ITEM', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x000000000803509F,
    @identityrangemanagementoption = N'manual', @destination_table = N'ITEM',
    @destination_owner = N'dbo', @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboITEM]',
    @del_cmd = N'CALL [sp_MSdel_dboITEM]',
    @upd_cmd = N'SCALL [sp_MSupd_dboITEM]';
GO
USE [HZN_CITRUS];
EXEC sp_addarticle @publication = N'CITRUS_Replication', @article = N'LOOKUP',
    @source_owner = N'dbo', @source_object = N'LOOKUP', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x000000000803509F,
    @identityrangemanagementoption = N'manual', @destination_table = N'LOOKUP',
    @destination_owner = N'dbo', @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboLOOKUP]',
    @del_cmd = N'CALL [sp_MSdel_dboLOOKUP]',
    @upd_cmd = N'SCALL [sp_MSupd_dboLOOKUP]';
GO
USE [HZN_CITRUS];
EXEC sp_addarticle @publication = N'CITRUS_Replication',
    @article = N'PROCESS_TYPE', @source_owner = N'dbo',
    @source_object = N'PROCESS_TYPE', @type = N'logbased', @description = N'',
    @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x000000000803509F,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'PROCESS_TYPE', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboPROCESS_TYPE]',
    @del_cmd = N'CALL [sp_MSdel_dboPROCESS_TYPE]',
    @upd_cmd = N'SCALL [sp_MSupd_dboPROCESS_TYPE]';
GO
USE [HZN_CITRUS];
EXEC sp_addarticle @publication = N'CITRUS_Replication', @article = N'PRODUCT',
    @source_owner = N'dbo', @source_object = N'PRODUCT', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x000000000803509F,
    @identityrangemanagementoption = N'manual',
    @destination_table = N'PRODUCT', @destination_owner = N'dbo', @status = 24,
    @vertical_partition = N'false', @ins_cmd = N'CALL [sp_MSins_dboPRODUCT]',
    @del_cmd = N'CALL [sp_MSdel_dboPRODUCT]',
    @upd_cmd = N'SCALL [sp_MSupd_dboPRODUCT]';
GO
USE [HZN_CITRUS];
EXEC sp_addarticle @publication = N'CITRUS_Replication',
    @article = N'PRODUCT_GROUP', @source_owner = N'dbo',
    @source_object = N'PRODUCT_GROUP', @type = N'logbased', @description = N'',
    @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x000000000803509F,
    @identityrangemanagementoption = N'none',
    @destination_table = N'PRODUCT_GROUP', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboPRODUCT_GROUP]',
    @del_cmd = N'CALL [sp_MSdel_dboPRODUCT_GROUP]',
    @upd_cmd = N'SCALL [sp_MSupd_dboPRODUCT_GROUP]';
GO
USE [HZN_CITRUS];
EXEC sp_addarticle @publication = N'CITRUS_Replication',
    @article = N'PRODUCT_RANGE', @source_owner = N'dbo',
    @source_object = N'PRODUCT_RANGE', @type = N'logbased', @description = N'',
    @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x000000000803509F,
    @identityrangemanagementoption = N'none',
    @destination_table = N'PRODUCT_RANGE', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboPRODUCT_RANGE]',
    @del_cmd = N'CALL [sp_MSdel_dboPRODUCT_RANGE]',
    @upd_cmd = N'SCALL [sp_MSupd_dboPRODUCT_RANGE]';
GO
USE [HZN_CITRUS];
EXEC sp_addarticle @publication = N'CITRUS_Replication',
    @article = N'PRODUCT_SECTOR', @source_owner = N'dbo',
    @source_object = N'PRODUCT_SECTOR', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x000000000803509F,
    @identityrangemanagementoption = N'none',
    @destination_table = N'PRODUCT_SECTOR', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboPRODUCT_SECTOR]',
    @del_cmd = N'CALL [sp_MSdel_dboPRODUCT_SECTOR]',
    @upd_cmd = N'SCALL [sp_MSupd_dboPRODUCT_SECTOR]';
GO
USE [HZN_CITRUS];
EXEC sp_addarticle @publication = N'CITRUS_Replication',
    @article = N'PRODUCT_SUBGROUP', @source_owner = N'dbo',
    @source_object = N'PRODUCT_SUBGROUP', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x000000000803509F,
    @identityrangemanagementoption = N'none',
    @destination_table = N'PRODUCT_SUBGROUP', @destination_owner = N'dbo',
    @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboPRODUCT_SUBGROUP]',
    @del_cmd = N'CALL [sp_MSdel_dboPRODUCT_SUBGROUP]',
    @upd_cmd = N'SCALL [sp_MSupd_dboPRODUCT_SUBGROUP]';
GO
USE [HZN_CITRUS];
EXEC sp_addarticle @publication = N'CITRUS_Replication', @article = N'STOCK',
    @source_owner = N'dbo', @source_object = N'STOCK', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x000000000803509F,
    @identityrangemanagementoption = N'none', @destination_table = N'STOCK',
    @destination_owner = N'dbo', @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboSTOCK]',
    @del_cmd = N'CALL [sp_MSdel_dboSTOCK]',
    @upd_cmd = N'SCALL [sp_MSupd_dboSTOCK]';
GO
USE [HZN_CITRUS];
EXEC sp_addarticle @publication = N'CITRUS_Replication', @article = N'TRADER',
    @source_owner = N'dbo', @source_object = N'TRADER', @type = N'logbased',
    @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x000000000803509F,
    @identityrangemanagementoption = N'manual', @destination_table = N'TRADER',
    @destination_owner = N'dbo', @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboTRADER]',
    @del_cmd = N'CALL [sp_MSdel_dboTRADER]',
    @upd_cmd = N'SCALL [sp_MSupd_dboTRADER]';
GO
USE [HZN_CITRUS];
EXEC sp_addarticle @publication = N'CITRUS_Replication',
    @article = N'VAT_RATE', @source_owner = N'dbo',
    @source_object = N'VAT_RATE', @type = N'logbased', @description = N'',
    @creation_script = N'', @pre_creation_cmd = N'drop',
    @schema_option = 0x000000000803509F,
    @identityrangemanagementoption = N'none', @destination_table = N'VAT_RATE',
    @destination_owner = N'dbo', @status = 24, @vertical_partition = N'false',
    @ins_cmd = N'CALL [sp_MSins_dboVAT_RATE]',
    @del_cmd = N'CALL [sp_MSdel_dboVAT_RATE]',
    @upd_cmd = N'SCALL [sp_MSupd_dboVAT_RATE]';
GO

-- Adding the transactional subscriptions
USE [HZN_CITRUS];
EXEC sp_addsubscription @publication = N'CITRUS_Replication',
    @subscriber = N'WIN-9Q8REFSVUCT', @destination_db = N'HZN_CITRUS_Repl',
    @subscription_type = N'Push', @sync_type = N'automatic', @article = N'all',
    @update_mode = N'read only', @subscriber_type = 0;
EXEC sp_addpushsubscription_agent @publication = N'CITRUS_Replication',
    @subscriber = N'WIN-9Q8REFSVUCT', @subscriber_db = N'HZN_CITRUS_Repl',
    @job_login = NULL, @job_password = NULL, @subscriber_security_mode = 0,
    @subscriber_login = N'citrus', @subscriber_password = NULL,
    @frequency_type = 64, @frequency_interval = 1,
    @frequency_relative_interval = 1, @frequency_recurrence_factor = 0,
    @frequency_subday = 4, @frequency_subday_interval = 5,
    @active_start_time_of_day = 0, @active_end_time_of_day = 235959,
    @active_start_date = 0, @active_end_date = 0,
    @dts_package_location = N'Distributor';
GO

