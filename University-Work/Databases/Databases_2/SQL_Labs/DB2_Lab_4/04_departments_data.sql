/****************************************/
/* DB2-VT22-L4-departments     			*/
/* Senast ändrad: 2022-01-26 			*/
/****************************************/

create table departments (
	id 			int primary key auto_increment,
	department 	varchar(50),
	manager 	int
);

insert into departments (department, manager) values 
('Accounting', 333),
('Business Development', 56),
('Support', 111),
('Training', 295),
('Design', 328),
('Human Resources', 33),
('Services', 204),
('Sales', 307),
('Research', 293),
('Legal', 385),
('Product Management', 415),
('Engineering', 377),