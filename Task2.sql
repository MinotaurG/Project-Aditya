-- Task 2: Student Database Management System (PostgreSQL)

-- Step 1: Database Setup
-- Create a database named "student_database"

-- Create the "student_table" with columns
CREATE TABLE student_table (
    Student_id SERIAL PRIMARY KEY,
    Stu_name VARCHAR(100),
    Department TEXT,
    email_id TEXT,
    Phone_no NUMERIC,
    Address TEXT,
    Date_of_birth DATE,
    Gender TEXT,
    Major TEXT,
    GPA NUMERIC,
    Grade CHAR(1)
);

-- Step 2: Data Entry
-- Insert 10 sample records into the "student_table"
INSERT INTO student_table (Stu_name, Department, email_id, Phone_no, Address, Date_of_birth, Gender, Major, GPA, Grade)
VALUES
    ('Rahul Kumar', 'Computer Science', 'rahul@example.com', 9876543210, '123 Main St, Delhi', '1999-04-15', 'Male', 'Computer Science', 8.2, 'A'),
    ('Priya Sharma', 'Electrical Engineering', 'priya@example.com', 7890123456, '456 Elm St, Mumbai', '2000-07-22', 'Female', 'Electrical Engineering', 7.5, 'B'),
    ('Amit Verma', 'Mechanical Engineering', 'amit@example.com', 9876543211, '789 Oak St, Chennai', '1998-12-10', 'Male', 'Mechanical Engineering', 6.8, 'C'),
    ('Sneha Gupta', 'Computer Science', 'sneha@example.com', 7890123457, '567 Pine St, Kolkata', '2000-01-30', 'Female', 'Computer Science', 7.9, 'B'),
    ('Avinash Singh', 'Civil Engineering', 'avinash@example.com', 9876543212, '890 Cedar St, Bangalore', '1999-09-05', 'Male', 'Civil Engineering', 7.2, 'C'),
    ('Anjali Patel', 'Electrical Engineering', 'anjali@example.com', 7890123458, '234 Birch St, Mumbai', '2001-03-12', 'Female', 'Electrical Engineering', 8.7, 'A'),
    ('Vikas Pandey', 'Computer Science', 'vikas@example.com', 9876543213, '345 Redwood St, Chennai', '1999-06-18', 'Male', 'Computer Science', 7.1, 'C'),
    ('Neha Yadav', 'Mechanical Engineering', 'neha@example.com', 7890123459, '456 Walnut St, Delhi', '2000-04-05', 'Female', 'Mechanical Engineering', 8.4, 'A'),
    ('Rajat Jain', 'Civil Engineering', 'rajat@example.com', 9876543214, '678 Maple St, Pune', '1998-08-20', 'Male', 'Civil Engineering', 6.5, 'D'),
    ('Monika Mishra', 'Electrical Engineering', 'monika@example.com', 7890123460, '789 Birch St, Bangalore', '2000-11-08', 'Female', 'Electrical Engineering', 7.7, 'C');

-- Step 3: Student Information Retrieval
-- Retrieve all students' information and sort them in descending order by their grade
SELECT *
FROM student_table
ORDER BY Grade DESC;

-- Step 4: Query for Male Students
-- Retrieve information about all male students
SELECT *
FROM student_table
WHERE Gender = 'Male';

-- Step 5: Query for Students with GPA less than 5.0
-- Fetch the details of students with GPA less than 5.0
SELECT *
FROM student_table
WHERE GPA < 5.0;

-- Step 6: Update Student Email and Grade
-- Modify the email and grade of a student with a specific ID
UPDATE student_table
SET email_id = 'updated_email@example.com', Grade = 'B'
WHERE Student_id = 2;

-- Step 7: Query for Students with Grade "B"
-- Retrieve the names and ages of students with a grade of "B"
SELECT Stu_name, AGE(Date_of_birth) AS Age
FROM student_table
WHERE Grade = 'B';

-- Step 8: Grouping and Calculation
-- Group by "Department" and "Gender" and calculate the average GPA for each combination
SELECT Department, Gender, AVG(GPA) AS Average_GPA
FROM student_table
GROUP BY Department, Gender;

-- Step 9: Table Renaming
-- Rename the "student_table" to "student_info"
ALTER TABLE student_table RENAME TO student_info;

-- Step 10: Retrieve Student with Highest GPA
-- Query to retrieve the name of the student with the highest GPA
SELECT Stu_name, GPA
FROM student_info
ORDER BY GPA DESC
LIMIT 1;
