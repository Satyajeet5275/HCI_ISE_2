CREATE DATABASE university_db;
USE university_db;

CREATE TABLE Classroom (
    building VARCHAR(50),
    room_number VARCHAR(10),
    capacity INT,
    PRIMARY KEY (building, room_number)
);

CREATE TABLE Department (
    dept_name VARCHAR(50) PRIMARY KEY,
    building VARCHAR(50),
    budget DECIMAL(12, 2)
);

CREATE TABLE Course (
    course_id VARCHAR(10) PRIMARY KEY,
    title VARCHAR(100),
    dept_name VARCHAR(50),
    credits INT,
    FOREIGN KEY (dept_name) REFERENCES Department(dept_name)
);

CREATE TABLE Instructor (
    ID VARCHAR(10) PRIMARY KEY,
    name VARCHAR(100),
    dept_name VARCHAR(50),
    salary DECIMAL(10, 2),
    FOREIGN KEY (dept_name) REFERENCES Department(dept_name)
);

CREATE TABLE Section (
    course_id VARCHAR(10),
    sec_id VARCHAR(10),
    semester VARCHAR(10),
    year INT,
    building VARCHAR(50),
    room_number VARCHAR(10),
    time_slot_id VARCHAR(10),
    PRIMARY KEY (course_id, sec_id, semester, year),
    FOREIGN KEY (course_id) REFERENCES Course(course_id),
    FOREIGN KEY (building, room_number) REFERENCES Classroom(building, room_number)
);

CREATE TABLE Teaches (
    ID VARCHAR(10),
    course_id VARCHAR(10),
    sec_id VARCHAR(10),
    semester VARCHAR(10),
    year INT,
    PRIMARY KEY (ID, course_id, sec_id, semester, year),
    FOREIGN KEY (ID) REFERENCES Instructor(ID),
    FOREIGN KEY (course_id, sec_id, semester, year) REFERENCES Section(course_id, sec_id, semester, year)
);

CREATE TABLE Student (
    ID VARCHAR(10) PRIMARY KEY,
    name VARCHAR(100),
    dept_name VARCHAR(50),
    tot_cred INT,
    FOREIGN KEY (dept_name) REFERENCES Department(dept_name)
);

CREATE TABLE Takes (
    ID VARCHAR(10),
    course_id VARCHAR(10),
    sec_id VARCHAR(10),
    semester VARCHAR(10),
    year INT,
    grade VARCHAR(2),
    PRIMARY KEY (ID, course_id, sec_id, semester, year),
    FOREIGN KEY (ID) REFERENCES Student(ID),
    FOREIGN KEY (course_id, sec_id, semester, year) REFERENCES Section(course_id, sec_id, semester, year)
);

CREATE TABLE Advisor (
    s_ID VARCHAR(10),
    i_ID VARCHAR(10),
    PRIMARY KEY (s_ID),
    FOREIGN KEY (s_ID) REFERENCES Student(ID),
    FOREIGN KEY (i_ID) REFERENCES Instructor(ID)
);

CREATE TABLE Time_slot (
    time_slot_id VARCHAR(10),
    day VARCHAR(10),
    start_time TIME,
    end_time TIME,
    PRIMARY KEY (time_slot_id, day, start_time)
);

CREATE TABLE Prereq (
    course_id VARCHAR(10),
    prereq_id VARCHAR(10),
    PRIMARY KEY (course_id, prereq_id),
    FOREIGN KEY (course_id) REFERENCES Course(course_id),
    FOREIGN KEY (prereq_id) REFERENCES Course(course_id)
);

-- Insert sample data here

-- Insert sample data for Classroom
INSERT INTO Classroom (building, room_number, capacity) 
VALUES 
('Science Block', '101', 50),
('Arts Block', '202', 30),
('Commerce Block', '303', 40),
('Engineering Block', '404', 60),
('Math Block', '505', 35);

-- Insert sample data for Department
INSERT INTO Department (dept_name, building, budget) 
VALUES 
('Computer Science', 'Science Block', 1000000.00),
('Mathematics', 'Math Block', 500000.00),
('Physics', 'Science Block', 800000.00),
('Economics', 'Commerce Block', 600000.00),
('History', 'Arts Block', 400000.00);

-- Insert sample data for Course
INSERT INTO Course (course_id, title, dept_name, credits) 
VALUES 
('CS101', 'Introduction to Programming', 'Computer Science', 4),
('MATH201', 'Calculus I', 'Mathematics', 3),
('PHYS101', 'Physics I', 'Physics', 4),
('ECON101', 'Microeconomics', 'Economics', 3),
('HIST101', 'World History', 'History', 3);

-- Insert sample data for Instructor
INSERT INTO Instructor (ID, name, dept_name, salary) 
VALUES 
('I1001', 'John Doe', 'Computer Science', 75000.00),
('I1002', 'Alice Smith', 'Mathematics', 65000.00),
('I1003', 'Bob Johnson', 'Physics', 70000.00),
('I1004', 'Mary White', 'Economics', 68000.00),
('I1005', 'Michael Brown', 'History', 62000.00);

-- Insert sample data for Section
INSERT INTO Section (course_id, sec_id, semester, year, building, room_number, time_slot_id) 
VALUES 
('CS101', 'S1', 'Fall', 2024, 'Science Block', '101', 'TS1'),
('MATH201', 'S1', 'Fall', 2024, 'Math Block', '505', 'TS2'),
('PHYS101', 'S1', 'Spring', 2024, 'Science Block', '101', 'TS3'),
('ECON101', 'S1', 'Spring', 2024, 'Commerce Block', '303', 'TS4'),
('HIST101', 'S1', 'Fall', 2024, 'Arts Block', '202', 'TS5');

-- Insert sample data for Teaches
INSERT INTO Teaches (ID, course_id, sec_id, semester, year) 
VALUES 
('I1001', 'CS101', 'S1', 'Fall', 2024),
('I1002', 'MATH201', 'S1', 'Fall', 2024),
('I1003', 'PHYS101', 'S1', 'Spring', 2024),
('I1004', 'ECON101', 'S1', 'Spring', 2024),
('I1005', 'HIST101', 'S1', 'Fall', 2024);

-- Insert sample data for Student
INSERT INTO Student (ID, name, dept_name, tot_cred) 
VALUES 
('S1001', 'David Green', 'Computer Science', 20),
('S1002', 'Emily Black', 'Mathematics', 30),
('S1003', 'Charlie Red', 'Physics', 25),
('S1004', 'Sophia White', 'Economics', 35),
('S1005', 'Liam Blue', 'History', 40);

-- Insert sample data for Takes
INSERT INTO Takes (ID, course_id, sec_id, semester, year, grade) 
VALUES 
('S1001', 'CS101', 'S1', 'Fall', 2024, 'A'),
('S1002', 'MATH201', 'S1', 'Fall', 2024, 'B+'),
('S1003', 'PHYS101', 'S1', 'Spring', 2024, 'A-'),
('S1004', 'ECON101', 'S1', 'Spring', 2024, 'B'),
('S1005', 'HIST101', 'S1', 'Fall', 2024, 'A');

-- Insert sample data for Advisor
INSERT INTO Advisor (s_ID, i_ID) 
VALUES 
('S1001', 'I1001'),
('S1002', 'I1002'),
('S1003', 'I1003'),
('S1004', 'I1004'),
('S1005', 'I1005');

-- Insert sample data for Time_slot
INSERT INTO Time_slot (time_slot_id, day, start_time, end_time) 
VALUES 
('TS1', 'Monday', '09:00:00', '10:30:00'),
('TS2', 'Tuesday', '10:00:00', '11:30:00'),
('TS3', 'Wednesday', '11:00:00', '12:30:00'),
('TS4', 'Thursday', '09:30:00', '11:00:00'),
('TS5', 'Friday', '08:00:00', '09:30:00');

-- Insert sample data for Prereq
INSERT INTO Prereq (course_id, prereq_id) 
VALUES 
('CS101', 'MATH201'),
('PHYS101', 'MATH201'),
('PHYS101', 'CS101'),
('ECON101', 'MATH201'),
('HIST101', 'ECON101');
