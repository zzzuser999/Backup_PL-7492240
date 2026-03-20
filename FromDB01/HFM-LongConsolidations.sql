  --Query pokazuje czasy dla  > @dateFrom i < @dateTo w UTC
  Declare @dateFrom as datetime = '2022-01-10 01:00' -- UTC time
  Declare @dateTo as datetime = '2022-01-10 18:00'-- UTC time
  SELECT  [User]
      ,[Activity]
      ,dateadd(HH, datediff(HH, getutcdate(), getdate()), [Time Started]) as 'TimeStartedCET'
      ,dateadd(HH, datediff(HH, getutcdate(), getdate()), [Time Ended]) as 'TimeEndedCET'
      , DATEDIFF(MINUTE, [Time Started], [Time Ended]) 'Duration'
      ,[Server]
      ,[Descrition]
  FROM [fm_prod_readerviews].[dbo].[vTaskAudit_ABACUS08_Log]
  where [Time Started] > @dateFrom and [Time Started] < @dateTo--UTC time
  --and Activity = 'Consolidation' 
  --and [Server]='XE-S-HFMAP03P' 
  --and [User]='CHAAHFM@ABB_AD'
  and Activity not in ('Logon','Logoff')
  and DATEDIFF(MINUTE, [Time Started], [Time Ended]) > 1
  order by  [Time Started]
