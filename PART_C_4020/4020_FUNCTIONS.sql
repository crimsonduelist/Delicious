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
    --CLOSE i2cursor;
    --for iv in i2cursor loop
    --RETVAL:=RETVAL+RETVAL||'  '||iv.KID;
     RETVAL:=iv.KID;
    --end loop;
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
/* FROM
        ( 
            (SELECT sum (AMENITIES.AMENCOST)FROM AMENITIES,PROVIDES WHERE
PROVIDES.TID=100 AND AMENITIES.AMENTYPE=PROVIDES.AMENTYPE)
            UNION ALL
            (SELECT sum (KATHGORIES.PRICE)FROM TRAPEZI,KATHGORIES WHERE
TRAPEZI.TID=100 AND KATHGORIES.CAT=TRAPEZI.CAT)
        ) ;cursorresults cursor2%ROWTYPE;*/
RETVAL NUMBER;
BEGIN
open cursor1;fetch cursor1 into iv;
IF (cursor1%FOUND=true) THEN
   open sum1;fetch sum1 into sum12;open sum2;fetch sum2 into sum22;
   RETVAL:=sum12+sum22;close sum1;close sum2;
ELSE
RETVAL:=-1;
END IF;

RETURN RETVAL;

END;

CREATE OR REPLACE FUNCTION CLIENTMONEYPAIDYEAR (TID IN VARCHAR2,YEARINPUT IN integer)
RETURN NUMBER
AS
TIDVAR varchar2(55):=TID;
cursor datec is select SUM(BILL) FROM KRATHSH WHERE (YEARINPUT IN (select EXTRACT(YEAR FROM INDATE)FROM KRATHSH))AND (OUTDATE IS NOT NULL) AND TID=TIDVAR;
RETVAL NUMBER;
BEGIN
OPEN datec;fetch datec into RETVAL;

RETURN RETVAL;close datec;
END;
/