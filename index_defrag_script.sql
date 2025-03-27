DECLARE @TableName NVARCHAR(128);
DECLARE @IndexName NVARCHAR(128);
DECLARE @Fragmentation FLOAT;

DECLARE IndexCursor CURSOR FOR
SELECT
	CONCAT_WS('.',s.name,t.name) TableName,
	i.name IndexName,
	ips.avg_fragmentation_in_percent FragmentationPercent
FROM
	sys.dm_db_index_physical_stats(DB_ID(),NULL,NULL,NULL,NULL) ips
JOIN
	sys.tables t ON t.object_id = ips.object_id
JOIN 
	sys.schemas s ON t.schema_id = s.schema_id
JOIN
	sys.indexes i ON i.index_id = ips.index_id AND i.object_id = ips.object_id
WHERE
	ips.avg_fragmentation_in_percent >= 10 AND i.name IS NOT NULL
ORDER BY
	ips.avg_fragmentation_in_percent DESC;

OPEN IndexCursor;
FETCH NEXT FROM IndexCursor INTO @TableName, @IndexName, @Fragmentation;

WHILE @@FETCH_STATUS = 0
BEGIN
	PRINT @TableName + ' -> ' + @IndexName;
	BEGIN TRY
		IF @Fragmentation <= 30
		BEGIN
			EXEC('ALTER INDEX ' + @IndexName + ' ON ' + @TableName + ' REORGANIZE;')
		END
		ELSE
		BEGIN
			EXEC('ALTER INDEX ' + @IndexName + ' ON ' + @TableName + ' REBUILD;')
		END
	END TRY
	BEGIN CATCH
		PRINT '---------------------'
		PRINT 'Hata: ' + ERROR_MESSAGE()
		PRINT 'Tablo Adı:' +@TableName
		PRINT 'Index Adı: ' + @IndexName
		PRINT '---------------------'
	END CATCH
	FETCH NEXT FROM IndexCursor INTO @TableName, @IndexName, @Fragmentation;
END
CLOSE IndexCursor;
DEALLOCATE IndexCursor;
