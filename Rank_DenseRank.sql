Select * from Employee;

Select DepartmentID,FirstName ,Salary,
	Rank() over (Order by Salary Desc) as [Rank]
from Employee

Select DepartmentID, FirstName ,Salary,
	Rank() over (Partition by DepartmentID Order by Salary Desc) as [Rank]
from Employee

Select DepartmentID, FirstName ,Salary,
	Dense_Rank() over (Order by Salary Desc) as DenseRank
from Employee

Select DepartmentID,FirstName ,Salary,
	Dense_Rank() over (Partition by DepartmentID Order by Salary Desc) as DenseRank
from Employee

Select DepartmentID, FirstName ,Salary,
	Rank() over (Partition by DepartmentID Order by Salary Desc) as [Rank],
	Dense_Rank() over (Partition by DepartmentID Order by Salary Desc) as DenseRank
from Employee