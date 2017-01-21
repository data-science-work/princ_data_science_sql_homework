###########################################################################
## QUESTION 2: POPULATING YOUR DATABASE
###########################################################################

## insert data that does not need to be transformed into tables
LOAD DATA LOCAL INFILE '/Users/austinwhite/Documents/Lipscomb/Principles of Data Science/course.csv' 
INTO TABLE LIPSCOMB_Student_Registration.COURSE
fields terminated by ','
OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY '\r'
ignore 2 LINES 
(COURSE_ID,    COURSE_NO,    COURSE_NAME,    CREDITS)

LOAD DATA LOCAL INFILE '/Users/austinwhite/Documents/Lipscomb/Principles of Data Science/location.csv' 
INTO TABLE LIPSCOMB_Student_Registration.LOCATION
fields terminated by ','
OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY '\r'
ignore 2 LINES 
(LOC_ID,    BLDG_CODE,    ROOM,    CAPACITY)




LOAD DATA LOCAL INFILE '/Users/austinwhite/Documents/Lipscomb/Principles of Data Science/faculty.csv' 
INTO TABLE LIPSCOMB_Student_Registration.FACULTY
fields terminated by ','
OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY '\r'
ignore 2 LINES 
(F_ID, F_LAST, F_FIRST, F_MI, LOC_ID, F_PHONE, F_RANK, @F_SUPER, F_PIN)
SET F_SUPER = nullif(@F_SUPER,'')

ALTER TABLE LIPSCOMB_Student_Registration.FACULTY
ADD FOREIGN KEY (F_SUPER)
REFERENCES FACULTY(F_ID)

##insert cleaned data
-- INSERT INTO LIPSCOMB_Student_Registration.STUDENT
-- Select S_ID, S_LAST, S_FIRST, S_MI, S_ADDRESS, S_CITY, S_STATE, S_ZIP, S_PHONE, S_CLASS, 
-- STR_TO_DATE(S_DOB,'%m/%d/%Y') as S_DOB,
-- S_PIN, F_ID, 
-- STR_TO_DATE(DATE_ENROLLED,'%m/%d/%Y') as DATE_ENROLLED
-- from LIPSCOMB_Student_Registration.tmpSTUDENT

#DATE_ENROLLE-- 
LOAD DATA LOCAL INFILE '/Users/austinwhite/Documents/Lipscomb/Principles of Data Science/student.csv' 
INTO TABLE LIPSCOMB_Student_Registration.STUDENT
fields terminated by ','
OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY '\r'
ignore 2 LINES 
(S_ID, S_LAST, S_FIRST, S_MI, S_ADDRESS, S_CITY, S_STATE, S_ZIP, S_PHONE, S_CLASS, @S_DOB, S_PIN, F_ID, @DATE_ENROLLED)
SET S_DOB = STR_TO_DATE(@S_DOB,'%m/%d/%Y'),
DATE_ENROLLED = STR_TO_DATE(@DATE_ENROLLED,'%m/%d/%Y') 

LOAD DATA LOCAL INFILE '/Users/austinwhite/Documents/Lipscomb/Principles of Data Science/term.csv' 
INTO TABLE LIPSCOMB_Student_Registration.TERM
fields terminated by ','
OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY '\r'
ignore 2 LINES 
(TERM_ID, TERM_DESC, STATUS, @START_DATE)
SET START_DATE = STR_TO_DATE(@START_DATE,'%d-%b-%Y')

-- insert into LIPSCOMB_Student_Registration.TERM
-- select TERM_ID, TERM_DESC, STATUS, 
-- STR_TO_DATE(START_DATE,'%d-%b-%Y') as START_DATE
-- FROM LIPSCOMB_Student_Registration.tmpTERM

LOAD DATA LOCAL INFILE '/Users/austinwhite/Documents/Lipscomb/Principles of Data Science/course_section.csv' 
INTO TABLE LIPSCOMB_Student_Registration.COURSE_SECTION
fields terminated by ','
OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY '\r'
ignore 2 LINES 
(C_SEC_ID, COURSE_ID, TERM_ID, SEC_NUM, F_ID, MTG_DAYS, @START_TIME, @END_TIME, LOC_ID, MAX_ENRL)
SET START_TIME = TIME_FORMAT(
 cast(
CONCAT(CASE WHEN RIGHT(@START_TIME,2) = 'PM' THEN
HOUR(@START_TIME) + 12 ELSE HOUR(@START_TIME) END, ':',
MINUTE(@START_TIME))
 AS CHAR CHARACTER SET utf8)
, '%H:%i'),
END_TIME = TIME_FORMAT(
 cast(
CONCAT(CASE WHEN RIGHT(@END_TIME,2) = 'PM' THEN
HOUR(@END_TIME) + 12 ELSE HOUR(@END_TIME) END, ':',
MINUTE(@END_TIME))
 AS CHAR CHARACTER SET utf8)
, '%H:%i')

-- SELECT * FROM LIPSCOMB_Student_Registration.COURSE_SECTION 


LOAD DATA LOCAL INFILE '/Users/austinwhite/Documents/Lipscomb/Principles of Data Science/enrollment.csv' 
INTO TABLE LIPSCOMB_Student_Registration.ENROLLMENT
fields terminated by ','
OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY '\r'
ignore 2 LINES 
(S_ID, C_SEC_ID, @GRADE)
SET GRADE = nullif(@GRADE,'')



SELECT * FROM LIPSCOMB_Student_Registration.COURSE 
SELECT * FROM LIPSCOMB_Student_Registration.COURSE_SECTION
SELECT * FROM LIPSCOMB_Student_Registration.ENROLLMENT
SELECT * FROM LIPSCOMB_Student_Registration.FACULTY
SELECT * FROM LIPSCOMB_Student_Registration.LOCATION
SELECT * FROM LIPSCOMB_Student_Registration.STUDENT
SELECT * FROM LIPSCOMB_Student_Registration.TERM






#############################################################################################
## QUESTION 3: CHECKING YOUR DATABASE
#############################################################################################
INSERT into LIPSCOMB_Student_Registration.COURSE_SECTION 
(C_SEC_ID,COURSE_ID,TERM_ID,SEC_NUM,F_ID,MTG_DAYS,START_TIME,END_TIME,LOC_ID,MAX_ENRL)
VALUES (12,2,6,2,2,"MTWRF","10:00 AM","11:30 AM",5,35) 
## ERROR CODE:1062 DUPLICATE ENTRY '12' FOR KEY 'PRIMARY'

INSERT into LIPSCOMB_Student_Registration.COURSE_SECTION 
(C_SEC_ID,COURSE_ID,TERM_ID,SEC_NUM,F_ID,MTG_DAYS,START_TIME,END_TIME,LOC_ID,MAX_ENRL)
VALUES (12,2,6,2,2,"MTWRF","9:00 AM","10:30 AM",6,35) 
## ERROR CODE:1062 DUPLICATE ENTRY '12' FOR KEY 'PRIMARY'

INSERT into LIPSCOMB_Student_Registration.COURSE_SECTION 
(C_SEC_ID,COURSE_ID,TERM_ID,SEC_NUM,F_ID,MTG_DAYS,START_TIME,END_TIME,LOC_ID,MAX_ENRL)
VALUES (2,1,4,2,3,"TR","9:30 AM","10:45 AM",4,35) 
## ERROR CODE:1062 DUPLICATE ENTRY '2' FOR KEY 'PRIMARY'


INSERT into LIPSCOMB_Student_Registration.FACULTY 
(F_ID,F_LAST,F_FIRST,F_MI,LOC_ID,F_PHONE,F_RANK,F_SUPER,F_PIN)
VALUES (4,"Brown","Colin","D",11,"3253456789","Assistant",4,9871) 
## ERROR CODE:1062 DUPLICATE ENTRY '4' FOR KEY 'PRIMARY'

INSERT into LIPSCOMB_Student_Registration.FACULTY 
(F_ID,F_LAST,F_FIRST,F_MI,LOC_ID,F_PHONE,F_RANK,F_SUPER,F_PIN)
VALUES (6,"Reeves","Bob","S",15,"3256789012","Full",null,1234) 
## Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails (`lipscomb_student_registration`.`faculty`, CONSTRAINT `faculty_ibfk_1` FOREIGN KEY (`LOC_ID`) REFERENCES `LOCATION` (`LOC_ID`) ON UPDATE CASCADE)

INSERT into LIPSCOMB_Student_Registration.FACULTY 
(F_ID,F_LAST,F_FIRST,F_MI,LOC_ID,F_PHONE,F_RANK,F_SUPER,F_PIN)
VALUES (6,"Reeves","Bob","S",10,"3256789012","Assistant",7,1234) 
##Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails (`lipscomb_student_registration`.`faculty`, CONSTRAINT `faculty_ibfk_2` FOREIGN KEY (`F_SUPER`) REFERENCES `FACULTY` (`F_ID`))

INSERT into LIPSCOMB_Student_Registration.FACULTY 
(F_ID,F_LAST,F_FIRST,F_MI,LOC_ID,F_PHONE,F_RANK,F_SUPER,F_PIN)
VALUES (6,"Reeves","Bob","S",10,"3255678901","Assistant",2,1234) 
##possible should error for having more than one professor in location with capacity of 1

INSERT into LIPSCOMB_Student_Registration.COURSE 
(COURSE_ID,COURSE_NO,COURSE_NAME,CREDITS)
VALUES (4,"CS 120","Intro. to Programming in C++", 3)
##Error Code: 1062. Duplicate entry '4' for key 'PRIMARY'


delete from LIPSCOMB_Student_Registration.LOCATION 
where LOC_ID = 11
##Error Code: 1451. Cannot delete or update a parent row: a foreign key constraint fails (`lipscomb_student_registration`.`faculty`, CONSTRAINT `faculty_ibfk_1` FOREIGN KEY (`LOC_ID`) REFERENCES `LOCATION` (`LOC_ID`) ON UPDATE CASCADE)


delete from LIPSCOMB_Student_Registration.TERM 
where TERM_ID = 4
##Error Code: 1451. Cannot delete or update a parent row: a foreign key constraint fails (`lipscomb_student_registration`.`course_section`, CONSTRAINT `course_section_ibfk_2` FOREIGN KEY (`TERM_ID`) REFERENCES `TERM` (`TERM_ID`) ON UPDATE CASCADE)

##########################################################################################
## QUESTION 4: SIMPLE DATABASE QUERIES
##########################################################################################

Select DISTINCT S.S_ID, S_LAST, S_FIRST
from ENROLLMENT E
JOIN STUDENT S
    ON E.S_ID = S.S_ID
WHERE E.GRADE IN ("A","B")



SELECT * 
FROM TERM T
WHERE TERM_DESC LIKE '%2007'


SELECT BLDG_CODE, ROOM, CAPACITY
FROM LOCATION
ORDER BY BLDG_CODE, ROOM


SELECT COURSE_NO, COURSE_NAME, 
concat('$', format(CREDITS * 730, 2)) AS TUITION_CHARGE
FROM COURSE


SELECT A.C_SEC_ID, A.SUM_MAX_ENROLLMENTS, B.AVERAGE_CURRENT_ENROLLMENT, 
B.MAX_CURRENT_ENROLLMENT, B.MIN_CURRENT_ENROLLMENT
FROM 
(
SELECT E.C_SEC_ID, SUM(CS.MAX_ENRL) AS SUM_MAX_ENROLLMENTS
FROM ENROLLMENT E
LEFT JOIN COURSE_SECTION CS
    ON E.C_SEC_ID = CS.C_SEC_ID
GROUP BY C_SEC_ID) A,
(
SELECT avg(CURRENT_ENROLLMENT) AVERAGE_CURRENT_ENROLLMENT, 
MAX(CURRENT_ENROLLMENT) MAX_CURRENT_ENROLLMENT, MIN(CURRENT_ENROLLMENT) MIN_CURRENT_ENROLLMENT
FROM (
SELECT E.C_SEC_ID, COUNT(S_ID) AS CURRENT_ENROLLMENT
FROM ENROLLMENT E
LEFT JOIN COURSE_SECTION CS
    ON E.C_SEC_ID = CS.C_SEC_ID
LEFT JOIN COURSE C
    ON CS.COURSE_ID = C.COURSE_ID
LEFT JOIN TERM T
    ON CS.TERM_ID = T.TERM_ID
WHERE TERM_DESC = 'Summer 2008'
GROUP BY  E.C_SEC_ID
) A
    ) B


SELECT COUNT(DISTINCT C.COURSE_ID) COURSE_COUNT
FROM ENROLLMENT E
JOIN STUDENT S
    ON E.S_ID = S.S_ID
JOIN COURSE_SECTION CS
    ON E.C_SEC_ID = CS.C_SEC_ID
JOIN COURSE C
    ON CS.COURSE_ID = C.COURSE_ID
WHERE S_FIRST = 'LISA'
AND S_LAST = 'JOHNSON'
AND GRADE IS NOT NULL


SELECT BLDG_CODE, SUM(CAPACITY)
FROM LOCATION L
GROUP BY BLDG_CODE
HAVING SUM(CAPACITY) > 100

select S.S_ID, S.S_LAST, S.S_FIRST, S.F_ID, F.F_LAST
FROM STUDENT S
JOIN FACULTY F
    ON S.F_ID = F.F_ID


SELECT F.F_LAST
FROM COURSE_SECTION CS
JOIN FACULTY F
    ON CS.F_ID = F.F_ID
JOIN TERM T
    ON CS.TERM_ID = T.TERM_ID
WHERE TERM_DESC = 'Summer 2008'

SELECT COURSE_NAME, GRADE, S.S_ID
FROM ENROLLMENT E
JOIN STUDENT S
    ON E.S_ID = S.S_ID
JOIN COURSE_SECTION CS
    ON E.C_SEC_ID = CS.C_SEC_ID
JOIN COURSE C
    ON CS.COURSE_ID = C.COURSE_ID
WHERE S_FIRST = 'Tammy'
AND S_LAST = 'Jones'

SELECT S_LAST, S_FIRST, S_PHONE
FROM STUDENT S
UNION 
SELECT F_LAST, F_FIRST, F_PHONE
FROM FACULTY F

##################################################################################################################
## QUESTION 5:  SLIGHTLY COMPLEX DATABASE
##################################################################################################################
SELECT S_FIRST, S_LAST
FROM STUDENT S
WHERE S_CLASS = (
SELECT S_CLASS
FROM STUDENT S
WHERE S_FIRST = 'Jorge'
AND S_LAST = 'Perez'
)

SELECT DISTINCT  S_LAST, S_FIRST
FROM STUDENT S
JOIN ENROLLMENT E
    ON S.S_ID = E.S_ID
WHERE E.C_SEC_ID IN (
SELECT E.C_SEC_ID
FROM STUDENT S
JOIN ENROLLMENT E
    ON S.S_ID = E.S_ID
WHERE S_FIRST = 'Jorge'
AND S_LAST = 'Perez'
)

SELECT DISTINCT  S_LAST, S_FIRST
FROM STUDENT S
JOIN ENROLLMENT E
    ON S.S_ID = E.S_ID
WHERE E.C_SEC_ID IN (
SELECT E.C_SEC_ID
FROM STUDENT S
JOIN ENROLLMENT E
    ON S.S_ID = E.S_ID
WHERE S_FIRST = 'Jorge'
AND S_LAST = 'Perez'
)
AND S_CLASS = (
SELECT S_CLASS
FROM STUDENT S
WHERE S_FIRST = 'Jorge'
AND S_LAST = 'Perez'
)


    
  
SELECT S.S_FIRST, S.S_LAST
FROM STUDENT S
JOIN ENROLLMENT E
    ON S.S_ID = E.S_ID
JOIN COURSE_SECTION CS
    ON E.C_SEC_ID = CS.C_SEC_ID
WHERE CS.C_SEC_ID IN (
        SELECT CS.C_SEC_ID
        FROM STUDENT S
        JOIN ENROLLMENT E
            ON S.S_ID = E.S_ID
        JOIN COURSE_SECTION CS
            ON E.C_SEC_ID = CS.C_SEC_ID
        JOIN LOCATION L
            ON CS.LOC_ID = L.LOC_ID
        WHERE S.S_ID IN (
                SELECT S.S_ID
                FROM STUDENT S
                WHERE S.S_FIRST = 'Jorge'
                and s.S_LAST = 'Perez'
        )
        AND BLDG_CODE = 'CR'
)

SELECT  COURSE_NAME
FROM COURSE C
JOIN COURSE_SECTION CS
    ON C.COURSE_ID = CS.COURSE_ID
JOIN ENROLLMENT E
    ON CS.C_SEC_ID = E.C_SEC_ID
JOIN STUDENT S
    ON E.S_ID = S.S_ID
WHERE S_CLASS <> 'SR'
UNION
SELECT  COURSE_NAME
FROM COURSE C
JOIN COURSE_SECTION CS
    ON C.COURSE_ID = CS.COURSE_ID
JOIN ENROLLMENT E
    ON CS.C_SEC_ID = E.C_SEC_ID
JOIN STUDENT S
    ON E.S_ID = S.S_ID
WHERE TERM_ID = 6



SELECT DISTINCT   COURSE_NAME
FROM COURSE C
JOIN COURSE_SECTION CS
    ON C.COURSE_ID = CS.COURSE_ID
JOIN ENROLLMENT E
    ON CS.C_SEC_ID = E.C_SEC_ID
JOIN STUDENT S
    ON E.S_ID = S.S_ID
WHERE S_CLASS <> 'SR'
AND COURSE_NAME IN (
SELECT  COURSE_NAME
FROM COURSE C
JOIN COURSE_SECTION CS
    ON C.COURSE_ID = CS.COURSE_ID
JOIN ENROLLMENT E
    ON CS.C_SEC_ID = E.C_SEC_ID
JOIN STUDENT S
    ON E.S_ID = S.S_ID
WHERE TERM_ID = 6
)


SELECT DISTINCT   COURSE_NAME
FROM COURSE C
JOIN COURSE_SECTION CS
    ON C.COURSE_ID = CS.COURSE_ID
JOIN ENROLLMENT E
    ON CS.C_SEC_ID = E.C_SEC_ID
JOIN STUDENT S
    ON E.S_ID = S.S_ID
WHERE S_CLASS in ('FR','SO','JR')
AND COURSE_NAME not IN (
SELECT  COURSE_NAME
FROM COURSE C
JOIN COURSE_SECTION CS
    ON C.COURSE_ID = CS.COURSE_ID
JOIN ENROLLMENT E
    ON CS.C_SEC_ID = E.C_SEC_ID
JOIN STUDENT S
    ON E.S_ID = S.S_ID
WHERE TERM_ID = 6
)

SELECT F.F_FIRST, F.F_LAST, F1.F_FIRST, F1.F_LAST
FROM FACULTY F
JOIN FACULTY F1
    ON F.F_SUPER = F1.F_ID
    
    

############################################################################################################
## QUESTION 6: EXPERIMENTING WITH VIEWS
############################################################################################################
CREATE VIEW faculty_view as
SELECT F_ID, F_LAST, F_FIRST, F_MI, LOC_ID, F_PHONE, F_RANK, F_SUPER 
FROM FACULTY F

insert into faculty_view
(F_ID,F_LAST,F_FIRST,F_MI,LOC_ID,F_PHONE,F_RANK,F_SUPER)
values (6, "May", "Lisa", "I", 11, "3256789012", "Assistant", null)

select * 
from faculty_view

##updating a view updates the underlying tables, which has a primark key for f_id


SELECT F_FIRST, F_LAST, BLDG_CODE, ROOM
FROM faculty_view FV
JOIN LOCATION L
    ON FV.LOC_ID = L.LOC_ID
    

DROP VIEW faculty_view

#no change to the underlying data, just a virtual table is dropped

#############################################################################################################
## QUESTION 7: UPDATING THE DATABASE
#############################################################################################################
CREATE TEMPORARY TABLE tmpUPDATE (
C_SEC_ID INT);
INSERT INTO tmpUPDATE
SELECT C_SEC_ID
FROM COURSE_SECTION CS
JOIN FACULTY F
    ON CS.F_ID = CS.F_ID
WHERE F.F_LAST = 'BROWN'

UPDATE COURSE_SECTION 
SET LOC_ID = 8 #(SELECT DISTINCT LOC_ID FROM LOCATION WHERE BLDG_CODE = 'BUS' AND ROOM = 211)
WHERE C_SEC_ID IN (
SELECT C_SEC_ID FROM tmpUPDATE
);

CREATE TABLE enrollment_numbers (
COURSE_ID INT,
C_SEC_ID INT,
ENROLLMENTS INT);

INSERT INTO enrollment_numbers
SELECT COURSE_ID, CS.C_SEC_ID, COUNT(S_ID) AS ENROLLMENTS
FROM COURSE_SECTION CS
JOIN ENROLLMENT E
    ON CS.C_SEC_ID = E.C_SEC_ID
JOIN TERM T
    ON CS.TERM_ID = T.TERM_ID
WHERE T.TERM_DESC = 'SPRING 2008'
GROUP BY COURSE_ID, CS.C_SEC_ID

select * 
from enrollment_numbers




INSERT into LIPSCOMB_Student_Registration.FACULTY 
(F_ID,F_LAST,F_FIRST,F_MI,LOC_ID,F_PHONE,F_RANK,F_SUPER,F_PIN)
VALUES (4,"Brown","Colin","D",11,"3253456789","Assistant",4,9871) 