Create database sampleDB;

CREATE TABLE SampleDB.dbo.TableChanges (
    ChangeID INT IDENTITY(1,1) PRIMARY KEY,
    DatabaseName VARCHAR(250) NOT NULL,    
    TableName VARCHAR(250) NOT NULL,       
    EventType NVARCHAR(250) NOT NULL,      
	LoginName VARCHAR(250) NOT NULL,       
    SQLCommand NVARCHAR(2500) NULL,        
	AuditDateTime DATETIME DEFAULT GETDATE() 
);

CREATE TRIGGER tr_AuditTableChanges
ON ALL SERVER
FOR CREATE_TABLE, ALTER_TABLE, DROP_TABLE
AS
BEGIN

    DECLARE @EventData XML;
    SELECT @EventData = EVENTDATA(); 

    INSERT INTO SampleDB.dbo.TableChanges 
    (DatabaseName, TableName, EventType, LoginName, SQLCommand, AuditDateTime)
    VALUES 
    (
        @EventData.value('(/EVENT_INSTANCE/DatabaseName)[1]', 'varchar(250)'),
        @EventData.value('(/EVENT_INSTANCE/ObjectName)[1]', 'varchar(250)'),  
        @EventData.value('(/EVENT_INSTANCE/EventType)[1]', 'nvarchar(250)'),  
        @EventData.value('(/EVENT_INSTANCE/LoginName)[1]', 'varchar(250)'),   
        @EventData.value('(/EVENT_INSTANCE/TSQLCommand)[1]', 'nvarchar(2500)'),
        GETDATE() 
    );
END;

CREATE TABLE SampleDB.dbo.TestTable (
    ID INT PRIMARY KEY,
    Name NVARCHAR(100)
);

ALTER TABLE SampleDB.dbo.TestTable
ADD Description NVARCHAR(255);

DROP TABLE SampleDB.dbo.TestTable;

Select * from SampleDB.dbo.TableChanges;



