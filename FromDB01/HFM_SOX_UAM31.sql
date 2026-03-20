USE [fm_prod_readerviews];
GO

SELECT [LogDateStr]
      ,[LogTimeStr]
      ,[ScenarioName]
      ,[PeriodName]
      ,[EntityName]
      ,[ValueID]
      ,[ValueName]
      ,[AccountName]
      ,[ICPName]
      ,[Custom1Name]
	  ,[Custom2Name]
	  ,[Custom3Name]
	  ,[Custom4Name]
      ,[UserName]
      ,[ServerName]
      ,[ActivityID]
	  ,[DataValue]
	  ,[bNoData]
	  ,[LogDate]
FROM [fm_prod_readerviews].[dbo].[vDataAudit_ABACUS10_Log]
where UserName in ('PLEMGEO@ABB_AD')
and LogDate >= '2023-09-05'