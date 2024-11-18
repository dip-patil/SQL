Select * From Employee;

SELECT TOP 5 FirstName AS '@FirstName',  
             LastName
FROM Employee FOR XML PATH('Person'), ROOT('Employee');


SELECT DISTINCT 
a.DepartmentID,
STUFF(
	(SELECT ',' + b.FirstName 
	FROM Employee b
	WHERE b.DepartmentID = a.DepartmentID
	FOR XML PATH('')),1,1,'') AS Employee,
STUFF(
	(SELECT ',' + b.Position 
	FROM Employee b
	WHERE b.DepartmentID = a.DepartmentID
	FOR XML PATH('')),1,1,'') AS Position
FROM Employee a;
	
	

