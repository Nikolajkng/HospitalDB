###########################################################################################################
# 1) the statements used to create the database, its tables and views (as used in section 4 of the report)
# 2) the statements used to populate the tables (as used in section 5
###########################################################################################################

CREATE Table Patients (
CPR_no  VARCHAR(11) Primary Key,
Full_name			 VARCHAR(30),
Address				VARCHAR(30),
Phone_number		INT(8),
Email				VARCHAR(20),
Room				INT(3)
);

CREATE TABLE Departments (
Department  VARCHAR(20)PRIMARY KEY,
Dept_floor INT(2)
);

CREATE TABLE Doctors (
DoctorID INT(6) PRIMARY KEY,
Name varchar(30),
Salary INT(9),
Department VARCHAR(20) REFERENCES Departments(Department),
Head_of_department BIT(1)
);

CREATE TABLE Patient_Journals (
CPR_no 	VARCHAR(11) references Patients(CPR_no),
Diagnosis	VARCHAR(200),
DateTime_for_diagnosis	DATETIME,
Doctor_in_charge_of_diagnosis VARCHAR(6) references Doctors(Staff_ID)
);

CREATE TABLE DoctorPatients (
Staff_ID VARCHAR(6) references Doctors(Staff_ID),
CPR_no VARCHAR(11) references Patients(CPR_no)
);

CREATE TABLE Nurses (
NurseID VARCHAR(6) PRIMARY KEY,
Name varchar(30),
Salary INT(6),
Department VARCHAR(20) references Departments(Department)
);

# Filler info
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
