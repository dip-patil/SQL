Create Database Employees;

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,       
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50) ,
    Phone CHAR(10),                          
    Email NVARCHAR(100) ,                     
    Department NVARCHAR(50),
    City NVARCHAR(50),
    State NVARCHAR(50),
    PinCode CHAR(6)
);

select * from Employees;
drop table Employees;

INSERT INTO Employees (EmployeeID, FirstName, LastName, Phone, Email, Department, City, State, PinCode)
VALUES 
    (3, 'Amit', 'Verma', '9876543210', 'amit.verma@example.com', 'IT', 'Delhi', 'Delhi', '110001'),
    (5,'Neha', 'Kumar', '9876543211', 'neha.kumar@example.com', 'HR', 'Mumbai', 'Maharashtra', '400001'),
    (1,'Raj', 'Singh', '9876543212', 'raj.singh@example.com', 'Finance', 'Chennai', 'Tamil Nadu', '600001'),
    (2,'Priya', 'Sharma', '9876543213', 'priya.sharma@example.com', 'Marketing', 'Bangalore', 'Karnataka', '560001'),
    (4,'Rahul', 'Gupta', '9876543214', 'rahul.gupta@example.com', 'Sales', 'Hyderabad', 'Telangana', '500001');


CREATE NONCLUSTERED INDEX IDX_Department
ON Employees (Department);

CREATE Unique NONCLUSTERED INDEX IDX_City
ON Employees (City);

CREATE CLUSTERED INDEX IDX_City
ON Employees (City);

CREATE UNIQUE INDEX UQ_Employees_Phone
ON Employees (Phone);


CREATE UNIQUE INDEX UQ_Employees_Email
ON Employees (Email);

Drop index Employees.IDX_City;


