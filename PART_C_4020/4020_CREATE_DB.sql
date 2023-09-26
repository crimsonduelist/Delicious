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