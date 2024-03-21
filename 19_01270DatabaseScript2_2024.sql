#########################################################################################################
# 1) the queries made (as in section 6)
# 2) the statements used to create and apply functions, procedures, and triggers (as in section 7), and
# 3) the delete/update statements used to change the tables (as in section 8).
#########################################################################################################

# Niko

CREATE TRIGGER NurseID_Before_Insert
BEFORE INSERT ON Nurses FOR EACH ROW
BEGIN 
	SELECT ID as CONCAT('N','Test');
	SET NEW.Staff_ID = NEW.ID;
END;







