SELECT name FROM master.dbo.sysdatabases
WHERE dbid > 4 AND name NOT LIKE 'COGNOS%'
ORDER BY name