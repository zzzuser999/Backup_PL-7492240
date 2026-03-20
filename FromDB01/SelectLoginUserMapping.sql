USE fm_prod_readerviews
GO

SELECT db_name(), a.name AS UserName, b.name AS RoleName
FROM sys.database_principals AS a 
INNER JOIN sys.database_role_members ON a.principal_id = sys.database_role_members.member_principal_id 
INNER JOIN sys.database_principals AS b ON b.principal_id = sys.database_role_members.role_principal_id
WHERE a.name like 'EUROPE\PLBOT%';