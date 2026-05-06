-- Create Department table
CREATE TABLE Department (
    department_id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

-- Create Employee table
CREATE TABLE Employee (
    emp_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age INT,
    salary DECIMAL(10, 2),
    department_id INT,
    hire_date DATE,
    FOREIGN KEY (department_id) REFERENCES Department(department_id)
);

-- Create Project table
CREATE TABLE Project (
    project_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES Department(department_id)
);

-- Insert data into Department table
INSERT INTO Department (department_id, name) VALUES
(1, 'IT'),
(2, 'HR'),
(3, 'Finance'),
(4, 'Marketing');

-- Insert data into Employee table
INSERT INTO Employee (emp_id, name, age, salary, department_id, hire_date) VALUES
(1, 'John Doe', 28, 50000.00, 1, '2020-01-15'),
(2, 'Jane Smith', 34, 60000.00, 2, '2019-07-23'),
(3, 'Bob Brown', 45, 80000.00, 1, '2018-02-12'),
(4, 'Alice Blue', 25, 45000.00, 3, '2021-03-22'),
(5, 'Charlie P.', 29, 50000.00, 2, '2019-12-01'),
(6, 'David Green', 38, 70000.00, 4, '2022-05-18'),
(7, 'Eve Black', 40, 55000.00, 3, '2021-08-30');

-- Insert data into Project table
INSERT INTO Project (project_id, name, department_id) VALUES
(1, 'Project Alpha', 1),
(2, 'Project Beta', 2),
(3, 'Project Gamma', 1),
(4, 'Project Delta', 3),
(5, 'Project Epsilon', 4),
(6, 'Project Zeta', 4),
(7, 'Project Eta', 3);


-- Insert additional data into Department table (if needed)
-- No additional departments needed for this data set

-- Insert additional data into Employee table to test edge cases for joins and nested queries
INSERT INTO Employee (emp_id, name, age, salary, department_id, hire_date) VALUES
(8, 'Frank White', 32, 48000.00, NULL, '2021-07-10'),  -- Employee without a department
(9, 'Grace Kelly', 27, 65000.00, 1, '2018-11-13'),
(10, 'Hannah Lee', 30, 53000.00, 4, '2020-02-25');

-- Insert additional data into Project table to test edge cases for joins
INSERT INTO Project (project_id, name, department_id) VALUES
(8, 'Project Theta', 1),
(9, 'Project Iota', NULL);  -- Project without a department




-- 1
SELECT * FROM Employee;
--2
SELECT name , salary FROM Employee;
--3
SELECT *FROM Employee WHERE age >30;
--4
SELECT name FROM Employee WHERE department_id = 1;
--5
SELECT *FROM Employee WHERE deparment_id = 1 ;
--6
SELECT *FROM Employee WHERE name LIKE "J%";
--7 
SELECT *FROM Employee WHERE name LIKE "%e";
--8
SELECT *FROM Employee WHERE name LIKE "%a%";
--9
SELECT *FROM Employee WHERE name LIKE "___";
--10
SELECT *FROM Employee WHERE name LIKE "_a%";
--11
SELECT *FROM Employee WHERE YEAR (hire_date) = 2020;
--12
SELECT *FROM Employee 
WHERE hire_date >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR);
--13
SELECT *FROM Employee WHERE hire_date < '2019-01-01';
--14
SELECT *FROM Employee WHERE hire_date BETWEEN '2021-01-01' AND '2021-12-31';
--15
SELECT *FROM Employee 
WHERE hire_date >= DATE_SUB(CURDATE(),INTERNAL 2 YEAR);
--16
SELECT SUM(salary) FROM Employee;
--17
SELECT AVG(salary) FROM Employee;
--18
SELECT MIN(salary) FROM Employee;
--19
SELECT department_id,COUNT(*)
FROM Employee
GROUP BY department_id;
--20
SELECT department_id,AVG(salary)
FROM Employee
GROUP BY department_id;
--21   
SELECT department_id,SUM(salary)
FROM Employee
GROUP BY department_id;
--22
SELECT department_id,AVG(salary)
FROM Employee
GROUP BY department_id;
--23
SELECT YEAR(hire_date) AS hire_year, COUNT(*)AS total_employees
FROM Employee
GROUP BY YEAR(hire_date);
--24
SELECT department_id, MAX(salary) AS highest_salary
FROM Employee
GROUP BY department_id;
--25
SELECT d.name, AVG(e.salary) AS avg_salary
FROM Employee e
JOIN DEpartment d
ON e.department_id = d.department_id
GROUP BY d.name
ORDER BY avg_salary DESC
LIMIT 1;
--26
SELECT department_id
FROM Empolyee
GROUP BY department_id
HAVING COUNT (*) >2;
--27
SELECT department_id
FROM Empolyee
GROUP BY department_id
HAVING AVG(salary)>55000;
--28
SELECT YEAR(hire_date) AS hire_year
FROM Employee
GROUP BY YEAR(hire_date)
HAVING COUNT(*) > 1;
--29
SELECT department_id
FROM Employee
GROUP BY department_id
HAVING SUM(salary) < 100000;
--30
SELECT department_id
FROM Empolyee
GROUP BY department_id
HAVING MAX(salary) > 75000;
--31
SELECT *FROM Employee
ORDER BY salary ASC;
--32
SELECT *FROM Employee
ORDER BY age DESC;
--33
SELECT *FROM Employee
ORDER BY hire_date ASC;
--34
SELECT *FROM Employee
ORDER BY department_id ASC, salary ASC;
--35
SELECT department_id, SUM(salary) AS total_salary
FROM Employee
GROUP BY department_id
ORDER BY total_salary DESC;
--36
SELECT e.name, d.name AS department_name
FROM Employee e
JOIN Department d ON e.department_id = d.department_id;
--37
SELECT p.name, d.name AS department_name
FROM Project p
JOIN Department d ON p.department_id = d.department_id;
--38
SELECT e.name, p.name AS project_name
FROM Employee e
JOIN Project p ON e.department_id = p.department_id;
--39
SELECT e.name , d.name AS department_name
FROM Employee e
LEFT JOIN Department d ON e.department_id = d.department_id;
--40
SELECT d.name , e.name AS employee_name
FROM Department d
LEFT JOIN Employee e ON d.department_id = e.department_id;
--41
SELECT *
FROM Employee 
WHERE department_id NOT IN (SELECT department_id FROM Project);
--42
SELECT e.name,COUNT(p.project_id) AS project_count
FROM Employee e
LEFT JOIN Project p ON e.department_id = p.department_id
GROUP BY e.name;
--43
SELECT d.name
FROM Department d
LEFT JOIN Employee e ON d.department_id = e.department_id
WHERE e.emp_id IS NULL;
--44
SELECT name
FROM Employee
WHERE department_id = (SELECT department_id FROM Employee WHERE name = 'John Doe');
--45
SELECT d.name, AVG(e.salary) AS avg_salary
FROM Department d
JOIN Employee e ON e.department_id = d.department_id
GROUP BY d.name
ORDER BY avg_salary DESC 
LIMIT 1;
--46
SELECT *
FROM Employee
WHERE salary > (SELECT MAX(salary) FROM Employee);
--47
SELECT *
FROM Employee
WHERE salary > (SELECT AVG(salary) FROM Employee);
--48
SELECT MAX(salary)
FROM Employee
WHERE salary < (SELECT MAX(salary) FROM Employee);
--49
SELECT department_id
FROM Employee
GROUP BY department_id
ORDER BY COUNT(*) DESC
LIMIT 1;
--50
SELECT e.name,e.salary
FROM Employee e
WHERE e.salary > (SELECT AVG(salary) FROM Employee WHERE department_id = e.department_id);
--51
SELECT salary 
FROM Employee
ORDER BY salary DESC
LIMIT 1 OFFSET 2;
--52
SELECT *
FROM Employee 
WHERE age > ALL( SELECT age FROM Employee WHERE department_id = (SELECT department_id FROM Department WHERE name = 'HR'));
--53
SELECT department_id
FROM Employee
GROUP BY department_id
HAVING AVG(salary) > 55000;
--54
SELECT *
FROM Employee
WHERE department_id IN (SELECT department_id FROM Project GROUP BY department_id HAVING COUNT(*) >= 2);
--55
SELECT *
FROM Employee WHERE hire_date = (SELECT MIN(hire_date) FROM Employee WHERE name = 'Jane Smith');
--56
SELECT SUM(salary)
FROM Employee WHERE YEAR (hire_date) = 2020;
--57
SELECT department_id, AVG(salary) AS avg_salary
FROM Employee 
GROUP BY department_id
ORDER BY avg_salary DESC;
--58
SELECT d.department_name
FROM Department d
JOIN Employee e ON d.department_id = e.department_id
GROUP BY d.department_id, d.department_name
HAVING COUNT(e.employee_id) > 1 AND AVG(e.salary) > 55000;
--59
SELECT *
FROM Employee 
WHERE hire_date >= CURRENT_DATE - INTERVAL '2 years'
ORDER BY hire_date;
--60
SELECT d.department_name, COUNT(e.employee_id) AS total_employees, AVG(e.salary) AS avg_salary
FROM Department d
JOIN  Employee e ON d.department_id = e.department_id
GROUP BY d.department_id, d.department_name HAVING COUNT(e.employee_id) > 2;
--61
SELECT e.name,e.salary
FROM Employee e
WHERE e.salary > (SELECT AVG(e2.salary) FROM Employee e2 WHERE e2.department_id = e.department_id);
--62
SELECT name
FROM Employee
WHERE hire_date=(SELECT MIN(hire_date) FROM Employee);
--63
SELECT d.department_name, COUNT(p.project_id)AS total_projects
FROM Department d
JOIN Projects p ON d.department_id = p.department_id
GROUP BY d.department_id, d.department_name
ORDER BY total_projects DESC;
--64
SELECT e.name,e.department_id,e.salary
FROM Employee e
WHERE e.salary > (SELECT MAX(e2.salary) FROM Employee e2 WHERE e2.department_id = e.department_id);
--65
SELECT e.name,e.salary
FROM Employee e
WHERE e.age > (SELECT AVG(e2.age) FROM Employee e2 WHERE e2.department_id = e.department_id);