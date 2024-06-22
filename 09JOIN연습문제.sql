--1
SELECT * FROM DEPARTMENTS D INNER JOIN EMPLOYEES E ON d.department_id= e.department_id;
SELECT * FROM DEPARTMENTS D LEFT JOIN EMPLOYEES E ON d.department_id= e.department_id;
SELECT * FROM DEPARTMENTS D RIGHT JOIN EMPLOYEES E ON d.department_id= e.department_id;

--2
SELECT E.FIRST_NAME||E.LAST_NAME,E.DEPARTMENT_ID
FROM DEPARTMENTS D
INNER JOIN EMPLOYEES E
ON d.department_id = e.department_id
WHERE E.EMPLOYEE_ID =200;
--3
SELECT E.FIRST_NAME, E.JOB_ID,J.JOB_TITLE
FROM JOBS J
INNER JOIN EMPLOYEES E
ON j.job_id = e.job_id
ORDER BY E.FIRST_NAME;
--4
SELECT * FROM job_history;
SELECT * FROM JOBS;
SELECT * FROM departments;
SELECT *
FROM JOBS J
LEFT OUTER JOIN job_history JH ON jh.job_id = j.job_id;
--5
SELECT DEPARTMENT_NAME
FROM DEPARTMENTS D
JOIN EMPLOYEES E ON d.department_id = e.department_id
WHERE FIRST_NAME='Steven' AND LAST_NAME='King';
--6
SELECT * FROM EMPLOYEES CROSS JOIN DEPARTMENTS;
SELECT * FROM EMPLOYEES;
--7
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.SALARY, D.DEPARTMENT_NAME, l.street_address
FROM EMPLOYEES E
LEFT JOIN DEPARTMENTS D  ON E.department_id = D.department_id
LEFT JOIN locations L ON d.location_id = l.location_id
WHERE E.JOB_ID = 'SA_MAN';

--8
SELECT *
FROM EMPLOYEES E
JOIN JOBS J ON e.job_id = j.job_id
WHERE JOB_TITLE = 'Stock Manager' OR JOB_TITLE = 'Stock Clerk';

--9
SELECT * 
FROM DEPARTMENTS
LEFT OUTER JOIN EMPLOYEES ON employees.department_id = departments.department_id
WHERE EMPLOYEE_ID IS NULL;
--10
SELECT E.FIRST_NAME ||' -> '|| E2.FIRST_NAME
FROM EMPLOYEES E
LEFT JOIN EMPLOYEES E2 ON e.manager_id = e2.employee_id;
--11
SELECT * FROM EMPLOYEES;
SELECT  E.FIRST_NAME AS 사원, E2.FIRST_NAME AS 관리자이름 ,E2.SALARY AS 매니저월급
FROM EMPLOYEES E
LEFT JOIN EMPLOYEES E2 ON e.manager_id = e2.employee_id
WHERE e.manager_id IS NOT NULL
ORDER BY E2.SALARY DESC;
--12
SELECT E3.FIRST_NAME||' > '||E2.FIRST_NAME||' > '||E.FIRST_NAME AS 계급
FROM EMPLOYEES E
LEFT JOIN EMPLOYEES E2 ON E.MANAGER_ID = E2.EMPLOYEE_ID
LEFT JOIN EMPLOYEES E3 ON E2.MANAGER_ID = E3.EMPLOYEE_ID
WHERE E.FIRST_NAME = 'William' AND E.LAST_NAME = 'Smith';






