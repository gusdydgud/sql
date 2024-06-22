--�����̵� ���ν��� (�Ϸ��� SQLó�� ������ ����ó�� ��� ����ϴ� ����)
SET SERVEROUTPUT ON;
--����� ȣ���� �ֵ�
CREATE OR REPLACE PROCEDURE NEW_JOB_POC --���ν�����
IS
BEGIN
    DBMS_OUTPUT.put_line('HELLO WORLD');
END;
--ȣ��
EXEC new_job_poc;
-------------------------------------------------------------------
--���ν����� �Ű����� IN
CREATE OR REPLACE PROCEDURE NEW_JOB_PROC --�̸��� ������ �ڵ����� ������.
    (P_JOB_ID IN VARCHAR2,
     P_JOB_TITLE IN VARCHAR2,
     P_MIN_SALARY IN JOBS.MIN_SALARY%TYPE := 1000, --���̺��� Ÿ�԰� ������ Ÿ��
     P_MAX_SALARY IN JOBS.MAX_SALARY%TYPE := 10000
    )
IS
BEGIN
    
    INSERT INTO JOBS_IT VALUES(P_JOB_ID,P_JOB_TITLE,P_MIN_SALARY,P_MAX_SALARY);
    COMMIT;
END;

DESC JOBS_IT;
EXEC NEW_JOB_PROC('EXAMPLE','EXAMPLE',1000,10000);
EXEC NEW_JOB_PROC('EXAMPLE'); --�Ű������� ��ġ���������� X
EXEC NEW_JOB_PROC('SAMPLE','SAMPLE2'); --�⺻������������ ��� ����
SELECT * FROM JOBS_IT;

----------------------------------------------------------------------
--PLSQL��� ���� ���, Ż�⹮, Ŀ�� ������ ���ν����� ���� �ֽ��ϴ�.
--JOB_ID�� �����ϸ� ������Ʈ, ������ INSERT
CREATE OR REPLACE PROCEDURE NEW_JOB_PROC
    (A IN VARCHAR2, --JOB_ID
     B IN VARCHAR2,
     C IN NUMBER,
     D IN NUMBER
    )
IS
    CNT NUMBER;--��������
BEGIN
    SELECT COUNT(*)
    INTO CNT --�ִٸ� ������ CNT�� ���� ����
    FROM JOBS_IT
    WHERE job_id = A;
    
    IF CNT =0 THEN
        INSERT INTO JOBS_IT VALUES(A,B,C,D);
    ELSE
        UPDATE JOBS_IT 
        SET JOB_ID = A,
            JOB_TITLE =B,
            MIN_SALARY = C,
            MAX_SALARY=D
        WHERE JOB_ID =A;
    END IF;
    COMMIT;
END;

EXEC NEW_JOB_PROC('AD','ADMIN',1000,10000);
EXEC NEW_JOB_PROC('AD_VP','ADMIN2',1000,20000);
SELECT * FROM JOBS_IT;
------------------------------------------------------------------
--OUT �Ű����� - �ܺη� ���� �����ֱ� ���� �Ű�����

CREATE OR REPLACE PROCEDURE NEW_JOB_PROC
    (A IN VARCHAR2, --JOB_ID
     B IN VARCHAR2,
     C IN NUMBER,
     D IN NUMBER,
     E OUT NUMBER --�ܺη� ������ �Ű�����
    )
IS
    CNT NUMBER;--��������
BEGIN
    SELECT COUNT(*)
    INTO CNT --�ִٸ� ������ CNT�� ���� ����
    FROM JOBS_IT
    WHERE job_id = A;
    
    IF CNT =0 THEN
        INSERT INTO JOBS_IT VALUES(A,B,C,D);
    ELSE
        UPDATE JOBS_IT 
        SET JOB_ID = A,
            JOB_TITLE =B,
            MIN_SALARY = C,
            MAX_SALARY=D
        WHERE JOB_ID =A;
    END IF;
    -- �ƿ� �Ű������� ���� �Ҵ�
    E:= CNT; 
    COMMIT;
END;
--
DECLARE
    CNT NUMBER;
BEGIN
    --�͸������ �Ѵٸ� EXEC����
    NEW_JOB_PROC('AD_VP','ADMIN',1000,10000,CNT); 
    DBMS_OUTPUT.put_line('���ν��� ���ο��� �Ҵ���� ��:'||CNT);
END;

--------------------------------------------------------------------
--RETURN�� - ���ν����� ������.
--EXCEPTION WHEN OTHERS THEN - ���ܰ� �߻��ϸ� �����
CREATE OR REPLACE PROCEDURE NEW_JOB_PROC2
    (P_JOB_ID IN JOBS.JOB_ID%TYPE
     )
IS
    CNT NUMBER;
    SAL NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO CNT
    FROM JOBS
    WHERE JOB_ID = P_JOB_ID;
    IF CNT=0 THEN
        DBMS_OUTPUT.put_line('���� �����ϴ�');
        RETURN; --���ν��� ����
    ELSE
        
        SELECT MAX_SALARY
        INTO SAL
        FROM JOBS
        WHERE JOB_ID = P_JOB_ID;
        DBMS_OUTPUT.put_line('�ִ�޿�:'|| SAL );
    END IF;
    DBMS_OUTPUT.put_line('���ν��� ���� ����');
    --����ó�� ����(���ܸ� ������ ���ܹ����� �����)
    EXCEPTION WHEN OTHERS THEN
        DBMS_OUTPUT.put_line('���ܰ� �߻��߽��ϴ�');
    
END;

EXEC NEW_JOB_PROC2('AD');
EXEC NEW_JOB_PROC2('AD_VP');
------------------------------------------------------------------
--3. ���ν����� DEPTS_PROC
--- �μ���ȣ, �μ���, �۾� flag(I: insert, U:update, D:delete)�� 
--�Ű������� �޾� 
--DEPTS���̺� ���� flag�� i�� INSERT, u�� UPDATE, d�� DELETE �ϴ� 
--���ν����� �����մϴ�.
--- �׸��� ���������� commit, ���ܶ�� �ѹ� ó���ϵ��� ó���ϼ���.
--- ����ó���� �ۼ����ּ���.

CREATE OR REPLACE PROCEDURE DEPTS_PROC
    (P_DEPARTMENT_ID IN NUMBER,
     P_DEPARTMENT_NAME IN VARCHAR2,
     P_FLAG IN VARCHAR2
     )
IS
    FLAG VARCHAR2;
BEGIN
    IF P_FLAG='I' THEN
        INSERT INTO DEPTS (DEPT_NO,dept_name)VALUES(P_DEPARTMENT_ID,P_DEPARTMENT_NAME);
    ELSIF P_FLAG='U' THEN
        UPDATE DEPTS SET DEPT_NAME=P_DEPARTMENT_NAME
        WHERE DEPT_NO=P_DEPARTMENT_ID;
        
    ELSIF P_FLAG='D' THEN
        DELETE FROM DEPTS WHERE DEPT_NO=P_DEPARMENT_ID;
    END IF;
    COMMIT;
    EXCEPTION WHEN OTHERS THEN
        ROLLBACK;
END;


SELECT * FROM DEPTS;

--6. ���ν����� - SALES_PROC
--- sales���̺��� ������ �Ǹų����̴�.
--- day_of_sales���̺��� �Ǹų��� ������ ���� ������ �Ѹ����� ����ϴ� ���̺��̴�.
--- ������ sales�� ���ó�¥ �Ǹų����� �����Ͽ� day_of_sales�� �����ϴ�
--���ν����� �����غ�����.
--����) day_of_sales�� ���������� �̹� �����ϸ� ������Ʈ ó��

CREATE OR REPLACE PROCEDURE SALES_PROC
    (P_PRO VARCHAR2,
     P_TOTAL NUMBER,
     P_PRICE NUMBER,
     P_DATE DATE
     )
IS
    TS NUMBER;
    TODAY DATE;
BEGIN
    SELECT SUM(TOTAL*PRICE)
    INTO TS
    FROM SALES
    WHERE REGDATE = P_DATE;
    
    SELECT REGDATE
    INTO TODAY
    FROM DAY_OF_SALES
    WHERE DAY_OF_SALES = P_DATE;
    
    IF TODAY IS NOT NULL THEN
        UPDATE DAY_OF_SALES SET
            REGDATE = P_DATE,
            FINAL_TOTAL = TS
        WHERE REGDATE= P_DATE;
    ELSE
        INSERT INTO DAY_OF_SALES VALUES(P_DATE,TS);
    END IF;
    COMMIT;
            
END;

CREATE TABLE SALES(
    SNO NUMBER(5) CONSTRAINT SALES_PK PRIMARY KEY, -- ��ȣ
    NAME VARCHAR2(30), -- ��ǰ��
    TOTAL NUMBER(10), --����
    PRICE NUMBER(10), --����
    REGDATE DATE DEFAULT SYSDATE --��¥
);

CREATE TABLE DAY_OF_SALES(
    REGDATE DATE,
    FINAL_TOTAL NUMBER(10)
);

INSERT INTO SALES (SNO,NAME,TOTAL,PRICE) VALUES(1,'�Ƹ޸�ī��',3,1000);
INSERT INTO SALES (SNO,NAME,TOTAL,PRICE) VALUES(2,'�ݵ���',2,2000);
INSERT INTO SALES (SNO,NAME,TOTAL,PRICE) VALUES(3,'��ü��',1,3000);

SELECT SUM(TOTAL*PRICE) 
FROM SALES WHERE TO_CHAR(REGDATE,'YYYYMMDD')=TO_CHAR(SYSDATE,'YYYYMMDD');

--
CREATE OR REPLACE PROCEDURE SALES_PROC2
    
IS
    CNT NUMBER:=0 ; --��Ż��
    FLAG NUMBER:=0; --���ó�¥ �����Ͱ� �ִ��� ����
BEGIN
    --1. ���ó�¥�� �ݾ� ����
    SELECT SUM(TOTAL*PRICE) 
    INTO CNT
    FROM SALES 
    WHERE TO_CHAR(REGDATE,'YYYYMMDD')=TO_CHAR(SYSDATE,'YYYYMMDD');
    --2. �������̺� ���ó�¥ ���������Ͱ� �ִ��� Ȯ��.
    SELECT COUNT(*)
    INTO FLAG
    FROM DAY_OF_SALES
    WHERE TO_CHAR(REGDATE,'YYYYMMDD')=TO_CHAR(SYSDATE,'YYYYMMDD');
    
    IF FLAG <> 0 THEN --�����Ͱ� �̹� �ִ°��
        UPDATE DAY_OF_SALES
        SET FINAL_TOTAL = CNT -- �ݾ��հ�
        WHERE TO_CHAR(REGDATE,'YYYYMMDD')=TO_CHAR(SYSDATE,'YYYYMMDD');
    ELSE --�����Ͱ� ���°��
        INSERT INTO DAY_OF_SALES VALUES(SYSDATE,CNT);
    END IF;
    COMMIT;

END;

EXEC sales_proc2;
SELECT * FROM DAY_OF_SALES;









