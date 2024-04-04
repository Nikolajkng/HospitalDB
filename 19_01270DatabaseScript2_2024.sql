#########################################################################################################
# 1) the queries made (as in section 6)
# 2) the statements used to create and apply functions, procedures, and triggers (as in section 7), and
# 3) the delete/update statements used to change the tables (as in section 8).
#########################################################################################################
USE Hospital;

Delimiter //

CREATE FUNCTION numOfPatients (DoctorID int) RETURNS int
BEGIN 
	DECLARE vNumOfPatients int;
	SELECT COUNT(*) into vNumOfPatients from Patients
	WHERE Patients.AssignedDoctor = DoctorID;
	RETURN vNumOfPatients;
END; //

Delimiter ;

SELECT FullName, numOfPatients(DoctorID) FROM Doctors







SELECT * FROM Doctors


UPDATE Doctors SET Salary =
	CASE 
	WHEN Sex = "Male"
	THEN Salary * 1.05
	ELSE Salary * 1.03
	END WHERE HeadOfDept = 1; 







