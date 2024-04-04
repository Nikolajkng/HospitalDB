#########################################################################################################
# 1) the queries made (as in section 6)
# 2) the statements used to create and apply functions, procedures, and triggers (as in section 7), and
# 3) the delete/update statements used to change the tables (as in section 8).
#########################################################################################################
USE Hospital;

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


UPDATE Doctors SET Salary =
	CASE 
	WHEN Sex = "Male"
	THEN Salary * 1.05
	ELSE Salary * 1.03
	END WHERE HeadOfDept = 1; 


#########################################################################################################
# 1) the queries made (as in section 6)
#########################################################################################################
# Give 3 examples of typical SQL query statements using joins, group by, and
# set operations like UNION and IN. For each query explain informally what
# it asks about. Show also the output of the queries for the database
# instance established in step 5





