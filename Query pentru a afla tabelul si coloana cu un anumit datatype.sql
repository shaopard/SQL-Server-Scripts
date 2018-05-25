SELECT OBJECT_NAME(c.OBJECT_ID) TableName, c.name ColumnName
FROM sys.columns AS c
JOIN sys.types AS t ON c.user_type_id=t.user_type_id
WHERE t.name = 'datetime2' --you can change text to other datatypes
ORDER BY c.OBJECT_ID;
GO