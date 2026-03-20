
 UPDATE [core].[ExpirationPolicy] SET [PolicyType] = 4, [Description] = 'Invalidate 90 days after creation', [PolicyXml] = N'﻿<?xml version="1.0" encoding="utf-8"?><Expiration slidingTimeSpan="90.00:00:00"/>' WHERE [Name] = 'DefaultObjectExpiration'
 DELETE FROM [cache].ca WHERE [Key] NOT like '%QueryId%' 
  
  --UPDATE [CDM.Rest].[core].[ExpirationPolicy] SET [PolicyType] = 3, [Description] = 'Invalidate after two days of inactivity', [PolicyXml] = N'﻿<?xml version="1.0" encoding="utf-8"?><Expiration slidingTimeSpan="2.00:00:00"/>' WHERE [Name] = 'DefaultObjectExpiration'