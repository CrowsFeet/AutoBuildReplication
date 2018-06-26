DECLARE @SchemaOption binary(8),
		@intermediate binary(8)

SET @schemaoption  = 0x000000000803509F-- 0x00000000080350DF --<<<Your Schema Option here>>>    --Replace the value here


SET NOCOUNT ON

SELECT cast(cast(@schemaoption as int) & 0x01 as binary(8))

--SET @intermediate= cast(cast(@schemaoption as int) & 0x01 as binary(8))

      