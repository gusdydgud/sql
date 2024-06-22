--��ȯ �Լ�

--����ȯ�Լ�
--�ڵ�����ȯ�� ������ݴϴ�. (���ڿ� ����, ���ڿ� ��¥)
SELECT * FROM EMPLOYEES WHERE SALARY>='20000'; --����->���� �ڵ�����ȯ�� �Ͼ
SELECT * FROM EMPLOYEES WHERE HIRE_DATE>='08/01/01';--���� ->��¥ �ڵ�����ȯ

--��������ȯ
--TO_CHAR -> ��¥�� ���ڷ�
SELECT TO_CHAR(SYSDATE,'YYYY-MM-DD HH:MI:SS') FROM DUAL;
SELECT TO_CHAR( SYSDATE, 'YY-MM-DD PM HH12:MI:SS') AS TIME FROM DUAL;
SELECT TO_CHAR( SYSDATE, 'YY"��" MM"��" DD"��"') AS TIME FROM DUAL; --����Ʈ ���䰪�� �ƴ� ���� ������ ""�� �����ݴϴ�.

--TO_CHAR -> ���ڸ� ���ڷ�
SELECT TO_CHAR(20000,'9999999') AS RESULT FROM DUAL; 
SELECT TO_CHAR(20000,'0999999') AS RESULT FROM DUAL; --�����ڸ��� 0���� ä��
SELECT TO_CHAR(20000,'999') AS RESULT FROM DUAL; --�ڸ����� �����ϸ� #ó���˴ϴ�.
SELECT TO_CHAR(20000.123,'999999999.9999') AS RESULT FROM DUAL; --�Ҽ��� 4�ڸ�����
SELECT TO_CHAR(20000,'$99999999') AS RESULT FROM DUAL; --$��ȣ���̱�
SELECT TO_CHAR(20000,'L99,999,999') AS RESULT FROM DUAL; --L�� ����ȭ���ȣ

--���� ȯ�� 1372.17�� �϶� SALARY���� �ѱ������� ǥ��
SELECT TO_CHAR(SALARY*1372.17,'L99,999,999,999') AS �� FROM EMPLOYEES;

--TO_DATE -> ���ڸ� ��¥��
SELECT SYSDATE - TO_DATE('2024-06-13','YYYY-MM-DD') FROM DUAL; --��¥������ ���缭 ��Ȯ�� ����
SELECT TO_DATE('2024�� 06�� 13��','YYYY"��" MM"��" DD"��"') FROM DUAL; --��¥ ���˹��ڰ� �ƴ϶�� " "
SELECT TO_DATE('24-06-13 11�� 30�� 23��','YY-MM-DD HH"��" MI"��" SS"��"') FROM DUAL;

--2024��06��13�� �� ���ڷ� ��ȯ�Ѵٸ�?
SELECT TO_CHAR(TO_DATE('240613','YYMMDD'), 'YYYY"��"MM"��"DD"��"') FROM DUAL;

--TO_NUMBER -> ���ڸ� ���ڷ�
SELECT '4000' -1000 FROM DUAL; --�ڵ�����ȯ
SELECT TO_NUMBER('4000') -1000 FROM DUAL; --�������ȯ �� ����

SELECT '$5,500' - 1000 FROM DUAL; -- �ڵ�����ȯX
SELECT TO_NUMBER('$5,500','$99,999') - 1000 FROM DUAL; --���ڷ� ������ �ڵ����� �Ұ����� ��� ����� ��ȯ.

--NULLó�� �Լ�
SELECT NVL(1000,0),NVL(NULL,0) FROM DUAL;
SELECT NULL+1000 FROM DUAL; -- NULL�� �������ص� NULL�� ����

SELECT FIRST_NAME, SALARY, commission_pct,SALARY+SALARY*NVL(commission_pct,0)AS �����޿� FROM EMPLOYEES;


--NVL2 (���, ���� �ƴѰ��, ���ΰ��)
SELECT NVL2(NULL, 'NULL�� �ƴմϴ�', 'NULL�Դϴ�') FROM DUAL;
SELECT NVL2(300, 'NULL�� �ƴմϴ�', 'NULL�Դϴ�') FROM DUAL;
SELECT FIRST_NAME,SALARY,COMMISSION_PCT,NVL2(COMMISSION_PCT,SALARY+SALARY*COMMISSION_PCT,SALARY)AS �޿� FROM EMPLOYEES;

--COALESCE (��,��,��....) - NULL�� �ƴ� ù��° ���� ��ȯ ������
SELECT COALESCE(1,2,3) FROM DUAL; 
SELECT COALESCE(NULL,2,3,4) FROM DUAL;
SELECT COALESCE( NULL,NULL,NULL,3,4,5) FROM DUAL;
SELECT COALESCE(COMMISSION_PCT,0) FROM EMPLOYEES; --NVL�� ����

--DECODE (���, �񱳰�, �����, �񱳰�, �����,....,ELSE��)
SELECT DECODE('B', 'A','A�Դϴ�','B','B�Դϴ�') FROM DUAL;
SELECT DECODE('X','A','A�Դϴ�','A�� �ƴ�') FROM DUAL; --IF ELSE����
SELECT DECODE('X','A','A�Դϴ�',
                  'B','B�Դϴ�',
                  'C','C�Դϴ�',
                  '���ξƴմϴ�') FROM DUAL; --ELSE IF ����

SELECT JOB_ID,
DECODE(JOB_ID,'IT_PROG' , SALARY*1.1,
                     'AD_VP' , SALARY*1.2,
                     'FI_MGR', SALARY*1.3,
                     SALARY
) AS �޿� FROM EMPLOYEES;


--CASE WHEN THEN ELSE END (SWITCH���� ���)
SELECT JOB_ID,
       CASE JOB_ID WHEN 'IT_PROG' THEN SALARY*1.1
                   WHEN 'AD_VP' THEN SALARY*1.2
                   WHEN 'FI_MGR' THEN SALARY*1.3
                   ELSE SALARY
       END AS �޿�
FROM EMPLOYEES;
--�񱳿� ���� ������ WHEN���� ���� ����
SELECT JOB_ID,
       CASE WHEN JOB_ID = 'IT_PROG' THEN SALARY*1.1
            WHEN JOB_ID = 'AD_VP' THEN SALARY*1.2
            WHEN JOB_ID = 'FI_MGR' THEN SALARY*1.3
            ELSE SALARY
       END AS �޿�
FROM EMPLOYEES;
                  

SELECT * FROM EMPLOYEES;
SELECT EMPLOYEE_ID AS �����ȣ, FIRST_NAME||LAST_NAME AS �����, HIRE_DATE AS �Ի糯�� , TRUNC((SYSDATE-HIRE_DATE)/365) AS �ټӳ�� FROM EMPLOYEES WHERE TRUNC((SYSDATE-HIRE_DATE)/365)>=10 ORDER BY HIRE_DATE;

SELECT FIRST_NAME,MANAGER_ID,DECODE(MANAGER_ID,100,'����',120,'����',121,'�븮',122,'����','���') AS ���� FROM EMPLOYEES WHERE department_id=50;
SELECT FIRST_NAME,MANAGER_ID,
    CASE  WHEN MANAGER_ID= 100 THEN '����'
          WHEN MANAGER_ID= 120 THEN '����'
          WHEN MANAGER_ID= 121 THEN '�븮'
          WHEN MANAGER_ID= 122 THEN '����'
          ELSE '���'
    END AS ����
FROM EMPLOYEES WHERE DEPARTMENT_ID=50;

SELECT FIRST_NAME AS �̸�,
       TO_CHAR(HIRE_DATE,'YYYY"��"MM"��"DD"��"')AS �Ի���,
       TO_CHAR(1300*(SALARY+SALARY*NVL(commission_pct,0)),'L99,999,999,999')AS �����޿� ,
       DECODE(MOD(TRUNC((SYSDATE-HIRE_DATE)/365),5),0,'���޴��',
                                           
                                                      '������ȸ') AS ���޴��
       FROM EMPLOYEES WHERE department_id IS NOT NULL;
    
                    











