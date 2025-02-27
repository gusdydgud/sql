--제약조건 (컬럼에 대한 데이터 수정, 삭제, 삽입등 이상을 방지하기 위한 조건
--PRIMARY KEY - 테이블 고유키, 중복 X, NULL (X), PK는 테이블에서 1개
--NOT NULL - NULL을 허용하지 않음
--UNIQUE KEY - 중복 X, NULL(O)
--FORIEGN KEY - 참조하는 테이블의 PK를 넣어놓은 키, 중복 O, NULL (O)
--CHECK - 컬럼에대한 데이터 제한

--전체 제약조건 확인
SELECT * FROM USER_CONSTRAINTS;
DROP TABLE DEPTS;
--1ST (열레벨 제약조건)
CREATE TABLE DEPTS(
    DEPT_NO NUMBER(2) CONSTRAINT DEPTS_DEPT_NO_PK PRIMARY KEY,
    DEPT_NAME VARCHAR2(30)CONSTRAINT DEPTS_DEPT_NAME_NN NOT NULL,
    DEPT_DATE DATE DEFAULT SYSDATE, --제약조건은 아니며(칼럼의 기본값)
    DEPT_PHONE VARCHAR2(30) CONSTRAINT DEPTS_DEPT_PHONE_UK UNIQUE,
    DEPT_GENDER CHAR(1) CONSTRAINT DEPTS_DEPT_GENDER_CK CHECK(DEPT_GENDER IN('F','M')),
    LOCA_ID NUMBER(4) CONSTRAINT DEPTS_LOCA_ID_FK REFERENCES LOCATIONS(LOCATION_ID)
);

INSERT INTO DEPTS(DEPT_NO,DEPT_NAME,DEPT_PHONE,DEPT_GENDER,LOCA_ID)
VALUES(1,NULL,'010-2233','F',1700);--NOT NULL제약 위배

INSERT INTO DEPTS(DEPT_NO,DEPT_NAME,DEPT_PHONE,DEPT_GENDER,LOCA_ID)
VALUES(1,'HONG','010-2233','A',1700); --CHECK 제약 위배

INSERT INTO DEPTS(DEPT_NO,DEPT_NAME,DEPT_PHONE,DEPT_GENDER,LOCA_ID)
VALUES(1,'HONG','010-2233','F',100); --참조 제약위배

INSERT INTO DEPTS(DEPT_NO,DEPT_NAME,DEPT_PHONE,DEPT_GENDER,LOCA_ID)
VALUES(1,'HONG','010-2233','F',1700); --성공

INSERT INTO DEPTS(DEPT_NO,DEPT_NAME,DEPT_PHONE,DEPT_GENDER,LOCA_ID)
VALUES(2,'HONG','010-2233','F',1700); --유니크 제약 위배
-----------------------------------------------------------
--2ND (테이블레벨 제약조건 정의)
DROP TABLE DEPTS;
CREATE TABLE DEPTS(
    DEPT_NO NUMBER(2),
    DEPT_NAME VARCHAR2(30) NOT NULL, -- NOT NULL은 열레벨 정의
    DEPT_DATE DATE DEFAULT SYSDATE,
    DEPT_PHONE VARCHAR2(30),
    DEPT_GENDER CHAR(1),
    LOCA_ID NUMBER(4),
    CONSTRAINT DEPTS_DEPT_NO_PK PRIMARY KEY (DEPT_NO,DEPT_NAME), --컬럼명,슈퍼키만들기는 테이블레벨에서가능
    CONSTRAINT DEPTS_DEPT_PHONE_UK UNIQUE (DEPT_PHONE),--컬럼명
    CONSTRAINT DEPTS_DEPT_GENDER_CK CHECK (DEPT_GENDER IN ('F','M')),
    CONSTRAINT DEPTS_LOCA_ID_FK FOREIGN KEY (LOCA_ID) REFERENCES LOCATIONS(LOCATION_ID)
    
);
---------------------------------------------------------------
--ALTER로 제약조건 추가
CREATE TABLE DEPTS(
    DEPT_NO NUMBER(2),
    DEPT_NAME VARCHAR2(30) , -- NOT NULL은 열레벨 정의
    DEPT_DATE DATE DEFAULT SYSDATE,
    DEPT_PHONE VARCHAR2(30),
    DEPT_GENDER CHAR(1),
    LOCA_ID NUMBER(4)
   
);
--PK추가
ALTER TABLE DEPTS ADD CONSTRAINT DEPTS_DEPT_NO_PK PRIMARY KEY(DEPT_NO);
--NOT NULL은 열 변경(MODIFY)로 추가함
ALTER TABLE DEPTS MODIFY DEPT_NAME VARCHAR2(30) NOT NULL;
--UNIQUE추가
ALTER TABLE DEPTS ADD CONSTRAINT DEPTS_DEPT_PHONE_UK UNIQUE(DEPT_PHONE);
--FK추가
ALTER TABLE DEPTS ADD CONSTRAINT DEPTS_LOCA_ID_FK FOREIGN KEY (LOCA_ID) REFERENCES LOCATIONS(LOCATION_ID);
--CHECK추가
ALTER TABLE DEPTS ADD CONSTRAINT DEPTS_DEPT_GENDER_CK CHECK(DEPT_GENDER IN('F','M'));

--제약조건 삭제
ALTER TABLE DEPTS DROP CONSTRAINT DEPTS_DEPT_GENDER_CK; --제약조건명 드랍


--문제1.
--
--다음과 같은 테이블을 생성하고 데이터를 insert해보세요.
--테이블 제약조건은 아래와 같습니다. 
--조건) M_NAME 는 가변문자형 20byte, 널값을 허용하지 않음
--조건) M_NUM 은 숫자형 5자리, PRIMARY KEY 이름(mem_memnum_pk) 
--조건) REG_DATE 는 날짜형, 널값을 허용하지 않음, UNIQUE KEY 
--이름:(mem_regdate_uk)
--조건) GENDER 고정문자형 1byte, CHECK제약 (M, F)
--조건) LOCA 숫자형 4자리, FOREIGN KEY ? 참조 
--locations테이블(location_id) 이름:(mem_loca_loc_locid_fk)
CREATE TABLE SOCK (
    M_NAME VARCHAR2(20) NOT NULL,
    M_NUM NUMBER(5),
    REG_DATE DATE NOT NULL,
    GENDER CHAR(1),
    LOCA NUMBER(4));
INSERT INTO SOCK VALUES('AAA',1,'2018-07-01','M',1800);
INSERT INTO SOCK VALUES('BBB',2,'2018-07-02','F',1900);
INSERT INTO SOCK VALUES('CCC',3,'2018-07-03','M',2000);
INSERT INTO SOCK VALUES('DDD',4,SYSDATE,'M',2000);

------------------------------------------------------
--2
CREATE TABLE RENTS (
    RENT_NUM NUMBER(10),
    RENT_NAME VARCHAR2(30),
    RENT_DATE DATE,
    RENT_DDATE DATE,
    RENT_DONE CHAR(1));


    



    
    
    
