          --Create temporary tabel to store results if not exist
if OBJECT_ID('tempdb..##DBAccesses') is null
              CREATE TABLE [dbo].[##DBAccesses]( 
                     [DBName] [nvarchar](50) NULL,
                     [UserName] [nvarchar](100) NULL,
                     [RoleName] [nvarchar](100) NULL
              ) ON [PRIMARY]

-- defain DB accesses Query
declare @sqlc as varchar(1500)
set @sqlc = '
use [?] 
SELECT db_name(), a.name AS UserName, b.name AS RoleName
FROM sys.database_principals AS a 
INNER JOIN sys.database_role_members ON a.principal_id = sys.database_role_members.member_principal_id 
INNER JOIN sys.database_principals AS b ON b.principal_id = sys.database_role_members.role_principal_id'    

--Run query for all databases in sql server
INSERT INTO [dbo].[##DBAccesses]
           (DBName,UserName,RoleName)
exec sp_MSForEachDB @sqlc

--Select results from temporary table
Select * from [dbo].[##DBAccesses] order by 1,3
           --Remove temporary table
if OBJECT_ID('tempdb..##DBAccesses') is not null
DROP TABLE [dbo].[##DBAccesses]
