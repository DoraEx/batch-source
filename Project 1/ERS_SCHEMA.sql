DROP TABLE ERS_REIMBURSEMENT;
DROP TABLE ERS_EMPLOYEE;
DROP TABLE ERS_MANAGER;

CREATE TABLE ERS_MANAGER(
    MANAGER_ID NUMBER(6),
    MANAGER_NAME VARCHAR2(100) NOT NULL,
    EMAIL VARCHAR2(60) NOT NULL,
    MANAGER_PASSWORD VARCHAR2(20) NOT NULL
);

ALTER TABLE ERS_MANAGER
ADD CONSTRAINT PK_ERS_MANAGER
PRIMARY KEY (MANAGER_ID);

CREATE SEQUENCE SQ_ERS_MANAGER_PK
START WITH 1;

CREATE OR REPLACE TRIGGER TR_ERS_MANAGER_PK
BEFORE INSERT ON ERS_MANAGER
FOR EACH ROW
BEGIN
    SELECT SQ_ERS_MANAGER_PK.NEXTVAL INTO :NEW.MANAGER_ID FROM DUAL;
END;

/

CREATE TABLE ERS_EMPLOYEE(
    EMPLOYEE_ID NUMBER(6),
    EMPLOYEE_NAME VARCHAR2(100) NOT NULL,
    EMAIL VARCHAR2(60) NOT NULL,
    PASSWORD VARCHAR(20) NOT NULL,
    MANAGER_ID NUMBER(6) NOT NULL
);

ALTER TABLE ERS_EMPLOYEE
ADD CONSTRAINT PK_ERS_EMPLOYEE
PRIMARY KEY (EMPLOYEE_ID);

ALTER TABLE ERS_EMPLOYEE
ADD CONSTRAINT FK_ERS_EMPLOYEE_MANAGER
FOREIGN KEY (MANAGER_ID)
REFERENCES ERS_MANAGER
ON DELETE CASCADE;

CREATE SEQUENCE SQ_ERS_EMPLOYEE_PK
START WITH 1;

CREATE OR REPLACE TRIGGER TR_ERS_EMPLOYEE_PK
BEFORE INSERT ON ERS_EMPLOYEE
FOR EACH ROW
BEGIN
    SELECT SQ_ERS_EMPLOYEE_PK.NEXTVAL INTO :NEW.EMPLOYEE_ID FROM DUAL;
END;

/

CREATE TABLE ERS_REIMBURSEMENT(
    REIMBURSEMENT_ID NUMBER(10),
    REIMBURSEMENT_NAME VARCHAR2(60),
    AMOUNT NUMBER(7,2) NOT NULL,
    STATUS NUMBER(1,0) DEFAULT 0,
    EMPLOYEE_ID NUMBER(6) NOT NULL,
    PICTURE BLOB
    );
    
ALTER TABLE ERS_REIMBURSEMENT
ADD CONSTRAINT PK_ERS_REIMBURSEMENT
PRIMARY KEY (REIMBURSEMENT_ID);

ALTER TABLE ERS_REIMBURSEMENT
ADD CONSTRAINT FK_ERS_REIMBURSEMENT_EMPLOYEE
FOREIGN KEY (EMPLOYEE_ID)
REFERENCES ERS_EMPLOYEE
ON DELETE CASCADE;

CREATE SEQUENCE SQ_ERS_REIMBURSEMENT_PK
START WITH 1;

CREATE OR REPLACE TRIGGER TR_ERS_REIMBURSEMENT_PK
BEFORE INSERT ON ERS_REIMBURSEMENT
FOR EACH ROW
BEGIN
    SELECT SQ_ERS_REIMBURSEMENT_PK.NEXTVAL INTO :NEW.REIMBURSEMENT_ID FROM DUAL;
END;
/

INSERT INTO ERS_MANAGER (MANAGER_NAME, EMAIL,MANAGER_PASSWORD) VALUES('Holly','query@java.com','password');
INSERT INTO ERS_EMPLOYEE (EMPLOYEE_NAME, EMAIL,PASSWORD,MANAGER_ID) VALUES('Jeffry','insert@java.com','password',1);
INSERT INTO ERS_REIMBURSEMENT (REIMBURSEMENT_NAME,AMOUNT,EMPLOYEE_ID) VALUES('Goats',2000,1);