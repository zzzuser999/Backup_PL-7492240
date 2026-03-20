SELECT
    OBJECT_NAME(major_id) as ObjectName, USER_NAME(grantee_principal_id) as userName, permission_name as Permission
FROM
    sys.database_permissions p
--WHERE
    --p.class <> 1 --AND
    --OBJECTPROPERTY(major_id, 'IsMSSHipped') = 0 
WHERE USER_NAME(grantee_principal_id) LIKE '%PLBOTOT1'
ORDER BY
    OBJECT_NAME(major_id), USER_NAME(grantee_principal_id), permission_name