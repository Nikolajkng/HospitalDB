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
Department  VARCHAR(40) PRIMARY KEY,
DeptFloor 	INT(3) UNIQUE,
Budget 		INT(10)
);

CREATE TABLE Doctors (
DoctorID 	SERIAL PRIMARY KEY,
FullName 	VARCHAR(90),
Sex			VARCHAR(6),
Salary 		INT(10),
Department 	VARCHAR(20) REFERENCES Departments(Department),
HeadOfDept 	BIT(1)
);

CREATE Table Patients (
CPR_no  		VARCHAR(11) PRIMARY KEY,
FullName		VARCHAR(90),
Age				INT(3),
Sex				VARCHAR(6),
Address			VARCHAR(60),
PhoneNumber		INT(10),
Email			VARCHAR(60),
Room			INT(3)
);


CREATE TABLE DoctorPatients (
DoctorID 	SERIAL references Doctors(DoctorID),
CPR_no 		VARCHAR(11) references Patients(CPR_no)
);


CREATE TABLE Nurses (
NurseID 	SERIAL PRIMARY KEY,
FullName 	VARCHAR(90),
Sex 		VARCHAR(6),
Salary		INT(10),
Department 	VARCHAR(20) REFERENCES Departments(Department)
);


CREATE TABLE PatientJournals (
CPR_no 				VARCHAR(11) references Patients(CPR_no),
Diagnosis 			VARCHAR(200),
DiagnosisDate 		DATE,
DiagnosisTime 		TIME,
DiagnosedBy		 	SERIAL references Doctors(DoctorID)
);


# Creation of Views (Only makes sense after populating tables in the next step below)
DROP VIEW IF EXISTS Doctors_In_HeartAndSkin;
DROP VIEW IF EXISTS Male_Doctors_Patients_With_FullNames;

CREATE VIEW Doctors_In_HeartAndSkin AS
SELECT DoctorID, FullName, Department FROM Doctors
WHERE Department IN ('Cardiology', 'Neurology');

Select * FROM Doctors_In_HeartAndSkin;

Select * From (DoctorPatients NATURAL JOIN Doctors NATURAL JOIN Patients)
group by DoctorID;

CREATE VIEW Male_Doctors_Patients_With_FullNames AS
SELECT Fullname as doctor, FullName as patient 
FROM (DoctorPatients NATURAL JOIN Doctors) NATURAL JOIN Patients
WHERE Doctors.Sex IN ('Male');

Select * FROM Male_Doctors_Patients_With_FullNames;



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
	('Christoffer Frost', 'Male', 80000*12, 'Cosmetic Surgery',1),
	('Tea Mortensen', 'Female', 85000*12, 'Neurology',1),
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
	('Bruce Banner','Male', 32000*12, 'Radiology');


INSERT INTO Patients values
	('260702-3671', 'Christian Vedel Pedersen', 22, 'Male', 'Nybrogaard kollegie 69a', 30220813, 's224810@student.dtu.dk', 5),
	('250701-4732', 'Katinka Spangtoft', 23, 'Female','P.O. Pedersen-kollegiet' ,61341289, 's224805@student.dtu.dk', 9),
	('240700-7418', 'Marilouise Arbøl', 24, 'Female', 'Kampsax kollegiet 521', 93990618,'s214401@student.dtu.dk', 10),
	('130301-3666', 'Michelle Mai', 23, 'Female', 'NoClue avenue 17', 52690290, 's224771@student.dtu.dk', 4),
	('300501-7451', 'Thor Skipper', 23, 'Male','Nybrogaard kollegie 69a', 51924474, 's224817@student.dtu.dk', 1),
	('010100-1818', 'Franken Stein', 106,'Male', 'Basement', 66666666, 'MaryShelley@darkmail.com', 3);
	
	
INSERT INTO DoctorPatients values
	(1, '260702-3671'),
	(2, '250701-4732'),
	(3, '240700-7418'),
	(4, '130301-3666'),
	(5, '300501-7451'),
	(6, '010100-1818');
	

INSERT INTO Patient_Journals values
	('260702-3671', 'Suffers from Bigusdikus', 2002-07-26 02:54:23, 'XXXFredXXX'),
	('250701-4732', 'Langelandssyndrom stadie 2', 2001-07-25 00:00:00, 'XXXPeterXXX'),
	('240700-7418', 'Kaps (lethal)', 2022-09-02 08:00:00, 'XXXtobiXXX'),
	('130301-3666', 'UX fanatic', 2023-06-06, 'XXXNikoXXX'),
	('300501-7451', 'Suffers from succes', 2022-09-02 08:00:00, 'XXXChristfofferXXX')
