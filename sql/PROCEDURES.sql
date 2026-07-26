create or replace procedure BOOKTABLE(kid IN VARCHAR2,PID IN VARCHAR2,
TID IN VARCHAR2,INDATE IN DATE)
IS
BEGIN
INSERT INTO KRATHSH(KID,PID,TID,INDATE,OUTDATE,reservationno,BILL)
VALUES (KID,PID,TID,TO_DATE(INDATE,'DD/MM/YY HH24:MI:SS'),NULL,CUSTSEQ.nextval,NULL);
END;
/
create or replace procedure ADDPHONE(PID IN VARCHAR2,PHONES IN VARCHAR2)
IS
ii varchar2(55):=pid;
nomorethan2 EXCEPTION;iii integer;
cursor i is select count(*)from phone where pid=ii ;
BEGIN
--ii:=pid; 
  open i; fetch i into iii;
if (iii<2)
then
INSERT INTO PHONE(PID,PHONES)
VALUES (PID,PHONES);
else 
raise nomorethan2; END IF;
EXCEPTION WHEN nomorethan2 then 
RAISE_APPLICATION_ERROR(-20000, 'already have 2 phones registered');
CLOSE i;
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
while i<=tablecount loop
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
delete from PROVIDES WHERE TID=i;
DELETE FROM TRAPEZI WHERE TID=i;

END;
/