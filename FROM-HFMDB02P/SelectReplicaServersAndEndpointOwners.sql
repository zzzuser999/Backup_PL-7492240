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


SELECT
me.name AS EndpointName
,sp.name AS EndpointOwner -- ID of the principal that created and owns this endpoint
,me.type_desc AS EndpointDescription
,me.endpoint_id AS EndpointID
,me.state_desc AS EndpointState
,role_desc AS RoleDescription -- Can be none, partner, witness, or all
FROM sys.database_mirroring_endpoints me
INNER JOIN sys.server_principals sp ON me.principal_id = sp.principal_id

select e.name
    , p.state_desc, SUSER_NAME(p.grantor_principal_id) AS Grantor
    , p.permission_name, SUSER_NAME(p.grantee_principal_id) AS Grantee
from sys.endpoints AS e
    join sys.server_permissions AS p
        on e.endpoint_id = p.major_id
where name = 'Hadr_endpoint'