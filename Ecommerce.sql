use EcommerceDB
select * from customers

select * from dbo.orders

select * from dbo.products


-- Q1- Retrieve all orders that occurred in 2023. 

select *
from orders
where year(order_date) = 2023


-- Q2- Retrieve all orders with status = 'Delivered'.

select *
from orders
where order_status = 'Delivered'

-- Q3- Retrieve all customers who live in Cairo.

select * 
from customers
where city = 'Cairo'


-- Q4- Retrieve all products with price greater than 5000.

select *
from products
where price > 5000


--Q5- Retrieve all orders where the discount is greater than 10%. 

select *
from orders
where discount > 10



--Q6- Count the total number of orders.

select COUNT(*) Total_Orders
from orders


--Q7- Calculate the total quantity of products sold.

select SUM(quantity) total_quantity_sold
from orders



--Q8- Calculate the average product price.

select AVG(price) Avg_Price
from products


--Q9- Count the number of orders for each order status (Delivered, Cancelled, Pending). 

select order_status, count(*) Orders_Count
from orders
group by order_status


--Q10- Count the number of customers in each city. 

select city, count(*) Customer_Count
from customers
group by city


--Q11- Retrieve each order along with the customer name who made it. 

select o.order_id, c.customer_name
from orders o
join customers c
on o.customer_id = c.customer_id


--Q12-  Retrieve each product along with the total quantity sold. 

select p.product_name, sum(o.quantity) Total_Quantity
from orders o
join products p
on o.product_id = p.product_id
group by p.product_name




--Q13- Calculate total sales for each product (price × quantity × (1 - discount/100))

select p.product_name, SUM(p.price * o.quantity * (1-o.discount/100)) Total_Sales
from orders o
join products p
on o.product_id = p.product_id
group by p.product_name


--Q14- Find the top 5 customers based on total spending. 

select top(5) c.customer_name, SUM(p.price * o.quantity * (1-o.discount/100)) Total_Sales
from orders o
join products p
on o.product_id = p.product_id
join customers c
on o.customer_id = c.customer_id
group by c.customer_name
order by Total_Sales desc



--Q15- Retrieve customers who made more than 3 orders.

select c.customer_name, COUNT(*) orders_count
from orders o
join customers c
on o.customer_id = c.customer_id
group by c.customer_name
having(COUNT(*) > 3)



--Q16-  Find the total sales for each city.

select c.city, SUM(p.price * o.quantity * (1-o.discount/100)) Total_Sales
from orders o
join products p
on o.product_id = p.product_id
join customers c
on o.customer_id = c.customer_id
group by c.city


-- Formatting the final output and putting a "," separator after each 3 numbers

select c.city, format(SUM(p.price * o.quantity * (1-o.discount/100)) ,'N0')
from orders o
join products p
on o.product_id = p.product_id
join customers c
on o.customer_id = c.customer_id
group by c.city

--Q17-  Find the most sold product (by quantity). 

select top(1) p.product_name, sum(o.quantity) Total_Quantity
from orders o
join products p
on o.product_id = p.product_id
group by p.product_name
order by Total_Quantity desc




--Q18-  Calculate the total revenue generated for each payment method.

select o.payment_method, SUM(p.price * o.quantity * (1-o.discount/100)) Total_Sales
from orders o
join products p
on o.product_id = p.product_id
group by o.payment_method



--Q19- Find the monthly total sales trend.

select datename(MONTH, o.order_date) as Month_Name, SUM(p.price * o.quantity * (1-o.discount/100)) Total_Sales
from orders o
join products p
on o.product_id = p.product_id
group by datename(MONTH, o.order_date)



--Q20- Identify high-value customers who: made more than 3 orders and spent more than 20000 

select c.customer_name, COUNT(*) orders_count, SUM(p.price * o.quantity * (1-o.discount/100)) Total_Sales
from orders o
join products p
on o.product_id = p.product_id
join customers c
on o.customer_id = c.customer_id
group by c.customer_name
having(COUNT(*) > 3) and SUM(p.price * o.quantity * (1-o.discount/100)) > 20000



select p.category, SUM(p.price * o.quantity * (1-o.discount/100)) Total_Sales
from orders o
join products p
on o.product_id = p.product_id
group by p.category


select * 
from orders
where discount > 0