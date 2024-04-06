USE Hospital;


#########################################################################################################
# 1) the queries made (as in section 6).
# Give three examples of typical SQL query statements using joins, group by,
# and set operations like UNION and IN. For each query explain informally
# what it asks about. Show also the output of the queries.
#########################################################################################################

# Query using: JOIN & GROUP BY
SELECT Patients.FullName , Doctors.FullName as AssignedDoctor, Doctors.Department 
FROM Patients Join Doctors
WHERE Patients.AssignedDoctor = Doctors.DoctorID
Group By Patients.FullName;


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
DROP Function IF EXISTS numOfPatients;

Delimiter //

CREATE FUNCTION numOfPatients (DoctorID int) RETURNS int
BEGIN 
	DECLARE vNumOfPatients int;
	SELECT COUNT(*) into vNumOfPatients from Patients
	WHERE Patients.AssignedDoctor = DoctorID;
	RETURN vNumOfPatients;
END; //

Delimiter ;

SELECT FullName, numOfPatients(DoctorID) FROM Doctors;

DROP PROCEDURE IF EXISTS doctorsSalaryInDepartment;

delimiter //

create procedure doctorsSalaryInDepartment (IN Department  VARCHAR(40), OUT salarySum int)
begin
	SELECT SUM(Doctors.Salary) into salarySum FROM Doctors WHERE Doctors.Department = Department ;
end //

delimiter ;

CALL doctorsSalaryInDepartment('Cardiology', @sumOfSalareis);
SELECT @sumOfSalareis;



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
	WHERE numOfNurses = (SELECT MIN(numOfNurses) from Number_of_Nurses_Per_Department) LIMIT 1) 
	WHERE (Nurses.Department IS NULL)


DELETE FROM Nurses WHERE Department = "Cardiology" AND Salary > 490000


DELETE FROM Departments WHERE Department = "Pathology"
 













