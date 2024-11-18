Create Database Students;

CREATE TABLE Assignments (
    assignment_id INT PRIMARY KEY IDENTITY(1,1),
    course_id INT NOT NULL,
    title NVARCHAR(255) NOT NULL,
    due_date DATE NOT NULL
);

CREATE TABLE Grades (
    grade_id INT PRIMARY KEY IDENTITY(1,1),
    student_id INT NOT NULL,
    assignment_id INT NOT NULL,
    score DECIMAL(5, 2) NOT NULL,
    FOREIGN KEY (assignment_id) REFERENCES Assignments(assignment_id)
);

CREATE TABLE Instructors (
    instructor_id INT PRIMARY KEY IDENTITY(1,1),
    name NVARCHAR(100) NOT NULL,
    course_id INT NULL, 
    email NVARCHAR(255) NOT NULL
);

CREATE TABLE Attendance (
    attendance_id INT PRIMARY KEY IDENTITY(1,1),
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    attendance_date DATE NOT NULL,
    status NVARCHAR(10) CHECK (status IN ('Present', 'Absent'))
);


INSERT INTO Assignments (course_id, title, due_date)
VALUES 
(101, 'Math Assignment 1', '2024-11-20'),
(102, 'History Assignment 1', '2024-11-15');

-- Insert into Grades
INSERT INTO Grades (student_id, assignment_id, score)
VALUES 
(1, 1, 85.5),
(2, 1, 90.0),
(1, 2, 78.0);

-- Insert into Instructors
INSERT INTO Instructors (name, course_id, email)
VALUES 
('Dr. Smith', 101, 'smith@university.edu'),
('Dr. Jane', NULL, 'jane@college.org');


INSERT INTO Attendance (student_id, course_id, attendance_date, status)
VALUES 
(1, 101, '2024-11-01', 'Present'),
(1, 101, '2024-11-02', 'Absent'),
(2, 102, '2024-11-01', 'Present');

---1)Retrieve all assignments with due dates in the next 7 days.
SELECT *
FROM Assignments
WHERE due_date BETWEEN GETDATE() AND DATEADD(DAY, 7, GETDATE());

--2)Find the average score of all students on a specific assignment.

SELECT AVG(score) AS AverageScore
FROM Grades
WHERE assignment_id = 1;

-- 3)Count the total number of days each student was marked "Present".

SELECT student_id, COUNT(*) AS DaysPresent
FROM Attendance
WHERE status = 'Present'
GROUP BY student_id;

--4)Retrieve a list of instructors who have an email address ending with "@university.edu".

SELECT *
FROM Instructors
WHERE email LIKE '%@university.edu';

--5)List all students who scored above 90 on any assignment.

SELECT DISTINCT student_id
FROM Grades
WHERE score > 90;

--6)Retrieve the names of all instructors who have not assigned a course.

SELECT name
FROM Instructors
WHERE course_id IS NULL;

--7)Find students who have more than three absences.

SELECT student_id, COUNT(*) AS AbsenceCount
FROM Attendance
WHERE status = 'Absent'
GROUP BY student_id
HAVING COUNT(*) > 3;

--8) For each assignment, find the highest score achieved by any student.

SELECT assignment_id, MAX(score) AS HighestScore
FROM Grades
GROUP BY assignment_id;

--9)Retrieve all assignments that were due more than a month ago.

SELECT *
FROM Assignments
WHERE due_date < DATEADD(MONTH, -1, GETDATE());

--10)Count the total number of assignments for each course.

SELECT course_id, COUNT(*) AS TotalAssignments
FROM Assignments
GROUP BY course_id;

--11)Retrieve a list of instructors, sorted by name in descending order.

SELECT *
FROM Instructors
ORDER BY name DESC;

--12)List all students and their highest score across all assignments.

SELECT student_id, MAX(score) AS HighestScore
FROM Grades
GROUP BY student_id;