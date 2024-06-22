--유저 목록
SELECT * FROM ALL_USERS;

--현재 유저 권한 확인
SELECT * FROM user_sys_privs;

--계정생성
CREATE USER USER01 IDENTIFIED BY USER01; --아이디 USER01 비번 USER01
--권한부여 (접속권한, 테이블 뷰 시퀀스 프로시져 생성권한)
GRANT CREATE SESSION, CREATE TABLE, CREATE SEQUENCE, CREATE VIEW, CREATE PROCEDURE TO USER01;
--테이블스페이스 (데이터를 저장하는 물리적인 공간) 지정
ALTER USER USER01 DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS; 
--수정한다 유저 USER01을 기본 테이블스페이스 USERS고 무제한으로 사용할거임 USERS에서

--권한 회수
REVOKE CREATE SESSION FROM USER01; --접속권한 뺏음
--계정삭제
DROP USER USER01;
--------------------------------------------------------------
--롤(ROLE) - 권한의 그룹을 통한 권한부여
CREATE USER USER01 IDENTIFIED BY USER01;
GRANT CONNECT, RESOURCE TO USER01; -- CONNECT접속롤, RESOUCE 개발롤,DBA관리자롤











