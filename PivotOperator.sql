CREATE TABLE SalesData (
    Id INT PRIMARY KEY,
    SalesAgent VARCHAR(50),
    SalesCountry VARCHAR(50),
    SalesAmount INT
);

INSERT INTO SalesData (Id, SalesAgent, SalesCountry, SalesAmount) VALUES
(1, 'Tom', 'UK', 200),
(2, 'John', 'US', 180),
(3, 'John', 'UK', 260),
(4, 'David', 'India', 450),
(5, 'Tom', 'India', 350),
(6, 'David', 'US', 200),
(7, 'Tom', 'US', 130),
(8, 'John', 'India', 540),
(9, 'John', 'UK', 120),
(10, 'David', 'UK', 220),
(11, 'John', 'UK', 420);

Select SalesAgent, SalesCountry, Sum(SalesAmount) as SalesAmount
from SalesData
Group by SalesAgent,SalesCountry
Order by SalesAgent


Select SalesAgent, UK,India,US
from (
	Select SalesAgent, SalesCountry, SalesAmount
	from SalesData
	) as TempTable
	Pivot
	(
		Sum(SalesAmount) 
		for SalesCountry in ([UK],[India],[US])
	
	) as PivotTable
