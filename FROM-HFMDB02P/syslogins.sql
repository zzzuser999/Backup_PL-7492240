
USE Master
GO
SELECT [name], updatedate
FROM master.dbo.syslogins
WHERE [name] = 'DisclosureNet_prod_dbo'
GO