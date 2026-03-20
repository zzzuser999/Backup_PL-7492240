--Show Availability groups visible to the Server and Replica information such as Which server is the Primary
--Sync and Async modes , Readable Secondary and Failover Mode, these can all be filtered using a Where clause
--if you are running some checks, no Where clause will show you all of the information.
WITH AGStatus AS(
SELECT
name as AGname,
replica_server_name,
CASE WHEN  (primary_replica  = replica_server_name) THEN  1
ELSE  '' END AS IsPrimaryServer,
secondary_role_allow_connections_desc AS ReadableSecondary,
[availability_mode]  AS [Synchronous],
failover_mode_desc
FROM master.sys.availability_groups Groups
INNER JOIN master.sys.availability_replicas Replicas ON Groups.group_id = Replicas.group_id
INNER JOIN master.sys.dm_hadr_availability_group_states States ON Groups.group_id = States.group_id
)
 
Select
[AGname],
[Replica_server_name],
[IsPrimaryServer],
[Synchronous],
[ReadableSecondary],
[Failover_mode_desc]
FROM AGStatus
--WHERE
--IsPrimaryServer = 1
--AND Synchronous = 1
ORDER BY
AGname ASC,
IsPrimaryServer DESC;