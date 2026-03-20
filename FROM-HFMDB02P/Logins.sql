select name, is_policy_checked
from sys.sql_logins

select sp.name
	   ,case when sp.is_policy_checked = 1 then 'True' Else 'False' end as 'Enforce Windows Password Policies'
	   from master.sys.sql_logins as sp left join master.sys.syslogins as sl on (sp.sid = sl.sid)
	   --WHERE sp.name LIKE 'P2EPM%'

select sp.name as login,
       sp.type_desc as login_type,
       --sl.password_hash,
       --sp.create_date,
       sp.modify_date,
       case when sp.is_disabled = 1 then 'Disabled'
            else 'Enabled' end as password_policy
from sys.server_principals sp
left join sys.sql_logins sl
          on sp.principal_id = sl.principal_id
where sp.type not in ('G', 'R') AND sp.name LIKE '%DisclosureNet_prod_dbo%'
order by sp.name;


-- Password last set time
SELECT 
    name AS LoginName, 
    modify_date AS LastPasswordSetDate
FROM 
    sys.sql_logins
ORDER BY 
    LastPasswordSetDate DESC;
