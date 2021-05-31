SELECT name AS FileName,
    convert(DOUBLE PRECISION, size*1.0/128/1024) AS FileSizeInGB,
    CASE max_size 
        WHEN 0 THEN 'Autogrowth is off.'
        WHEN -1 THEN 'Autogrowth is unlimited'
        ELSE 'File maxsize value set '
    END AS AutoGrowth,
	CASE max_size
		WHEN 0 THEN 0
		WHEN -1 THEN -1
		ELSE convert(DOUBLE PRECISION,max_size*1.0/128/1024) 
	END AS MaxSizeGB,
    convert(DOUBLE PRECISION, growth*1/128) AS GrowthValueMB,
    'GrowthIncrement' =
        CASE
            WHEN growth = 0 THEN 'Size is fixed.'
            WHEN growth > 0 AND is_percent_growth = 0
                THEN 'Growth in 8-KB pages.'
            ELSE 'Growth a percentage.'
        END
	, physical_name
FROM tempdb.sys.database_files;
GO