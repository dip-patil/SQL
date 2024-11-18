Create table Bonuses(EmployeeID int ,BonusAmount DECIMAL(10, 2));
Insert into Bonuses
Values (1,5000),(2,7000),(3,8000),(5,6500),(6,7500);

Select * from Bonuses;

Alter table Bonuses 
Add  Constraint FK_EmployeeID Foreign key(EmployeeID)
references Employee(EmployeeID)

DECLARE employee_cursor CURSOR FOR
SELECT EmployeeID, Salary FROM Employee;

DECLARE @EmployeeID INT;
DECLARE @Salary DECIMAL(10, 2);

OPEN employee_cursor;

FETCH NEXT FROM employee_cursor INTO @EmployeeID, @Salary;

WHILE @@FETCH_STATUS = 0
BEGIN
    DECLARE @Bonus DECIMAL(10, 2);
    SET @Bonus = CASE 
                    WHEN @Salary < 50000 THEN @Salary * 0.1
                    WHEN @Salary >= 50000 THEN @Salary * 0.05
                 END;

    UPDATE Bonuses SET BonusAmount = @Bonus WHERE EmployeeID = @EmployeeID;

    FETCH NEXT FROM employee_cursor INTO @EmployeeID, @Salary;
END;

CLOSE employee_cursor;
DEALLOCATE employee_cursor;


----Using Joins---

Update Bonuses
set BonusAmount = CASE 
                    WHEN Salary < 50000 THEN Salary * 0.1
                    WHEN Salary >= 50000 THEN Salary * 0.05
                 END
From Employee
join Bonuses on Employee.EmployeeID= Bonuses.EmployeeID
Where Salary<50000 or Salary>=5000;

Select * from Bonuses;
Select * from Employee;