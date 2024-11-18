Select * from Employee;

Create Proc TransactionExample
As
Begin 
	Begin Try
		Begin Transaction
			Update Employee 
			set Salary=45000
			where EmployeeID=1;

			Update Employee 
			set Salary=45000
			where EmployeeID=1;
			Commit Transaction
	
	End Try
	Begin Catch
		RollBack Transaction
	End Catch
End

Exec TransactionExample;
Select * from Employee;

	




