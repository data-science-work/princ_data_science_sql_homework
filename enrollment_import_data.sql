LOAD DATA LOCAL INFILE 'Users/gdiaz/Documents/OneDrive/Documents/lipscomb/spring2017/pinc_data_science/sql_homework/Enrollment.csv' 
INTO TABLE ENROLLMENT
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 2 LINES
(S_ID,C_SEC_ID,@GRADE)
SET GRADE = NULLIF(@GRADE,'');