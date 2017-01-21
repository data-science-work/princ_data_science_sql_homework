LOAD DATA LOCAL INFILE 'Users/gdiaz/Documents/OneDrive/Documents/lipscomb/spring2017/pinc_data_science/sql_homework/course.csv' INTO TABLE lipscomb.course
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 2 LINES
(COURSE_ID,COURSE_NO,COURSE_NAME,CREDITS)