CREATE PROCEDURE GetEmployeeByCity
@City NVARCHAR(50)
AS
BEGIN
    
    SELECT EmployeeID, FirstName, LastName, Department, City
    FROM Employees
    WHERE City = @City;
END;

Select * from Employees;
EXEC GetEmployeeByCity 'mumbai'


-----------------------------------------------------------

Create PROCEDURE GetEmployeeByID
@ID int ,
@Name nvarchar(50) output
AS
BEGIN
    
    SELECT @Name = CONCAT(FirstName,' ',LastName)
    FROM Employees
	where EmployeeID = @ID
END;

Declare @Name nvarchar(50)
Exec GetEmployeeByID 1, @Name output
print @Name

Drop Proc GetEmployeeByID;


---------------------------------------------------------------

Alter PROCEDURE GetEmployeeByDepartment
@Dept NVARCHAR(50)
AS
BEGIN
    
   return( SELECT EmployeeID
    FROM Employees
    WHERE Department = @Dept)
END;

Declare @ReturnResult nvarchar(50)
Exec @ReturnResult = GetEmployeeByDepartment 'IT'
print @ReturnResult

------------------------------------------------------------------
Create Proc PrintNnumbersWhile
@InputNum int 
as
DECLARE @counter INT = 1;

WHILE @counter <= @InputNum
	BEGIN
		PRINT @counter;
		SET @counter = @counter + 1;
	END

Exec PrintNnumbersWhile 10



----------------------------------------------------------------------

alter Proc PrintNnumbersBreak
@InputNum int 
as
DECLARE @counter INT = 0;

WHILE @counter <= @InputNum
BEGIN
    SET @counter = @counter + 1;
    IF @counter = 4
        BREAK;
    PRINT @counter;
END

Exec PrintNnumbersBreak 5

--------------------------------------------------------

create Proc PrintNnumbersContinue
@InputNum int 
as
DECLARE @counter INT = 0;

WHILE @counter <= @InputNum
BEGIN
    SET @counter = @counter + 1;
    IF @counter = 4
        Continue;
    PRINT @counter;
END

Exec PrintNnumbersContinue 10

---------------------------------------------------------

Alter PROC DevidebyZeroExceptionHandle(
    @a decimal,
    @b decimal,
    @c decimal output
) AS
BEGIN
    BEGIN TRY
        SET @c = @a / @b;
		RAISERROR('Error occurred in the TRY block.', 17, 1);
    END TRY
    BEGIN CATCH
        SELECT  
            ERROR_NUMBER() AS ErrorNumber    
            ,ERROR_STATE() AS ErrorState  
            ,ERROR_PROCEDURE() AS ErrorProcedure  
            ,ERROR_LINE() AS ErrorLine  
            ,ERROR_MESSAGE() AS ErrorMessage;  
    END CATCH
END;

DECLARE @r decimal;
EXEC DevidebyZeroExceptionHandle 10, 2, @r output;
PRINT @r;

----------------------------------------------------------------
Select * from Employees;
Alter table Employees
add EmploymentType nvarchar(40);


CREATE PROCEDURE GetEmployeeDetailsByStatus
    @Status INT
AS
BEGIN
    SELECT EmployeeID, FirstName, LastName, EmploymentType
    FROM Employees
    WHERE EmploymentType = 
        CASE 
            WHEN @Status = 1 THEN 'Full-time'
            WHEN @Status = 2 THEN 'Part-time'
            WHEN @Status = 3 THEN 'Contract'
            ELSE NULL 
        END;
END;

EXEC GetEmployeeDetailsByStatus @Status = 1;
EXEC GetEmployeeDetailsByStatus @Status = 2;
EXEC GetEmployeeDetailsByStatus @Status = 3;



