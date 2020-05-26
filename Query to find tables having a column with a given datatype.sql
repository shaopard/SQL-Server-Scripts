SELECT OBJECT_NAME(c.OBJECT_ID) TableName, c.name ColumnName, TYPE_NAME(user_type_id) AS TypeName
FROM sys.columns AS c
JOIN sys.tables AS t ON c.object_id=t.object_id
WHERE TYPE_NAME(user_type_id) in ('DECIMAL') AND PRECISION = 23 AND SCALE = 12 --you can change text to other datatypes
ORDER BY c.OBJECT_ID;
GO