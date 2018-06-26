-- Testing
DECLARE @DBName NVARCHAR(255)
SET @DBName = 'HZN_CITRUS'

DECLARE @PublicationName NVARCHAR(255),
		@SubscriberServerName NVARCHAR(255)

SELECT TOP 1
	@PublicationName = PublisherName,
	@SubscriberServerName = SubscriberServer
FROM HostedMaintenance.[dbo].[tbl_StoreTablesForReplication] 
WHERE PublisherDB = @DBName



--SELECT * FROM HostedMaintenance.[dbo].[tbl_StoreTablesForReplication] 

SELECT @PublicationName,@SubscriberServerName
