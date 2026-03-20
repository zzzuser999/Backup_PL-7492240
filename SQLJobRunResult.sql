 SELECT 
	JobName, 
	LastRunDateTime as [Start],
	Duration as [Duration],
	DATEADD(second, DATEDIFF(second, GETDATE(), GETUTCDATE()), LastRunDateTime) as [Start],
	DATEADD(second, DATEDIFF(second, GETDATE(), GETUTCDATE()), DATEADD(SECOND, Duration,LastRunDateTime)) as [End],
	LastRunStatus
FROM
(SELECT 
	@@SERVERNAME as [InstanceName],
	[run_duration]/10000*3600+[run_duration]%10000/100*60+[run_duration]%100 as Duration,
	j.name as [JobName],
	j.enabled as [Enabled],
	CASE 
			WHEN run_date IS NULL OR run_time IS NULL THEN NULL
			ELSE CAST(CAST(run_date AS CHAR(8)) + ' '  + STUFF(
				STUFF(RIGHT('000000' + CAST(run_time AS VARCHAR(6)),  6)
							, 3, 0, ':')
						, 6, 0, ':')
					AS DATETIME)
			END AS [LastRunDateTime]
	 , CASE [run_status]
			WHEN 0 THEN 'Failed'
			WHEN 1 THEN 'Succeeded'
			WHEN 2 THEN 'Retry'
			WHEN 3 THEN 'Canceled'
			WHEN 4 THEN 'Running' -- In Progress
	   END AS [LastRunStatus]
	FROM msdb.dbo.sysjobs j
	INNER JOIN msdb.dbo.sysjobhistory h ON j.job_id = h.job_id 
	WHERE h.[step_id] = 0
) AS JOB
WHERE [Enabled] = 1 
AND JobName in ('DC_HFM_DataAudit_ImportAccess','DC_ArchiveEPMLogs','HSSReportsSnapshot','IntelexHeadcountSnapshot')
--AND $__timeFilter(LastRunDateTime)
AND LastRunDateTime >= '2024-06-25 04:00:00'
ORDER BY JobName, LastRunDateTime asc