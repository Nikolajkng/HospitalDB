#########################################################################################################
# 1) the queries made (as in section 6)
# 2) the statements used to create and apply functions, procedures, and triggers (as in section 7), and
# 3) the delete/update statements used to change the tables (as in section 8).
#########################################################################################################

# Niko

DROP TRIGGER NurseID_Before_Insert;
CREATE TRIGGER NurseID_Before_Insert 
BEFORE INSERT ON Nurses FOR EACH ROW
BEGIN 
	SET NurseID = CONCAT('N',NEW.NurseID);
END;

DROP TRIGGER TimeSlot_Before_Insert;
CREATE TRIGGER TimeSlot_Before_Insert 
	BEFORE INSERT ON TimeSlot FOR EACH ROW
	BEGIN 
		IF (NEW.StartTime > NEW.EndTime) then signal sqlstate 'HY000'
			set mysql_errno = 1525, message_text = 'TRIGGER: StartTime cannot be after EndTime'; 
		END IF;
	END

INSERT INTO TimeSlot VALUES ('E', 'W', '13:00', '8:00');







