SELECT * FROM INFO;
SELECT * FROM AUTH;

-- INNER JOIN
SELECT * 
FROM INFO /*INNER*/ JOIN AUTH
ON info.auth_id = auth.auth_id;

SELECT INFO.ID,
       INFO.TITLE,
       INFO.CONTENTS,
       INFO.AUTH_ID, -- AUTH_ID는 양측에 다있는 키라서, 테이블.컬럼 기입해줘
       AUTH.NAME
FROM INFO 
INNER JOIN AUTH
ON info.auth_id = auth.auth_id;

--테이블이 ALIAS
SELECT i.id,
       I.TITLE,
       A.AUTH_ID,
       A.JOB,
       A.NAME
FROM INFO I --테이블 엘리어스
INNER JOIN AUTH A
ON i.auth_id = a.auth_id;
--연결할 키가 같다면 USING구문을 사용할 수 있음
SELECT *
FROM INFO I
INNER JOIN AUTH A
USING(AUTH_ID);
---------------------------------------------
--OUTER JOIN
--LEFT OUTER JOIN (OUTER생략가능) - 왼쪽테이블이 기준이 되서, 왼쪽테이블 다나옴
SELECT * FROM INFO I LEFT JOIN AUTH A ON i.auth_id= a.auth_id;

--RIGHT OUTER JOIN - 오른쪽테이블이 기주이 되서, 오른쪽테이블이 다나옴.
SELECT * FROM INFO I RIGHT JOIN AUTH A ON I.AUTH_ID = A.AUTH_ID;

--RIGHT조인의 테이블 자리만 바꿔주면 LEFT JOIN
SELECT * FROM AUTH A RIGHT JOIN INFO I ON a.auth_id=i.auth_id;

--FULL OUTER JOIN - 양쪽데이터 누락없이 다 나옴.
SELECT * FROM INFO I FULL JOIN AUTH A ON i.auth_id=a.auth_id;

--CROSS JOIN (잘못된 조인의 형태 - 실제로 쓸일은 없음)
SELECT * FROM INFO I CROSS JOIN AUTH A;

---------------------------------------------------------------------
--SELF JOIN (하나의 테이블을 가지고 조인을 거는것) - 조건 테이블안에 연결가능한 키가 필요함
SELECT * FROM EMPLOYEES;
SELECT * 
FROM EMPLOYEES E
LEFT JOIN EMPLOYEES E2
ON e.manager_id = e2.employee_id;

-------------------------------------------------------------------
-- 오라클 조인 - 오라클에서만 사용할 수 있고, 조인할 테이블을 FROM절에 씀
-- 조인 조건을 WHERE절에 쓴다

-- 오라클 INNER JOIN
SELECT *
FROM INFO I, AUTH A
WHERE I.AUTH_ID = A.AUTH_ID;

-- 오라클 LEFT JOIN
SELECT *
FROM INFO I, AUTH A
WHERE i.auth_id = a.auth_id(+); --붙일 테이블에 +
-- 오라클 RIGHT JOIN
SELECT *
FROM INFO I, AUTH A
WHERE i.auth_id(+) = a.auth_id; --붙일 테이블에 +
-- 오라클 FULL OUTER JOIN은 없음

--크로스조인은 잘못된 조인(조인 조건을 안적었을 때 나타남)
SELECT *
FROM INFO I , AUTH A;









SELECT * FROM EMPLOYEES;
SELECT * FROM DEPARTMENTS;
SELECT * FROM LOCATIONS;
SELECT * FROM EMPLOYEES E /*LEFT*/ JOIN DEPARTMENTS D ON E.DEPARTMENT_ID=d.department_id;
--조인은 여러번 할 수도 있음
SELECT E.EMPLOYEE_ID,
       E.FIRST_NAME,
       d.department_id,
       l.city

FROM EMPLOYEES E LEFT JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = d.department_id 
LEFT JOIN LOCATIONS L ON d.location_id = l.location_id
WHERE EMPLOYEE_ID>=150;

--평범하게 생각하면 N테이블에 1테이블을 가장 많다.
SELECT * FROM DEPARTMENTS D LEFT JOIN EMPLOYEES E ON d.department_id= E.DEPARTMENT_ID;












