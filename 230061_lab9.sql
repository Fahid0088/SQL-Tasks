-- Create Employees Table
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(100)
);

-- Insert Sample Employees
INSERT INTO Employees (EmployeeID, EmployeeName) VALUES
(1, 'Alice Johnson'),
(2, 'Bob Smith');

-- Create Orders Table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    EmployeeID INT,
    OrderDate DATE,
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

-- Insert Sample Orders
INSERT INTO Orders (OrderID, EmployeeID, OrderDate) VALUES
(101, 1, '2024-04-01'),
(102, 1, '2024-04-02'),
(103, 2, '2024-04-03');

-- Create OrderDetails Table
CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY AUTO_INCREMENT,
    OrderID INT,
    ProductName VARCHAR(100),
    UnitPrice DECIMAL(10,2),
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Insert Sample Order Details
INSERT INTO OrderDetails (OrderID, ProductName, UnitPrice, Quantity) VALUES
(101, 'Laptop', 1000.00, 2),
(101, 'Mouse', 50.00, 3),
(102, 'Keyboard', 75.00, 1),
(102, 'Monitor', 200.00, 2),
(103, 'Headphones', 150.00, 4);

-- 1- Create a stored procedure that accepts an employee ID as input parameter, and returns a result
-- set of all the orders made by that employee, including the order ID, order date, and total order
-- amount.

Delimiter $$
	create procedure store( in EID int , out var3 DECIMAL(10,2))
    Begin 
		select od.OrderID, o.OrderDate
        from OrderDetails as od
        natural join orders as o;
        
        select sum(od.quantity * od.UnitPrice) into var3
        from OrderDetails as od
        natural join orders as o
        group by o.EmployeeID
        having o.EmployeeID = EID;
			
    end $$
    
Delimiter ;
drop procedure store;
call store (1, @var1);
select @var1;


-- Suppose you want to calculate the total revenue for a given order. You can create a function
-- that takes an order ID as input, calculates the total revenue for that order by multiplying the
-- unit price of each product by the quantity ordered, and returns the result.

Delimiter $$
	
	create function func1(  OID int )
    returns DECIMAL(10,2)
    deterministic 
    Begin 
		declare var1 DECIMAL(10,2);
		select sum(quantity * UnitPrice) into var1
        from OrderDetails
        where OrderID = OID
        group by OrderID;
		
        return var1;
    end $$

Delimiter ;
drop function func1; 
select func1(102);


-- Define a function called square that accepts an integer as input parameter, calculates the square
-- of the integer, and returns the result

Delimiter $$
	
	create function Square(  num int )
    returns int
    deterministic 
    Begin 
		declare var1 int;
		set var1 = num*num;
        return var1;
    end $$

Delimiter ;
drop function func1; 
select Square(5);

-- 4- Define a stored procedure called print_squares that uses a WHILE loop to loop through the
-- integers 1 to 10, calling the square function for each integer and printing the result to the
-- console.

Delimiter $$
	create procedure print_squares( )
    Begin 
		declare x int default 1;
        while x <= 11 do
			select square (x);
            set x = x+1;
        end while;
        
			
    end $$
    
Delimiter ;

call print_squares;
