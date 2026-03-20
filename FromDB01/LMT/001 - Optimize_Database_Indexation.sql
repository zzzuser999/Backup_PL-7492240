--
-- Monitored Recommendation / Reduce Lookups
--
IF EXISTS (SELECT 1 FROM sysindexes WHERE NAME = 'IX_CacheEntry_Zone')
BEGIN
       DROP INDEX [IX_CacheEntry_Zone] ON [cache].[CacheEntry]
END
GO
CREATE NONCLUSTERED INDEX [IX_CacheEntry_Zone] ON [cache].[CacheEntry]
(
       [Zone] ASC
)
INCLUDE (     [CreationTime],
       [Key],
       [LastAccessedTime],
       [Policy],
       [Priority]) WITH (STATISTICS_NORECOMPUTE = OFF, DROP_EXISTING = OFF, ONLINE = OFF) ON [PRIMARY]
GO
