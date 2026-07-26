-- Combined setup script - recreates entire Delicious database from scratch
-- Run in order: drops (if exist), creates tables, constraints, functions, procedures, triggers, indexes, inserts data, creates views
--
-- Prerequisites: Oracle Database with CREATE TABLE, CREATE PROCEDURE, CREATE TRIGGER, CREATE SEQUENCE, CREATE VIEW privileges
-- Dependencies: None (standalone)
--
-- Usage: sqlplus user/pass @setup_db.sql

-- =====================================================
-- 1. DROP existing stored objects (idempotent)
-- =====================================================
drop PROCEDURE BOOKTABLE;
drop PROCEDURE ADDPHONE;
drop procedure TABLEREMOVE;
drop function calculatebill;
drop function TABLEEXISTS;
drop function TABLERESERVED;
drop function CLIENTMONEYPAIDYEAR;
drop trigger UPPERPELATISTRIGGER;
drop trigger UPPERAMENITIESTRIGGER;
drop trigger FUTURETIMETRIGGER;
drop trigger DENYKRATHSHTRIGGER;
drop trigger TABLEBOOKTIMESTRIGGER;
drop trigger CATEGORYTABLESCOUNTTRIGGER;
drop trigger RESERVATIONBILLTRIGGER;

-- =====================================================
-- 2. DROP existing tables (idempotent)
-- =====================================================
drop table provides;
drop table AMENITIES;
drop table Phone;
drop table KRATHSH;
drop table Pelatis;
drop table TRAPEZI;
drop table KATHGORIES;

-- =====================================================
-- 3. CREATE tables
-- =====================================================
create table PELATIS (Pid VARCHAR2(14)not null,
Lname VARCHAR2(14) not null,
Fname VARCHAR2(14)not null,
Regdate DATE not null,artayt VARCHAR2(14) not null,
PRIMARY KEY(Pid),UNIQUE (artayt));

create table PHONE(Pid VARCHAR2(14)not null,phones NUMBER
not null, PRIMARY KEY(Pid,phones),FOREIGN KEY(Pid)REFERENCES 
PELATIS(Pid));

create table KATHGORIES(cat VARCHAR2(14) not null,
price NUMBER,tablecount NUMBER,PRIMARY KEY(cat));

create table TRAPEZI(Tid VARCHAR2(14)not null,
floor NUMBER not null,area VARCHAR2(14),
timesreserved NUMBER, cat VARCHAR2(14),PRIMARY KEY(Tid),FOREIGN 
KEY(cat) REFERENCES KATHGORIES(cat));

create table KRATHSH(Kid VARCHAR2(14)not null,indate DATE not null,outdate DATE not null
,bill NUMBER,Pid VARCHAR2(14),Tid VARCHAR2(14)not null,PRIMARY KEY (Kid,Tid,Pid),
FOREIGN KEY (Pid) REFERENCES PELATIS(Pid),FOREIGN KEY (Tid) REFERENCES TRAPEZI(Tid));

ALTER TABLE KRATHSH MODIFY outdate date NULL;
ALTER TABLE PELATIS MODIFY PID varchar2(20);

create table AMENITIES(AmenType VARCHAR2(14) not null,
AmenCost NUMBER, PRIMARY KEY (AmenType));

create table provides(AmenType VARCHAR2(14) not null,Tid VARCHAR2(14)not null, PRIMARY KEY (AmenType,Tid),
FOREIGN KEY (AmenType)REFERENCES AMENITIES(AmenType), 
FOREIGN KEY (Tid)REFERENCES TRAPEZI(Tid));

-- =====================================================
-- 4. Add CHECK CONSTRAINTS
-- =====================================================
alter table KATHGORIES ADD (constraint notnegative check ((tablecount >=0)and (price >=0)));
alter table TRAPEZI ADD (constraint notnegative2 check (timesreserved >=0));
alter table KRATHSH ADD (constraint notnegative3 check (bill >=0));
alter table AMENITIES ADD (constraint notnegative4 check (Amencost >=0));
alter table KRATHSH ADD (constraint DATES check ((OUTDATE IS NULL)OR(OUTDATE>INDATE)));

-- =====================================================
-- 5. Add reservation number column + sequence
-- =====================================================
ALTER TABLE KRATHSH ADD reservationNo number;
CREATE SEQUENCE CustSeq INCREMENT BY 1 START WITH 1;
update KRATHSH SET reservationNO=CustSeq.NEXTVAL;

-- =====================================================
-- 6. Create FUNCTIONS
-- =====================================================
create or replace function TABLEEXISTS(TID IN VARCHAR2)
return number
AS
ii varchar2(55):=TID;
cursor i2 is SELECT COUNT(*) FROM TRAPEZI WHERE TID=ii;
iii integer;
RETVAL NUMBER;
BEGIN
OPEN i2;
FETCH i2 INTO iii;
IF (iii=1) THEN
RETVAL:= 1;
ELSE
RETVAL:= 0;
END IF;
CLOSE i2;
RETURN RETVAL;
END;
/
create or replace function TABLERESERVED(TID IN VARCHAR2)
return VARCHAR2
AS
ii varchar2(55):=TID;
cursor i2cursor is SELECT KID FROM KRATHSH WHERE (TID=ii and NOT( (outdate is not null) and (outdate<sysdate) ));
iv i2cursor%ROWTYPE;

RETVAL VARCHAR2(55);
BEGIN
IF (TABLEEXISTS(TID)=1) THEN
    OPEN i2cursor;
    FETCH i2cursor INTO iv;
    IF (i2cursor%FOUND =TRUE ) THEN 
    RETVAL:=iv.KID;
    ELSE
   RETVAL:= 0;
    END IF;
ELSE RETVAL:=-1;
END IF;    

RETURN RETVAL;
    
END;
/
create or replace function CALCULATEBILL(TID IN VARCHAR2,
PID IN VARCHAR2)
return NUMBER
AS
TIDVAR varchar2(55):=TID;PIDVAR VARCHAR2(55):=PID;
cursor cursor1 is SELECT * FROM KRATHSH WHERE (PID=PIDVAR AND TID=TIDVAR)AND (OUTDATE IS NULL) ;
iv cursor1%ROWTYPE;
cursor sum1 is SELECT sum (AMENITIES.AMENCOST)FROM AMENITIES,PROVIDES WHERE PROVIDES.TID=100 AND AMENITIES.AMENTYPE=PROVIDES.AMENTYPE;
cursor sum2 is SELECT sum (KATHGORIES.PRICE)FROM TRAPEZI,KATHGORIES WHERE
TRAPEZI.TID=100 AND KATHGORIES.CAT=TRAPEZI.CAT;sum12 number;sum22 number;

BEGIN
sum12:=0;sum22:=0;
OPEN sum1;FETCH sum1 INTO sum12;CLOSE sum1;
OPEN sum2;FETCH sum2 INTO sum22;CLOSE sum2;
RETVAL:=sum12+sum22;
RETURN RETVAL;
END;
/
create or replace function CLIENTMONEYPAIDYEAR(PID IN VARCHAR2, YEAR IN NUMBER)
return NUMBER
AS
ii varchar2(55):=PID;yy number:=YEAR;
cursor cursor1 is SELECT sum(BILL) FROM KRATHSH WHERE PID=ii AND extract(YEAR FROM indate)=yy;
retval number;
BEGIN
OPEN cursor1;FETCH cursor1 INTO retval;CLOSE cursor1;
RETURN retval;
END;
/

-- =====================================================
-- 7. Create PROCEDURES
-- =====================================================
create or replace procedure BOOKTABLE(kid IN VARCHAR2,PID IN VARCHAR2,
TID IN VARCHAR2,INDATE IN DATE)
IS
BEGIN
INSERT INTO KRATHSH(KID,PID,TID,INDATE,OUTDATE,RESERVATIONNO,BILL)
VALUES (KID,PID,TID,INDATE,NULL,CUSTSEQ.NEXTVAL,NULL);
END;
/
create or replace procedure ADDPHONE(PID IN VARCHAR2,PHONES IN VARCHAR2)
IS
ii varchar2(55):=pid;
nomorethan2 EXCEPTION;iii integer;
cursor i is select count(*)from phone where pid=ii ;
BEGIN
open i; fetch i into iii;
if (iii<2)
then
INSERT INTO PHONE(PID,PHONES)
VALUES (PID,PHONES);
else 
raise nomorethan2; END IF;
EXCEPTION WHEN nomorethan2 then 
RAISE_APPLICATION_ERROR(-20000, 'already have 2 phones registered');
close i;
END;
/
create or replace procedure ADDTABLESCATEGORY(CAT IN VARCHAR2,
TABLECOUNT IN NUMBER,
FLOOR IN NUMBER,
AREA IN NUMBER,
TID IN VARCHAR2)
is
i integer:=0;
ii varchar2(30);
BEGIN
ii:=TID;
while i<tablecount loop
INSERT INTO TRAPEZI(TID,CAT,FLOOR,AREA,TIMESRESERVED)
VALUES (ii,CAT,FLOOR,AREA,NULL);
i:=i+1;
ii:=ii+1;
end loop;
END;
/
create or replace procedure TABLEREMOVE(TID IN VARCHAR2)
IS
i varchar2(55);
BEGIN
i:=TID;
delete from KRATHSH WHERE TID=i;
delete from provides WHERE TID=i;
DELETE FROM TRAPEZI WHERE TID=i;
END;
/

-- =====================================================
-- 8. Create TRIGGERS
-- =====================================================
create or replace trigger UPPERPELATISTRIGGER
before INSERT or UPDATE on PELATIS
FOR EACH ROW
BEGIN
:NEW.PID := UPPER( :NEW.PID );
:NEW.LNAME := UPPER( :NEW.LNAME );
:NEW.ARTAYT := UPPER( :NEW.ARTAYT );
:NEW.FNAME := UPPER( :NEW.FNAME );
END;
/
create or replace trigger UPPERAMENITIESTRIGGER
before INSERT or UPDATE on AMENITIES
FOR EACH ROW
BEGIN
:NEW.AMENTYPE := UPPER( :NEW.AMENTYPE );
END;
/
create or replace trigger FUTURETIMETRIGGER
before INSERT or UPDATE on KRATHSH
FOR EACH ROW
DECLARE
FUTURETIMEEXCEPTION EXCEPTION;
BEGIN
IF :NEW.INDATE<=CURRENT_DATE THEN
RAISE FUTURETIMEEXCEPTION;
END IF;
EXCEPTION 
WHEN FUTURETIMEEXCEPTION THEN RAISE_APPLICATION_ERROR(-20003,'Please Input Future Date');
END;
/
create or replace trigger DENYKRATHSHTRIGGER
before INSERT or UPDATE on KRATHSH
FOR EACH ROW
DECLARE
WINTERMONTH EXCEPTION;
BEGIN
IF (EXTRACT(MONTH FROM :NEW.INDATE)) = 12 OR (EXTRACT(MONTH FROM :NEW.INDATE)) = 1 OR (EXTRACT(MONTH FROM :NEW.INDATE)) = 3 THEN
RAISE WINTERMONTH;
END IF;
EXCEPTION 
WHEN WINTERMONTH THEN RAISE_APPLICATION_ERROR(-20003,'Cannot Make a Reservation during Winter');
END;
/
create or replace trigger TABLEBOOKTIMESTRIGGER
before INSERT OR DELETE on KRATHSH
FOR EACH ROW
BEGIN
IF INSERTING THEN 
UPDATE TRAPEZI SET TIMESRESERVED=TIMESRESERVED+1 WHERE
TID= :NEW.TID;
END IF;
IF DELETING THEN
UPDATE TRAPEZI SET TIMESRESERVED=TIMESRESERVED-1 WHERE TID=
:OLD.TID;
END IF;
END;
/
create or replace trigger CATEGORYTABLESCOUNTTRIGGER
before INSERT OR DELETE on TRAPEZI
FOR EACH ROW
DECLARE
CATNOTHERE EXCEPTION;CURSOR cursor1 is (SELECT * FROM KATHGORIES WHERE :NEW.CAT=CAT);
cursorfetch cursor1%rowtype;
BEGIN
open cursor1;fetch cursor1 into cursorfetch;
IF cursor1%FOUND=TRUE THEN CLOSE cursor1;
IF INSERTING THEN 
UPDATE KATHGORIES SET TABLECOUNT=TABLECOUNT+1 WHERE
CAT= :NEW.CAT;
END IF;
IF DELETING THEN
UPDATE KATHGORIES SET TABLECOUNT=TABLECOUNT-1 WHERE CAT=
:OLD.CAT;
END IF;
ELSE RAISE CATNOTHERE;
END IF;
EXCEPTION
WHEN CATNOTHERE THEN 
RAISE_APPLICATION_ERROR(-20003,'CATEGORY DOES NOT EXIST');
END;
/
create or replace trigger RESERVATIONBILLTRIGGER
BEFORE insert OR UPDATE on KRATHSH
FOR EACH ROW
DECLARE
BEGIN
SELECT CALCULATEBILL(:NEW.TID,:NEW.PID) into :NEW.BILL FROM DUAL;
DBMS_OUTPUT.put_line('SUCCESS');
end;
/

-- =====================================================
-- 9. Create INDEXES
-- =====================================================
create index index1 ON KRATHSH(reservationno,kid,outdate,bill,tid,pid);
create INDEX index2 on PELATIS(PID,LNAME,FNAME);
create INDEX index3 on TRAPEZI(TID,FLOOR);

-- =====================================================
-- 10. INSERT data
-- =====================================================
insert into PELATIS VALUES('1','ALEXANDROU','ALEXANDROS',TO_DATE('15/05/26','DD/MM/YY'),'A1');
insert into PELATIS VALUES('2','PAPADOPOULOU','MARIA',TO_DATE('20/03/26','DD/MM/YY'),'B2');
insert into PELATIS VALUES('3','KONSTANTINOU','GIANNIS',TO_DATE('10/06/26','DD/MM/YY'),'C3');
insert into PELATIS VALUES('4','GEORGIOU','EKATERINI',TO_DATE('01/04/26','DD/MM/YY'),'D4');
insert into PELATIS VALUES('5','PETROU','NIKOLAOS',TO_DATE('25/07/26','DD/MM/YY'),'E5');
insert into PELATIS VALUES('6','TSIPOURA','SOPHIA',TO_DATE('12/08/26','DD/MM/YY'),'F6');
insert into PELATIS VALUES('7','VOULGARIS','DIMITRIOS',TO_DATE('30/09/26','DD/MM/YY'),'G7');
insert into PELATIS VALUES('8','PANAGIOTOU','ELENI',TO_DATE('18/10/26','DD/MM/YY'),'H8');
insert into PELATIS VALUES('9','MIHALOPOULOU','CHRISTOS',TO_DATE('22/11/26','DD/MM/YY'),'I9');
insert into PELATIS VALUES('10','FRANGOULIS','ANNA',TO_DATE('08/05/26','DD/MM/YY'),'J10');
insert into PELATIS VALUES('11','SKARAMAGA','STAVROS',TO_DATE('14/06/26','DD/MM/YY'),'K11');
insert into PELATIS VALUES('12','XENODOCHIDOU','ZOE',TO_DATE('03/07/26','DD/MM/YY'),'L12');

insert into PHONE VALUES('1','2310111111');
insert into PHONE VALUES('1','2310111112');
insert into PHONE VALUES('2','2310222222');
insert into PHONE VALUES('3','2310333333');
insert into PHONE VALUES('4','2310444444');
insert into PHONE VALUES('5','2310555555');
insert into PHONE VALUES('6','2310666666');
insert into PHONE VALUES('7','2310777777');
insert into PHONE VALUES('8','2310888888');
insert into PHONE VALUES('9','2310999999');
insert into PHONE VALUES('10','2310101010');
insert into PHONE VALUES('11','2310121212');
insert into PHONE VALUES('12','2310131313');

insert into KATHGORIES VALUES('STOUGA',15,0);
insert into KATHGORIES VALUES('MEZES',10,0);
insert into KATHGORIES VALUES('PIROTA',12,0);
insert into KATHGORIES VALUES('GIASTRIA',18,0);
insert into KATHGORIES VALUES('GESVENTES',8,0);
insert into KATHGORIES VALUES('NEROKA',25,0);
insert into KATHGORIES VALUES('GLAFASTRA',20,0);

insert into TRAPEZI VALUES('100',1,'15.5',0,'STOUGA');
insert into TRAPEZI VALUES('101',1,'15.5',0,'STOUGA');
insert into TRAPEZI VALUES('102',1,'15.5',0,'STOUGA');
insert into TRAPEZI VALUES('103',1,'10.0',0,'MEZES');
insert into TRAPEZI VALUES('104',1,'10.0',0,'MEZES');
insert into TRAPEZI VALUES('105',2,'20.0',0,'PIROTA');
insert into TRAPEZI VALUES('106',2,'20.0',0,'PIROTA');
insert into TRAPEZI VALUES('107',2,'20.0',0,'PIROTA');
insert into TRAPEZI VALUES('108',2,'18.0',0,'GIASTRIA');
insert into TRAPEZI VALUES('109',2,'18.0',0,'GIASTRIA');
insert into TRAPEZI VALUES('200',3,'25.0',0,'NEROKA');
insert into TRAPEZI VALUES('201',3,'25.0',0,'NEROKA');
insert into TRAPEZI VALUES('202',3,'30.0',0,'GLAFASTRA');
insert into TRAPEZI VALUES('203',3,'30.0',0,'GLAFASTRA');
insert into TRAPEZI VALUES('204',3,'30.0',0,'GLAFASTRA');
insert into TRAPEZI VALUES('205',4,'12.0',0,'GESVENTES');
insert into TRAPEZI VALUES('206',4,'12.0',0,'GESVENTES');
insert into TRAPEZI VALUES('207',4,'12.0',0,'GESVENTES');

insert into AMENITIES VALUES('WIFI',2);
insert into AMENITIES VALUES('CHARGE',1);
insert into AMENITIES VALUES('PROJECTOR',5);
insert into AMENITIES VALUES('SOUNDBAR',3);

insert into provides VALUES('WIFI','100');
insert into provides VALUES('WIFI','101');
insert into provides VALUES('WIFI','102');
insert into provides VALUES('WIFI','103');
insert into provides VALUES('WIFI','104');
insert into provides VALUES('WIFI','105');
insert into provides VALUES('WIFI','106');
insert into provides VALUES('WIFI','107');
insert into provides VALUES('WIFI','108');
insert into provides VALUES('WIFI','109');
insert into provides VALUES('WIFI','200');
insert into provides VALUES('WIFI','201');
insert into provides VALUES('WIFI','202');
insert into provides VALUES('WIFI','203');
insert into provides VALUES('WIFI','204');
insert into provides VALUES('WIFI','205');
insert into provides VALUES('WIFI','206');
insert into provides VALUES('WIFI','207');
insert into provides VALUES('CHARGE','100');
insert into provides VALUES('CHARGE','101');
insert into provides VALUES('CHARGE','103');
insert into provides VALUES('CHARGE','105');
insert into provides VALUES('CHARGE','107');
insert into provides VALUES('CHARGE','108');
insert into provides VALUES('CHARGE','200');
insert into provides VALUES('CHARGE','202');
insert into provides VALUES('CHARGE','204');
insert into provides VALUES('PROJECTOR','202');
insert into provides VALUES('PROJECTOR','203');
insert into provides VALUES('SOUNDBAR','200');
insert into provides VALUES('SOUNDBAR','201');

insert into KRATHSH VALUES('1','05/10/26 19:30:00','05/10/26 22:00:00',0,'1','100');
insert into KRATHSH VALUES('2','05/10/26 20:00:00',NULL,0,'2','101');
insert into KRATHSH VALUES('3','06/10/26 18:00:00','06/10/26 21:30:00',0,'3','103');
insert into KRATHSH VALUES('4','06/10/26 19:00:00',NULL,0,'4','105');
insert into KRATHSH VALUES('5','07/10/26 12:30:00',NULL,0,'5','108');
insert into KRATHSH VALUES('6','07/10/26 13:00:00','07/10/26 15:00:00',0,'6','106');
insert into KRATHSH VALUES('7','08/10/26 20:00:00','08/10/26 23:00:00',0,'7','200');
insert into KRATHSH VALUES('8','08/10/26 20:30:00',NULL,0,'8','202');
insert into KRATHSH VALUES('9','09/10/26 19:00:00',NULL,0,'9','203');
insert into KRATHSH VALUES('10','09/10/26 19:30:00','09/10/26 22:30:00',0,'10','109');
insert into KRATHSH VALUES('11','10/10/26 18:30:00',NULL,0,'1','202');
insert into KRATHSH VALUES('12','10/10/26 19:00:00','10/10/26 21:00:00',0,'2','104');
insert into KRATHSH VALUES('13','11/10/26 20:00:00',NULL,0,'3','102');
insert into KRATHSH VALUES('14','11/10/26 20:30:00','11/10/26 23:30:00',0,'4','107');
insert into KRATHSH VALUES('15','12/10/26 13:00:00',NULL,0,'5','204');
insert into KRATHSH VALUES('16','12/10/26 19:00:00',NULL,0,'6','100');
insert into KRATHSH VALUES('17','13/10/26 12:00:00','13/10/26 14:30:00',0,'7','103');
insert into KRATHSH VALUES('18','13/10/26 19:30:00',NULL,0,'8','200');
insert into KRATHSH VALUES('19','14/10/26 20:00:00','14/10/26 22:30:00',0,'9','105');
insert into KRATHSH VALUES('20','15/10/26 13:00:00',NULL,0,'10','109');
insert into KRATHSH VALUES('21','15/10/26 19:00:00',NULL,0,'1','203');
insert into KRATHSH VALUES('22','16/10/26 12:30:00','16/10/26 15:00:00',0,'2','201');
insert into KRATHSH VALUES('23','16/10/26 20:00:00',NULL,0,'3','101');
insert into KRATHSH VALUES('24','17/10/26 19:30:00',NULL,0,'4','204');
insert into KRATHSH VALUES('25','18/10/26 13:00:00','18/10/26 16:00:00',0,'5','106');
insert into KRATHSH VALUES('26','18/10/26 20:00:00',NULL,0,'6','107');
insert into KRATHSH VALUES('27','19/10/26 12:00:00',NULL,0,'7','102');
insert into KRATHSH VALUES('28','19/10/26 19:00:00','19/10/26 22:00:00',0,'8','104');
insert into KRATHSH VALUES('29','20/10/26 20:30:00',NULL,0,'9','202');
insert into KRATHSH VALUES('30','21/10/26 13:00:00',NULL,0,'10','200');
CREATE VIEW VIEW1 AS SELECT *FROM KRATHSH WHERE BILL>20;
CREATE VIEW VIEW2 AS SELECT 
TRAPEZI.FLOOR,PELATIS.LNAME,PELATIS.FNAME,KRATHSH.BILL,reservationno
FROM TRAPEZI,KRATHSH,PELATIS;
CREATE VIEW VIEW3 AS SELECT PROVIDES.AMENTYPE,AMENITIES.AMENCOST,
PROVIDES.TID,KRATHSH.KID,KRATHSH.PID,PELATIS.LNAME,PELATIS.FNAME 
FROM AMENITIES,PROVIDES,KRATHSH,PELATIS;
