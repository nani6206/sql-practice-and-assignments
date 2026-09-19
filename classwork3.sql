-- ============================================================
-- SQL CLASSWORK: 2926
-- Topics: Subqueries, IN, NOT IN, ANY, ALL, EXISTS,
--         NOT EXISTS, UPDATE, Window Functions
-- ============================================================

-- ------------------------------------------------------------
-- 1. USE DATABASE
-- ------------------------------------------------------------

USE nani;


-- ------------------------------------------------------------
-- 2. SUBQUERY
-- Find the student with the highest student_id greater than 1
-- ------------------------------------------------------------

SELECT student_name
FROM students_25
WHERE student_id = (
    SELECT student_id
    FROM students_25
    WHERE student_id > 1
    ORDER BY student_id DESC
    LIMIT 1
);


-- ------------------------------------------------------------
-- 3. SUBQUERY WITH AVG
-- ------------------------------------------------------------

SELECT name
FROM students_25
WHERE student_id = (
    SELECT AVG(student_id)
    FROM students_25
);


-- ------------------------------------------------------------
-- 4. SELECT ALL STUDENTS
-- ------------------------------------------------------------

SELECT *
FROM students_25;


-- ------------------------------------------------------------
-- 5. NOT IN SUBQUERY
-- ------------------------------------------------------------

SELECT student_name
FROM students_25
WHERE student_id NOT IN (
    SELECT student_id
    FROM students_25
    WHERE student_id > 1
);


-- ------------------------------------------------------------
-- 6. ANY SUBQUERY
-- ------------------------------------------------------------

SELECT student_name
FROM students_25
WHERE student_id = ANY (
    SELECT student_id
    FROM students_25
    WHERE student_id > 1
);


-- ------------------------------------------------------------
-- 7. ALL SUBQUERY
-- ------------------------------------------------------------

SELECT student_name
FROM students_25
WHERE student_id > ALL (
    SELECT student_id
    FROM students_25
    WHERE student_id > 1
);


-- ------------------------------------------------------------
-- 8. IN SUBQUERY
-- ------------------------------------------------------------

SELECT *
FROM students_25
WHERE course_id IN (
    SELECT course_id
    FROM students_25
    WHERE city = 'hyderabad'
);


-- ------------------------------------------------------------
-- 9. SELECT STUDENT IDs
-- ------------------------------------------------------------

SELECT student_id
FROM students_25
WHERE student_id > 1;


-- ------------------------------------------------------------
-- 10. UPDATE CITY VALUES
-- ------------------------------------------------------------

UPDATE students_25
SET city = 'hyderabad'
WHERE city IN ('Chennai', 'Bangalore', 'Hyderabad', 'Vijayawada');


UPDATE students_25
SET city = 'Hyderabad'
WHERE student_id IN (1, 4);


UPDATE students_25
SET city = 'Banglore'
WHERE student_id = 3;


UPDATE students_25
SET city = 'Chennai'
WHERE student_id = 2;


UPDATE students_25
SET city = 'Vijayawada'
WHERE student_id = 5;


-- ------------------------------------------------------------
-- 11. EXISTS
-- Find students who share a city with another student
-- ------------------------------------------------------------

SELECT *
FROM students_25 AS s1
WHERE EXISTS (
    SELECT *
    FROM students_25 AS s2
    WHERE s2.city = s1.city
      AND s2.student_id != s1.student_id
);


-- ------------------------------------------------------------
-- 12. NOT EXISTS
-- Find students whose city is not shared by another student
-- ------------------------------------------------------------

SELECT *
FROM students_25 AS s1
WHERE NOT EXISTS (
    SELECT *
    FROM students_25 AS s2
    WHERE s2.city = s1.city
      AND s2.student_id != s1.student_id
);


-- ------------------------------------------------------------
-- 13. SWITCH TO MAQBOOL DATABASE
-- ------------------------------------------------------------

USE maqbool;


-- ------------------------------------------------------------
-- 14. ROW_NUMBER()
-- Number all students based on marks in descending order
-- ------------------------------------------------------------

SELECT
    student_id,
    name,
    marks,
    ROW_NUMBER() OVER (ORDER BY marks DESC) AS row_num
FROM students;


-- ------------------------------------------------------------
-- 15. ROW_NUMBER() WITH PARTITION BY
-- Number students separately within each department
-- ------------------------------------------------------------

SELECT
    student_id,
    name,
    marks,
    dept_id,
    ROW_NUMBER() OVER (PARTITION BY dept_id) AS row_num
FROM students;


-- ------------------------------------------------------------
-- 16. ROW_NUMBER() WITH PARTITION BY + ORDER BY
-- Number students within each department by marks
-- ------------------------------------------------------------

SELECT
    student_id,
    name,
    marks,
    dept_id,
    ROW_NUMBER() OVER (
        PARTITION BY dept_id
        ORDER BY marks DESC
    ) AS row_num
FROM students;


-- ------------------------------------------------------------
-- 17. ROW_NUMBER() WITHOUT ORDER BY
-- ------------------------------------------------------------

SELECT
    student_id,
    name,
    marks,
    ROW_NUMBER() OVER () AS row_num
FROM students;


-- ------------------------------------------------------------
-- 18. RANK()
-- Rank students according to marks
-- ------------------------------------------------------------

SELECT
    student_id,
    name,
    marks,
    RANK() OVER (ORDER BY marks DESC) AS rank_ofstudents
FROM students;


-- ------------------------------------------------------------
-- 19. SELECT ALL RECORDS
-- ------------------------------------------------------------

SELECT *
FROM students;


-- ------------------------------------------------------------
-- 20. COMMON TABLE EXPRESSIONS (CTEs)
-- ------------------------------------------------------------

-- CTE: Select students whose marks are greater than 70
WITH high_marks AS (
    SELECT
        student_id,
        name,
        marks,
        dept_id
    FROM students
    WHERE marks > 70
)
SELECT *
FROM high_marks;


-- CTE: Calculate the average marks
WITH average_marks AS (
    SELECT AVG(marks) AS avg_marks
    FROM students
)
SELECT *
FROM average_marks;


-- CTE: Find students scoring above the overall average
WITH average_marks AS (
    SELECT AVG(marks) AS avg_marks
    FROM students
)
SELECT
    student_id,
    name,
    marks
FROM students
WHERE marks > (
    SELECT avg_marks
    FROM average_marks
);
