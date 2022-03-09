create database CRM;
use CRM;
drop table customer if exists ;
create table customer ( 
Cust_ID varchar(5)  , 
Cust_Name varchar(30) not null ,
Age tinyInt not null check (Age >= 18),
Gender enum('Male','Female','Others') not null ,
Email varchar(40) unique ,
Mobile char(10) unique ,
Address varchar(250) not null ,
Purchase_Date DATE not null,
Primary Key(Cust_ID,Purchase_Date) );

create index c_cust on customer (Cust_Name) ;
create index c_cust1 on customer (Address) ;
create index c_cust2 on customer (Purchase_Date) ;
create index c_cust3 on customer (Cust_ID)
;
create table item (
Item_ID varchar(5) ,
Item_Name varchar(30) not null ,
Item_Price int not null ,
Item_Qty smallInt not null ,
Cust_Id varchar(5) not null ,
Employee_ID varchar(5) not null,
Primary key (Item_ID),
foreign key (Cust_Id) references customer (Cust_ID),
foreign key (Employee_ID) references employee (Employee_ID) ,
Sold_date DATE not null, 
foreign key (Sold_date) references customer (Purchase_Date)
);

create table employee (
Employee_ID varchar(5) Primary Key ,
Employee_Name varchar(30) not null ,
Employee_Desig enum('GM','Manager','Asst.Manager','Sales','Trainee','Cust_Exc') not null,
Gender enum('Male','Female','Others') not null ,
Email varchar(40) unique 
) ;
create index e_employee on employee (Employee_Desig) ;

create table showroom (
Showroom_ID varchar(5) primary Key ,
Location enum('Delhi','Mumbai','Faridabad','Jaipur','Gurugram') not null,
Inventory_Name varchar(20) not null unique ,
Inventory_Qty int not null ,
Employee_ID varchar(5) ,foreign key (Employee_ID) references employee (Employee_ID) ,
No_Visitors int not null ) ;

create index s_showroom on showroom (Location) ;
create index s_showroom1 on showroom (Inventory_Name) ;
create index s_showroom2 on showroom (Inventory_Qty) ;

create table service_center (
Center_ID varchar(5) primary key ,
Date_Delivery DATE not null ,
Issue varchar(500) not null ,
Issue_date DATE not null ,
Repair_Cost int not null ,Item_ID varchar(5) ,
Cust_ID varchar(5)  ,
Showroom_ID varchar(5) ,
foreign key (Item_ID)references item (Item_ID),foreign key (Cust_ID)references customer (Cust_ID),foreign key (Showroom_ID) references showroom (Showroom_ID )) ;

create index s_center on service_center (Date_Delivery) ;
create index s_center1 on service_center (Issue) ;
create index s_center2 on service_center (Issue_date) ;

create table customer_care (
Customer_ID varchar(5) ,
Employee_ID varchar(5), 
Date_Complaint DATE not null ,
Issue varchar(500) not null ,
Customer_feedback enum('1','2','3','4','5') not null,
foreign key (Customer_ID) references customer (Cust_ID) ,
foreign key (Employee_ID) references employee (Employee_ID)
) ;
create index c_care on customer_care(Issue) ;
create index c_care1 on customer_care (Date_Complaint) ;
create index c_care2 on customer_care (Customer_feedback) ;


create table rel_customer_Item (
Cust_ID varchar(5) not null ,
Item_ID varchar(5) not null ,
Showroom_ID varchar(5) not null ,
Purchase_Date DATE not null,
Issue varchar(500) not null,
Primary Key (Cust_ID , Item_ID , Purchase_Date ),
Foreign key (Cust_ID,Purchase_Date) references customer (Cust_ID, Purchase_Date) ,
Foreign Key (Item_ID) references item (Item_ID) ,
Foreign key (Showroom_ID) references showroom (Showroom_ID) ,
Foreign key (Issue) references customer_care (Issue) ) ;

create table rel_customer_service_center (
Cust_ID varchar(5) not null ,
Center_ID varchar(5) not null ,
Item_ID varchar(5) not null ,
Showroom_ID varchar(5) not null ,
Issue varchar(500) not null ,
Issue_Date DATE not null ,
Date_Delivery DATE not null,
Primary Key (Cust_ID, Item_ID, Issue_Date) ,
Foreign Key (Cust_ID) references customer (Cust_ID) ,
Foreign Key (Center_ID) references service_center (Center_ID) ,
Foreign Key (Item_ID) references item (Item_ID) ,
Foreign Key (Showroom_ID) references showroom (Showroom_ID) ,
Foreign Key (Issue) references service_center (Issue),
Foreign Key (Issue_Date) references service_center (Issue_Date)  ,
Foreign Key (Date_Delivery) references service_center (Date_Delivery) 
); 

create table rel_employee_showroom (
Employee_ID varchar(5) not null ,
Showroom_ID varchar(5) not null ,
Employee_Desig enum('GM','Manager','Asst.Manager','Sales','Trainee','Cust_Exc') not null ,
Location enum('Delhi','Mumbai','Faridabad','Jaipur','Gurugram') not null,
Primary Key (Employee_ID, Employee_Desig) ,
Foreign Key (Employee_ID) references employee (Employee_ID) ,
Foreign Key (Employee_Desig) references employee (Employee_Desig),
Foreign Key (Showroom_ID) references showroom (Showroom_ID),
Foreign Key (Location) references showroom (Location) 
);
create table rel_item_showroom (
Showroom_ID varchar(5) , 
Item_ID varchar(5),
Location enum('Delhi','Mumbai','Faridabad','Jaipur','Gurugram') not null,
Inventory_Name varchar(20) not null unique,
Sold_Date DATE not null, 
Primary Key (Item_ID,Location,Sold_Date) ,
Foreign Key (Showroom_ID) references showroom (Showroom_ID) ,
Foreign Key (Location) references showroom (Location),
Foreign Key (Inventory_Name) references showroom (Inventory_Name),
Foreign Key (Sold_Date) references customer (Purchase_Date) 
);


create table rel_customer_ccare ( 
Cust_ID varchar(5) not null ,
Cust_Name varchar(30) not null ,
Address varchar(250),
Employee_ID varchar(5) not null,
Issue varchar(500) not null ,
Date_Complaint DATE ,
Primary Key (Cust_ID) ,
Foreign Key (Cust_ID) references customer (Cust_ID) ,
Foreign Key (Cust_Name) references customer (Cust_Name) ,
Foreign Key (Address) references customer (Address),
Foreign Key (Employee_ID) references employee (Employee_ID) ,
Foreign Key (Issue) references customer_care (Issue),
Foreign Key (Date_Complaint) references customer_care (Date_Complaint)
); 

 
CREATE USER 'anand'@'localhost' IDENTIFIED BY 'anand' ;
CREATE USER 'arora'@'localhost' IDENTIFIED BY 'arora' ;
CREATE USER 'sharma'@'localhost' IDENTIFIED BY 'sharma' ;
CREATE USER 'raj'@'localhost' IDENTIFIED BY 'raj' ;
CREATE USER 'kumar'@'localhost' IDENTIFIED BY 'kumar' ;

GRANT select  ON  item  TO  'anand'@'localhost'  ;
GRANT select, update  ON customer  TO 'arora'@'localhost' ;
GRANT select, update  ON item  TO 'arora'@'localhost' ;
GRANT update  ON customer_care  TO 'arora'@'localhost' ;
GRANT create, drop, select ON  *.* TO 'sharma'@'localhost' with grant option ;
GRANT select, insert, update  ON customer_care  TO 'raj'@'localhost' ;
GRANT select, insert, update  ON service_center  TO 'raj'@'localhost' ;
GRANT select, insert, update  ON service_center  TO 'kumar'@'localhost' ;




