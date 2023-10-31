-- Task 1: Academic Management System (using SQL)

-- Step 1: Database Creation
-- Create the Studentinfo table with columns STU_ID, STU_NAME, DOB, PHONE_NO, EMAIL_ID, ADDRESS
CREATE TABLE Studentinfo (
    STU_ID SERIAL PRIMARY KEY,
    STU_NAME VARCHAR(100),
    DOB DATE,
    PHONE_NO VARCHAR(15),
    EMAIL_ID VARCHAR(100),
    ADDRESS TEXT
);

-- Create the Coursesinfo table with columns COURSE_ID, COURSE NAME, COURSE INSTRUCTOR NAME
CREATE TABLE Coursesinfo (
    COURSE_ID SERIAL PRIMARY KEY,
    COURSE_NAME VARCHAR(100),
    COURSE_INSTRUCTOR_NAME VARCHAR(100)
);

-- Create the Enrollmentinfo table with columns ENROLLMENT_ID, STU_ID, COURSE_ID, ENROLL_STATUS (Enrolled/Not Enrolled)
CREATE TABLE Enrollmentinfo (
    ENROLLMENT_ID SERIAL PRIMARY KEY,
    STU_ID INT REFERENCES Studentinfo(STU_ID),
    COURSE_ID INT REFERENCES Coursesinfo(COURSE_ID),
    ENROLL_STATUS VARCHAR(15)
);

-- Step 2: Data Creation
-- Insert sample data for Studentinfo table
INSERT INTO Studentinfo (STU_NAME, DOB, PHONE_NO, EMAIL_ID, ADDRESS)
VALUES
    ('Rajesh Kumar', '1998-05-12', '9876543210', 'rajesh@example.com', '123 Main St, Delhi'),
    ('Sneha Gupta', '2000-02-18', '7890123456', 'sneha@example.com', '456 Elm St, Mumbai');

-- Insert sample data for Coursesinfo table
INSERT INTO Coursesinfo (COURSE_NAME, COURSE_INSTRUCTOR_NAME)
VALUES
    ('Mathematics', 'Dr. Verma'),
    ('Physics', 'Prof. Singh');

-- Insert sample data for Enrollmentinfo table
INSERT INTO Enrollmentinfo (STU_ID, COURSE_ID, ENROLL_STATUS)
VALUES
    (1, 1, 'Enrolled'),
    (1, 2, 'Enrolled'),
    (2, 1, 'Enrolled'),
    (2, 2, 'Not Enrolled');

-- Step 3: Retrieve Student Information
-- a) Retrieve student details, including name, contact information, and enrollment status
SELECT STU_NAME, PHONE_NO, ENROLL_STATUS
FROM Studentinfo
JOIN Enrollmentinfo ON Studentinfo.STU_ID = Enrollmentinfo.STU_ID;

-- b) Retrieve a list of courses in which a specific student is enrolled
SELECT S.STU_NAME, C.COURSE_NAME, E.ENROLL_STATUS
FROM Studentinfo AS S
JOIN Enrollmentinfo AS E ON S.STU_ID = E.STU_ID
JOIN Coursesinfo AS C ON E.COURSE_ID = C.COURSE_ID
WHERE S.STU_NAME = 'Rajesh Kumar';

-- c) Retrieve course information, including course name and instructor information
SELECT COURSE_NAME, COURSE_INSTRUCTOR_NAME
FROM Coursesinfo;

-- d) Retrieve course information for a specific course
SELECT COURSE_NAME, COURSE_INSTRUCTOR_NAME
FROM Coursesinfo
WHERE COURSE_NAME = 'Mathematics';

-- e) Retrieve course information for multiple courses
SELECT COURSE_NAME, COURSE_INSTRUCTOR_NAME
FROM Coursesinfo
WHERE COURSE_NAME IN ('Mathematics', 'Physics');

-- f) Test the queries to ensure accurate retrieval of student information.
-- Execute the queries and verify the results against the expected output.

-- Step 4: Reporting and Analytics (Using joining queries)
-- a) Retrieve the number of students enrolled in each course
SELECT C.COURSE_NAME, COUNT(E.STU_ID) AS NUM_ENROLLED
FROM Coursesinfo AS C
LEFT JOIN Enrollmentinfo AS E ON C.COURSE_ID = E.COURSE_ID
GROUP BY C.COURSE_NAME;

-- b) Retrieve the list of students enrolled in a specific course
SELECT S.STU_NAME, E.ENROLL_STATUS
FROM Studentinfo AS S
JOIN Enrollmentinfo AS E ON S.STU_ID = E.STU_ID
JOIN Coursesinfo AS C ON E.COURSE_ID = C.COURSE_ID
WHERE C.COURSE_NAME = 'Mathematics';

-- c) Retrieve the count of enrolled students for each instructor
SELECT C.COURSE_INSTRUCTOR_NAME, COUNT(E.STU_ID) AS NUM_ENROLLED
FROM Coursesinfo AS C
LEFT JOIN Enrollmentinfo AS E ON C.COURSE_ID = E.COURSE_ID
GROUP BY C.COURSE_INSTRUCTOR_NAME;

-- d) Retrieve the list of students who are enrolled in multiple courses
SELECT S.STU_NAME, COUNT(E.COURSE_ID) AS NUM_ENROLLED
FROM Studentinfo AS S
JOIN Enrollmentinfo AS E ON S.STU_ID = E.STU_ID
GROUP BY S.STU_NAME;

-- e) Retrieve the courses with the highest number of enrolled students
SELECT C.COURSE_NAME, COUNT(E.STU_ID) AS NUM_ENROLLED
FROM Coursesinfo AS C
LEFT JOIN Enrollmentinfo AS E ON C.COURSE_ID = E.COURSE_ID
GROUP BY C.COURSE_NAME
ORDER BY NUM_ENROLLED DESC;
