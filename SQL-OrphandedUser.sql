/* Reference: 
https://www.sqlshack.com/how-to-discover-and-handle-orphaned-database-users-in-sql-server/
*/

-- Finding orphaned USERS

-- Method 1

Use [fm_prod_readerviews];
GO
exec sp_change_users_login @Action='Report' ;
GO

-- Method 2

USE [fm_prod_readerviews]
GO

select p.name,p.sid
from sys.database_principals p
where p.type in ('G','S','U')
--where p.type in ()
and p.sid not in (select sid from sys.server_principals)
and p.name not in (
    'dbo',
    'guest',
    'INFORMATION_SCHEMA',
    'sys',
    'MS_DataCollectorInternalUser'
) ;


-- Matching login with USER

EXEC dbo.sp_change_users_login 
@Action          = 'update_one', 
@UserNamePattern = 'ABBEpmTools_prod_reader', 
@LoginName       = 'ABBEpmTools_prod_reader';

/* Other method
--First, make sure that this is the problem. This will lists the orphaned users:

EXEC sp_change_users_login 'Report'

--If you already have a login id and password for this user, fix it by doing:

EXEC sp_change_users_login 'Auto_Fix', 'user'
*/ 