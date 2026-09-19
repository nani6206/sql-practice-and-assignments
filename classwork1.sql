-- ============================================================
-- SQL CLASSWORK: nani1
-- Topics: Table Creation, INSERT, Aggregate Functions, ORDER BY,
--         Joins, Self Join, UNION / UNION ALL, GROUP BY, HAVING
-- ============================================================

-- ------------------------------------------------------------
-- 1. CREATE STUDENTS TABLE AND INSERT DATA
-- ------------------------------------------------------------

CREATE TABLE nani.students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50),
    dept VARCHAR(10),
    marks INT
);

INSERT INTO nani.students (name, dept, marks)
VALUES
    ('Ravi', 'CSE', 80),
    ('Ananya', 'CSE', 70),
    ('Rohit', 'ECE', 90),
    ('Meena', 'ECE', 60),
    ('Siva', 'ME', 100),
    ('Kiran', 'ME', 80);


-- ------------------------------------------------------------
-- 2. AGGREGATE FUNCTIONS
-- ------------------------------------------------------------

SELECT COUNT(*) FROM nani.students;

SELECT SUM(marks) FROM nani.students;

SELECT AVG(marks) FROM nani.students;

SELECT MAX(marks) FROM nani.students;

SELECT MIN(marks) FROM nani.students;


-- ------------------------------------------------------------
-- 3. ORDER BY
-- ------------------------------------------------------------

-- Sort marks in ascending order
SELECT *
FROM nani.students
ORDER BY marks;

-- Sort marks in descending order
SELECT *
FROM nani.students
ORDER BY marks DESC;

-- Sort students by student_id
SELECT *
FROM nani.students
ORDER BY student_id;


-- ------------------------------------------------------------
-- 4. CREATE COURSES TABLE AND INSERT DATA
-- ------------------------------------------------------------

CREATE TABLE nani.courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    duration INT,
    fee DECIMAL(10, 2)
);

INSERT INTO nani.courses (course_id, course_name, duration, fee)
VALUES
    (101, 'Python', 6, 15000),
    (102, 'Java', 8, 20000),
    (103, 'Data Science', 10, 30000),
    (104, 'Web Development', 6, 18000),
    (105, 'Cloud Computing', 5, 25000);


-- ------------------------------------------------------------
-- 5. CREATE STUDENTS_25 TABLE
-- ------------------------------------------------------------

CREATE TABLE nani.students_25 (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    student_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    course_id INT,
    city VARCHAR(50),

    FOREIGN KEY (course_id)
        REFERENCES courses(course_id)
);

INSERT INTO nani.students_25
    (student_name, email, course_id, city)
VALUES
    ('Ravi Kumar', 'ravi@gmail.com', 101, 'Hyderabad'),
    ('Priya Sharma', 'priya@gmail.com', 102, 'Chennai'),
    ('Arjun Reddy', 'arjun@gmail.com', 103, 'Bangalore'),
    ('Sneha Rao', 'sneha@gmail.com', 101, 'Hyderabad'),
    ('Kiran Kumar', 'kiran@gmail.com', 104, 'Vijayawada');


-- ------------------------------------------------------------
-- 6. INNER JOIN
-- ------------------------------------------------------------

SELECT
    s.student_id,
    s.student_name,
    c.course_name,
    c.fee
FROM nani.students_25 AS s
INNER JOIN nani.courses AS c
    ON s.course_id = c.course_id;


-- ------------------------------------------------------------
-- 7. LEFT JOIN + RIGHT JOIN USING UNION ALL
-- ------------------------------------------------------------

SELECT *
FROM nani.students_25 AS s
LEFT JOIN nani.courses AS c
    ON s.course_id = c.course_id

UNION ALL

SELECT *
FROM nani.students_25 AS s
RIGHT JOIN nani.courses AS c
    ON s.course_id = c.course_id;


-- ------------------------------------------------------------
-- 8. LEFT JOIN + RIGHT JOIN USING UNION
-- ------------------------------------------------------------

SELECT *
FROM nani.students_25 AS s
LEFT JOIN nani.courses AS c
    ON s.course_id = c.course_id

UNION

SELECT *
FROM nani.students_25 AS s
RIGHT JOIN nani.courses AS c
    ON s.course_id = c.course_id;


-- ------------------------------------------------------------
-- 9. CROSS JOIN
-- ------------------------------------------------------------

SELECT
    s.student_name,
    c.course_name
FROM nani.students_25 AS s
CROSS JOIN nani.courses AS c;


-- ------------------------------------------------------------
-- 10. SELF JOIN
-- ------------------------------------------------------------

CREATE TABLE nani.employee (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50) NOT NULL,
    manager_id INT
);

INSERT INTO nani.employee (emp_id, emp_name, manager_id)
VALUES
    (1, 'Ravi', NULL),
    (2, 'Ananya', 1),
    (3, 'Rahul', 1),
    (4, 'Meena', 2);

SELECT *
FROM nani.employee AS e
LEFT JOIN nani.employee AS p
    ON e.manager_id = p.emp_id;


-- ------------------------------------------------------------
-- 11. UNION
-- ------------------------------------------------------------

SELECT city
FROM nani.students_25
WHERE city = 'Hyderabad'

UNION

SELECT city
FROM nani.students_25
WHERE city = 'Chennai';


-- ------------------------------------------------------------
-- 12. UNION ALL
-- ------------------------------------------------------------

SELECT city
FROM nani.students_25
WHERE city = 'Hyderabad'

UNION ALL

SELECT city
FROM nani.students_25
WHERE city = 'Chennai';


-- ------------------------------------------------------------
-- 13. GROUP BY
-- ------------------------------------------------------------

SELECT
    dept,
    AVG(marks) AS average_marks
FROM nani.students
GROUP BY dept;


-- ------------------------------------------------------------
-- 14. GROUP BY WITH WHERE
-- ------------------------------------------------------------

SELECT
    dept,
    AVG(marks) AS average_marks
FROM nani.students
WHERE marks >= 70
GROUP BY dept;


-- ------------------------------------------------------------
-- 15. GROUP BY WITH HAVING
-- ------------------------------------------------------------

SELECT
    dept,
    AVG(marks) AS average_marks
FROM nani.students
GROUP BY dept
HAVING AVG(marks) > 80;
