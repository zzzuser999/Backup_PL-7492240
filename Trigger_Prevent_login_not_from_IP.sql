USE [master]
GO

/*
***** Object:  DdlTrigger [Prevent_login_not_from_IP] 
***** Create Date: 11.07.2024
***** Create By: Mateusz MROWKA
*/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE TRIGGER [Prevent_login_not_from_IP]
ON ALL SERVER WITH EXECUTE AS 'sa'
FOR LOGON
AS
BEGIN

  SET CONCAT_NULL_YIELDS_NULL ON
  SET ANSI_WARNINGS ON
  SET ANSI_PADDING ON

  DECLARE @LoginName sysname
  DECLARE @LoginType sysname
  
    SET @LoginName = ORIGINAL_LOGIN()
 ---logins permited to connect
  IF(@LoginName in(
'prd_hss_dbo', ---Sharedservices PROD
'prd_hfm_dbo', ---HFM PROD
'prd_fdmee_dbo', ---FinacialDataQualityMenagement PROD
'prd_ea_dbo', ---ExtendedAnalitics PROD
'dr_hss_dbo', ---Sharedservices DR
'dr_hfm_dbo', ---HFM DR
'dr_fdmee_dbo',  ---FinacialDataQualityMenagement DR
'dr_ea_dbo' ---ExtendedAnalitics DR
)
 and 
   (EVENTDATA().value('(/EVENT_INSTANCE/ClientHost)[1]','nvarchar(128)') NOT IN /*List of IPs*/
(
'<local machine>',
-- HFM DR servers
'10.17.104.80',--XF-S-XHFMTM02R | TerminalServer
'10.17.103.142',--XF-S-NHFMFE01R | FE1R 
'10.17.103.143',--XF-S-NHFMFE02R | FE2R
'10.17.103.144',--XF-S-NHFMAP01R | AP01R
'10.17.103.145',--XF-S-NHFMAP02R | AP02R
'10.17.103.146',--XF-S-NHFMAP03R | AP03R
'10.17.103.44',--XF-S-NHFMDB01R	| DB01R server
'10.17.103.45',--XF-S-NHFMDB02R | DB02R server
-- HFM PROD servers
'10.16.111.115', --XE-S-NHFMTM01P | TerminalServer
'10.16.111.102',--XE-S-NHFMFE01P | FE server
'10.16.111.103',--XE-S-NHFMFE02P | FE server
'10.16.127.40',--XE-S-NHFMAP01P | FE server
'10.16.127.41',--XE-S-NHFMAP02P | FE server
'10.16.127.42',--XE-S-NHFMAP03P | FE server
'10.16.127.44',--XE-S-NXHFMDB02P | DB server
'10.16.127.43' --XE-S-NXHFMDB01P | DB server

		)))
		BEGIN
      ROLLBACK; --Disconnect the session
  END
  END
GO

DISABLE TRIGGER [Prevent_login_not_from_IP] ON ALL SERVER
GO