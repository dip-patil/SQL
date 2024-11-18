create table Employee
(
 EmployeeID int Primary key ,
 Name varchar(15),
 Age int,
 Department varchar(15)
);

Alter table Employee
Add Salary int;


EXEC sp_rename 'Employee.Department' , 'Dept';

select * from Employee;

Insert into Employee values(1,'Dip',21,'IT',50000);
Insert into Employee values(2,'Pratham',21,'HR',56000);
Insert into Employee values(3,'Vaibhav',28,'IT',58000);
Insert into Employee values(4,'Gautam',29,'HR',60000);

Update Employee
Set Salary=55000
Where EmployeeID=1;

Delete from Employee
Where Age>25;

Select * 
from Employee
order by Name;

Select top 3 Name,Salary
from Employee
order by Salary DESC; 

Select Name
from Employee
where Name like 'G%M';

Select *
from Employee
order by EmployeeID
offset 3 rows 


create table Departments
(
   
 DeptName varchar(15) Primary key,
 
);
Insert into Departments values('IT');
Insert into Departments values('HR');

Select Employee.Name, Departments.DeptName
from Employee
Inner Join Departments on Employee.Dept=Departments.DeptName

/*
Suppose you have three tables: "Orders," "Customers," and "Products," with the following columns:
Orders: OrderID, CustomerID, ProductID, Quantity
Customers: CustomerID, CustomerName, Email
Products: ProductID, ProductName, Price
Write a SQL query to retrieve the order details (OrderID, CustomerName, ProductName, Quantity) for all orders, including orders without associated customer or product information. Use an appropriate join type.
*/
Select Order.OrderID, Customer.CustomerName, Products.ProductName, Order.Quantity
from Orders
Inner join Customers on Order.CustomerID=Customer.CustomerID
Inner join Product on Order.ProductID=Product.ProductID;