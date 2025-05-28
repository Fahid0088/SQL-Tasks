create database FastCompany
use Fastcompany

create table DEPT
(DPTNO int not null ,
DNAME varchar(100) not null,
LOC varchar(100) not null,
constraint P_key2 Primary key (DPTNO));

create table EMP
(EMPNO int not null ,
ENAME varchar(100) not null,
JOB varchar(100) not null,
MGR int,
HIREDATE date not null,
SAL int not null,
COMM int ,
DEPTNO int not null,
constraint P_key Primary key (EMPNO),
constraint F_key Foreign key (DEPTNO) references DEPT(DPTNO)
);

create table SALGRADE
(GRADE int not null,
LOSAL int not null,
HISAL int not null,
constraint P_key3 Primary key (GRADE)
);



insert into dept (DPTNO, DNAME, LOC)
values(10, 'Accounting', 'New York'),
(20, 'Research', 'Dallas'),
(30, 'Sales', 'Chicago'),
(40, 'Operations', 'Boston')

insert into salgrade (GRADE, LOSAL, HISAL)
values(1, 700, 1200),
(2, 1201,1400),
(3, 1401,2000),
(4, 2001, 3000),
(5, 3001, 9999)

insert into EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
values 
(7839, 'KING', 'PRESIDENT', NULL, '1981-11-17', 5000, NULL, 10),
(7698, 'BLAKE', 'MANAGER', 7839, '1981-05-01', 2850, NULL, 30),
(7782, 'CLARK', 'MANAGER', 7839, '1981-06-09', 2450, NULL, 10),
(7566, 'JONES', 'MANAGER', 7839, '1981-04-02', 2975, NULL, 20),
(7654, 'MARTIN', 'SALESMAN', 7698, '1981-09-28', 1250, 1400, 30),
(7499, 'ALLEN', 'SALESMAN', 7698, '1981-02-20', 1600, 300, 30),
(7844, 'TURNER', 'SALESMAN', 7698, '1981-09-08', 1500, 0, 30),
(7900, 'JAMES', 'CLERK', 7698, '1981-12-03', 950, NULL, 30),
(7521, 'WARD', 'SALESMAN', 7698, '1981-02-22', 1250, 500, 30),
(7902, 'FORD', 'ANALYST', 7566, '1981-12-03', 3000, NULL, 20),
(7369, 'SMITH', 'CLERK', 7902, '1980-12-17', 800, NULL, 20),
(7788, 'SCOTT', 'ANALYST', 7566, '1982-12-09', 3000, NULL, 20),
(7876, 'ADAMS', 'CLERK', 7788, '1983-01-12', 1100, NULL, 20),
(7934, 'MILLER', 'CLERK', 7782, '1982-01-23', 1300, NULL, 10)


select *
from emp
 
 select *
from dept
 
 select *
from salgrade

select *
from emp
where ENAME = 'James'

select *
from emp
where ENAME Like '__a%'

select *
from emp
where job Like 'sales%'

select *
from emp
where ENAME Like 'a%'

select *
from emp
where DEPTNO in (10,30)


select *
from emp
where COMM is not null and SAL between 1200 and 4700

select *
from emp
where COMM is null

select *
from emp
where EMPNO between 7566 and 7900 and SAL > 3700

select distinct JOB
from emp

--Write a SQL query to display the department ID followed by department name that is holding
--the location Chicago.

select DPTNO, DNAME
from dept
where LOC = 'Chicago'

select *
from dept

--13. Write a SQL query to give the higher-grade salary since 1400.

select *
from salgrade

select HISAL
from salgrade
where HISAL >= 1400


select DEPTNO
from emp
where MGR = 7698 and JOB <> 'clerk'

select *
from emp

--15. Write a SQL query to display all employee names where employee salary is less than 1500 or
--exclude those employee names whose hiring date is on or greater than 2nd April, 81 and
--employee id is below 7566. (DATE - format YYYY-MM-DD)

select ENAME
from emp 
where SAL < 1500 and HIREDATE < '1981-04-02' and EMPNO < 7566

--Write a SQL statement to display all the employee names which are either belongs to the
--unknown community or not had a salary above 1500.

select ENAME
from emp 
where COMM is null or SAL <= 1500

--17. Display the names of Employees who have hiring date 09-June-81.

select ENAME
from emp 
where HIREDATE = '1981-06-09'













