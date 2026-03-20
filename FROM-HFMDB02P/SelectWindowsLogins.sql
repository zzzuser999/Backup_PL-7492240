select *
from sys.server_principals sp
left join sys.sql_logins sl
          on sp.principal_id = sl.principal_id
where sp.type not in ('G', 'R')  AND sp.type_desc LIKE '%windows%' --AND sp.name like '%NT Service%' --AND sp.modify_date > '2021-01-31 23:59:59.000' 
--order by modify_date;