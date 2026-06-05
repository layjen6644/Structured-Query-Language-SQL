--Question 1
--Inner Join
SELECT a.department_name,
       b.first_name,
       b.last_name
FROM l_departments a,
     l_employees b
WHERE a.dept_code = b.dept_code;

--Left Outer Join
SELECT a.department_name,
       b.first_name,
       b.last_name
FROM l_departments a
LEFT OUTER JOIN l_employees b
    ON a.dept_code = b.dept_code;

--Question 2
--Inner Join
SELECT a.department_name,
       b.first_name,
       b.last_name
FROM l_employees b,
     l_departments a
WHERE a.dept_code = b.dept_code;

--Right Outer Join
SELECT a.department_name,
       b.first_name,
       b.last_name
FROM l_employees b
RIGHT OUTER JOIN l_departments a
     ON a.dept_code = b.dept_code;

--Question 3
--Inner Join
SELECT a.department_name,
       b.first_name,
       b.last_name
FROM l_departments a,
     sec1405_employees b
WHERE a.dept_code = b.dept_code;

--Full Outer Join
SELECT a.department_name,
       b.first_name,
       b.last_name
FROM l_departments a
FULL OUTER JOIN sec1405_employees b
    ON a.dept_code = b.dept_code;

--Question 4
SELECT *
FROM l_departments
UNION
SELECT *
FROM sec1407_departments;
