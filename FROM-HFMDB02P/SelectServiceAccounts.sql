/*select sp.name as login,
       sp.type_desc as login_type,
       sl.password_hash,
       sp.create_date,
       sp.modify_date, */
	   SELECT *
       --case when sp.is_disabled = 1 then 'Disabled'
         --   else 'Enabled' end as status
from sys.server_principals sp
left join sys.sql_logins sl
          on sp.principal_id = sl.principal_id
where sp.type not in ('G', 'R') and sp.name like '%sa%'
order by sp.name;

SELECT ar.replica_server_name
	,ag.name AS ag_name
	,ar.owner_sid
	,sp.name
FROM sys.availability_replicas ar
LEFT JOIN sys.server_principals sp
	ON sp.sid = ar.owner_sid 
INNER JOIN sys.availability_groups ag
	ON ag.group_id = ar.group_id
WHERE ar.replica_server_name = SERVERPROPERTY('ServerName') ;

USE master
GO
SELECT e.name as EndpointName,
sp.name AS EndpointOwner,
et.PayloadType,
e.state_desc
FROM sys.endpoints e
INNER JOIN sys.server_principals sp
ON e.principal_id = sp.principal_id
RIGHT OUTER JOIN ( VALUES ( 2, 'TSQL'),
( 3, 'SERVICE_BROKER'), ( 4, 'DATABASE_MIRRORING') )
AS et ( typeid, PayloadType )
ON et.typeid = e.type