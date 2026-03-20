USE master
GO
select g.name AS GroupName, p.name AS OwnerName
from sys.availability_groups as g
    join sys.availability_replicas AS r
        on g.group_id = r.group_id
    join sys.server_principals AS p
        on r.owner_sid = p.sid