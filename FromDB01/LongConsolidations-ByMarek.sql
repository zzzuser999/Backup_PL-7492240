    --Query pokazuje czasy dla  > @dateFrom i < @dateTo w UTC
    Declare @dateFrom as datetime = '2026-02-10 14:01' -- UTC time
    Declare @dateTo as datetime = '2026-02-10 17:00'-- UTC time
    SELECT  [User]
        ,[Activity]
      --,[ActivityCode]
        ,dateadd(HH, datediff(HH, getutcdate(), getdate()), [Time Started]) as 'TimeStartedCET'
        ,dateadd(HH, datediff(HH, getutcdate(), getdate()), [Time Ended]) as 'TimeEndedCET'
        , DATEDIFF(MINUTE, [Time Started], [Time Ended]) as 'Duration'
        ,[Server]
        ,[Descrition]
    FROM [fm_prod_readerviews].[dbo].[vTaskAudit_ABACUS13_Log]
    where [Time Started] > @dateFrom and [Time Started] < @dateTo--UTC time
    --and Activity = 'Consolidation'
    --and Activity = 'Extended Analytics Export'
    --and [Server]='XE-S-HFMAP03P' 
    --and [User]='CHAAHFM@ABB_AD'
    and Activity not in ('Logon','Logoff')
    and DATEDIFF(MINUTE, [Time Started], [Time Ended]) > 1
    --order by  [Time Started]; 
    order by Duration desc;