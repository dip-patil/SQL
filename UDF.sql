CREATE TABLE IndianEmployees
(
    EmployeeID INT PRIMARY KEY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    DepartmentID INT,
    Salary DECIMAL(10, 2),
    DateOfJoining DATE
);

INSERT INTO IndianEmployees
VALUES 
    (1, 'Rajesh', 'Sharma', 101, 50000, '2020-01-15'),
    (2, 'Priya', 'Kumar', 102, 65000, '2019-06-10'),
    (3, 'Amit', 'Patel', 101, 55000, '2021-03-20'),
    (4, 'Sunita', 'Singh', 103, 70000, '2018-11-01'),
    (5, 'Ravi', 'Reddy', 102, 45000, '2022-05-05');

Select * from IndianEmployees;

--Truncate table IndianEmployees;



CREATE FUNCTION CalculateAnnualBonus(@Salary DECIMAL(10, 2),@BonusPercentage DECIMAL(5, 2))
RETURNS DECIMAL(10, 2)
AS
BEGIN
    RETURN @Salary * (@BonusPercentage / 100);
END;


SELECT 
    EmployeeID, 
    FirstName, 
    LastName, 
    Salary, 
    dbo.CalculateAnnualBonus(Salary, 10) AS AnnualBonus
FROM IndianEmployees;

-----------------------------------------------------------------------------

CREATE FUNCTION GetEmployeesByDepartment_Inline(@DepartmentID INT)
RETURNS TABLE
AS
RETURN
(
    SELECT Top 100
        EmployeeID, 
        FirstName, 
        LastName, 
        Salary, 
        DateOfJoining
    FROM IndianEmployees
    WHERE DepartmentID = @DepartmentID
    ORDER BY Salary DESC
);

SELECT * 
FROM dbo.GetEmployeesByDepartment_Inline(102)

--------------------------------------------------------------------------------------

CREATE FUNCTION dbo.GetHighEarningEmployees(@MinSalary DECIMAL(10, 2))
RETURNS @HighEarners TABLE
(EmployeeID INT,FirstName NVARCHAR(50),LastName NVARCHAR(50),Salary DECIMAL(10, 2),DepartmentID INT,DateOfJoining DATE)
AS
BEGIN
    INSERT INTO @HighEarners
    SELECT 
        EmployeeID, 
        FirstName, 
        LastName, 
        Salary, 
        DepartmentID, 
        DateOfJoining
    FROM IndianEmployees
    WHERE Salary > @MinSalary;

    RETURN;
END;


SELECT * 
FROM dbo.GetHighEarningEmployees(60000)
ORDER BY Salary DESC;


