-- CREATE SCHEMA etl AUTHORIZATION dbo

CREATE TABLE etl.ControlTable (
	TableName VARCHAR(100) PRIMARY KEY,
	LastLoadDate DATETIME NOT NULL,
	RowProcessed INT NULL,
	Status VARCHAR(20) DEFAULT 'Success',
	LastRunDuration INT NULL
)
