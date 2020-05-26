SELECT OBJECT_NAME(OBJECT_ID) as databasename, last_user_update, *
from sys.dm_db_index_usage_stats
where database_id = DB_ID('albuquerque') and OBJECT_ID = OBJECT_ID('station')
GO