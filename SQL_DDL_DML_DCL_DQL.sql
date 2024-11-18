
-- DML

INSERT INTO Clients (FirstName, LastName, City)
VALUES ('Priya', 'Singh', 'Hyderabad');

UPDATE Clients
SET City = 'Pune'
WHERE ClientID = 1;

DELETE FROM Clients
WHERE ClientID = 3;

SELECT FirstName, LastName, City
FROM Clients;

-- DDL

CREATE TABLE Suppliers (
    SupplierID INT PRIMARY KEY IDENTITY(1,1),
    SupplierName NVARCHAR(100),
    City NVARCHAR(50)
);

ALTER TABLE Clients
ADD Email NVARCHAR(100);

DROP TABLE Suppliers;

TRUNCATE TABLE Orders;

--DCL

GRANT SELECT, INSERT ON Clients TO dip;

REVOKE INSERT ON Clients FROM dip;

-- DQL

Select * from Clients;




