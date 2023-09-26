insert into PELATIS VALUES('13','NIKOU','NIKOS',TO_DATE('19/02/19','DD-MM-YY'),'23AT');
insert into PELATIS VALUES('14','PETROU','PETROS',TO_DATE('15/02/19','DD-MM-YY'),'24TA');
insert into PHONE VALUES('13','2310781781');
insert into PHONE VALUES('14','2310771771');
insert into KATHGORIES VALUES('dithesio','0','2');
insert into KATHGORIES VALUES('trithesio','0','3');
insert into TRAPEZI VALUES('100','4','25','3','dithesio');
insert into TRAPEZI VALUES('101','4','25','3','dithesio');
INSERT INTO AMENITIES values('charge','1');
INSERT INTO AMENITIES values('wifi','1');


insert into TRAPEZI VALUES('103','4','25','3','dithesio');
insert into KRATHSH VALUES('100',TO_DATE('19/02/19 19:00:00','DD/MM/YY HH24:MI:SS')
,TO_DATE('19/02/19 20:00:00','DD/MM/YY HH24:MI:SS'),'2','13','100');
insert into KRATHSH VALUES('101',TO_DATE('19/02/19 19:00:00','DD/MM/YY HH24:MI:SS')
,TO_DATE('19/02/19 20:00:00','DD/MM/YY HH24:MI:SS'),'1','14','101');


insert into provides VALUES('charge','101');
insert into provides VALUES('wifi','100');
insert into provides VALUES('charge','100');
