--Question 1
CREATE TABLE l_employees_copy1 AS
FROM l_employees;

INSERT INTO l_employees_copy1
SELECT *
FROM l_employees;

--Question 2
ALTER TABLE sec0609_employees
ADD CONSTRAINT pk_sec0609_employees
PRIMARY KEY (employee_id);

--Question 3
ALTER TABLE sec0611_departments
ADD (manager_name VARCHAR2(40),
    annual_budget NUMBER);

--Question 4
ALTER TABLE sec0612_employees
MODIFY last_name VARCHAR2(50);

--Question 5
ALTER TABLE sec0613_employees
DROP COLUMN phone_number;

--Question 6
CREATE TABLE sec0616_no_duplicates AS
SELECT DISTINCT *
FROM sec0616_duplicate_rows;

--Question 7
CREATE TABLE sec0617_row_numbers AS
SELECT rownum AS row_id, 
       sec0617_duplicate_rows.*
FROM sec0617_duplicate_rows;

