create database lab6_Q1;
use lab6_Q1;
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

select e.ename , d.dname
from employee as e
join dept as d
on e.deptno = d.deptno;

select count(*) , d.dname
from employee as e
join dept as d
on e.deptno = d.deptno
group by (e.deptno);

select count(*) , d.dname
from employee as e
join dept as d
on e.deptno = d.deptno
group by (e.deptno)
having d.dname = 'sales';

select count(*) as no_of_employees , d.dname
from employee as e
join dept as d
on e.deptno = d.deptno
group by (e.deptno)
having no_of_employees >= 5
order by  d.dname ASC;

select sum(e.sal) as total_Salary , d.dname
from employee as e
join dept as d
on e.deptno = d.deptno
group by (e.deptno);

select e.*, d.dname
from employee as e
right join dept as d 
on e.deptno = d.deptno;

select e.ename, d.ename as mgr_name
from employee as e
left join employee as d 
on e.mgr = d.empno;

select e.ename, e.sal as esal, d.ename as mgr_name, d.sal as mgr_sal 
from employee as e
join employee as d 
on e.mgr = d.empno and e.sal > d.sal;

select d.ename, count(*) as no_of_emp 
from employee as e
join employee as d
on e.mgr = d.empno
group by(e.mgr)
;


create database lab6_Q2;
use lab6_Q2;
CREATE TABLE VENDOR ( 
    V_CODE      INT PRIMARY KEY, 
    V_NAME      VARCHAR(35) NOT NULL, 
    V_CONTACT   VARCHAR(15) NOT NULL, 
    V_AREACODE  VARCHAR(3) NOT NULL, 
    V_PHONE     VARCHAR(8) NOT NULL, 
    V_STATE     VARCHAR(2) NOT NULL, 
    V_ORDER     CHAR(1) NOT NULL
);

CREATE TABLE PRODUCT (
    P_CODE      VARCHAR(10) PRIMARY KEY,
    P_DESCRIPT  VARCHAR(35) NOT NULL,
    P_INDATE    DATE NOT NULL,
    P_ONHAND    INT NOT NULL,
    P_MIN       INT NOT NULL,
    P_PRICE     DECIMAL(8,2) NOT NULL,
    P_DISCOUNT  DECIMAL(4,2) NOT NULL,
    V_CODE      INT,
    FOREIGN KEY (V_CODE) REFERENCES VENDOR(V_CODE)
);

CREATE TABLE CUSTOMER (
    CUS_CODE    INT PRIMARY KEY,
    CUS_LNAME   VARCHAR(15) NOT NULL,
    CUS_FNAME   VARCHAR(15) NOT NULL,
    CUS_INITIAL CHAR(1),
    CUS_AREACODE VARCHAR(3) NOT NULL DEFAULT '615' CHECK (CUS_AREACODE IN ('615','713','931')),
    CUS_PHONE   VARCHAR(8) NOT NULL,
    CUS_BALANCE DECIMAL(9,2) DEFAULT 0.00,
    UNIQUE(CUS_LNAME, CUS_FNAME)
);

CREATE TABLE INVOICE (
    INV_INT     INT PRIMARY KEY,
    CUS_CODE    INT NOT NULL,
    INV_DATE    DATE NOT NULL,
    INV_SUBTOTAL DECIMAL(9,2),
    INV_TAX     DECIMAL(9,2),
    INV_TOTAL   DECIMAL(9,2),
    FOREIGN KEY (CUS_CODE) REFERENCES CUSTOMER(CUS_CODE)
);

CREATE TABLE LINE (
    INV_INT     INT NOT NULL,
    LINE_INT    DECIMAL(2,0) NOT NULL,
    P_CODE      VARCHAR(10) NOT NULL,
    LINE_UNITS  DECIMAL(9,2) NOT NULL DEFAULT 0.00,
    LINE_PRICE  DECIMAL(9,2) NOT NULL DEFAULT 0.00,
    LINE_TOTAL  DECIMAL(9,2),
    PRIMARY KEY (INV_INT, LINE_INT),
    FOREIGN KEY (INV_INT) REFERENCES INVOICE(INV_INT) ON DELETE CASCADE,
    FOREIGN KEY (P_CODE) REFERENCES PRODUCT(P_CODE),
    UNIQUE(INV_INT, P_CODE)
);

-- Insert Data into VENDOR
INSERT INTO VENDOR VALUES
(21225,'Bryson, Inc.','Smithson','615','223-3234','TN','Y'),
(21226,'SuperLoo, Inc.','Flushing','904','215-8995','FL','N'),
(21231,'D&E Supply','Singh','615','228-3245','TN','Y'),
(21344,'Gomez Bros.','Ortega','615','889-2546','KY','N'),
(22567,'Dome Supply','Smith','901','678-1419','GA','N'),
(23119,'Randsets Ltd.','Anderson','901','678-3998','GA','Y'),
(24004,'Brackman Bros.','Browning','615','228-1410','TN','N'),
(24288,'ORDVA, Inc.','Hakford','615','898-1234','TN','Y'),
(25443,'B&K, Inc.','Smith','904','227-0093','FL','N'),
(25501,'Damal Supplies','Smythe','615','890-3529','TN','N'),
(25595,'Rubicon Systems','Orton','904','456-0092','FL','Y');

-- Insert Data into PRODUCT
INSERT INTO PRODUCT VALUES
('11QER/31','Power painter, 15 psi., 3-nozzle','2003-11-03',8,5,109.99,0.00,25595),
('13-Q2/P2','7.25-in. pwr. saw blade','2003-12-13',32,15,14.99,0.05,21344),
('14-Q1/L3','9.00-in. pwr. saw blade','2003-11-13',18,12,17.49,0.00,21344),
('1546-QQ2','Hrd. cloth, 1/4-in., 2x50','2004-01-15',15,8,39.95,0.00,23119),
('1558-QW1','Hrd. cloth, 1/2-in., 3x50','2004-01-15',23,5,43.99,0.00,23119),
('2232/QTY','B&D jigsaw, 12-in. blade','2003-12-30',8,5,109.92,0.05,24288),
('2232/QWE','B&D jigsaw, 8-in. blade','2003-12-24',6,5,99.87,0.05,24288),
('2238/QPD','B&D cordless drill, 1/2-in.','2004-01-20',12,5,38.95,0.05,25595),
('23109-HB','Claw hammer','2004-01-20',23,10,9.95,0.10,21225),
('23114-AA','Sledge hammer, 12 lb.','2004-01-02',8,5,14.40,0.05,NULL),
('54778-2T','Rat-tail file, 1/8-in. fine','2003-12-15',43,20,4.99,0.00,21344),
('89-WRE-Q','Hicut chain saw, 16 in.','2004-02-07',11,5,256.99,0.05,24288),
('PVC23DRT','PVC pipe, 3.5-in., 8-ft','2004-02-20',188,75,5.87,0.00,NULL),
('SM-18277','1.25-in. metal screw, 25','2004-03-01',172,75,6.99,0.00,21225),
('SW-23116','2.5-in. wd. screw, 50','2004-02-24',237,100,8.45,0.00,21231),
('WR3/TT3','Steel matting, 4x8x1/6, .5 mesh','2004-01-17',18,5,119.95,0.10,25595);

-- Insert Data into CUSTOMER
INSERT INTO CUSTOMER VALUES
(10010,'Ramas','Alfred','A','615','844-2573',0),
(10011,'Dunne','Leona','K','713','894-1238',0),
(10012,'Smith','Kathy','W','615','894-2285',345.86),
(10013,'Olowski','Paul','F','615','894-2180',536.75),
(10014,'Orlando','Myron',NULL,'615','222-1672',0),
(10015,'O''Brian','Amy','B','713','442-3381',0),
(10016,'Brown','James','G','615','297-1228',221.19),
(10017,'Williams','George',NULL,'615','290-2556',768.93),
(10018,'Farriss','Anne','G','713','382-7185',216.55),
(10019,'Smith','Olette','K','615','297-3809',0);

-- Insert Data into INVOICE
INSERT INTO INVOICE VALUES
(1001,10014,'2004-01-16',24.90,1.99,26.89),
(1002,10011,'2004-01-16',9.98,0.80,10.78),
(1003,10012,'2004-01-16',153.85,12.31,166.16),
(1004,10011,'2004-01-17',34.97,2.80,37.77),
(1005,10018,'2004-01-17',70.44,5.64,76.08),
(1006,10014,'2004-01-17',397.83,31.83,429.66),
(1007,10015,'2004-01-17',34.97,2.80,37.77),
(1008,10011,'2004-01-17',399.15,31.93,431.08);

-- Insert Data into LINE
INSERT INTO LINE VALUES 
(1001,1,'13-Q2/P2',1,  14.99,  14.99),
(1001,2,'23109-HB',1,   9.95,   9.95),
(1002,1,'54778-2T',2,   4.99,   9.98),
(1003,1,'2238/QPD',1,  38.95,  38.95),
(1003,2,'1546-QQ2',1,  39.95,  39.95),
(1003,3,'13-Q2/P2',5,  14.99,  74.95),
(1004,1,'54778-2T',3,   4.99,  14.97),
(1004,2,'23109-HB',2,   9.95,  19.90),
(1005,1,'PVC23DRT',12,  5.87,  70.44),
(1006,1,'SM-18277',3,   6.99,  20.97),
(1006,2,'2232/QTY',1, 109.92, 109.92),
(1006,3,'23109-HB',1,   9.95,   9.95),
(1006,4,'89-WRE-Q',1, 256.99, 256.99),
(1007,1,'13-Q2/P2',2,  14.99,  29.98),
(1007,2,'54778-2T',1,   4.99,   4.99),
(1008,1,'PVC23DRT',5,   5.87,  29.35),
(1008,2,'WR3/TT3' ,3, 119.95, 359.85),
(1008,3,'23109-HB',1,   9.95,   9.95);

select c.cus_lname, i.inv_int, i.inv_date, p.p_descript
from customer as c
join invoice as i
on c.cus_code = i.cus_code
join line as l
on l.inv_int = i.inv_int 
join product as p
on p.p_code = l.p_code

;

select  p.p_descript, i.inv_int, i.inv_date

from invoice as i

join line as l
on l.inv_int = i.inv_int 
join product as p
on p.p_code = l.p_code

;



