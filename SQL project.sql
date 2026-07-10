CREATE DATABASE OnlineShopping;
USE OnlineShopping;

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    email VARCHAR(50),
    city VARCHAR(30)
);


CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    category VARCHAR(30),
    price DECIMAL(10,2)
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE Order_Details (
    order_detail_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

INSERT INTO Customers VALUES
(1, 'Raju', 'raju@gmail.com', 'Hyderabad'),
(2, 'Anjali', 'anjali@gmail.com', 'Bangalore'),
(3, 'Suresh', 'suresh@gmail.com', 'Chennai'),
(4, 'Priya', 'priya@gmail.com', 'Hyderabad'),
(5, 'Amit', 'amit@gmail.com', 'Delhi');

INSERT INTO Products VALUES
(101, 'Laptop', 'Electronics', 55000),
(102, 'Mobile', 'Electronics', 25000),
(103, 'Headphones', 'Accessories', 3000),
(104, 'Keyboard', 'Accessories', 1500),
(105, 'Smart Watch', 'Electronics', 12000);

INSERT INTO Orders VALUES
(1001, 1, '2025-01-05'),
(1002, 2, '2025-01-10'),
(1003, 3, '2025-01-15'),
(1004, 1, '2025-02-02'),
(1005, 4, '2025-02-10'),
(1006, 5, '2025-02-15');

INSERT INTO Order_Details VALUES
(1, 1001, 101, 1),   -- Laptop
(2, 1001, 103, 2),   -- Headphones

(3, 1002, 102, 1),   -- Mobile
(4, 1002, 104, 1),   -- Keyboard

(5, 1003, 105, 1),   -- Smart Watch

(6, 1004, 102, 2),   -- Mobile
(7, 1004, 103, 1),   -- Headphones

(8, 1005, 101, 1),   -- Laptop

(9, 1006, 104, 2),   -- Keyboard
(10, 1006, 103, 1);  -- Headphones

SELECT * FROM Customers;
SELECT * FROM Products;
SELECT * FROM Orders;
SELECT * FROM Order_Details;

select * from Customers 
where customer_id=1

 /* 1. Display all Customers*/
 select * from Customers
 /* 2.Display all Products*/
 select * from Products

 /* Customers from Hyderabad*/

 select * from Customers
 where city='Hyderabad';

 /* products cost more than 10000*/

 select * from Products
 where price>10000;

 /* product between 2000 and 30000*/

 select * from products
 where price between 2000 and 30000;

 /* electronic products*/

 select * from products
 where category='Electronics';

 /* display unique categories*/

 select distinct category
 from products;

 /* sort products by price (high to low)*/

 select * from products 
 order by price desc;

 /* sort products by price (low to high)*/

 select * from products
 order by price asc;

 /* customer names starting with 'R'*/

 select * from Customers
 where customer_name like 'R%';

 /* products names ends with 'e*/

 select * from products
 where product_name like '%e';

 /* Total number of products*/

 select count(*) as total_products
 from Products;

 /* total number of customers*/
 
 select count(*) as total_customers
 from Customers;

 /* avg product price*/

 select avg(price) as avg_price
 from Products;

 /* Max product price*/

 select max(price) as max_price
 from products;

 /* min product price*/

 select min(price) as min_price
 from Products;

 /* total value of all products*/

 select sum(price) as total_price
 from products;

 /* number of customer in each city*/
  select city,count(*) as total_customers
  from customers
  group by city;

  /* number of products in each category*/

  select category,count(*) as total_products
  from products
  group by category;

  /* cities having more than one customer*/

  select city,count(*) as total_customers
  from Customers
  group by city
  having count(*)>1;

  /* customer names with their orders*/

  select c.customer_name,
  o.order_id,o.order_date
  from Customers c
  join orders o 
  on c.customer_id=o.customer_id;

  /* products names in each order*/

  select o.order_id,p.product_name,od.quantity
  from Order_Details od
  join Orders o
  on od.order_id=o.order_id
  join Products p on od.product_id=p.product_id;

  /* customer order and product details*/

  select c.customer_name,o.order_id,p.product_name,od.quantity
  from Customers c join Orders o on c.customer_id=o.customer_id
  join Order_Details od
  on o.order_id=od.order_id
  join products p
  on od.order_id=p.product_id;

  /* total amount of each order*/

  select o.order_id,
  sum(p.price*od.quantity)as total_amount
  from orders o join Order_Details od
  on o.order_id=od.order_id
  join Products p
  on od.product_id=p.product_id
  group by o.order_id;

  /* total spending of each customer*/

  select c.customer_name,
  sum(p.price*od.quantity) as total_spending
  from Customers c join Orders o
  on c.customer_id=o.customer_id
  join Order_Details od
  on o.order_id=od.order_id
  join Products p
  on od.product_id=p.product_id
  group by c.customer_name;

  /* best selling product */

  select p.product_name,
  sum(od.quantity) as quantity_sold
  from Products p join Order_Details od
  on p.product_id=od.product_id
  group by p.product_name
  order by quantity_sold desc;

  /* number of orders placed by each customer*/

  select c.customer_name,
  count(o.order_id) as total_orders
  from Customers c join Orders o
  on c.customer_id=o.customer_id
  group by c.customer_name;