
CREATE DATABASE payroll_service;

SELECT name 
FROM sys.databases 
WHERE name = 'payroll_service';

USE payroll_service;

CREATE TABLE employee_payroll (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(50),
    salary DECIMAL(18, 2),
    start_date DATE
);


INSERT INTO employee_payroll (name, salary, start_date) 
VALUES ('Dip', 50000, '2018-02-01'),
    ('Prathamesh', 60000, '2019-05-15'),
    ('Vaibhav', 55000, '2020-10-10');

SELECT * FROM employee_payroll;


SELECT salary FROM employee_payroll WHERE name = 'Dip';


SELECT * FROM employee_payroll
WHERE start_date BETWEEN CAST('2018-03-01' AS DATE) AND CAST(GETDATE() AS DATE);


ALTER TABLE employee_payroll
ADD gender CHAR(1);

UPDATE employee_payroll 
SET gender = 'M' 
WHERE name = 'Dip' OR name = 'Prathamesh';

UPDATE employee_payroll 
SET gender = 'F' 
WHERE name = 'Vaibhav';


SELECT 
    gender,
    SUM(salary) AS total_salary,
    AVG(salary) AS average_salary,
    MIN(salary) AS minimum_salary,
    MAX(salary) AS maximum_salary,
    COUNT(*) AS employee_count
FROM 
    employee_payroll
GROUP BY 
    gender;





