begin
BOOKTABLE('105','13','100',TO_DATE('19/02/19 19:00:00','DD/MM/YY HH24:MI:SS'));
end;
/
begin
ADDPHONE('13',2310751783);
end;
/
begin
addtablescategory('dithesio',3,1,5,'103');
end;
/
begin
tableremove('105');
end;
/
DECLARE
RETVAL number;
begin
--SELECT TABLEEXISTS('13') into RETVAL FROM DUAL;
SELECT TABLEEXISTS('100') into RETVAL FROM DUAL;
dbms_output.put_line(RETVAL);
end;
/
DECLARE
RETVAL VARCHAR2(55);
begin
SELECT TABLERESERVED('100') into RETVAL FROM DUAL;
--SELECT TABLERESERVED('101') into RETVAL FROM DUAL;
dbms_output.put_line(RETVAL);
end;
/
DECLARE
RETVAL VARCHAR2(55);
begin
SELECT CALCULATEBILL('100',13) into RETVAL FROM DUAL;
--SELECT TABLERESERVED('101',13) into RETVAL FROM DUAL;
dbms_output.put_line(RETVAL);
end;
/
DECLARE
RETVAL VARCHAR2(55);
begin
SELECT CLIENTMONEYPAIDYEAR('100',2019) into RETVAL FROM DUAL;

dbms_output.put_line(RETVAL);
end;
/
DECLARE
begin
insert into PELATIS VALUES
('133','NIKOU','NIKOS',TO_DATE('19/02/19','DD-MM-YY'),'2T3AT');
end;
/
DECLARE
begin
insert into AMENITIES VALUES('VIP',2);
end;
/
DECLARE
begin
insert into KRATHSH VALUES('102',TO_DATE('19/9/20 19:00:00','DD/MM/YY HH24:MI:SS')
,NULL,'2','13','100',CUSTSEQ.nextval);

end;
/
DECLARE
begin
insert into KRATHSH VALUES('102',TO_DATE('19/12/20 19:00:00','DD/MM/YY HH24:MI:SS')
,NULL,'2','13','100',CUSTSEQ.nextval);
--insert into KRATHSH VALUES('102',TO_DATE('19/9/20 19:00:00','DD/MM/YY HH24:MI:SS')
--,NULL,'2','13','100',CUSTSEQ.nextval);
end;
/
DECLARE
begin
insert into KRATHSH VALUES('175',TO_DATE('19/12/20 19:00:00','DD/MM/YY HH24:MI:SS')
,NULL,'2','13','100',CUSTSEQ.nextval);
--DELETE FROM KRATHSH WHERE KID =175;

end;
/
DECLARE
begin
insert into TRAPEZI VALUES('103','4','25','3','dithesio');


end;
/
DECLARE
begin
insert into TRAPEZI VALUES('103','4','25','3','dithesio');
--insert into TRAPEZI VALUES('103','4','25','3','dithesio');

end;
/
DECLARE
begin
insert into KRATHSH VALUES('175',TO_DATE('19/12/20 19:00:00','DD/MM/YY HH24:MI:SS')
,NULL,'2','13','100',CUSTSEQ.nextval);

end;
/