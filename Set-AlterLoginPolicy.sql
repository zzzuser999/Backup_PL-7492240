select name, is_policy_checked, 'ALTER LOGIN ' + name + ' WITH CHECK_POLICY = ON' from sys.sql_logins where is_policy_checked = 0

ALTER LOGIN test01 WITH CHECK_POLICY = ON