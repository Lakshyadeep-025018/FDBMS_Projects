create table if not exists FORM (
PNR_No int(10) , 
Passenger1_Name varchar(50) not null , 
Passenegr2_Name varchar(50) ,
Passenegr3_Name varchar(50) ,
Passenegr4_Name varchar(50) ,
Passenegr5_Name varchar(50) ,
Passenegr6_Name varchar(50) ,
Gender enum('Female','Male','Other') ,
Age int ,
DOJ DATE,
Mobile_No char(10) unique ,
Adhar_No char (12) unique not null ,
From_St varchar(50) not null ,
To_St varchar(50) not null ,
primary key (PNR_No , DOJ ) 
);

create index Form3 on FORM (PNR_No);
create index Form4 on FORM (DOJ);
create index Form1 on FORM (From_St);
create index Form2 on FORM (To_St);



create table if not exists TRAIN (
Train_No int (5) ,
Train_Name varchar(50) not null ,
Arrival_Time Time ,
Dept_Time Time ,
No_of_Seats int ,
Date_1 Date not null,
Class enum('General','Sleeper','3A','2A','1A') not null,
Primary Key (Train_No, Date_1) );

create index t_train on TRAIN (Train_No) ;
create index t_train4 on TRAIN (Train_Name) ;
create index t_train1 on TRAIN (Date_1) ;
create index t_train2 on TRAIN (Arrival_Time) ;
create index t_train3 on TRAIN (Dept_Time) ;

create table if not exists STATION(
ST_No int(5),
ST_Name varchar(50) ,
No_Plt int(10),
Primary Key (ST_No)
) ;

create index St1 on STATION (ST_No) ;
create index St2 on STATION (ST_Name) ;


Create table if not exists Rel_FORM_TRAIN (
Train_No int(5),
Train_Name varchar(50) not null ,
PNR_No int(10),
DOJ Date,
Arrival_Time Time ,
Dept_Time Time ,
From_St varchar(50) not null ,
To_St varchar(50) not null,
Primary key (Train_No,Train_Name, PNR_No,DOJ),
Constraint Foreign Key (Train_No) references TRAIN (Train_No) ,
Constraint Foreign Key (DOJ) references FORM (DOJ) ,
Constraint Foreign Key (Train_Name) references TRAIN (Train_Name) ,
Constraint Foreign Key (PNR_No) references FORM (PNR_No) ,
Constraint Foreign Key (Arrival_Time) references TRAIN (Arrival_Time),
Constraint Foreign Key (Dept_Time) references TRAIN (Dept_Time),
Constraint Foreign Key (From_St) references FORM (From_St),
Constraint Foreign Key (To_St) references FORM (To_St) ) ;

Create table if not exists Rel_Train_Station (
Train_No int (5) ,
Train_Name varchar(50) not null,
ST_No int(5),
ST_Name varchar(50),
Primary Key (Train_No,ST_No,ST_Name),
Constraint Foreign Key (Train_No) references TRAIN (Train_No) ,
Constraint Foreign Key (Train_Name) references TRAIN (Train_Name) ,
Constraint Foreign Key (ST_No) references STATION (ST_No) ,
Constraint Foreign Key (ST_Name) references STATION (ST_Name) );

Create table if not exists Rel_FORM_STATION (
PNR_No int(10) ,
ST_No int(5),
ST_Name varchar(50),
Primary key (PNR_No,ST_No) ,
Constraint Foreign Key (PNR_No) references FORM (PNR_No) ,
Constraint Foreign Key (ST_No) references STATION (ST_No) ,
Constraint Foreign Key (ST_Name) references STATION (ST_Name) ) ;

Create table if not exists TICKET (
Train_No int(5),
DOJ DATE,
Class enum('General','Sleeper','3A','2A','1A') not null,
Seat_No tinyint,
PNR_No int(5) ,
Primary Key (Train_no,DOJ,Class,Seat_No,PNR_No) ,
Constraint Foreign Key (Train_No) references TRAIN (Train_No) ,
Constraint Foreign Key (DOJ) references FORM (DOJ) ,
Constraint Foreign Key (PNR_No) references FORM (PNR_No) );


CREATE USER 'anand'@'localhost' IDENTIFIED BY 'anand' ;
CREATE USER 'arora'@'localhost' IDENTIFIED BY 'arora' ;
CREATE USER 'sharma'@'localhost' IDENTIFIED BY 'sharma' ;

GRANT  select  ON  FORM TO  'anand'@'localhost'  ;
GRANT  select, insert, delete, update  ON TRAIN TO 'arora'@'localhost' ;
GRANT  select, insert, delete, update  ON STATION TO 'arora'@'localhost' ;
GRANT create, drop, select ON  *.* TO 'sharma'@'localhost' with grant option ;























  









