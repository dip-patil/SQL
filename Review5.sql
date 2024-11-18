Select * from Employees;




CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100) NOT NULL,
    Location VARCHAR(100)
);

CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Position VARCHAR(50),
    Salary DECIMAL(18, 2),
    DepartmentID INT,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

Insert into Departments (DepartmentID,DepartmentName,Location)
values
(1,'IT','Mumbai'),
(2,'HR','Pune')

Insert into Employee (EmployeeID,FirstName,LastName,Position,Salary,DepartmentID)
values
(1,'Dip','Patil','Jr Devloper',50000.20,1),
(2,'Vaibhav', 'Koli' , 'Sr Devloper',70000.57,1),
(3,'Om' ,'Kakde' , 'HR' ,80000.24,2);

Select * from Employee;
Select * from Departments;
-----------------------------------------------------------------------------------------

Alter Proc sp_AddNewEmployee
	@EmployeeID INT ,
	@FirstName VARCHAR(50),
    @LastName VARCHAR(50),
    @Position VARCHAR(50),
    @Salary DECIMAL(18, 2),
    @DepartmentID INT
as
Begin 
	Insert into Employee (EmployeeID,FirstName,LastName,Position,Salary,DepartmentID)
	values
	(@EmployeeID,@FirstName,@LastName,@Position,@Salary,@DepartmentID)
End



Exec sp_AddNewEmployee 4 ,'Pratham' ,'Bagar' ,'Jr Devloper' ,50000.56, 1;

Select * from Employee;

-------------------------------------------------------------------------------------------------

Create Proc sp_EmployeeDetails_byDepartment
@DepartmentID int
as
Begin 
	Select * 
	from Employee
	where DepartmentID=@DepartmentID
	
End

select * from Departments
where DepartmentID in(
SELECT TOP 1 DepartmentID
FROM Employee
GROUP BY DepartmentID
ORDER BY Count(DepartmentID) DESC);

SELECT TOP 1 D.DepartmentName, COUNT(E.DepartmentID) AS Count
FROM Employee E
JOIN Departments D ON E.DepartmentID = D.DepartmentID
GROUP BY D.DepartmentName
ORDER BY Count DESC;



SELECT *
FROM Employee
WHERE Salary IN (
    SELECT DISTINCT TOP 2 Salary
    FROM Employee
    ORDER BY Salary DESC
)
OR Salary IN (
    SELECT DISTINCT TOP 2 Salary
    FROM Employee
    ORDER BY Salary ASC
);
 



SELECT DepartmentID, COUNT(DepartmentID) 
FROM Employee
GROUP BY DepartmentID
HAVING COUNT(DepartmentID) = (
    SELECT MAX(EmployeeCount)
    FROM (
        SELECT COUNT(DepartmentID) AS EmployeeCount
        FROM Employee
        GROUP BY DepartmentID
    ) AS DepartmentCounts
);


Exec sp_EmployeeDetails_byDepartment 1



