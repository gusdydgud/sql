SELECT * FROM EMPLOYEES;
SELECT * FROM departments;
SELECT * FROM jobs;
--Ư���÷��� ��ȸ�ϱ�
--���ڿ� ��¥�� ���ʿ� ���ڴ� �����ʿ� ǥ�õ˴ϴ�.
SELECT first_name, hire_date,email,salary from employees;

--�÷����ڸ������� ���� �Ǵ� ��¥�� ������ �˴ϴ�.
SELECT first_name,salary,salary+salary*0.1 from employees;

SELECT first_name AS �̸�, salary �޿� From employees;
--pk�� employee_id, fk - department_id
SELECT * FROM employees;

--����� (��Ī)
select first_name as ��Ī, salary �޿�, salary+salary*0.1 "10�� �λ�޿�" from employees;
--���ڿ� ���� ||
--''�ȿ��� '����ʹٸ� ''�տ����ٿ���
SELECT 'HELLO' || ' WORLD' FROM employees;
SELECT FIRST_NAME || '���� �޿��� ' || SALARY ||'$ �Դϴ�' AS �޿� FROM employees;

--DISTINCT(�ߺ� ����) Ű����  -SELECT ������ �ٿ�����
SELECT DEPARTMENT_ID FROM employees;
SELECT DISTINCT DEPARTMENT_ID FROM EMPLOYEES;

--ROWID(���ڵ尡 ����� ��ġ), ROWNUM(��ȸ�� ����)
SELECT EMPLOYEE_ID, FIRST_NAME, ROWID, ROWNUM  FROM EMPLOYEES;




