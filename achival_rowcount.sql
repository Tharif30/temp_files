SELECT [SourceTablename ]

,[DestinationTableName]

,LEFT([Filter],33) AS 'Archival_Condition'

,SUM( [Rows ]) AS 'Total_Archived_Rows'

FROM [DBADB]. [dbo]. [TBL_RETENTION_MASTER_AUTO] WHERE SourceTablename=' [MARSPROD] . [dbo]. [AT_TERMINAL_DATA]'

AND CAST(LastUpdated as DATE)>=CAST(GETDATE()-2 AS DATE)

GROUP BY SourceTablename, DestinationTableName, LEFT([Filter],33)
 
