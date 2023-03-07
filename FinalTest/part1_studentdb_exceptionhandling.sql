# UCSC Extension
# DBDA.X409.(10) MySQL and Oracle Database for Developers and Designers
# 
# Final Test
# Part 1
# Exception Handling
# 
# Cheng Fei
# 11/17/2022
# 
# Handle two types of exceptions: duplicate ids and duplicate columns.

# Change the current database to studentdb.
USE studentdb;

# @_CREATE_PROCEDURE_
# Handle duplicate id and duplicate column exceptions. 
DELIMITER $
# Drop the existing procedure.
DROP PROCEDURE IF EXISTS exception_handle$
CREATE PROCEDURE exception_handle(IN in_student_id INT, 
								  OUT out_msg_1 VARCHAR(200),
                                  OUT out_msg_2 VARCHAR(200))
BEGIN
	# Declare exception flags.
	DECLARE duplicate_id INT DEFAULT 0;
    DECLARE duplicate_column_specified INT DEFAULT 0;
	BEGIN
		# Declare exception handler.
        DECLARE CONTINUE HANDLER FOR 1062 SET duplicate_id = 1;
        DECLARE CONTINUE HANDLER FOR 1110 SET duplicate_column_specified = 1;
        # Search the student id.
        SELECT * FROM student WHERE student_id = in_student_id;
        # Test the duplicate id exception handler.
        INSERT INTO student (student_id, name, gender) VALUES (in_student_id, 'Test', 'M');
        # Test the duplicate column exception handler.
        INSERT INTO student (student_id, name, name, gender) 
        VALUES (in_student_id, 'Test', 'Test', 'M');
    END;
    IF duplicate_id = 1 THEN
		SET out_msg_1 = concat('You are trying to insert student_id ', 
							 in_student_id, 
							 ', which is already present in the table.');
    END IF;
    IF duplicate_column_specified = 1 THEN
		SET out_msg_2 = concat('You are trying to enter values into columns twice.');
    END IF;
END$
DELIMITER ;

# Commit changes.
COMMIT;