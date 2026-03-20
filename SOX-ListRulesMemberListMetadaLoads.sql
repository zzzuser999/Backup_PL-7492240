SELECT TOP (1000) [User]
      ,[Activity]
      ,[Time Started]
      ,[Time Ended]
      ,[Server]
      ,[Current Module]
  FROM [fm_prod_readerviews].[dbo].[vTaskAudit_ABACUS13_Log]
  where Activity in ('Rules Load','Metadata Load','Member List Load')
  and [Time Started] >='2026-02-05' and [Time Started] <'2026-02-06'
  order by [Time Started]
