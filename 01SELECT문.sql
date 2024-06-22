SELECT * FROM EMPLOYEES;
SELECT * FROM departments;
SELECT * FROM jobs;
--특정컬럼만 조회하기
--문자와 날짜는 왼쪽에 숫자는 오른쪽에 표시됩니다.
SELECT first_name, hire_date,email,salary from employees;

--컬럼명자리에서는 숫자 또는 날짜가 연산이 됩니다.
SELECT first_name,salary,salary+salary*0.1 from employees;

SELECT first_name AS 이름, salary 급여 From employees;
--pk는 employee_id, fk - department_id
SELECT * FROM employees;

--엘리어스 (별칭)
select first_name as 별칭, salary 급여, salary+salary*0.1 "10퍼 인상급여" from employees;
--문자열 연결 ||
--''안에서 '쓰고싶다면 ''앞에더붙여줌
SELECT 'HELLO' || ' WORLD' FROM employees;
SELECT FIRST_NAME || '님의 급여는 ' || SALARY ||'$ 입니다' AS 급여 FROM employees;

--DISTINCT(중복 제거) 키워드  -SELECT 다음에 붙여써줌
SELECT DEPARTMENT_ID FROM employees;
SELECT DISTINCT DEPARTMENT_ID FROM EMPLOYEES;

--ROWID(레코드가 저장된 위치), ROWNUM(조회된 순서)
SELECT EMPLOYEE_ID, FIRST_NAME, ROWID, ROWNUM  FROM EMPLOYEES;




