USE Hospital;


#########################################################################################################
# 1) the queries made (as in section 6).
# Give three examples of typical SQL query statements using joins, group by,
# and set operations like UNION and IN. For each query explain informally
# what it asks about. Show also the output of the queries.
#########################################################################################################

# Query using: JOIN & GROUP BY
SELECT Patients.FullName , Doctors.FullName AS AssignedDoctor, Doctors.Department 
FROM Patients Join Doctors
WHERE Patients.AssignedDoctor = Doctors.DoctorID
GROUP BY Patients.FullName;


# Query using set operation: UNION
(SELECT Fullname, CPR_no, Diagnosis FROM PatientJournals NATURAL JOIN Patients WHERE STRCMP(Diagnosis, 'Communism') = 0) #Exact equal
UNION
(SELECT Fullname, CPR_no, Diagnosis FROM PatientJournals NATURAL JOIN Patients WHERE Diagnosis LIKE '%Alzheimers%'); #Contains


# Query using set operation: IN
SELECT DISTINCT Diagnosis FROM PatientJournals
WHERE DiagnosedBy = 4 AND Diagnosis
IN (SELECT Diagnosis FROM PatientJournals 
	WHERE DiagnosisTime = '08:00:00');


#########################################################################################################
# 2) the statements used to create and apply functions, procedures, and triggers (as in section 7)
#########################################################################################################

# Function
DROP FUNCTION IF EXISTS numOfPatients;

DELIMITER //

CREATE FUNCTION numOfPatients (DoctorID int) RETURNS int
BEGIN 
	DECLARE vNumOfPatients int;
	SELECT COUNT(*) INTO vNumOfPatients FROM Patients
	WHERE Patients.AssignedDoctor = DoctorID;
	RETURN vNumOfPatients;
END //

DELIMITER ;

SELECT FullName, numOfPatients(DoctorID) FROM Doctors;


# Procedure
DROP PROCEDURE IF EXISTS doctorsSalaryInDepartment;

DELIMITER //

CREATE PROCEDURE doctorsSalaryInDepartment (IN Department  VARCHAR(40), OUT salarySum INT)
BEGIN
	SELECT SUM(Doctors.Salary) INTO salarySum FROM Doctors WHERE Doctors.Department = Department ;
END //

DELIMITER ;

CALL doctorsSalaryInDepartment('Cardiology', @sumOfSalareis);
SELECT @sumOfSalareis;


# Trigger
DELIMITER //

CREATE TRIGGER toHighSalary
BEFORE INSERT ON Nurses FOR EACH ROW 
BEGIN 
	IF NEW.Salary > 45000*12 THEN SET NEW.Salary = 39000*12;
	END IF;
END//

DELIMITER ;

INSERT INTO Nurses(FullName, Sex,Salary, Department) VALUES
	('Tes Tnurse', 'Male', 550000, 'Cardiology');
	
SELECT * FROM Nurses ORDER BY salary;


########################################################################################################
# 3) the delete/update statements used to change the tables (as in section 8).
########################################################################################################

UPDATE Doctors SET Salary =
	CASE 
	WHEN Sex = "Male"
	THEN Salary * 1.05
	ELSE Salary * 1.03
	END WHERE HeadOfDept = 1; 


UPDATE Nurses SET Department = 
	(SELECT Department FROM Number_of_Nurses_Per_Department 
	WHERE numOfNurses = (SELECT MIN(numOfNurses) FROM Number_of_Nurses_Per_Department) LIMIT 1) 
	WHERE (Nurses.Department IS NULL);


DELETE FROM Nurses WHERE Department = "Cardiology" AND Salary > 490000;


DELETE FROM Departments WHERE Department = "Pathology";
 













