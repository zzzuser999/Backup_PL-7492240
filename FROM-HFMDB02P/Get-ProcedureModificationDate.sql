SELECT name, create_date, modify_date 
FROM sys.objects
WHERE modify_date > '2020-07-06 00:00:00' and type = 'P'
ORDER BY modify_date DESC