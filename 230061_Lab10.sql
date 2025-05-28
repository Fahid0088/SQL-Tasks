create database lab10;
use lab10;

CREATE TABLE employees (
emp_id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(100),
salary DECIMAL(10,2)
);

CREATE TABLE salary_audit_log (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_id INT,
    old_salary DECIMAL(10 , 2 ),
    new_salary DECIMAL(10 , 2 ),
    change_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO employees (name, salary) VALUES
('Ali Khan', 50000),
('Sarah Ahmed', 70000),
('Hamza Malik', 80000);

drop trigger updateSalary;
delimiter $$
Create trigger updateSalary
before update
On employees for each row
Begin 
if new.salary >= (old.salary / 100 * 50) then 
Insert into salary_audit_log (emp_id, old_salary, new_salary)
Value (old.emp_id, old.salary, new.salary);
end if;
End $$
delimiter ;

update employees
set salary = 26000
where name = 'Ali Khan';

update employees
set salary = 45000
where name = 'Sarah Ahmed';

update employees
set salary = 75000
where name = 'Hamza Malik';
select *
from salary_audit_log;


CREATE TABLE orders (
order_id INT PRIMARY KEY AUTO_INCREMENT,
customer_id INT,
item_name VARCHAR(100),
order_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO orders (customer_id, item_name) VALUES
(1, 'Pizza'),
(2, 'Burger');


drop trigger insertOrder;
delimiter $$
Create trigger insertOrder
before insert
On orders for each row
Begin 

if (select count(*) as count
from orders
where customer_id = new.customer_id and item_name = new.item_name and order_time > now() - interval 1 minute ) != 0 then
SIGNAL SQLSTATE '45000' 
SET MESSAGE_TEXT = 'Already place this order';
end if ;

End $$
delimiter ;

Insert into orders (customer_id, item_name)
Value (5, 'Pizza');

Insert into orders (customer_id, item_name)
Value (7, 'Burger');
select * 
from orders;

CREATE TABLE discount_coupons (
coupon_id INT PRIMARY KEY AUTO_INCREMENT,
code VARCHAR(50) UNIQUE,
discount_percent INT CHECK (discount_percent BETWEEN 1 AND 100),
expiration_date DATE
);

INSERT INTO discount_coupons (code, discount_percent, expiration_date) VALUES
('SAVE10', 10, '2025-03-20'), -- Expired
('BIGSALE', 20, '2025-04-05'), -- Active
('FLASH50', 50, '2025-03-22');

delimiter $$
create event deleteEXP 
on schedule every 1 day 
starts current_date + interval 1 day
do 
begin 
	delete 
    from discount_coupons
    where expiration_date <= current_date();
    
end $$

delimiter ;