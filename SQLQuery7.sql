
USE [HZN_CITRUS] 
;With ReplicationObjects as
(Select pubid,artID,dest_object,'filter_clause' AS Filter_clause,dest_owner,objid,name from sysschemaarticles
union
Select pubid,artID,dest_table,CONVERT(NVARCHAR(4000),filter_clause) AS filter_clause,dest_owner,objid,name from sysarticles)

--INSERT INTO HostedMaintenance.[dbo].[tbl_StoreTablesForReplication] (PublisherServer,PublisherName,PublisherDB,PublisherTableName,Type_desc,SubscriberTableName,SubscriberDB,SubscriberServer,Filter_clause)
Select CONVERT(NVARCHAR(255),Serverproperty('ServerName')) as [PublisherServer],
B.name as [PublisherName],DB_Name() as [PublisherDB],
E.Name+'.'+A.Name as [PublisherTableName],D.Type_desc,
A.dest_owner+'.'+A.dest_Object as [SubscriberTableName],
C.dest_db as [SubscriberDB],C.srvname as [SubscriberServer],
a.Filter_clause
From ReplicationObjects A
Inner Join syspublications B on A.pubid=B.pubid
Inner Join dbo.syssubscriptions C on C.artid=A.artid
Inner Join sys.objects D on A.objid=D.Object_id
Inner Join sys.schemas E on E.Schema_id=D.Schema_id
Where dest_db not in ('Virtual')


--SELECT * FROM HostedMaintenance.[dbo].[tbl_StoreTablesForReplication] 