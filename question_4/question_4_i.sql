SELECT F.F_LAST
FROM COURSE_SECTION CS
JOIN FACULTY F
    ON CS.F_ID = F.F_ID
JOIN TERM T
    ON CS.TERM_ID = T.TERM_ID
WHERE TERM_DESC = 'Summer 2008'