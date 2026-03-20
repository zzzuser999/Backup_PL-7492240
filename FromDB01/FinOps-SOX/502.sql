SELECT   sp.name as Account
,sp.[principal_id] as "Account Principal ID"
      ,sp.[sid] as "Account SID"
      ,sp.[type_desc] as "Account Type"
      ,sp.[is_disabled] as "Account Disabled"
      ,sl.denylogin as "Account Deny Login"
      ,sl.hasaccess as "Has Access"
      ,sp.[create_date] as "Account Create Date"
      ,sp.[modify_date] as "Account Modify Date"
      , LOGINPROPERTY(sp.name,'PasswordLastSetTime') as "Account Last Password Change Date"
      ,sp.is_policy_checked as "Enforce Windows Password Policies?"
      , sp.is_expiration_checked as "Enforce Windows Expiration Policies?"
      , sp.password_hash as "Password Hash"
      , case when (PWDCOMPARE('',sp.password_hash)=1) then 'Yes' Else 'No' End as "Blank Password?"
       FROM master.sys.sql_logins as sp LEFT JOIN
       master.sys.syslogins as sl
       on (sp.sid = sl.sid);