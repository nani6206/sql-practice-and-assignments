-- ============================================================
-- SQL CLASSWORK: 2926-1
-- Topics: Database Creation, Table Creation, Constraints,
--         INSERT, ALTER, SELECT, GROUP BY, UPDATE, DROP TABLE,
--         Subquery
-- ============================================================

-- ------------------------------------------------------------
-- 1. CREATE DATABASE
-- ------------------------------------------------------------

CREATE DATABASE maqbool;

USE maqbool;


-- ------------------------------------------------------------
-- 2. CREATE STUDENTS TABLE
-- ------------------------------------------------------------

CREATE TABLE students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    marks INT NOT NULL,
    dept_id INT NOT NULL,
    email VARCHAR(50) NOT NULL UNIQUE
);


-- ------------------------------------------------------------
-- 3. INSERT STUDENT DATA
-- ------------------------------------------------------------

INSERT INTO students (name, marks, dept_id, email)
VALUES
    ('nani', 99, 1, 'nani@gmail.com'),
    ('raj', 90, 1, 'raj@gmail.com'),
    ('tej', 61, 2, 'tej@gmail.com'),
    ('siva', 79, 1, 'siva@gmail.com'),
    ('raji', 39, 2, 'raji@gmail.com'),
    ('ravi', 89, 3, 'ravi@gmail.com'),
    ('ragu', 69, 2, 'ragu@gmail.com'),
    ('rayan', 49, 3, 'rayan@gmail.com'),
    ('nag', 70, 1, 'nag@gmail.com'),
    ('abhi', 59, 3, 'abhi@gmail.com'),
    ('harika', 79, 2, 'harika@gmail.com');


-- ------------------------------------------------------------
-- 4. ALTER TABLE
-- Rename dept_id to department_id
-- ------------------------------------------------------------

ALTER TABLE students
RENAME COLUMN dept_id TO department_id;


-- ------------------------------------------------------------
-- 5. SELECT ALL RECORDS
-- ------------------------------------------------------------

SELECT *
FROM students;


-- ------------------------------------------------------------
-- 6. GROUP BY + ORDER BY + LIMIT
-- Find the top 2 marks based on each name
-- ------------------------------------------------------------

SELECT
    name,
    MAX(marks)
FROM students
GROUP BY name
ORDER BY MAX(marks) DESC
LIMIT 2;


-- ------------------------------------------------------------
-- 7. UPDATE
-- Change marks from 80 to 66
-- ------------------------------------------------------------

UPDATE students
SET marks = 66
WHERE marks = 80;


-- ------------------------------------------------------------
-- 8. DISABLE SQL SAFE UPDATES
-- Kept exactly as part of the original classwork.
-- ------------------------------------------------------------

SET SQL_SAFE_UPDATES = 0;


-- ------------------------------------------------------------
-- 9. GROUP BY
-- Display unique department IDs
-- ------------------------------------------------------------

SELECT department_id
FROM students
GROUP BY department_id;


-- ------------------------------------------------------------
-- 10. DROP TABLE
-- ------------------------------------------------------------

DROP TABLE students;


-- ------------------------------------------------------------
-- 11. SUBQUERY
-- Original classwork query.
-- NOTE: This query comes after DROP TABLE, so it will fail if
-- the script is executed from top to bottom without recreating
-- the students table.
-- ------------------------------------------------------------

SELECT name
FROM students
WHERE student_id > (
    SELECT AVG(student_id)
    FROM students
);
