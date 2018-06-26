--SELECT * FROM MSarticles
--SELECT * FROM MScached_peer_lsns -- empty
--SELECT * FROM MSdistribution_agents -- lists the replicating sql agent (be wary of the cirtual ones. cant remember why though)
--SELECT * FROM MSdistribution_history -- lists the replication distribution history (could be useful one day)
--SELECT * FROM MSlogreader_agents -- lists the log read sql agent job (need to properly figure out what each of these are and do)
--SELECT * FROM MSlogreader_history -- lists the log reader history
--SELECT * FROM MSmerge_agents -- lists the megre sql agent job (i think)
--SELECT * FROM MSmerge_articlehistory -- lists the merger article history
--SELECT * FROM MSmerge_articleresolver -- something to do with the merge process I guess
--SELECT * FROM MSmerge_history -- lists the merge history
--SELECT * FROM MSmerge_identity_range_allocations -- merge again
--SELECT * FROM MSmerge_sessions -- merge again
--SELECT * FROM MSmerge_subscriptions -- merge yet again
--SELECT * FROM MSnosyncsubsetup -- no idea
--SELECT * FROM MSpublication_access -- who has access to the replication
--SELECT * FROM MSpublications -- this lists the publications
--SELECT * FROM MSpublicationthresholds -- no idea
--SELECT * FROM MSpublisher_databases -- source database 
--SELECT * FROM MSqreader_agents -- no idea
--SELECT * FROM MSqreader_history -- no idea
--SELECT * FROM MSredirected_publishers -- no idea
--SELECT * FROM MSrepl_backup_lsns -- i can guess, but not going to. something to do with backup, but not sure how this is used
--SELECT * FROM MSrepl_commands -- I cant remember how this works anymore
--SELECT * FROM MSrepl_errors -- lists any replication errors.
--SELECT * FROM MSrepl_identity_range -- no idea
--SELECT * FROM MSrepl_originators -- no idea
--SELECT * FROM MSrepl_transactions -- i think I should know this... nope, not a clue
--SELECT * FROM MSrepl_version -- lists a version number
--SELECT * FROM MSreplication_monitordata -- might be used in gui
--SELECT * FROM MSsnapshot_agents -- this is the name of the SQL Agent for the snapshot
--SELECT * FROM MSsnapshot_history -- lists the history of the snapshot processing
--SELECT * FROM MSsubscriber_info -- details of the subscriber
--SELECT * FROM MSsubscriber_schedule -- maybe for the sql agents?
--SELECT * FROM MSsubscriptions where subscriber_db <> 'Virtual' -- lists the articles on the subscriber db
--SELECT * FROM MSsync_states -- no idea
--SELECT * FROM MStracer_history -- used for tracing replication
--SELECT * FROM MStracer_tokens -- as above



-- somehow this worked.
-- Connect Subscriber
--connect HZN_CITRUS_Repl
use [master]
exec sp_helpreplicationdboption @dbname = N'HZN_CITRUS_Repl'
go
use HZN_CITRUS_Repl
exec sp_subscription_cleanup @publisher = N'HZN_CITRUS', @publisher_db = N'HZN_CITRUS_Repl', 
@publication = N'HZN_CITRUS_Repl'
go
/*
-- Connect Publisher Server
:connect TestPubSQL1
-- Drop Subscription
use HZN_CITRUS_Repl
exec sp_dropsubscription @publication = N'MyReplPub', @subscriber = N'all', 
@destination_db = N'MyReplDB', @article = N'all'
go
-- Drop publication
exec sp_droppublication @publication = N'MyReplPub'
-- Disable replication db option
exec sp_replicationdboption @dbname = N'MyReplDB', @optname = N'publish', @value = N'false'
GO
*/

/*
-- Connect Subscriber
:connect TestSubSQL1
use [master]
exec sp_helpreplicationdboption @dbname = N'MyReplDB'
go
use [MyReplDB]
exec sp_subscription_cleanup @publisher = N'TestPubSQL1', @publisher_db = N'MyReplDB', 
@publication = N'MyReplPub'
go
-- Connect Publisher Server
:connect TestPubSQL1
-- Drop Subscription
use [MyReplDB]
exec sp_dropsubscription @publication = N'MyReplPub', @subscriber = N'all', 
@destination_db = N'MyReplDB', @article = N'all'
go
-- Drop publication
exec sp_droppublication @publication = N'MyReplPub'
-- Disable replication db option
exec sp_replicationdboption @dbname = N'MyReplDB', @optname = N'publish', @value = N'false'
GO
*/