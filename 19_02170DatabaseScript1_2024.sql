###########################################################################################################
# 1) the statements used to create the database, its tables and views (as used in section 4 of the report)
###########################################################################################################

# Creation of database:
DROP DATABASE IF EXISTS Hospital;
CREATE DATABASE Hospital;
USE Hospital;

# Creation of the database tables:
DROP TABLE IF EXISTS PatientJournals;
DROP TABLE IF EXISTS Doctors;
DROP TABLE IF EXISTS Patients;
DROP TABLE IF EXISTS Nurses;
DROP TABLE IF EXISTS Departments;


CREATE TABLE Departments (
Department  VARCHAR(40) PRIMARY KEY,
DeptFloor 	INT(3) UNIQUE,
Budget 		INT(10)
);

CREATE TABLE Doctors (
DoctorID 	SERIAL PRIMARY KEY,
FullName 	VARCHAR(90),
Sex			VARCHAR(6),
Salary 		INT(10),
Department 	VARCHAR(20),
HeadOfDept 	BIT(1),
FOREIGN KEY (Department) REFERENCES Departments(Department) ON DELETE CASCADE
);

CREATE Table Patients (
CPR_no  		VARCHAR(11) PRIMARY KEY,
FullName		VARCHAR(90),
Age				INT(3),
Sex				VARCHAR(6),
Address			VARCHAR(60),
PhoneNumber		INT(10),
Email			VARCHAR(60),
Room			INT(3),
AssignedDoctor  BIGINT UNSIGNED,
FOREIGN KEY (AssignedDoctor) references Doctors(DoctorID) ON DELETE SET NULL
);

CREATE TABLE Nurses (
NurseID 	SERIAL PRIMARY KEY,
FullName 	VARCHAR(90),
Sex 		VARCHAR(6),
Salary		INT(10),
Department 	VARCHAR(20),
FOREIGN KEY (Department) REFERENCES Departments(Department) ON DELETE SET NULL
);


CREATE TABLE PatientJournals (
	CPR_no 				VARCHAR(11),
	Diagnosis 			VARCHAR(200),
	DiagnosisDate 		DATE,
	DiagnosisTime 		TIME,
	DiagnosedBy		 	BIGINT UNSIGNED,
	primary key(CPR_no, Diagnosis, DiagnosisDate),
	foreign key(CPR_no) references Patients(CPR_no) ON DELETE CASCADE,
	foreign key(DiagnosedBy) references Doctors(DoctorID) ON DELETE SET NULL 
);


# Creation of Views (Only makes sense after populating tables in the next step below)
DROP VIEW IF EXISTS Doctors_In_HeartAndSkin;
DROP VIEW IF EXISTS Male_Doctors_Patients_With_FullNames;


CREATE VIEW Doctors_In_HeartAndSkin AS
SELECT DoctorID, FullName, Department FROM Doctors
WHERE Department IN ('Cardiology', 'Neurology');

Select * FROM Doctors_In_HeartAndSkin;



CREATE VIEW Male_Doctors_Patients_With_FullNames AS
SELECT 
	Doctors.DoctorID,
	Doctors.FullName as doctorName, 
	Patients.CPR_no,
	Patients.FullName as patientName
FROM Doctors
	INNER JOIN Patients
	ON Patients.AssignedDoctor = Doctors.DoctorID
Order by Doctors.DoctorID;


SELECT * FROM Male_Doctors_Patients_With_FullNames;
SELECT DoctorID, FullName FROM Doctors WHERE Sex = 'Male'; # For Comparison


######################################################################
# 2) the statements used to populate the tables (as used in section 5)
######################################################################

INSERT INTO Departments VALUES 
	('Cardiology', 7, 1200000),
	('Sexual Health', 6, 600000),
	('Fertility', -3, 545000),
	('Dermatology', 1, 950000),
	('Cosmetic Surgery', 18, 850000),
	('Neurology', 8, 1400000),
	('Oncology', 12, 1000000),
	('Pharmacy', 13, 450000),
	('Pathology', -2, 3350000),
	('Radiology', -1, 300000);


# This syntax due to SERIAL as primary key
INSERT INTO Doctors(FullName,Sex,Salary,Department,HeadOfDept) Values 
	('Tobias Martinsen', 'Male', 60000*12, 'Sexual Health', 0),
	('Peter Stensig', 'Male', 76000*12, 'Cardiology',1),
	('Frederik Udby', 'Male', 50000*12, 'Fertility',1),
	('Nikolaj Nguyen', 'Male', 58000*12, 'Dermatology',1),
	('Christoffer Frost', 'Male', 30000*12, 'Cosmetic Surgery',1),
	('Tea Mortensen', 'Female', 65000*12, 'Neurology',1),
	('Pernille Vandsig', 'Female', 75000*12, 'Oncology',1),
	('Fie Indby', 'Female', 52000*12, 'Pharmacy',0), 
	('Nikoline Nissen', 'Female', 66000*12, 'Pathology',0),
	('Christina Sommer', 'Female', 48000*12, 'Radiology',1);


INSERT INTO Nurses(FullName, Sex, Salary, Department) values
	('Danny DeVito', 'Male', 34000*12, 'Sexual Health'),
	('Margot Robbie', 'Female', 38000*12, 'Cardiology'),
	('Kasper Friis', 'Male', 36000*12, 'Fertility'),
	('Sydney Sweeney', 'Female', 40000*12, 'Dermatology'),
	('Angelina Joelie','Female', 40000*12, 'Cosmetic Surgery'),
	('Albert Einstein','Male', 42000*12, 'Neurology'),
	('Chadwick Boseman','Male', 40000*12, 'Oncology'),
	('Martin Malmsten','Male', 40000*12, 'Pharmacy'),
	('Corona Lockdown','Male', 40000*12, 'Pathology'),
	('Lady Gaga','Female', 42000*12, 'Cardiology'),
	('Peter Parker','Male', 40000*12, 'Cardiology'),
	('Miles Moralis','Male', 40000*12, NULL),
	('Bard Bard','Male', 40000*12, NULL),
	('Bruce Banner','Male', 32000*12, 'Fertility');


INSERT INTO Patients values
	('260702-3671', 'Christian Vedel Pedersen', 22, 'Male', 'Nybrogaard kollegie 69a', 30220813, 's224810@student.dtu.dk', 5, 1),
	('250701-4732', 'Katinka Spangtoft', 23, 'Female','P.O. Pedersen-kollegiet' ,61341289, 's224805@student.dtu.dk', 9, 2),
	('240700-7418', 'Marilouise Arbøl', 24, 'Female', 'Kampsax kollegiet 521', 93990618,'s214401@student.dtu.dk', 10, 3),
	('130301-3666', 'Michelle Mai', 23, 'Female', 'NoClue avenue 17', 52690290, 's224771@student.dtu.dk', 4, 4),
	('300501-7451', 'Thor Skipper', 23, 'Male','Nybrogaard kollegie 69a', 51924474, 's224817@student.dtu.dk', 1, 5),
	('010100-1818', 'Franken Stein', 106,'Male', 'Basement', 66666666, 'MaryShelley@darkmail.com', 3, 2), 
	('100000-1000', 'Vladimir Putin', 71,'Male', 'Moskva', 11111111, 'Putin@mail.com', 6, 6), 
	('200000-2000', 'Joseph Stalin', 54,'Male', 'Moskva', 22222222, 'Stalin@mail.com', 7, 6), 
	('300000-3000', 'Adolf Hitler', 45,'Male', 'Tyskland', 33333333, 'Hitler@mail.com', 8, 7), 
	('400000-4000', 'Barrack Obama',62 ,'Male', 'USA', 44444444, 'Obama@mail.com', 11, 7), 
	('500000-5000', 'Hussein Gaddafi', 57,'Male', 'Libien', 55555555, 'Gaddafi@mail.com', 12, 8), 
	('600000-6000', 'Mette Mink', 46 ,'Female', 'Danmark', 77777777, 'Mette@mail.com', 13, 8), 
	('700000-7000', 'Charles Darwin', 112,'Male', 'England', 88888888, 'Darwin@mail.com', 14, 9), 
	('800000-8000', 'Michael Pedersen', 48,'Male', 'Danmark', 12344321, 'Michael@mail.com', 15, 9), 
	('900000-9000', 'Donald Trump', 77,'Male', 'USA', 43211234, 'Trump@mail.com', 16, 10), 
	('905000-9050', 'Joe Biden', 81,'Male', 'USA', 87654321, 'Biden@mail.com', 17, 10);
	

INSERT INTO PatientJournals values
	('260702-3671', 'Suffers from Bigusdikus', '2002-07-26', '02:54:23', 3),
	('250701-4732', 'Langelandssyndrom stadie 2', '2001-07-25', '00:00:00', 2),
	('240700-7418', 'Kaps (lethal)', '2022-09-02', '08:00:00', 1),
	('130301-3666', 'UX fanatic', '2023-06-06', '08:00:00', 4),
	('300501-7451', 'Communism og Suffers from succes', '2022-09-02', '08:00:00', 5),
	('010100-1818', 'Death', '2022-05-01', '09:00:00', 6), 
	('100000-1000', 'Communism', '2011-05-01', '10:00:00', 7), 
	('200000-2000', 'Communism', '2022-05-01', '09:00:00', 8), 
	('300000-3000', 'Nazism', '2016-07-01', '08:00:00', 9), 
	('400000-4000', 'Democracy', '2013-06-01', '07:00:00', 10), 
	('500000-5000', 'Insanity', '2013-06-01', '06:00:00', 3), 
	('600000-6000', 'Mink og sms', '2016-06-01', '05:00:00', 2), 
	('700000-7000', 'Tubercoluse', '2013-06-01', '04:00:00', 1), 
	('800000-8000', 'Mathmatics syndrome', '2013-06-01', '03:00:00', 4), 
	('900000-9000', 'Democracy og Fake news syndrome', '2018-06-01', '02:00:00', 5), 
	('905000-9050', 'Alzheimers og Ligma', '2019-05-01', '02:00:00', 6);
