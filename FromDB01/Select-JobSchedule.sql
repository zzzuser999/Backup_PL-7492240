SELECT @@servername;

SELECT sj.name AS jobName
, ss.name AS scheduleName
, sja.next_scheduled_run_date
FROM msdb.dbo.sysjobs sj
INNER JOIN msdb.dbo.sysjobactivity sja ON sja.job_id = sj.job_id
INNER JOIN msdb.dbo.sysjobschedules sjs ON sjs.job_id = sja.job_id
INNER JOIN msdb.dbo.sysschedules ss ON ss.schedule_id = sjs.schedule_id
WHERE (sj.name LIKE 'DC_ArchiveEPMLogs')
AND (sja.next_scheduled_run_date > GETDATE())