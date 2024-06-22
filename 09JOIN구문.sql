SELECT * FROM INFO;
SELECT * FROM AUTH;

-- INNER JOIN
SELECT * 
FROM INFO /*INNER*/ JOIN AUTH
ON info.auth_id = auth.auth_id;

SELECT INFO.ID,
       INFO.TITLE,
       INFO.CONTENTS,
       INFO.AUTH_ID, -- AUTH_ID�� ������ ���ִ� Ű��, ���̺�.�÷� ��������
       AUTH.NAME
FROM INFO 
INNER JOIN AUTH
ON info.auth_id = auth.auth_id;

--���̺��� ALIAS
SELECT i.id,
       I.TITLE,
       A.AUTH_ID,
       A.JOB,
       A.NAME
FROM INFO I --���̺� �����
INNER JOIN AUTH A
ON i.auth_id = a.auth_id;
--������ Ű�� ���ٸ� USING������ ����� �� ����
SELECT *
FROM INFO I
INNER JOIN AUTH A
USING(AUTH_ID);
---------------------------------------------
--OUTER JOIN
--LEFT OUTER JOIN (OUTER��������) - �������̺��� ������ �Ǽ�, �������̺� �ٳ���
SELECT * FROM INFO I LEFT JOIN AUTH A ON i.auth_id= a.auth_id;

--RIGHT OUTER JOIN - ���������̺��� ������ �Ǽ�, ���������̺��� �ٳ���.
SELECT * FROM INFO I RIGHT JOIN AUTH A ON I.AUTH_ID = A.AUTH_ID;

--RIGHT������ ���̺� �ڸ��� �ٲ��ָ� LEFT JOIN
SELECT * FROM AUTH A RIGHT JOIN INFO I ON a.auth_id=i.auth_id;

--FULL OUTER JOIN - ���ʵ����� �������� �� ����.
SELECT * FROM INFO I FULL JOIN AUTH A ON i.auth_id=a.auth_id;

--CROSS JOIN (�߸��� ������ ���� - ������ ������ ����)
SELECT * FROM INFO I CROSS JOIN AUTH A;

---------------------------------------------------------------------
--SELF JOIN (�ϳ��� ���̺��� ������ ������ �Ŵ°�) - ���� ���̺�ȿ� ���ᰡ���� Ű�� �ʿ���
SELECT * FROM EMPLOYEES;
SELECT * 
FROM EMPLOYEES E
LEFT JOIN EMPLOYEES E2
ON e.manager_id = e2.employee_id;

-------------------------------------------------------------------
-- ����Ŭ ���� - ����Ŭ������ ����� �� �ְ�, ������ ���̺��� FROM���� ��
-- ���� ������ WHERE���� ����

-- ����Ŭ INNER JOIN
SELECT *
FROM INFO I, AUTH A
WHERE I.AUTH_ID = A.AUTH_ID;

-- ����Ŭ LEFT JOIN
SELECT *
FROM INFO I, AUTH A
WHERE i.auth_id = a.auth_id(+); --���� ���̺� +
-- ����Ŭ RIGHT JOIN
SELECT *
FROM INFO I, AUTH A
WHERE i.auth_id(+) = a.auth_id; --���� ���̺� +
-- ����Ŭ FULL OUTER JOIN�� ����

--ũ�ν������� �߸��� ����(���� ������ �������� �� ��Ÿ��)
SELECT *
FROM INFO I , AUTH A;









SELECT * FROM EMPLOYEES;
SELECT * FROM DEPARTMENTS;
SELECT * FROM LOCATIONS;
SELECT * FROM EMPLOYEES E /*LEFT*/ JOIN DEPARTMENTS D ON E.DEPARTMENT_ID=d.department_id;
--������ ������ �� ���� ����
SELECT E.EMPLOYEE_ID,
       E.FIRST_NAME,
       d.department_id,
       l.city

FROM EMPLOYEES E LEFT JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = d.department_id 
LEFT JOIN LOCATIONS L ON d.location_id = l.location_id
WHERE EMPLOYEE_ID>=150;

--����ϰ� �����ϸ� N���̺� 1���̺��� ���� ����.
SELECT * FROM DEPARTMENTS D LEFT JOIN EMPLOYEES E ON d.department_id= E.DEPARTMENT_ID;












