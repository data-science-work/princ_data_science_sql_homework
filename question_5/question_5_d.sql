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