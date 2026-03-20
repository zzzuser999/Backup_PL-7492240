DECLARE @name sysname = N'fm_prod_userparams_writer'; -- input param, presumably

DECLARE @sql nvarchar(max) = N'';

SELECT @sql += N'UNION ALL SELECT N''' + REPLACE(name,'''','''''') + ''' as Name,
    p.name                 COLLATE SQL_Latin1_General_CP1_CI_AS as Login, 
    p.default_schema_name  COLLATE SQL_Latin1_General_CP1_CI_AS, 
    STUFF((SELECT N'','' + r.name 
      FROM ' + QUOTENAME(name) + N'.sys.database_principals AS r
      INNER JOIN ' + QUOTENAME(name) + N'.sys.database_role_members AS rm
      ON r.principal_id = rm.role_principal_id
      WHERE rm.member_principal_id = p.principal_id
      FOR XML PATH, TYPE).value(N''.[1]'',''nvarchar(max)''),1,1,N'''')
    FROM sys.server_principals AS sp
    LEFT OUTER JOIN ' + QUOTENAME(name) + '.sys.database_principals AS p
    ON sp.sid = p.sid
    WHERE sp.name = @name AND p.name = ''fm_prod_userparams_writer'''
  FROM sys.databases WHERE [state] = 0;

SET @sql = STUFF(@sql, 1, 9, N'');

PRINT @sql;
EXEC master.sys.sp_executesql @sql, N'@name sysname', @name;