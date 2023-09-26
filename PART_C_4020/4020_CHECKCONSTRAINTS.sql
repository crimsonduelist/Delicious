alter table KATHGORIES ADD (constraint notnegative check ((tablecount >=0)and (price >=0)));
alter table TRAPEZI ADD (constraint notnegative2 check (timesreserved >=0));
alter table KRATHSH ADD (constraint notnegative3 check (bill >=0));
alter table AMENITIES ADD (constraint notnegative4 check (Amencost >=0));
alter table KRATHSH ADD (constraint DATES check ((OUTDATE IS NULL)OR(OUTDATE>INDATE)));