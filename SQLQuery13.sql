--IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES 
--      WHERE TABLE_NAME = 'bitwise')
--   DROP TABLE bitwise;
--GO
--CREATE TABLE bitwise
--( 
--a_int_value int NOT NULL,
--b_int_value int NOT NULL
--);
--GO
--INSERT bitwise VALUES (170, 75);
--GO

--SELECT cast(cast(0x000000000803509F as int) & 0x01 as binary(8))
SELECT cast(cast(0x000000000803509F as int) & 0x01 as int) -- 1
SELECT cast(cast(0x000000000803509F as int) & 0x02 as int) -- 2
SELECT cast(cast(0x000000000803509F as int) & 0x04 as int) -- 4
SELECT cast(cast(0x000000000803509F as int) & 0x08  as int) -- 8
SELECT cast(cast(0x000000000803509F as int) & 0x10 as int) -- 10
SELECT cast(cast(0x000000000803509F as int) & 0x80 as int) -- 128
SELECT cast(cast(0x000000000803509F as int) & 0x1000 as int) -- 4096
SELECT cast(cast(0x000000000803509F as int) & 0x4000 as int) -- 16384
SELECT cast(cast(0x000000000803509F as int) & 0x10000 as int) -- 65536
SELECT cast(cast(0x000000000803509F as int) & 0x20000 as int) -- 131072
SELECT cast(cast(0x000000000803509F as int) & 0x8000000 as int) -- 134217728

DECLARE @P1 BIGINT

SET @P1 = POWER(2*cast(cast(0x000000000803509F as int) & 0x01 as int),1) -- 1
			+ POWER(2*CAST(cast(0x000000000803509F as int) & 0x02 as int),2) -- 2
			+ POWER(2*cast(cast(0x000000000803509F as int) & 0x04 as int),3) -- 4
			+ POWER(2*cast(cast(0x000000000803509F as int) & 0x08  as int),4) -- 8
			+ POWER(2*cast(cast(0x000000000803509F as int) & 0x10 as int),5) -- 10
			+ POWER(2*cast(cast(0x000000000803509F as int) & 0x80 as int),6) -- 128
			+ POWER(2*cast(cast(0x000000000803509F as int) & 0x1000 as int),7) -- 4096
			+ POWER(2*cast(cast(0x000000000803509F as int) & 0x4000 as int),8) -- 16384
			+ POWER(2*cast(cast(0x000000000803509F as int) & 0x10000 as int),9) -- 65536
			+ POWER(2*cast(cast(0x000000000803509F as int) & 0x20000 as int),10) -- 131072
			+ POWER(2*cast(cast(0x000000000803509F as int) & 0x8000000 as int),11) -- 134217728

SELECT @P1

-- convert to int
-- then compare each one for their integer values if they are not 0 they are set values

--0x000000000803509F -- without nonclustered indexes
--0x00000000080350DF -- with nonclustered indexes


--0x02
--0x04
--0x08
--0x10
--0x80
--0x1000
--0x4000
--0x10000
--0x20000
--0x8000000
