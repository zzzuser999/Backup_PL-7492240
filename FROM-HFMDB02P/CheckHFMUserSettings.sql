USE fm_prd
GO

	SELECT 
		'ABACUS08' as ApplicationName,
		*, 
		CONVERT(nVARCHAR(2000), BlobData) AS BlobText 
	FROM
		fm_prd.dbo.ABACUS08_USERPARAMS
		WHERE ParameterKey like '%clus%'
		ORDER BY BlobText