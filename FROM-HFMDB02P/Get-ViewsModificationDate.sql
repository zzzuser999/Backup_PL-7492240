USE Database_Name
SELECT name, create_date, modify_date
FROM sys.objects
WHERE type = 'V'
AND DATEDIFF(D, create_date, GETDATE()) < 10