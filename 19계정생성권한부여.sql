--���� ���
SELECT * FROM ALL_USERS;

--���� ���� ���� Ȯ��
SELECT * FROM user_sys_privs;

--��������
CREATE USER USER01 IDENTIFIED BY USER01; --���̵� USER01 ��� USER01
--���Ѻο� (���ӱ���, ���̺� �� ������ ���ν��� ��������)
GRANT CREATE SESSION, CREATE TABLE, CREATE SEQUENCE, CREATE VIEW, CREATE PROCEDURE TO USER01;
--���̺����̽� (�����͸� �����ϴ� �������� ����) ����
ALTER USER USER01 DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS; 
--�����Ѵ� ���� USER01�� �⺻ ���̺����̽� USERS�� ���������� ����Ұ��� USERS����

--���� ȸ��
REVOKE CREATE SESSION FROM USER01; --���ӱ��� ����
--��������
DROP USER USER01;
--------------------------------------------------------------
--��(ROLE) - ������ �׷��� ���� ���Ѻο�
CREATE USER USER01 IDENTIFIED BY USER01;
GRANT CONNECT, RESOURCE TO USER01; -- CONNECT���ӷ�, RESOUCE ���߷�,DBA�����ڷ�











