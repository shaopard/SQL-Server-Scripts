DECLARE @addressId uniqueidentifier = '';

WITH HistoryCTE AS (
    SELECT
        *
    , Table_Name.ValidFrom
    ,    LEAD(ValidFrom) OVER (PARTITION BY Id ORDER BY ValidFrom) AS NextSysStartTime
    FROM dbo.Table_Name
    FOR SYSTEM_TIME ALL
    WHERE Id = @addressId
)
SELECT
    *
    , ISNULL(NextSysStartTime, '9999-12-31') AS SysEndTime
FROM
    HistoryCTE
ORDER BY HistoryCTE.ValidFrom DESC;