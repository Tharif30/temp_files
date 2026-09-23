SELECT
    CAST([StartTime] AS date) AS ExecutionDate,
    [storedprocedure],
    COUNT(*) AS ExecutionCount
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
