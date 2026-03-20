select 
 j.name as 'JobName',
 run_date,
 run_time,
 msdb.dbo.agent_datetime(run_date, run_time) as 'RunDateTime',
 run_duration
From msdb.dbo.sysjobs j 
INNER JOIN msdb.dbo.sysjobhistory h 
 ON j.job_id = h.job_id 
where j.name = 'DC_ArchiveEPMLogs' and run_date = '20220214'  --Only Enabled Jobs 
order by JobName, RunDateTime desc