# UCSC Extension
# DBDA.X409.(10) MySQL and Oracle Database for Developers and Designers
# Assignment 2
# Cheng Fei
# 10/16/2022
# 
# A set of functions to process data in studentdb database.

# Change current database to studentdb.
USE studentdb;

# A SQL query to show the following columns by joining STUDENT, GRADE_EVENT, and SCORE tables.
# The output of the query displays the following columns with the format shown below group by student_id.
# STUDENT_ID | EVENT_ID | CATEGORY | SUM(SCORE) | AVG(SCORE) | MIN(SCORE) | MAX(SCORE)
SELECT s.student_id, s.event_id, g.category, SUM(s.score), AVG(s.score), MIN(s.score), MAX(s.score)
FROM score s, grade_event g
WHERE s.event_id = g.event_id
GROUP BY s.student_id, s.event_id;

# @_CREATE_FUNCTION_
# A database function that takes "student_id" as an input parameter,
# and return the name of the student for the given studentId.
DELIMITER $

DROP FUNCTION IF EXISTS student_name_by_id$

CREATE FUNCTION student_name_by_id(in_student_id INT)
RETURNS VARCHAR(100)
READS SQL DATA
BEGIN
	DECLARE out_student_name VARCHAR(100);
    BEGIN
		SELECT name INTO out_student_name
        FROM student
        WHERE student_id = in_student_id;
        
        RETURN out_student_name;
    END;
END$

DELIMITER ;

# @_CREATE_FUNCTION_
# A database function that takes category as an input parameter,
# and returns how many categories are present. 
DELIMITER $

DROP FUNCTION IF EXISTS event_count_by_category$

CREATE FUNCTION event_count_by_category(in_category VARCHAR(1))
RETURNS INT
READS SQL DATA
BEGIN
	DECLARE out_event_count INT;
    BEGIN
		SELECT COUNT(*) INTO out_event_count
        FROM grade_event
        WHERE category = in_category;
        RETURN out_event_count;
    END;
END$

DELIMITER ;

# @_CREATE_FUNCTION_
# A database function that takes event_id as an input parameter,
# and returns SUM of score for all students for this given eventId.
DELIMITER $

DROP FUNCTION IF EXISTS score_sum_by_event_id$

CREATE FUNCTION score_sum_by_event_id(in_event_id INT)
RETURNS INT
READS SQL DATA
BEGIN
	DECLARE out_score_sum INT;
    BEGIN 
		SELECT SUM(score) INTO out_score_sum
        FROM score
        WHERE event_id = in_event_id
        GROUP BY event_id;
        RETURN out_score_sum;
    END;
END $

DELIMITER ;

COMMIT;

