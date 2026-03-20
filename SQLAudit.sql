-- SQL Server Version and Edition
SELECT
    SERVERPROPERTY('MachineName') AS MachineName,
    SERVERPROPERTY('ServerName') AS ServerName,
    SERVERPROPERTY('InstanceName') AS InstanceName,
    SERVERPROPERTY('Edition') AS Edition,
    SERVERPROPERTY('ProductVersion') AS ProductVersion,
    SERVERPROPERTY('ProductLevel') AS ProductLevel,
    SERVERPROPERTY('EngineEdition') AS EngineEdition,
    SERVERPROPERTY('IsClustered') AS IsClustered,
    SERVERPROPERTY('IsHadrEnabled') AS IsHadrEnabled,
    SERVERPROPERTY('IsIntegratedSecurityOnly') AS IsIntegratedSecurityOnly,
    SERVERPROPERTY('ProcessID') AS ProcessID,
    SERVERPROPERTY('Collation') AS Collation,
    SERVERPROPERTY('BuildClrVersion') AS BuildClrVersion,
    SERVERPROPERTY('ResourceLastUpdateDateTime') AS ResourceLastUpdateDateTime,
    SERVERPROPERTY('SqlCharSet') AS SqlCharSet,
    SERVERPROPERTY('SqlCharSetName') AS SqlCharSetName,
    SERVERPROPERTY('LCID') AS LCID;


-- Configuration settings
SELECT name, value_in_use
FROM sys.configurations
WHERE name IN (
    'max degree of parallelism', 
    'cost threshold for parallelism',
    'min server memory (MB)', 
    'max server memory (MB)',
    'backup compression default', 
    'optimize for ad hoc workloads'
);

-- Authentication mode
DECLARE @LoginMode INT;

EXEC xp_instance_regread 
    N'HKEY_LOCAL_MACHINE',
    N'Software\Microsoft\MSSQLServer\MSSQLServer',
    N'LoginMode',
    @LoginMode OUTPUT;

SELECT 
    CASE @LoginMode
        WHEN 1 THEN 'Windows'
        WHEN 2 THEN 'Mixed'
        ELSE 'Unknown'
    END AS AuthenticationMode;

-- Sysadmin members
SELECT sp.name as 'sysadmin'
FROM sys.server_principals sp
JOIN sys.server_role_members rm ON sp.principal_id = rm.member_principal_id
WHERE rm.role_principal_id = SUSER_ID('sysadmin');

-- Orphaned users
EXEC sp_change_users_login 'Report';

-- List of databases
SELECT name, suser_sname(owner_sid) AS Owner, recovery_model_desc,
       compatibility_level, page_verify_option_desc
FROM sys.databases;

-- File locations
SELECT db_name(database_id) AS DatabaseName, 
       name AS LogicalName,
       type_desc AS FileType, 
       physical_name AS FilePath,
       size * 8 / 1024 AS SizeMB
FROM sys.master_files;

-- SQL default data/log paths
SELECT 
    SERVERPROPERTY('InstanceDefaultDataPath') AS DefaultDataPath,
    SERVERPROPERTY('InstanceDefaultLogPath') AS DefaultLogPath;

-- SQL Default backup path
DECLARE @BackupPath NVARCHAR(4000);

EXEC master.dbo.xp_instance_regread
    N'HKEY_LOCAL_MACHINE',
    N'Software\Microsoft\MSSQLServer\MSSQLServer',
    N'BackupDirectory',
    @BackupPath OUTPUT;

SELECT @BackupPath AS DefaultBackupPath;

-- Backup info
SELECT 
    database_name,
    MAX(backup_finish_date) AS LastBackupDate,
    CASE type WHEN 'D' THEN 'Full' WHEN 'I' THEN 'Differential' WHEN 'L' THEN 'Log' END AS BackupType
FROM msdb.dbo.backupset
GROUP BY database_name, type
ORDER BY database_name;

-- SQL Agent jobs
SELECT name, enabled, date_created, date_modified
FROM msdb.dbo.sysjobs;

-- Wait stats
SELECT TOP 20 wait_type, wait_time_ms, waiting_tasks_count
FROM sys.dm_os_wait_stats
ORDER BY wait_time_ms DESC;

-- TempDB configuration
SELECT name, physical_name, size * 8 / 1024 AS SizeMB
FROM sys.master_files
WHERE database_id = 2;