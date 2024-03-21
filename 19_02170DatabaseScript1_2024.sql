###########################################################################################################
# 1) the statements used to create the database, its tables and views (as used in section 4 of the report)
###########################################################################################################

# Creation of database:
DROP DATABASE IF EXISTS Hospital;
CREATE DATABASE Hospital;
USE Hospital;

# Creation of the database tables:
DROP TABLE IF EXISTS PatientJournals;
DROP TABLE IF EXISTS DoctorPatients;
DROP TABLE IF EXISTS Doctors;
DROP TABLE IF EXISTS Patients;
DROP TABLE IF EXISTS Nurses;
DROP TABLE IF EXISTS Departments;


CREATE TABLE Departments (
Department  VARCHAR(20) PRIMARY KEY,
DeptFloor 	INT(3) UNIQUE,
Budget 		INT(10)
);

CREATE TABLE Doctors (
DoctorID SERIAL PRIMARY KEY,
Name 		VARCHAR(30),
Sex			VARCHAR(6),
Salary 		INT(9),
Department 	VARCHAR(20) REFERENCES Departments(Department),
HeadOfDept 	BIT(1)
);

CREATE Table Patients (
CPR_no  		VARCHAR(11) PRIMARY KEY,
FullName		VARCHAR(60),
Age				INT(3),
Sex				VARCHAR(6),
Address			VARCHAR(60),
PhoneNumber		INT(10),
Email			VARCHAR(20),
Room			INT(3)
);


CREATE TABLE DoctorPatients (
DoctorID 	SERIAL references Doctors(DoctorID),
CPR_no 		VARCHAR(11) references Patients(CPR_no)
);


CREATE TABLE Nurses (
NurseID 	SERIAL PRIMARY KEY,
Name 		VARCHAR(30),
Sex 		VARCHAR(6),
Salary		INT(6),
Department 	VARCHAR(20) references Departments(Department)
);


CREATE TABLE PatientJournals (
CPR_no 				VARCHAR(11) references Patients(CPR_no),
Diagnosis 			VARCHAR(200),
DiagnosisDate 		DATE,
DiagnosisTime 		TIME,
DiagnosedBy		 	SERIAL references Doctors(DoctorID)
);


# Creation of Views
DROP VIEW IF EXISTS Doctors_In_HeartAndSkin;
CREATE VIEW Doctors_In_HeartAndSkin AS
SELECT DoctorID, Name, Department FROM Doctors
WHERE Department IN ('Heart', 'Skin');

Select * FROM Doctors_In_HeartAndSkin;


DROP VIEW IF EXISTS Patients_with_STD;
CREATE VIEW Patients_with_STD AS
SELECT CPR_no, Fullname, Diagnosis FROM (Patients NATURAL JOIN PatientJournals) 
WHERE Diagnosis IN ('Clamydia');

Select * FROM Patients_with_STD;



######################################################################
# 2) the statements used to populate the tables (as used in section 5)
######################################################################
INSERT Departments VALUES (
	'Cardiology', 7),
	('Sexual Health', 6),
	('Fertility', -5),
	('Dermatology', 1),
	('Breast Screening', 18
);

INSERT Doctors Values 
	('Tobias Martinsen', 694202, 'Sexual Health', 1),
	('Peter Stensig', 6789096, 'Cardiology'),
	('Frederik Udby', 324364, 'Fertility'),
	('Nikolaj Nguyen', 623483, 'Dermatology'),
	('Christoffer Frost', 80085, 'Breast Screening');

INSERT Nurses values
	('Kasper Friis', 10000, 'Fertility'),
	('Margot Robbie', 999999, 'Cardiology'),
	('Sydney Sweeney', 999998, 'Dermatology'),
	('Danny DeVito', 420420, 'Sexual Health'),
	('Christoffers mor', 10500, 'Breast Screening');

INSERT Patients values
	('260702-3671', 'Christian Vedel Pedersen', 'Nybrogaard kollegie 69a', 30220813, 's224810@student.dtu.dk', 5),
	('250701-4732', 'Katinka Spangtoft', '', 61341289, 's224805@student.dtu.dk', 9),
	('240700-7418', 'Marilouise Arbøl', 'Kampsax kollegiet 521', 93990618,'s214401@student.dtu.dk', 10),
	('130301-3666', 'Michelle Mai', 'NoClue avenue 17', 52690290, 's224771@student.dtu.dk', 4),
	('300501-7451', 'Thor Skipper', 'Nybrogaard kollegie 69a', 51924474, 's224817@student.dtu.dk', 1)
	
INSERT DoctorPatients values
	('XXXXX', '260702-3671'),
	('XXXXX', '250701-4732'),
	('XXXXX', '240700-7418'),
	('XXXXX', '130301-3666'),
	('XXXXX', '300501-7451')

INSERT Patient_Journals values
	('260702-3671', 'Suffers from Bigusdikus', 2002-07-26 02:54:23, 'XXXFredXXX'),
	('250701-4732', 'Langelandssyndrom stadie 2', 2001-07-25 00:00:00, 'XXXPeterXXX'),
	('240700-7418', 'Kaps (lethal)', 2022-09-02 08:00:00, 'XXXtobiXXX'),
	('130301-3666', 'UX fanatic', 2023-06-06, 'XXXNikoXXX'),
	('300501-7451', 'Suffers from succes', 2022-09-02 08:00:00, 'XXXChristfofferXXX')
