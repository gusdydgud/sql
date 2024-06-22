--���
/*
IF ������ THEN
ELSIF ������ THEN
ELSE ~~~ 
END IF;

*/
SET SERVEROUTPUT ON;
DECLARE
    POINT NUMBER := TRUNC(DBMS_RANDOM.VALUE(1,101));
BEGIN
    DBMS_OUTPUT.put_line('����:'||POINT);
    /*
    IF POINT >=90 THEN
        DBMS_OUTPUT.put_line('A���� �Դϴ�');
    ELSIF POINT >=80 THEN
        DBMS_OUTPUT.put_line('B�����Դϴ�');
    ELSIF POINT >=70 THEN
        DBMS_OUTPUT.put_line('C���� �Դϴ�');
    ELSE
        DBMS_OUTPUT.put_line('F���� �Դϴ�');
    END IF;
    */
    CASE WHEN POINT>=90 THEN DBMS_OUTPUT.put_line('A���� �Դϴ�');
         WHEN POINT>=80 THEN DBMS_OUTPUT.put_line('B���� �Դϴ�');
         WHEN POINT>=70 THEN DBMS_OUTPUT.put_line('C���� �Դϴ�');
         WHEN POINT>=60 THEN DBMS_OUTPUT.put_line('D���� �Դϴ�');
    ELSE DBMS_OUTPUT.put_line('F���� �Դϴ�');
    END CASE;
    
END;

----------------------------------------------------------------------
--WHILE��
DECLARE
    CNT NUMBER:=1;
    
BEGIN
    WHILE CNT <=9
    LOOP
        DBMS_OUTPUT.put_line('3 X '||CNT||' = ' || CNT*3);
        CNT:=CNT+1; --1����
    END LOOP;
END;
-------------------------------------------------------------------
--FOR��
DECLARE
    
BEGIN
    FOR I IN 1..9 --1~9����
    LOOP
        CONTINUE WHEN I=5;
        DBMS_OUTPUT.put_line('3 X '||I||' = '||3*I);
        EXIT WHEN I = 5; -- I�� 5�� Ż��
    END LOOP;
END;

-------------------------------------------------------------------
--1 2~9�ܱ��� ����ϴ� �͸�
DECLARE

BEGIN
    FOR I IN 2..9
    LOOP
        DBMS_OUTPUT.put_line(I||'��');
        FOR J IN 1..9
        LOOP
            DBMS_OUTPUT.put_line(I||' X '||J||' = '||I*J);
        END LOOP;
        
    END LOOP;
END;


-----------------------------------------------------------------
--Ŀ��
DECLARE
    NAME VARCHAR2(30);
BEGIN
    
    SELECT FIRST_NAME 
    INTO NAME
    FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG';
    DBMS_OUTPUT.put_line(NAME);
END;

DECLARE
    NM VARCHAR2(30);
    SALARY NUMBER;
    CURSOR X IS SELECT FIRST_NAME,SALARY FROM EMPLOYEES WHERE JOB_ID='IT_PROG';
BEGIN
    OPEN X; --Ŀ�� ����
        DBMS_OUTPUT.put_line('--------------Ŀ�� ����-------------');
    LOOP
        FETCH X INTO NM, SALARY; --NM������ ,SALARY������ ����
        EXIT WHEN X%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(NM);
        DBMS_OUTPUT.put_line(SALARY);
    END LOOP;
    DBMS_OUTPUT.put_line('--------------Ŀ�� ����---------------');
    DBMS_OUTPUT.put_line('�����ͼ�:'|| X%ROWCOUNT); --Ŀ������ ���� ������ ��
    CLOSE X; --Ŀ������
    
END;
-------------------------------------------------------------------
--4. �μ��� �޿����� ����ϴ� Ŀ�������� �ۼ��غ��ô�.
DECLARE
    ID NUMBER;
    SALARY NUMBER;
    CURSOR X IS SELECT SUM(SALARY),DEPARTMENT_ID FROM EMPLOYEES GROUP BY DEPARTMENT_ID;
BEGIN
    OPEN X;
        DBMS_OUTPUT.put_line('---Ŀ�� ����---');
    LOOP
        FETCH X INTO SALARY,ID;
        EXIT WHEN X%NOTFOUND;
        DBMS_OUTPUT.put_line(ID||'�μ�');
        DBMS_OUTPUT.put_line(SALARY||'�޿�');
    END LOOP;
    DBMS_OUTPUT.put_line('--Ŀ������--');
    DBMS_OUTPUT.put_line(X%ROWCOUNT);
    CLOSE X;
END;
SELECT SUM(SALARY),department_id
FROM EMPLOYEES
GROUP BY department_id;
--5. ������̺��� ������ �޿����� ���Ͽ� EMP_SAL�� 
--���������� INSERT�ϴ� Ŀ�������� �ۼ��غ��ô�.
DECLARE
    HD VARCHAR2(20);
    SAL NUMBER;
    CURSOR X IS SELECT SUM(SALARY),A FROM (SELECT TO_CHAR(HIRE_DATE,'YYYY')AS A,SALARY
                                            FROM EMPLOYEES) GROUP BY A;
BEGIN
-- FOR I IN X --Ŀ���� FOR IN ������ ������ OPEN, CLOSE���� ����
    OPEN X;
    LOOP
        FETCH X INTO HD,SAL;
        EXIT WHEN X%NOTFOUND;
        INSERT INTO EMP_SAL VALUES(SAL,HD);
    END LOOP;
    CLOSE X;
    COMMIT;
END;

SELECT SUM(SALARY),A
FROM (SELECT TO_CHAR(HIRE_DATE,'YYYY')AS A,
            SALARY
            FROM EMPLOYEES)
GROUP BY A;
SELECT * FROM EMP_SAL;




