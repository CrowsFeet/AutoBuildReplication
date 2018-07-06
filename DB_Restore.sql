BACKUP DATABASE [<Add_DB_Name_Here>]
TO DISK = N'C:\temp\backup\<Add_DB_Name_Here>.bak'
WITH INIT,COMPRESSION,STATS=10


RESTORE FILELISTONLY
FROM DISK = N'C:\temp\backup\<Add_DB_Name_Here>.bak'

--RESTORE DATABASE [<Add_DB_Name_Here>]
--FROM DISK = N'C:\Temp\Backup\<Add_DB_Name_Here>.bak'
--WITH FILE = 1,
--MOVE N'<Add_DB_Logical_Name_Here>' TO N'C:\Temp\Data\<Add_DB_Name_Here>.mdf',
--MOVE N'<Add_Log_Logical_Name_Here>' TO N'C:\Temp\Log\<Add_DB_Name_Here>.ldf',
--NORECOVERY,REPLACE,STATS=10

RESTORE DATABASE [<Add_DB_Name_Here>]
FROM DISK = N'C:\temp\backup\<Add_DB_Name_Here>.bak'
WITH FILE = 1,
MOVE N'<Add_DB_Logical_Name_Here>' TO N'C:\Temp\Data\<Add_DB_Name_Here>.mdf',
MOVE N'<Add_Log_Logical_Name_Here>' TO N'C:\Temp\Log\<Add_DB_Name_Here>.ldf',
RECOVERY,REPLACE,STATS=10

