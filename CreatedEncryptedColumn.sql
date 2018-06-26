USE HostedMaintenance;  
GO  

SELECT * FROM tbl_DBUpdater
WHERE DatabaseName = 'HZN_CITRUS'

--UPDATE tbl_DBUpdater
--SET Repl_ServerName = 'UKCB-ANDYG',
--	Repl_Username = 'Repl_Account_001'--,
--	--Repl_Password = 'Repl_Account_001_Test'
--WHERE DatabaseName = 'HZN_CITRUS'


-- Step 1 -- Done
CREATE CERTIFICATE ReplicationConnections
   WITH SUBJECT = 'Replication Login Password';  
GO  

-- Step 2 - Done
CREATE SYMMETRIC KEY SSN_Key_01  
    WITH ALGORITHM = AES_256  
    ENCRYPTION BY CERTIFICATE ReplicationConnections;  
GO  

USE [HostedMaintenance];  
GO  

-- Step 3 -- Done
-- Create a column in which to store the encrypted data.  
--ALTER TABLE tbl_dbupdater
--    ADD Repl_ServerName nvarchar(255),
--		Repl_Username nvarchar(255),
--		Repl_Password varbinary(128);   
--GO  

-- Step 4 -- Done
-- Open the symmetric key with which to encrypt the data.  
OPEN SYMMETRIC KEY SSN_Key_01  
   DECRYPTION BY CERTIFICATE ReplicationConnections;  

DECLARE @NewPassword NVARCHAR(255)
SET @NewPassword = N'Repl_Account_001_Test'

-- Step 5 -- Done
-- Encrypt the value in column NationalIDNumber with symmetric   
-- key SSN_Key_01. Save the result in column EncryptedNationalIDNumber.  
-- by using the N prefix, this allows you to decrypt into an NVARCHAR datatype. otherwise you need to use a varchar datatype
UPDATE tbl_dbupdater
SET Repl_Password = EncryptByKey(Key_GUID('SSN_Key_01'), @NewPassword)
--SET Repl_Password = EncryptByKey(Key_GUID('SSN_Key_01'), N'Repl_Account_001_Test')
WHERE DatabaseName = 'HZN_CITRUS'
--GO  


-- step 6 -- Done
-- Verify the encryption.  
-- First, open the symmetric key with which to decrypt the data.  
OPEN SYMMETRIC KEY SSN_Key_01  
   DECRYPTION BY CERTIFICATE ReplicationConnections;  
GO  

-- Now list the original ID, the encrypted ID, and the   
-- decrypted ciphertext. If the decryption worked, the original  
-- and the decrypted ID will match.  
SELECT 
DatabaseName,
Repl_ServerName,
Repl_Username,
Repl_Password AS Repl_Password_Encrypted,
--CONVERT(varchar(max), DecryptByKey(Repl_Password)) AS 'Decrypted Password 1',  
CONVERT(nvarchar(max), DecryptByKey(Repl_Password)) AS 'Decrypted_Password'  
FROM tbl_DBUpdater
WHERE DatabaseName = 'HZN_CITRUS'

--SET Repl_ServerName = 'UKCB-ANDYG',
--	Repl_Username = 'Repl_Account_001'--,
--	--Repl_Password = 'Repl_Account_001_Test'

/*

-- example of reading the password
OPEN SYMMETRIC KEY SSN_Key_01  
   DECRYPTION BY CERTIFICATE ReplicationConnections;  
GO  



SELECT 
DatabaseName,
Repl_ServerName,
Repl_Username,
Repl_Password AS Repl_Password_Encrypted
,CONVERT(nvarchar(max), DecryptByKey(Repl_Password)) AS 'Decrypted_Password'  
FROM tbl_DBUpdater
WHERE DatabaseName = 'HZN_CITRUS'

CLOSE SYMMETRIC KEY SSN_Key_01  




*/





/*

USE AdventureWorks2012;  
GO  

CREATE CERTIFICATE HumanResources037  
   WITH SUBJECT = 'Employee Social Security Numbers';  
GO  

CREATE SYMMETRIC KEY SSN_Key_01  
    WITH ALGORITHM = AES_256  
    ENCRYPTION BY CERTIFICATE HumanResources037;  
GO  

USE [AdventureWorks2012];  
GO  

-- Create a column in which to store the encrypted data.  
ALTER TABLE HumanResources.Employee  
    ADD EncryptedNationalIDNumber varbinary(128);   
GO  

-- Open the symmetric key with which to encrypt the data.  
OPEN SYMMETRIC KEY SSN_Key_01  
   DECRYPTION BY CERTIFICATE HumanResources037;  

-- Encrypt the value in column NationalIDNumber with symmetric   
-- key SSN_Key_01. Save the result in column EncryptedNationalIDNumber.  
UPDATE HumanResources.Employee  
SET EncryptedNationalIDNumber = EncryptByKey(Key_GUID('SSN_Key_01'), NationalIDNumber);  
GO  

-- Verify the encryption.  
-- First, open the symmetric key with which to decrypt the data.  
OPEN SYMMETRIC KEY SSN_Key_01  
   DECRYPTION BY CERTIFICATE HumanResources037;  
GO  

-- Now list the original ID, the encrypted ID, and the   
-- decrypted ciphertext. If the decryption worked, the original  
-- and the decrypted ID will match.  
SELECT NationalIDNumber, EncryptedNationalIDNumber   
    AS 'Encrypted ID Number',  
    CONVERT(nvarchar, DecryptByKey(EncryptedNationalIDNumber))   
    AS 'Decrypted ID Number'  
    FROM HumanResources.Employee;  
GO  



*/