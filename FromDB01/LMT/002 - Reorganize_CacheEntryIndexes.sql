BEGIN TRY
	ALTER INDEX [IX_CacheEntry_Zone] ON [cache].[CacheEntry]
	REORGANIZE;

	ALTER INDEX [IX_CacheEntry_Key] ON [cache].[CacheEntry]
	REORGANIZE;

	ALTER INDEX [IX_CacheEntry_Key_Unique] ON [cache].[CacheEntry]
	REORGANIZE;

	ALTER INDEX [PK_CacheEntry] ON [cache].[CacheEntry]
	REORGANIZE;
END TRY  
BEGIN CATCH 
	print 'cannot reorganize indexes'
END CATCH

GO