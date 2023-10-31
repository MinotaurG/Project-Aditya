-- Task 3: Event Management System using PostgreSQL

-- Step 1: Database Creation
-- Create a database named "EventsManagement"

-- Step 2: Create tables for Events, Attendees, and Registrations

-- Create the "Events" table with columns
CREATE TABLE Events (
    Event_Id SERIAL PRIMARY KEY,
    Event_Name VARCHAR(100),
    Event_Date DATE,
    Event_Location VARCHAR(100),
    Event_Description TEXT
);

-- Create the "Attendees" table with columns
CREATE TABLE Attendees (
    Attendee_id SERIAL PRIMARY KEY,
    Attendee_Name VARCHAR(100),
    Attendee_Phone NUMERIC,
    Attendee_Email TEXT,
    Attendee_City VARCHAR(50)
);

-- Create the "Registrations" table with columns
CREATE TABLE Registrations (
    Registration_id SERIAL PRIMARY KEY,
    Event_Id INT,
    Attendee_id INT,
    Registration_Date DATE,
    Registration_Amount NUMERIC
);

-- Add foreign key constraints
ALTER TABLE Registrations
ADD CONSTRAINT fk_event
FOREIGN KEY (Event_Id)
REFERENCES Events(Event_Id);

ALTER TABLE Registrations
ADD CONSTRAINT fk_attendee
FOREIGN KEY (Attendee_id)
REFERENCES Attendees(Attendee_id);

-- Step 3: Data Creation

-- Insert sample data for the "Events" table
INSERT INTO Events (Event_Name, Event_Date, Event_Location, Event_Description)
VALUES
    ('Seminar on AI', '2023-03-15', 'Mumbai', 'Introduction to Artificial Intelligence'),
    ('Music Concert', '2023-04-20', 'Delhi', 'Live music performance'),
    ('Tech Conference', '2023-05-10', 'Bangalore', 'Latest tech trends and innovations');

-- Insert sample data for the "Attendees" table
INSERT INTO Attendees (Attendee_Name, Attendee_Phone, Attendee_Email, Attendee_City)
VALUES
    ('Rajesh Kumar', 9876543210, 'rajesh@email.com', 'Delhi'),
    ('Asha Sharma', 8765432109, 'asha@email.com', 'Mumbai'),
    ('Kiran Singh', 7654321098, 'kiran@email.com', 'Bangalore');

-- Insert sample data for the "Registrations" table
INSERT INTO Registrations (Event_Id, Attendee_id, Registration_Date, Registration_Amount)
VALUES
    (1, 1, '2023-03-10', 500),
    (1, 2, '2023-03-11', 500),
    (2, 2, '2023-04-15', 300),
    (3, 3, '2023-05-05', 600);

-- Step 4: Manage Event Details

-- a) Inserting a new event
-- Insert a new event named "Art Exhibition"
INSERT INTO Events (Event_Name, Event_Date, Event_Location, Event_Description)
VALUES
    ('Art Exhibition', '2023-06-15', 'Chennai', 'Display of modern art creations');

-- b) Updating an event's information
-- Update event description for the "Seminar on AI"
UPDATE Events
SET Event_Description = 'In-depth AI knowledge sharing'
WHERE Event_Id = 1;

-- c) Deleting an event
-- Delete the event with Event_Id = 3 (Tech Conference)
DELETE FROM Events
WHERE Event_Id = 3;

-- Step 5: Manage Track Attendees & Handle Events

-- a) Inserting a new attendee
-- Insert a new attendee named "Neha Pandey"
INSERT INTO Attendees (Attendee_Name, Attendee_Phone, Attendee_Email, Attendee_City)
VALUES
    ('Neha Pandey', 9876543211, 'neha@email.com', 'Chennai');

-- b) Registering an attendee for an event
-- Register Neha Pandey for the "Art Exhibition" event
INSERT INTO Registrations (Event_Id, Attendee_id, Registration_Date, Registration_Amount)
SELECT
    e.Event_Id,
    a.Attendee_id,
    '2023-06-10',
    400
FROM
    Events e
JOIN
    Attendees a ON a.Attendee_Name = 'Neha Pandey';

-- Step 6: Develop queries to retrieve event information, generate attendee lists, and calculate event attendance statistics

-- a) Retrieve event information
SELECT * FROM Events;

-- b) Generate attendee lists for a specific event
SELECT
    a.Attendee_Name
FROM
    Registrations r
JOIN
    Attendees a ON r.Attendee_id = a.Attendee_id
WHERE
    r.Event_Id = 1;  -- Specify the event ID

-- c) Calculate event attendance statistics
SELECT
    e.Event_Name,
    COUNT(r.Registration_id) AS Attendee_Count
FROM
    Events e
LEFT JOIN
    Registrations r ON e.Event_Id = r.Event_Id
GROUP BY
    e.Event_Name;

-- Step 7: Commit the transaction
COMMIT;
