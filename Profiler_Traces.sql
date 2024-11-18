CREATE TABLE dummyCustomers (
    CustomerID INT IDENTITY(1,1),
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    Email NVARCHAR(100),
    Phone NVARCHAR(15),
    City NVARCHAR(50)
);

--CREATE INDEX idx_LastName ON dummyCustomers (LastName);
--CREATE INDEX idx_City ON dummyCustomers (City);

DECLARE @counter INT = 1;
DECLARE @firstNames NVARCHAR(50), @lastNames NVARCHAR(50), @cities NVARCHAR(50);

DECLARE @FirstNamesList TABLE (Name NVARCHAR(50));
INSERT INTO @FirstNamesList VALUES ('John'), ('Jane'), ('Alice'), ('Bob'), ('Charlie');

DECLARE @LastNamesList TABLE (Name NVARCHAR(50));
INSERT INTO @LastNamesList VALUES ('Smith'), ('Johnson'), ('Williams'), ('Brown'), ('Jones');

DECLARE @CitiesList TABLE (Name NVARCHAR(50));
INSERT INTO @CitiesList VALUES ('New York'), ('Los Angeles'), ('Chicago'), ('Houston'), ('Phoenix');



WHILE @counter <= 6000
BEGIN
    
    SELECT TOP 1 @firstNames = Name FROM @FirstNamesList ORDER BY NEWID();
    SELECT TOP 1 @lastNames = Name FROM @LastNamesList ORDER BY NEWID();
    SELECT TOP 1 @cities = Name FROM @CitiesList ORDER BY NEWID();

   
    INSERT INTO dummyCustomers (FirstName, LastName, Email, Phone, City)
    VALUES (
        @firstNames,
        @lastNames,
        CONCAT(@firstNames, '.', @lastNames, '@gmail.com'),
        CONCAT('999-', CAST((100000 + @counter) AS VARCHAR(10)), 6),
        @cities
    );

    SET @counter = @counter + 1;
END;



Select * from dummyCustomers where CustomerID=560;
go 
Select * from dummyCustomers where CustomerID=5560;
go 
Select * from dummyCustomers where CustomerID=160;