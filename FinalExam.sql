--Question 1
SELECT course_no,
       description,
       TO_CHAR(cost, '$9,999') AS cost
FROM course
WHERE cost < (SELECT AVG(cost)
              FROM course)
ORDER BY cost DESC;

--Question 2
SELECT a.course_no,
       a.description,
       a.cost,
       b.start_date_time
FROM course a
INNER JOIN section b
    ON a.course_no = b.course_no
ORDER BY a.course_no,
         a.description;

--Question 3
SELECT a.zip,
       COUNT(b.instructor_id) AS number_of_instructors
FROM zipcode a
LEFT JOIN instructor b
    ON a.zip = b.zip
GROUP BY a.zip
ORDER BY a.zip;

--Question 4
SELECT a.student_id,
       a.first_name,
       a.last_name,
       a.street_address,
       a.zip,
       b.state
FROM student a
INNER JOIN zipcode b
    ON a.zip = b.zip
WHERE b.city = 'Brooklyn'
ORDER BY a.last_name,
         a.first_name;

--Question 5
SELECT a.first_name,
       a.last_name,
       COUNT(b.section_id) as number_of_sections
FROM instructor a
LEFT JOIN section b
    ON a.instructor_id = b.instructor_id
GROUP BY a.first_name,
         a.last_name
ORDER BY number_of_sections DESC;

--Question 6
SELECT a.first_name,
       a.last_name,
       a.street_address,
       a.zip
FROM student a
INNER JOIN instructor b
    ON a.zip = b.zip
WHERE b.first_name = 'Tom'
    AND b.last_name = 'Wojick'
ORDER BY a.zip;

--Question 7
SELECT student_id,
       salutation,
       first_name,
       last_name
FROM student 
WHERE registration_date < (SELECT MIN(registration_date)
                           FROM student
                           WHERE first_name = 'Vera'
                                AND last_name = 'Wetcel')
ORDER BY student_id ASC;

--Question 8
SELECT a.student_id
FROM student a
LEFT JOIN enrollment b
    ON a.student_id = b.student_id
WHERE b.student_id IS NULL
ORDER BY a.student_id;

--Question 9
CREATE OR REPLACE VIEW all_people_view AS
SELECT salutation,
       first_name || ' ' || last_name AS full_name,
       street_address,
       zip,
       phone
FROM student
UNION ALL
SELECT salutation,
       first_name || ' ' || last_name AS full_name,
       street_address,
       zip,
       phone
FROM instructor;

--Question 10
SELECT a.student_id,
       a.first_name,
       a.last_name
FROM student a
INNER JOIN enrollment b
    ON a.student_id = b.student_id
WHERE b.final_grade = (SELECT MAX(final_grade)
                       FROM enrollment);

--Question 11
SELECT a.course_no,
       a.description,
       COUNT(b.section_id) AS number_of_sections
FROM course a
INNER JOIN section b
    ON a.course_no = b.course_no
GROUP BY a.course_no,
         a.description
HAVING COUNT(b.section_id) > 5
ORDER BY a.course_no;

--Quetion 12
SELECT a.course_no,
       a.description,
       a.cost,
       b.course_no AS prereq_course,
       b.description AS prereq_desc
FROM course a 
LEFT JOIN course b
    ON a.prerequisite = b.course_no
ORDER BY a.course_no;

--Question 13
SELECT a.course_no,
       a.description,
       COUNT(b.section_id) AS number_of_sections
FROM course a
INNER JOIN section b
    ON a.course_no = b.course_no
GROUP BY a.course_no,
         a.description
ORDER BY number_of_sections DESC;

--OR ONLY MAX
SELECT a.course_no,
       a.description,
       COUNT(b.section_id) AS number_of_sections
FROM course a
INNER JOIN section b
    ON a.course_no = b.course_no
GROUP BY a.course_no,
         a.description
HAVING COUNT(b.section_id) = (SELECT MAX(section_count)
                              FROM (SELECT COUNT(section_id) AS section_count
                                    FROM section
                                    GROUP BY course_no));

--Question 14
SELECT a.course_no,
       a.description,
       b.start_date_time,
       b.capacity,
       COUNT(c.student_id) AS number_of_students
FROM course a
INNER JOIN section b
    ON a.course_no = b.course_no
INNER JOIN enrollment c
    ON b.section_id = c.section_id
GROUP BY a.course_no,
         a.description,
         b.start_date_time,
         b.capacity
HAVING COUNT(c.student_id) > b.capacity
ORDER BY a.course_no;
