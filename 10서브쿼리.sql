--�������� (SELECT �������� Ư����ġ�� �ٽ� SELECT �� ���� ����)
--������ �������� - ���������� ����� 1���� ��������

--���ú��� �޿��� �������
--1. ������ �޿��� ã�´�
--2. ã���޿��� WHERE���� �ִ´�

SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'Nancy';

SELECT * FROM EMPLOYEES WHERE SALARY >= (SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'Nancy');

--103���� ������ �������
SELECT * FROM EMPLOYEES WHERE EMPLOYEE_ID = 103;
SELECT * FROM EMPLOYEES WHERE JOB_ID = (SELECT JOB_ID FROM EMPLOYEES WHERE EMPLOYEE_ID = 103);

--�������� - ���� �÷��� ��Ȯ�� �Ѱ�������
SELECT *
FROM EMPLOYEES
WHERE JOB_ID=(SELECT * FROM EMPLOYEES WHERE EMPLOYEE_ID = 103);

--�������� - �������� ������ �����̶��, ������ �������� �����ڸ� ������մϴ�.
SELECT SALARY
FROM EMPLOYEES
WHERE FIRST_NAME = 'Steven';
SELECT *
FROM EMPLOYEES
WHERE SALARY >= (SELECT SALARY
FROM EMPLOYEES
WHERE FIRST_NAME = 'Steven');

--------------------------------------------------------------------
--������ �������� - ���������� ����� ������ ���ϵǴ� ��� IN, AND, ALL
SELECT SALARY
FROM EMPLOYEES
WHERE FIRST_NAME = 'David'; --4800,9500,6800

--���̺���� �ּұ޿����� ���̹޴� ���
--4800���� ū
SELECT *
FROM EMPLOYEES
WHERE SALARY > ANY(SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'David');

--���̺���� �ִ�޿����� ���Թ޴� ���
--9500���� ����
SELECT *
FROM EMPLOYEES
WHERE SALARY < ANY(SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'David');

--���̺�� �ִ� �޿����� ���� �޴� ���
--9500���� ū
SELECT *
FROM EMPLOYEES
WHERE SALARY >ALL (SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'David');

--���̺�� �ּұ޿����� ���Թ޴� ���
--4800���� ����
SELECT *
FROM EMPLOYEES
WHERE SALARY <ALL (SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'David');

-- IN ������ ��������, ��ġ�ϴ� ������
-- ���̺��� �μ��� ����
SELECT DEPARTMENT_ID
FROM EMPLOYEES WHERE FIRST_NAME = 'David';
SELECT *
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN(SELECT DEPARTMENT_ID FROM EMPLOYEES WHERE FIRST_NAME = 'David');

-----------------------------------------------------------------------
-- ��Į�� ���� - SELECT���� ���������� ���� ��� (JOIN�� ��ü��)
SELECT FIRST_NAME,
       DEPARTMENT_NAME
FROM EMPLOYEES E
LEFT JOIN DEPARTMENTS D ON e.DEPARTMENT_id = d.department_id;
--��Į��� �ٲ㺸�� (LEFT JOIN�� ����)
SELECT FIRST_NAME,
       (SELECT DEPARTMENT_NAME FROM DEPARTMENTS D WHERE E.DEPARTMENT_ID = d.department_id) AS �μ���
FROM EMPLOYEES E;

--��Į�������� �ٸ����̺��� 1���� �÷��� ������ �ö�, JOIN���� ������ ���
SELECT FIRST_NAME,
       JOB_ID,
       (SELECT JOB_TITLE FROM JOBS J WHERE j.job_id= E.JOB_ID) AS JOB_TITLE
FROM EMPLOYEES E ;
-- �ѹ��� �ϳ��� �÷��� �������� ������ ���� ���� ������ö��� ������ JOIN�� �������� ���� �� �ֵ�
SELECT FIRST_NAME,
       JOB_ID,
       (SELECT JOB_TITLE FROM JOBS J WHERE j.job_id= E.JOB_ID) AS JOB_TITLE,
       (SELECT MIN_SALARY FROM JOBS J WHERE J.JOB_ID = E.JOB_ID)AS MIN
FROM EMPLOYEES E ;

--����
--FIRST_NAME�÷�, DEPARTMENT_NAME, JOB_TITLE�� ���ÿ�
SELECT FIRST_NAME,
       (SELECT DEPARTMENT_NAME FROM departments D WHERE d.department_id = E.DEPARTMENT_ID) AS DPN,
       (SELECT JOB_TITLE FROM JOBS J WHERE J.JOB_ID = E.JOB_ID) AS JT
FROM EMPLOYEES E;

--------------------------------------------------------------------
--�ζ��� �� - FROM�� ������ ������������ ���ϴ�.
--�ζ��� �信�� (�����÷�) �� �����, �� �÷��� ���ؼ� ��ȸ�� ������ ����մϴ�.
SELECT *
FROM (SELECT *
      FROM EMPLOYEES
);
SELECT *
FROM EMPLOYEES;
--ROWNUM�� ��ȸ�� ������ ���� ��ȣ�� �ٽ��ϴ�.
SELECT  ROWNUM,
        FIRST_NAME,
        SALARY
FROM EMPLOYEES
ORDER BY SALARY DESC;

-- ORDER�� ���� ��Ų ����� ���ؼ� ����ȸ

SELECT ROWNUM, FIRST_NAME, SALARY
FROM (SELECT FIRST_NAME,
       SALARY,
       ROWNUM
FROM EMPLOYEES 
ORDER BY SALARY DESC)
WHERE ROWNUM BETWEEN 11 AND 20; --ROWNUM�� Ư¡�� �ݵ�� 1���� �����ؾ���
-- ORDER�� ���� ��Ų ����� �����, ROWNUM�� ���󿭷� �ٽø����,����ȸ

SELECT *
FROM(SELECT ROWNUM AS RN, --����(���������� ������ ��)
            FIRST_NAME,
            SALARY
     FROM (SELECT FIRST_NAME,
                  SALARY
           FROM EMPLOYEES
           ORDER BY SALARY DESC))
WHERE RN BETWEEN 11 AND 20; --�ȿ��� RN���� ������� ������ �ۿ��� ��밡��

--����
--�ټӳ�� 5��° �Ǵ� ����鸸 �����
SELECT *
FROM (SELECT FIRST_NAME,
             HIRE_DATE,
             TRUNC((SYSDATE-HIRE_DATE)/365) AS �ټӳ�� --�ȿ��� ���� ���󿭿� ���ؼ� ����ȸ �Ҷ� �ζ��κ䰡 ����
      FROM EMPLOYEES
      ORDER BY �ټӳ�� DESC)
WHERE MOD(�ټӳ��,5)=0;

--�ζ��� �信�� ���̺� ������� ��ȸ
SELECT A.*
FROM (SELECT E.*,
             TRUNC((SYSDATE-HIRE_DATE)/365) AS �ټӳ��       
      FROM EMPLOYEES E
      ORDER BY �ټӳ�� DESC) A;



