create database Interloop
use Interloop

create table Employee
(
Employee_Id nchar(7) primary key,
First_Name varchar(25) not NUll,
Last_Name varchar(25) not Null,
Branch nchar(5) not Null,
Age numeric(2,0) not Null,
NIC nchar(15) not Null,
Scale numeric(1,0) not Null,
Salary int not Null,
Joining_Date date not Null,
Overtime float
)

INSERT INTO Employee
VALUES
('i219012','Umer','Farooq','CS',21,'12345-6789345-7',3,5000,'2001-12-15',12.00 ),
('i200424','Ahmed','Sarwer','SE',21,'12345-6789274-1',3,6000,'2000-12-16',6.00 ),
('i200356','Chaudry','Shakeeb','BBA',21,'12345-6789236-3',2,7500,'2015-01-09',3.00 ),
('i219032','Osama','Khan','ENG',21,'12345-7892312-3',1,6500,'2000-12-04',12.00 ),
('i201012','Umer','Sheikh','MCE',22,'12346-7892378-9',5,5500,'2007-06-07',5.00 ),
('i201112','Ali','Hamza','SE',22,'34202-3279862-7',8,9500,'2020-12-05',7.00 ),
('i130389','Mehdi','Shah','SE',28,'12346-3789143-3',1,8550,'2003-10-04',8.00 ),
('i200127','Usama','Rehman','CVL',27,'12345-6789123-9',7,10500,'2005-11-16',7.00 ),
('i138069','Pablo','Escobar','EE',25,'12345-6791238-1',9,80000,'2006-07-08',11.00 ),
('i168060','Talha','Haider','CVL',25,'12345-6891325-7',7,65000,'2008-08-09',4.00 ),
('i219345','Ali','Ahmed','EE',26,'12345-6781231-5',5,9000,'2004-10-26',8.00 ),
('i181234','Muhammad','Tahir','BBA',22,'12345-6789123-3',1,67000,'2007-05-05',6.00 ),
('i143241','Amna','Ali','CS',28,'12345-6789315-8',8,6500,'2005-09-09',9.00 ),
('i211234','Hiba','Akhtar','SE',20,'12345-6789159-6',7,75000,'2011-04-17',8.00 ),
('i201113','Meesha','Shafi','CS',27,'12345-8915412-6',7,65005,'2008-02-07',5.00 ),
('i211123','Muhammad','Ahmed','CS',28,'12345-6781445-1',6,8500,'2015-01-01',5.00 ),
('i170345','Muhammad','Arman','EE',24,'12345-8975363-1',9,7500,'2014-03-04',6.00 ),
('i200426','Esha','Ahmed','SE',24,'12345-6789222-2',4,5500,'2008-12-01',9.00 ),
('i201324','Mir','Hamza','ENG',28,'12346-5178977-1',3,3500,'2015-01-01',2.20 ),
('i200786','Ahmed','Yar','ENG',22,'12345-6789756-1',4,66000,'2010-01-04',2.5 );


select  First_Name, Joining_Date, REPLACE (Joining_Date, '2008-08-09' , current_date()) as changed_Date
From employee
where Joining_Date = '2008-08-09';

-- Output max salary grouped by branch.

select branch , max(Salary) as Max_Salary
from employee
group by branch;

-- Output branches whose average salary is greater than 30k.

select branch , avg(Salary) as AVG_GREATER_30K
from employee
group by branch
having avg(Salary) > 30000;

-- Replace last name of any employee to “King”.

select Employee_id, First_Name, Last_name , replace (Last_name, 'Ahmed', 'King') as replaced_Last_Name
from employee
where Last_name = 'Ahmed';

-- Output sum of overtime in each branch.
select branch , sum(Overtime) as SUM_OVERTIME
from employee
group by branch;

-- Output max of overtime in each branch.
select branch , max(Overtime) as Max_OVERTIME
from employee
group by branch;

-- Output min of overtime in each branch.
select branch , min(Overtime) as Min_OVERTIME
from employee
group by branch;

-- Output count of employee who have overtime hours greater than 5.6.

select count(overtime) as COUNT
from employee
where overtime > 5.6;

-- Output all employee who started working at Interloop after “1stJanuary2015”

select *
from employee 
where Joining_Date > '2015-01-01';

-- Output all employee whose name starts with (A or M or E).

select *
from employee 
where First_name like 'A%' or First_name like 'M%' or First_name like 'E%';

-- Output all employee whose name contain a vowel.
select First_name
from employee 
where First_name like '%i%' or First_name like '%a%' or First_name like '%e%' or First_name like '%o%' or First_name like '%u%';

-- Output all employee whose last name length is greater than their first name.

select First_name, Last_Name
from employee
where length(Last_Name) > length(First_name);


-- Output all employee whose names are not in the following list {‘Ahmed’, ‘Tahir’, ‘Hiba’,’Amna’}

select First_name
from employee
where First_name <> 'Ahmed' and First_name <> 'Tahir' and First_name <> 'Hiba' and First_name <> 'Amna' ;

select First_name
from employee
where First_name not in ( 'Ahmed' , 'Tahir' , 'Hiba' , 'Amna') ;

-- Create a view with employee’s personal information. In view, combine the employee’s first & last name.

Create view employee_personal_information
as select * , concat(First_Name, ' ', Last_name) as EName
from employee;

select Ename 
from employee_personal_information;

-- 15) Output standard deviation of overtime hour in each branch.

select branch , std(Overtime) as STD_OVERTIME
from employee
group by branch;

-- Output variance of salary in each branch.
select branch , variance(Overtime) as Var_OVERTIME
from employee
group by branch;

-- Output the number of employee in each branch.
select branch , count(*) as NO_EMP
from employee
group by branch;

-- Output all employee’s whose employee ID starts from ‘i21’.
select * 
from employee
where Employee_Id like 'i21%';

-- Output all employee whose overtime hour is greater than the average (Overtime hour).

create view Avergae as
select AVG (Overtime) as AVG_QUERREY
from employee ;

select *
from Avergae;

Select First_name , Overtime
from employee , Avergae
where employee.overtime > Avergae.avg_querrey;

use interloop;
select * 
from employee
order by salary DESC 
limit 5;

alter table sjgfgj
add constraint fahfh foreign key (col name) references agf(agh)

create view abc
as select salary 
where name = 'Johen'


