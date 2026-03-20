SELECT @@ServerNAME as ServerName
       ,dbpm.NAME as Name
       ,dbpm.type_desc
       ,ISNULL(dbpr.NAME,'') as RoleName
       ,dbpm.is_disabled
       ,dbpm.modify_date
FROM sys.server_role_members dbrm
    RIGHT OUTER JOIN sys.server_principals dbpm ON dbrm.member_principal_id = dbpm.principal_id
LEFT OUTER JOIN sys.server_principals dbpr ON dbrm.role_principal_id = dbpr.principal_id
WHERE dbpr.Name <> ''
ORDER BY dbpm.NAME,dbpr.NAME
