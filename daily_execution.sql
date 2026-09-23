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
