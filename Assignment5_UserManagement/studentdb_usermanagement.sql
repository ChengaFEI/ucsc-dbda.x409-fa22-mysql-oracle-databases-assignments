# UCSC Extension
# DBDA.X409.(10) MySQL and Oracle Database for Developers and Designers
# Assignment 5
# Cheng Fei
# 11/06/2022
# 
# Create a new proxy_user and only grant him the deletion access on student table.

# Change the current database to studentdb.
USE studentdb;

# Create a new user.
DROP USER IF EXISTS proxy_user;
CREATE USER proxy_user IDENTIFIED BY "proxy";

# Drop existing tables.
DROP TABLE IF EXISTS score_bak;
DROP TABLE IF EXISTS student_bak;

# Duplicate the student table.
CREATE TABLE student_bak AS
(SELECT * FROM student);

# Add PRIMARY KEY constraint to the student_id column in the student_bak table.
ALTER TABLE student_bak
MODIFY COLUMN student_id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY;

# Duplicate the score table.
CREATE TABLE score_bak AS
(SELECT * FROM score);

# Add FOREIGN KEY constraint to the score_bak.student_id referencing the student_bak.student_id.
ALTER TABLE score_bak
ADD CONSTRAINT FK_score_bak_student_id
FOREIGN KEY (student_id)
REFERENCES student_bak (student_id) 
ON DELETE CASCADE;

# Grant only deletion privilege to proxy_user on the student_bak table.
GRANT DELETE ON student_bak to proxy_user;


