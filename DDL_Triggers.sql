CREATE TABLE DDL_Audit (
    AuditID INT IDENTITY(1,1) PRIMARY KEY,
    EventType NVARCHAR(100),      
    EventTime DATETIME DEFAULT GETDATE(),  
    EventData XML                  
);

CREATE or alter TRIGGER trg_DDL_LogTableChanges
ON DATABASE
FOR CREATE_TABLE, ALTER_TABLE,RENAME, DROP_TABLE
AS
BEGIN
        
    INSERT INTO DDL_Audit (EventType, EventData)
    VALUES (EVENTDATA().value('(/EVENT_INSTANCE/EventType)[1]', 'NVARCHAR(100)'),
            EVENTDATA());

    PRINT 'DDL change logged successfully.';
END;

CREATE TABLE Number (
    num INT                   
);
Exec sp_rename 'Number', 'Integer';
Drop table Integer;


Select * from DDL_Audit;





