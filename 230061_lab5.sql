create database Lab4_Q1
use Lab4_Q1;

CREATE TABLE DEPT(
DEPTNO INT NOT NULL,
 DNAME CHAR(14),
 LOC CHAR(13),
 CONSTRAINT DEPT_PRIMARY_KEY PRIMARY KEY (DEPTNO));

INSERT INTO DEPT VALUES (10,'ACCOUNTING','NEW YORK');
INSERT INTO DEPT VALUES (20,'RESEARCH','DALLAS');
INSERT INTO DEPT VALUES (30,'SALES','CHICAGO');
INSERT INTO DEPT VALUES (40,'OPERATIONS','BOSTON');


CREATE TABLE employee(
EMPNO INT NOT NULL,
ENAME CHAR(10),
JOB CHAR(9),
MGR INT,
HIREDATE DATE,
SAL INT,
COMM INT,
DEPTNO INT NOT NULL,
CONSTRAINT EMP_FOREIGN_KEY FOREIGN KEY (DEPTNO) REFERENCES DEPT (DEPTNO),
CONSTRAINT EMP_PRIMARY_KEY PRIMARY KEY (EMPNO));



INSERT INTO employee VALUES (7839, 'KING', 'PRESIDENT', NULL, '1981-11-17', 5000, NULL, 10),
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
(7934, 'MILLER', 'CLERK', 7782, '1982-01-23', 1300, NULL, 10);


select *
from employee
where SAL =  (select max(SAL) from employee);

select *
from employee
where deptno = (select deptno from dept where dname  = 'SALES');

select count(*) as No_Of_EMP
from employee
where deptno = (select deptno from dept where dname  = 'SALES');

select* 
from employee
where SAL > all (select SAL from employee where deptno = 30);

select* 
from employee
where SAL > (select min(SAL) from employee where deptno = 30);

select *
from dept
where deptno not in (select deptno from employee group by (deptno));

select * 
from employee as em
where sal > (select avg(sal)  from employee where em.deptno = deptno);

create database lab4_Q2;
use lab4_Q2;

create table bbc(name CHAR(20) primary key , 
region CHAR(20), 
area BIGINT, 
population BIGINT, 
gdp BIGINT
);


insert into bbc values('Afghanistan', 'South Asia', 652225, 26000000, null);
insert into bbc values('Albania', 'Europe', 28728, 3200000, 6656000000);
insert into bbc values('Algeria', 'Middle East', 2400000, 32900000, 75012000000);
insert into bbc values('Andorra', 'Europe', 468, 64000, null);
insert into bbc values('Bangladesh', 'South Asia', 143998, 152600000, 67144000000);
insert into bbc values('United Kingdom', 'Europe', 242514, 59600000, 2022824000000);


-- 10. Show the name, region and population of the smallest country in each region.
select name, region, population
from bbc as b
where area = (select min(area) from bbc where b.region = region );

-- Show the countries with a greater GDP then any country in Europe.
select *
from bbc
where gdp > any (select gdp from bbc where region = 'Europe' );

-- Show the countries with population smaller than United Kingdom but bigger than Albania.
select *
from bbc
where population > (select population from bbc where name = 'Albania') and population < (select population from bbc where name = 'United Kingdom') 





