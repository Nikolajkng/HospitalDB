#########################################################################################################
# 1) the queries made (as in section 6)
# 2) the statements used to create and apply functions, procedures, and triggers (as in section 7), and
# 3) the delete/update statements used to change the tables (as in section 8).
#########################################################################################################

# Niko (ikke færdig)

DROP TRIGGER NurseID_Before_Insert;
CREATE TRIGGER NurseID_Before_Insert 
BEFORE INSERT ON Nurses FOR EACH ROW
BEGIN 
	SET NurseID = CONCAT('N',NEW.NurseID);
END;








