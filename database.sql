-- Create Database
CREATE DATABASE IF NOT EXISTS ZenClassProgram;

USE ZenClassProgram;

CREATE TABLE Users (
    UserID INT PRIMARY KEY AUTO_INCREMENT,
    UserName VARCHAR(255),
    UserType VARCHAR(50)
);


INSERT INTO Users (UserName, UserType) VALUES
('Koushik', 'Student'),
('Arun', 'Student'),
('Sai', 'Mentor'),
('Triniton', 'Student');


SELECT * FROM Users;



-- Create CodeKata Table
CREATE TABLE CodeKata (
    CodeKataID INT PRIMARY KEY AUTO_INCREMENT,
    UserID INT,
    ProblemsSolved INT,
    Date DATE,
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

INSERT INTO CodeKata (UserID, ProblemsSolved, Date) VALUES
(1, 10, '2020-10-05'),
(2, 15, '2020-10-10'),
(4, 8, '2020-10-20');

SELECT * FROM CodeKata;


-- Create Attendance Table
CREATE TABLE Attendance (
    AttendanceID INT PRIMARY KEY AUTO_INCREMENT,
    UserID INT,
    Date DATE,
    Status VARCHAR(20),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

INSERT INTO Attendance (UserID, Date, Status) VALUES
(1, '2020-10-05', 'Present'),
(2, '2020-10-10', 'Present'),
(4, '2020-10-20', 'Absent');

SELECT * FROM Attendance;


-- Create Topics Table
CREATE TABLE Topics (
    TopicID INT PRIMARY KEY AUTO_INCREMENT,
    TopicName VARCHAR(255)
);

INSERT INTO Topics (TopicName) VALUES
('Database Design'),
('SQL'),
('Javascript');

SELECT * FROM Topics;



-- Create Tasks Table
CREATE TABLE Tasks (
    TaskID INT PRIMARY KEY AUTO_INCREMENT,
    TopicID INT,
    UserID INT,
    SubmissionStatus VARCHAR(20),
    Date DATE,
    FOREIGN KEY (TopicID) REFERENCES Topics(TopicID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

INSERT INTO Tasks (TopicID, UserID, SubmissionStatus, Date) VALUES
(1, 1, 'Submitted', '2020-10-08'),
(2, 2, 'Not Submitted', '2020-10-12'),
(3, 4, 'Submitted', '2020-10-25');

SELECT * FROM Tasks;



-- Create CompanyDrives Table
CREATE TABLE CompanyDrives (
    DriveID INT PRIMARY KEY AUTO_INCREMENT,
    DriveName VARCHAR(255),
    Date DATE
);

INSERT INTO CompanyDrives (DriveName, Date) VALUES
('Datafoundry', '2020-10-18'),
('Google', '2020-10-30');

SELECT * FROM CompanyDrives;



-- Create Mentors Table
CREATE TABLE Mentors (
    MentorID INT PRIMARY KEY AUTO_INCREMENT,
    MentorName VARCHAR(255)
);

INSERT INTO Mentors (MentorName) VALUES
('Karthik'),
('Arthy'),
('Bharathikannan');

SELECT * FROM Mentors;



-- Update Users Table with MentorID
UPDATE Users SET MentorID = 1 WHERE UserID = 1;
UPDATE Users SET MentorID = 2 WHERE UserID = 2;
UPDATE Users SET MentorID = 3 WHERE UserID = 4;

SELECT * FROM Users;




########################################################################

                         -- QUESTIONS AND RESULTS              

########################################################################


--  1 - Find all the topics and tasks taught in the month of October

SELECT Topics.TopicName, Tasks.TaskID
FROM Topics
JOIN Tasks ON Topics.TopicID = Tasks.TopicID
WHERE MONTH(Tasks.Date) = 10;




--  2 - Find all the company drives between 15-Oct-2020 and 31-Oct-2020:

SELECT * FROM CompanyDrives
WHERE Date BETWEEN '2020-10-15' AND '2020-10-31';



--  3 - Find all the company drives and students who appeared for placement:

SELECT CompanyDrives.DriveName, Users.UserName
FROM CompanyDrives
JOIN Attendance ON CompanyDrives.Date = Attendance.Date
JOIN Users ON Attendance.UserID = Users.UserID
WHERE Users.UserType = 'Student';




--  4 - Find the number of problems solved by the user in CodeKata:

SELECT Users.UserName, CodeKata.ProblemsSolved
FROM Users
JOIN CodeKata ON Users.UserID = CodeKata.UserID;




--  5 - Find all the mentors with more than 15 mentees:

SELECT Mentors.MentorName, COUNT(*) AS MenteeCount
FROM Mentors
JOIN Users ON Mentors.MentorID = Users.MentorID
GROUP BY Mentors.MentorID
HAVING MenteeCount > 15;





--- 6 - Find the number of users who are absent and the task is not submitted between 15-Oct-2020 and 31-Oct-2020:

SELECT COUNT(*) AS AbsentNotSubmittedCount
FROM Attendance
JOIN Tasks ON Attendance.UserID = Tasks.UserID
WHERE Attendance.Status = 'Absent' AND Tasks.SubmissionStatus = 'Not Submitted'
AND Attendance.Date BETWEEN '2020-10-15' AND '2020-10-31';
