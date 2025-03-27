SELECT
	OBJECT_NAME(ips.object_id) TableName,
	i.name IndexName,
	ips.index_type_desc IndexType,
	ips.avg_fragmentation_in_percent FragmentationPercent,
	ips.fragment_count FragmentCount,
	ips.page_count PageCount
FROM
	sys.dm_db_index_physical_stats(DB_ID(), NULL, NULL, NULL, NULL) ips
JOIN
	sys.indexes i ON ips.object_id = i.object_id
WHERE
	ips.avg_fragmentation_in_percent >= 10
ORDER BY
	ips.avg_fragmentation_in_percent DESC
