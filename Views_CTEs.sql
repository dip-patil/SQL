Create Database Contacts;


CREATE TABLE Contacts (
    ContactID INT PRIMARY KEY IDENTITY(1,1),
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50),
    State VARCHAR(50)
);

INSERT INTO Contacts (FirstName, LastName, Email, Phone, City, State) VALUES
('Rajesh', 'Sharma', 'rajesh.sharma@example.com', '9876543210', 'Mumbai', 'MH'),
('Priya', 'Verma', 'priya.verma@example.com', '9123456789', 'Delhi', 'DL'),
('Amit', 'Singh', 'amit.singh@example.com', '9988776655', 'Bengaluru', 'KA'),
('Anjali', 'Patel', 'anjali.patel@example.com', '9876541230', 'Ahmedabad', 'GJ'),
('Ravi', 'Kumar', 'ravi.kumar@example.com', '8765432109', 'Hyderabad', 'TS');

select * from Contacts;

CREATE VIEW ContactsByState AS
SELECT ContactID, FirstName, LastName, Email, Phone, City, State
FROM Contacts
WHERE State = 'MH' OR State = 'KA';

select * from ContactsByState;

WITH ContactLocations AS (
    SELECT ContactID,
           CONCAT(FirstName, ' ', LastName) AS FullName,
           City,
           State
    FROM Contacts
)
SELECT FullName, City, State
FROM ContactLocations
WHERE State = 'DL';

