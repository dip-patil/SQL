CREATE TABLE Clients (
    ClientID INT PRIMARY KEY IDENTITY(1,1),
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    City NVARCHAR(50)
);

INSERT INTO Clients (FirstName, LastName, City)
VALUES 
('Ravi', 'Kumar', 'Mumbai'),
('Anjali', 'Patel', 'Delhi'),
('Suresh', 'Sharma', 'Bangalore');

CREATE TABLE Products (
    ProductID INT PRIMARY KEY IDENTITY(1,1),
    ProductName NVARCHAR(100),
    Price DECIMAL(10, 2)
);

INSERT INTO Products (ProductName, Price)
VALUES
('Laptop', 50000.00),
('Smartphone', 20000.00),
('Tablet', 15000.00);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY IDENTITY(1,1),
    ClientID INT,
    ProductID INT,
    OrderDate DATE,
    Quantity INT,
    FOREIGN KEY (ClientID) REFERENCES Clients(ClientID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

INSERT INTO Orders (ClientID, ProductID, OrderDate, Quantity)
VALUES
(1, 1, '2024-10-10', 1),  
(2, 2, '2024-10-11', 2),  
(3, 3, '2024-10-12', 1);  


SELECT Cl.FirstName, Cl.LastName, P.ProductName, O.Quantity, O.OrderDate
FROM Clients Cl
INNER JOIN Orders O ON Cl.ClientID = O.ClientID
INNER JOIN Products P ON O.ProductID = P.ProductID;

SELECT Cl.FirstName, Cl.LastName, O.OrderID, P.ProductName
FROM Clients Cl
LEFT JOIN Orders O ON Cl.ClientID = O.ClientID
LEFT JOIN Products P ON O.ProductID = P.ProductID;


SELECT Cl.FirstName, Cl.LastName, O.OrderID, P.ProductName
FROM Orders O
RIGHT JOIN Clients Cl ON Cl.ClientID = O.ClientID
RIGHT JOIN Products P ON O.ProductID = P.ProductID;


SELECT Cl.FirstName, Cl.LastName, P.ProductName, O.Quantity, O.OrderDate
FROM Clients Cl
FULL JOIN Orders O ON Cl.ClientID = O.ClientID
FULL JOIN Products P ON O.ProductID = P.ProductID;


SELECT Cl.FirstName, Cl.LastName, P.ProductName
FROM Clients Cl
CROSS JOIN Products P;

SELECT Cl.FirstName, Cl.LastName, P.ProductName, O.Quantity, O.OrderDate
FROM Clients Cl
INNER JOIN Orders O ON Cl.ClientID = O.ClientID
INNER JOIN Products P ON O.ProductID = P.ProductID;

SELECT C1.FirstName AS Client1, C1.City, C2.FirstName AS Client2
FROM Clients C1
INNER JOIN Clients C2
ON C1.City = C2.City AND C1.ClientID <> C2.ClientID;





ALTER TABLE Clients
ADD CONSTRAINT PK_Clients PRIMARY KEY (ClientID);

ALTER TABLE Clients
ADD CONSTRAINT UQ_Clients_FirstName UNIQUE (FirstName);

select * from Clients;


ALTER TABLE Orders
ADD CONSTRAINT FK_Orders_Clients FOREIGN KEY (ClientID) REFERENCES Clients(ClientID);


ALTER TABLE Clients
ADD CONSTRAINT CK_Clients_Age CHECK (Age >= 18);

ALTER TABLE Clients
DROP COLUMN Email;
