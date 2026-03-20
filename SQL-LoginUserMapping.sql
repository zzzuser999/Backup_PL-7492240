IF OBJECT_ID(N'tempdb..#results', 'U') IS NOT NULL 
	DROP TABLE #results;

CREATE TABLE #results(
	LoginName sysname
	,LoginType nvarchar(60)
	,IsMustChange bit
	,DatabaseName sysname NULL
	,DatabaseUserName sysname NULL
	,DatabaseRoleName sysname NULL
	);

EXEC sp_MSforeachdb '
USE [fm_prod_readerviews];
INSERT INTO #results
	SELECT
		sp.name AS LoginName
		,sp.type_desc AS LoginType
		--,CAST(LOGINPROPERTY ( sp.name , ''IsMustChange'' ) AS bit) AS IsMustChange
		,DB_NAME() AS DatabaseName
		,dp.name AS DatabaseUserName
		,r.name AS DatabaseRoleName
	FROM sys.server_principals sp
	LEFT JOIN sys.database_principals dp ON
		dp.sid = sp.sid
	LEFT JOIN sys.database_role_members drm ON
		drm.member_principal_id = dp.principal_id
	LEFT JOIN sys.database_principals r ON
		r.principal_id = drm.role_principal_id
	WHERE sp.name = ''MgmtComment_prod_reader'' and dp.name is not null';

SELECT * FROM #results;

IF OBJECT_ID(N'tempdb..#results', 'U') IS NOT NULL 
	DROP TABLE #results;

	select name from sys.server_principals