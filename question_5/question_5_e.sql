SELECT COURSE_NAME
FROM COURSE C
JOIN COURSE_SECTION CS
    ON C.COURSE_ID = CS.COURSE_ID
JOIN ENROLLMENT E
    ON CS.C_SEC_ID = E.C_SEC_ID
JOIN STUDENT S
    ON E.S_ID = S.S_ID
WHERE S_CLASS <> 'SR'
UNION
SELECT COURSE_NAME
FROM COURSE C
JOIN COURSE_SECTION CS
    ON C.COURSE_ID = CS.COURSE_ID
JOIN ENROLLMENT E
    ON CS.C_SEC_ID = E.C_SEC_ID
JOIN STUDENT S
    ON E.S_ID = S.S_ID
WHERE TERM_ID = 6