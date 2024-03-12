create database ecommerce;
use ecommerce;
-- Customers table
create table Customers(
customer_id int primary key,
FirstName varchar(255),
LastName varchar(255),
Email varchar(255),
Address varchar(255)
);
-- Products table
create table Products(
ProductId int primary key,
Name varchar(255),
Description text,
Price decimal(10,2),
StockQuantity int 
);
-- Cart table
create table Cart(
CartId int primary key,
customer_id int,
ProductId int,
Quantity int,
foreign key (customer_id) references Customers(customer_id),
foreign key (ProductId) references Products(ProductId)
);
-- Orders table
create table Orders(
OrderId int primary key,
customer_id int,
OrderDate date,
TotalPrice decimal(10,2),
foreign key (customer_id) references Customers(customer_id)
);
-- Orders Item table
create table OrdersItems(
OrderItem int primary key,
OrderId int,
ProductId int,
Quantity int,
ItemAmount decimal(10,2),
foreign key (OrderId) references Orders(OrderId),
foreign key (ProductId) references Products(ProductId)
);

-- Data Insertion
insert into Customers values
(1,'John','Doe','johndoe@example.com','123 Main St,City'),
(2,'Jane','Smith','janesmith@example.com','456 Elm St, Town'),
(3,'Robert','Johnson','robert@example.com','789 Oak St, Village'),
(4,'Sarah','Brown','sarah@example.com','101 Pine St, Suburb'),
(5,'David','Lee','david@example.com','234 Cedar St, District'),
(6,'Laura','Hall','laura@example.com','567 Birch St, County'),
(7,'Michael','Davis','michael@example.com','890 Maple St, State'),
(8,'Emma','Wilson','emma@example.com','321 Redwood St, Country'),
(9,'William','Taylor','william@example.com','432 Spruce St, Province'),
(10,'Olivia','Adams','olivia@example.com','765 Fir St, Territory');

insert into Products values 
(1,'Laptop','High-Performance Laptop',800.00,10),
(2,'Samrtphone','Latest Smartphone',600.00,15),
(3,'Tablet','Portable Tablet',300.00,20),
(4,'Headphones','Noise-Cancelling',150.00,30),
(5,'TV','4K Smart TV',900.00,5),
(6,'Coffee Maker','Automatic Coffee Maker',50.00,25),
(7,'Refridgerator','Energy-Efficient',700.00,10),
(8,'Microwave Oven','Countertop Microwave',80.00,15),
(9,'Blender','High-Speed Blender',70.00,20),
(10,'Vacuum Cleaner','Bagless Vacuum Cleaner',120.00,10);

insert into Cart values
(1,1,1,2),
(2,1,3,1),
(3,2,2,3),
(4,3,4,4),
(5,3,5,2),
(6,4,6,1),
(7,5,1,1),
(8,6,10,2),
(9,6,9,3),
(10,7,7,2);

insert into Orders values
(1,1,'2023-01-05',1200.00),
(2,2,'2023-02-10',900.00),
(3,3,'2023-03-15',300.00),
(4,4,'2023-04-20',150.00),
(5,5,'2023-05-25',1800.00),
(6,6,'2023-06-30',400.00),
(7,7,'2023-07-05',700.00),
(8,8,'2023-08-10',160.00),
(9,9,'2023-09-15',140.00),
(10,10,'2023-10-20',1400.00);

insert into OrdersItems values
(1,1,1,2,1600.00),
(2,1,3,1,300.00),
(3,2,2,3,1800.00),
(4,3,5,2,1800.00),
(5,4,4,4,600.00),
(6,4,6,1,50.00),
(7,5,1,1,800.00),
(8,5,2,2,1200.00),
(9,6,10,2,240.00),
(10,6,9,3,210.00);

-- 1. Query to update refrigerator product price to 800
update Products set Price=800 where ProductId=7;

-- 2. Query to remove all cart items for a specific customer
delete from Cart where customer_id=7;

-- 3. Query to retrieve Products Priced Below $100
select * from Products where Price<800.00;

-- 4. Query to find Products with Stock Quantity Greater Than 5
select * from Products where StockQuantity>5;

-- 5. Query to retrieve Orders with Total Amount Between $500 and $1000
select * from Orders where TotalPrice between 500 and 1000;

-- 6. Query to find Products which name end with letter ‘r’ 
select * from Products where Name like '%r';

-- 7. Query to Retrieve Cart Items for Customer 5
select * from Cart where customer_id=5;

-- 8. Query to find Customers Who Placed Orders in 2023 
select * from Orders where year(OrderDate)='2023';

-- 9. Query to determine the Minimum Stock Quantity for Each Product Category 
select ProductId,Name,min(StockQuantity) as MinimumStockQuantity from Products
group by ProductId, Name;

-- 10. Query to calculate the Total Amount Spent by Each Customer 
select c.customer_id,c.FirstName,c.LastName,sum(oi.ItemAmount) as TotalAmount from Customers c
inner join Orders o on c.customer_id=o.customer_id
inner join OrdersItems oi on o.OrderId=oi.OrderId
group by c.customer_id,c.FirstName,c.LastName;

-- 11. Query to find the Average Order Amount for Each Customer
select c.customer_id,c.FirstName,c.LastName,avg(oi.ItemAmount) as AverageAmountSpent from Customers c
inner join Orders o on c.customer_id=o.customer_id
inner join OrdersItems oi on o.OrderId=oi.OrderId
group by c.customer_id,c.FirstName,c.LastName;

-- 12. Query to Count the Number of Orders Placed by Each Customer
select c.customer_id,c.FirstName,c.LastName,count(o.OrderId) as TotalOrder from Customers c
inner join Orders o on c.customer_id=o.customer_id
group by c.customer_id,c.FirstName,c.LastName;

-- 13. Query to find the Maximum Order Amount for Each Customer
select c.customer_id,c.FirstName,c.LastName,max(oi.ItemAmount) as MaxAmountSpent from Customers c
inner join Orders o on c.customer_id=o.customer_id
inner join OrdersItems oi on o.OrderId=oi.OrderId
group by c.customer_id,c.FirstName,c.LastName;

-- 14. Query to get Customers Who Placed Orders Totaling Over $1000
select c.customer_id,c.FirstName,c.LastName,sum(oi.ItemAmount) as TotalAmountSpent from Customers c
inner join Orders o on c.customer_id=o.customer_id
inner join OrdersItems oi on o.OrderId=oi.OrderId
group by c.customer_id,c.FirstName,c.LastName
having sum(oi.ItemAmount)>1000;

-- 15. Subquery to Find Products Not in the Cart
select * from Products where ProductId not in(select ProductId from Cart);

-- 16. Subquery to Find Customers Who Haven't Placed Orders
select * from customers where customer_id not in(select distinct customer_id from Orders);

-- 17. Subquery to Calculate the Percentage of Total Revenue for a Product
select p.ProductId,p.Name,p.Price,sum(oi.Quantity) as TotalQuantitySold,sum(oi.ItemAmount) as TotalRevenue,
(sum(oi.ItemAmount) / (select sum(ItemAmount) from OrdersItems)) * 100 as PercentageOfTotalRevenue
from Products p left join OrdersItems oi on p.ProductId = oi.ProductId
group by p.ProductId, p.Name, p.Price;

-- 18. Subquery to Find Products with Low Stock.
select * from Products where StockQuantity<(select avg(stockquantity) from products);

-- 19. Subquery to Find Customers Who Placed High-Value Orders
select customer_id,FirstName,LastName,TotalAmountSpent from (select c.customer_id,c.FirstName,c.LastName,sum(oi.ItemAmount) as TotalAmountSpent
from Customers c inner join Orders o on c.customer_id=o.customer_id
inner join OrdersItems oi on o.OrderId=oi.OrderId
group by c.customer_id,c.FirstName,c.LastName) as subquery 
where TotalAmountSpent>1000;