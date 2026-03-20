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


USE master
GO
SELECT SUSER_NAME(principal_id) AS endpoint_owner,
name as endpoint_name
FROM sys.database_mirroring_endpoints

USE master
GO
select g.name AS GroupName, p.name AS OwnerName
from sys.availability_groups as g
    join sys.availability_replicas AS r
        on g.group_id = r.group_id
    join sys.server_principals AS p
        on r.owner_sid = p.sid