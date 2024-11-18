

Insert into Departments values (3,'Admin','Delhi'),(4,'DS','Banglore');



CREATE TABLE EmployeeAudit (
    AuditID INT IDENTITY(1,1) PRIMARY KEY, 
    EmployeeID INT,                         
    FirstName VARCHAR(50),                 
    LastName VARCHAR(50),                   
    ActionType VARCHAR(10),                 
    ActionDate DATETIME DEFAULT GETDATE()   
);


Alter TRIGGER trg_AfterInsert_Employee
ON Employee
AFTER INSERT
AS
BEGIN
    PRINT 'New employee record inserted.'
    INSERT INTO EmployeeAudit (EmployeeID, FirstName, LastName, ActionType, ActionDate)
    SELECT EmployeeID, FirstName, LastName, 'INSERT', GETDATE()
    FROM INSERTED

	Select * from Employee;
	Select * from Departments;
	Select * from EmployeeAudit;
END

Insert into Employee values (6,'Samadhan','Tube','Data Eng',75000.46,4);

---------------------------------------------------------------------------------------------------
Alter TRIGGER trg_AfterDelete_Employee
ON Employee
AFTER DELETE
AS
BEGIN
    PRINT 'Employee record deleted.'
    INSERT INTO EmployeeAudit (EmployeeID, FirstName, LastName, ActionType, ActionDate)
    SELECT EmployeeID, FirstName, LastName, 'DELETE', GETDATE()
    FROM DELETED

	Select * from Employee;
	Select * from Departments;
	Select * from EmployeeAudit;
END

Delete from Employee where EmployeeID=4;

------------------------------------------------------------------------------------------------

Alter TRIGGER trg_AfterUpdate_Employee
ON Employee
AFTER UPDATE
AS
BEGIN
    PRINT 'Employee record updated.'
    INSERT INTO EmployeeAudit (EmployeeID, FirstName, LastName, ActionType, ActionDate)
    SELECT EmployeeID, FirstName, LastName, 'Before-UPDATE', GETDATE()
    FROM deleted

    INSERT INTO EmployeeAudit (EmployeeID, FirstName, LastName, ActionType, ActionDate)
    SELECT EmployeeID, FirstName, LastName, 'After-UPDATE', GETDATE()
    FROM inserted

	
	Select * from Employee;
	Select * from Departments;
	Select * from EmployeeAudit;
END

Update dbo.Employee 
set Position='Sr. Data Eng'
where EmployeeID=5

-------------------------------------------------------------------------------------------------

Alter VIEW EmployeeDepartmentView AS
SELECT 
    e.EmployeeID,
    e.FirstName,
    e.LastName,
    e.Position,
    e.Salary,
    d.DepartmentName
FROM 
    Employee e
JOIN 
    Departments d ON e.DepartmentID = d.DepartmentID;


Alter TRIGGER InsteadOfInsert_vWEmployeeDetails
ON EmployeeDepartmentView
INSTEAD OF INSERT
AS
BEGIN
    DECLARE @DeptID INT;

    
    SELECT @DeptID = DepartmentID
    FROM Departments
    JOIN inserted ON inserted.DepartmentName = Departments.DepartmentName;

    
    IF (@DeptID IS NULL)
    BEGIN
        RAISERROR('Invalid Department Name. Statement terminated.', 16, 1);
        RETURN;
    END
    
    
    INSERT INTO Employee (EmployeeID, FirstName, LastName,Position, Salary, DepartmentID)
    SELECT EmployeeID, FirstName, LastName, Position, Salary,@DeptID
    FROM inserted;

	Select * from Employee;
	Select * from Departments;
	Select * from EmployeeAudit;
END;

Insert into EmployeeDepartmentView values (4,'Pathamesh','Bagar','Java Dev',65000.56,'IT');

------------------------------------------------------------------------------------------------------------

Alter TRIGGER InsteadOfDelete_EmployeeDepartmentView
ON EmployeeDepartmentView
INSTEAD OF DELETE
AS
BEGIN
	IF Exists(SELECT EmployeeID FROM deleted)
		DELETE FROM Employee
		WHERE EmployeeID IN (SELECT EmployeeID FROM deleted);
	else 
		Raiserror('Employee Not Found',17,1);

    SELECT * FROM Employee;
    SELECT * FROM Departments;
    SELECT * FROM EmployeeAudit;
END;

Delete from EmployeeDepartmentView where EmployeeID=4;

