Det her er en test

DROP TABLE Departments

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
Staff_ID VARCHAR(6) PRIMARY KEY,
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
Staff_ID VARCHAR(6) PRIMARY KEY,
Salary INT(6),
Department VARCHAR(20) references Departments(Department)
);



