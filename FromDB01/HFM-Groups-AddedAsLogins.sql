select sp.name as login
from sys.server_principals sp
left join sys.sql_logins sl
          on sp.principal_id = sl.principal_id
where sp.type in ('G')
order by sp.name;

Select SERVERPROPERTY('MachineName') as 'MachineName';