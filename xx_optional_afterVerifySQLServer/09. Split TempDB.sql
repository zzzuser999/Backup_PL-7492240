---------------------------------------------------
---!!!!---CHANGE PATHS FOR EACH FILE---!!!!--------
---------------------------------------------------	
---https://support.microsoft.com/pl-pl/kb/2154845

	
	SELECT name, physical_name, state_desc
	FROM sys.master_files
	WHERE database_id = DB_ID(N'tempdb');
	 
	 
	ALTER DATABASE tempdb 
	MODIFY FILE 
	(NAME = tempdev, NEWNAME = tempdb01, FILENAME = 'T:\SQLTEMPDB\MSSQL12.TMSDEV\tempdb.mdf', SIZE = 6GB, MAXSIZE = 6GB, FILEGROWTH = 0MB)
	 
	ALTER DATABASE tempdb
	ADD FILE
	(NAME = tempdb02, FILENAME = 'T:\SQLTEMPDB\MSSQL12.TMSDEV\tempdb02.mdf', SIZE = 6GB, MAXSIZE = 6GB, FILEGROWTH = 0MB)
	 
	ALTER DATABASE tempdb
	ADD FILE
	(NAME = tempdb03, FILENAME = 'T:\SQLTEMPDB\MSSQL12.TMSDEV\tempdb03.mdf', SIZE = 6GB, MAXSIZE = 6GB, FILEGROWTH = 0MB)
	 
	ALTER DATABASE tempdb
	ADD FILE
	(NAME = tempdb04, FILENAME = 'T:\SQLTEMPDB\MSSQL12.TMSDEV\tempdb04.mdf', SIZE = 6GB, MAXSIZE = 6GB, FILEGROWTH = 0MB)
	 
	ALTER DATABASE tempdb
	ADD FILE
	(NAME = tempdb05, FILENAME = 'T:\SQLTEMPDB\MSSQL12.TMSDEV\tempdb05.mdf', SIZE = 6GB, MAXSIZE = 6GB, FILEGROWTH = 0MB)
	 
	ALTER DATABASE tempdb
	ADD FILE
	(NAME = tempdb06, FILENAME = 'T:\SQLTEMPDB\MSSQL12.TMSDEV\tempdb06.mdf', SIZE = 6GB, MAXSIZE = 6GB, FILEGROWTH = 0MB)
	 
	ALTER DATABASE tempdb
	ADD FILE
	(NAME = tempdb07, FILENAME = 'T:\SQLTEMPDB\MSSQL12.TMSDEV\tempdb07.mdf', SIZE = 6GB, MAXSIZE = 6GB, FILEGROWTH = 0MB)
	 
	ALTER DATABASE tempdb
	ADD FILE
	(NAME = tempdb08, FILENAME = 'T:\SQLTEMPDB\MSSQL12.TMSDEV\tempdb08.mdf', SIZE = 6GB, MAXSIZE = 6GB, FILEGROWTH = 0MB)
	 
	ALTER DATABASE tempdb
	MODIFY FILE
	(NAME = templog, SIZE = 1GB, MAXSIZE = 4GB, FILEGROWTH = 512MB)
