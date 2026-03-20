--Step 1 : Create temp tab;le
CREATE TABLE #tempMappings (LoginName nvarchar(1000),
DBname nvarchar(1000),
Username nvarchar(1000),
Alias nvarchar(1000))
--Step 2:Insert the sp_msloginmappings into the temp table
INSERT INTO #tempMappings
EXEC master..sp_msloginmappings
--Step 3 : List the results . Filter as required
SELECT *
FROM   #tempMappings WHERE username LIKE '%bot%'
ORDER BY DBname, username
--Step 4:  Manage cleanup of temp table
DROP TABLE #tempMappings