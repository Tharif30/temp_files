SELECT
    CAST([StartTime] AS date) AS ExecutionDate,
    [storedprocedure],
    COUNT(DISTINCT CONCAT(
        CAST([SPID] AS varchar(20)),
        '|',
        CONVERT(varchar(30), [StartTime], 121)
    )) AS ExecutionCount
FROM [DBADB].[dbo].[longqrydetails]
WHERE [StartTime] >= DATEADD(DAY, -21, CAST(GETDATE() AS date))
  AND [storedprocedure] IS NOT NULL
  AND LTRIM(RTRIM([storedprocedure])) <> ''
GROUP BY
    CAST([StartTime] AS date),
    [storedprocedure]
ORDER BY
    ExecutionDate DESC,
    ExecutionCount DESC;



--query_store
SELECT
    CAST(rsi.start_time AS date) AS ExecutionDate,
    OBJECT_SCHEMA_NAME(q.object_id) AS SchemaName,
    OBJECT_NAME(q.object_id) AS StoredProcedure,
    SUM(rs.count_executions) AS ExecutionCount
FROM sys.query_store_query AS q
INNER JOIN sys.query_store_plan AS p
    ON q.query_id = p.query_id
INNER JOIN sys.query_store_runtime_stats AS rs
    ON p.plan_id = rs.plan_id
INNER JOIN sys.query_store_runtime_stats_interval AS rsi
    ON rs.runtime_stats_interval_id = rsi.runtime_stats_interval_id
WHERE q.object_id > 0
  AND OBJECTPROPERTY(q.object_id, 'IsProcedure') = 1
  AND rsi.start_time >= DATEADD(DAY, -21, CAST(GETDATE() AS date))
  AND rs.execution_type = 0
GROUP BY
    CAST(rsi.start_time AS date),
    q.object_id
ORDER BY
    ExecutionDate DESC,
    ExecutionCount DESC;
