--제어문
/*
IF 조건절 THEN
ELSIF 조건절 THEN
ELSE ~~~ 
END IF;

*/
SET SERVEROUTPUT ON;
DECLARE
    POINT NUMBER := TRUNC(DBMS_RANDOM.VALUE(1,101));
BEGIN
    DBMS_OUTPUT.put_line('점수:'||POINT);
    /*
    IF POINT >=90 THEN
        DBMS_OUTPUT.put_line('A학점 입니다');
    ELSIF POINT >=80 THEN
        DBMS_OUTPUT.put_line('B학점입니다');
    ELSIF POINT >=70 THEN
        DBMS_OUTPUT.put_line('C학점 입니다');
    ELSE
        DBMS_OUTPUT.put_line('F학점 입니다');
    END IF;
    */
    CASE WHEN POINT>=90 THEN DBMS_OUTPUT.put_line('A학점 입니다');
         WHEN POINT>=80 THEN DBMS_OUTPUT.put_line('B학점 입니다');
         WHEN POINT>=70 THEN DBMS_OUTPUT.put_line('C학점 입니다');
         WHEN POINT>=60 THEN DBMS_OUTPUT.put_line('D학점 입니다');
    ELSE DBMS_OUTPUT.put_line('F학점 입니다');
    END CASE;
    
END;

----------------------------------------------------------------------
--WHILE문
DECLARE
    CNT NUMBER:=1;
    
BEGIN
    WHILE CNT <=9
    LOOP
        DBMS_OUTPUT.put_line('3 X '||CNT||' = ' || CNT*3);
        CNT:=CNT+1; --1증가
    END LOOP;
END;
-------------------------------------------------------------------
--FOR문
DECLARE
    
BEGIN
    FOR I IN 1..9 --1~9까지
    LOOP
        CONTINUE WHEN I=5;
        DBMS_OUTPUT.put_line('3 X '||I||' = '||3*I);
        EXIT WHEN I = 5; -- I가 5면 탈출
    END LOOP;
END;

-------------------------------------------------------------------
--1 2~9단까지 출력하는 익명
DECLARE

BEGIN
    FOR I IN 2..9
    LOOP
        DBMS_OUTPUT.put_line(I||'단');
        FOR J IN 1..9
        LOOP
            DBMS_OUTPUT.put_line(I||' X '||J||' = '||I*J);
        END LOOP;
        
    END LOOP;
END;


-----------------------------------------------------------------
--커서
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
    OPEN X; --커서 선언
        DBMS_OUTPUT.put_line('--------------커서 시작-------------');
    LOOP
        FETCH X INTO NM, SALARY; --NM변수와 ,SALARY변수에 저장
        EXIT WHEN X%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(NM);
        DBMS_OUTPUT.put_line(SALARY);
    END LOOP;
    DBMS_OUTPUT.put_line('--------------커서 종료---------------');
    DBMS_OUTPUT.put_line('데이터수:'|| X%ROWCOUNT); --커서에서 읽은 데이터 수
    CLOSE X; --커서닫음
    
END;
-------------------------------------------------------------------
--4. 부서벌 급여합을 출력하는 커서구문을 작성해봅시다.
DECLARE
    ID NUMBER;
    SALARY NUMBER;
    CURSOR X IS SELECT SUM(SALARY),DEPARTMENT_ID FROM EMPLOYEES GROUP BY DEPARTMENT_ID;
BEGIN
    OPEN X;
        DBMS_OUTPUT.put_line('---커서 시작---');
    LOOP
        FETCH X INTO SALARY,ID;
        EXIT WHEN X%NOTFOUND;
        DBMS_OUTPUT.put_line(ID||'부서');
        DBMS_OUTPUT.put_line(SALARY||'급여');
    END LOOP;
    DBMS_OUTPUT.put_line('--커서종료--');
    DBMS_OUTPUT.put_line(X%ROWCOUNT);
    CLOSE X;
END;
SELECT SUM(SALARY),department_id
FROM EMPLOYEES
GROUP BY department_id;
--5. 사원테이블의 연도별 급여합을 구하여 EMP_SAL에 
--순차적으로 INSERT하는 커서구문을 작성해봅시다.
DECLARE
    HD VARCHAR2(20);
    SAL NUMBER;
    CURSOR X IS SELECT SUM(SALARY),A FROM (SELECT TO_CHAR(HIRE_DATE,'YYYY')AS A,SALARY
                                            FROM EMPLOYEES) GROUP BY A;
BEGIN
-- FOR I IN X --커서를 FOR IN 구문에 넣으면 OPEN, CLOSE생략 가능
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




