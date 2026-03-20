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