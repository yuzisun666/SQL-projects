-- Provide your student ID number after two dashes on the next line:
-- 3748 6382 42

--Q1
select shipperID, CompanyName
from Shippers;


--Q2
select FirstName, LastName, HireDate
from Employees
where Title in ('Sales Representative','Inside Sales Coordinator');

--Q3
select FirstName, LastName, Country
from Employees
where Country != 'USA'
order by LastName;


--Q4
select FirstName, LastName, HireDate
from Employees
where HireDate < 'Jan 1, 1994'
order by HireDate desc;
--the newest hire is Steven and Michael


--Q5
select *
from orders
where ShipCity = 'Madrid' and OrderDate between '1996-01-01' and '1996-12-31';


--Q6
select ProductID, ProductName
from Products
where (ProductName ilike '%queso%') and UnitPrice > 30;


--Q7
select OrderID, CustomerID, ShipCountry
from orders
where ShipCountry in ('Brazil','Mexico','Argentina','Venezuela')
order by Freight desc
limit 10;


--Q8
select CompanyName, ContactTitle, City, Country
from Customers
where Country in ('Mexico','Brazil','Spain') and City != 'Madrid';


--Q9
select *
from Products
where Discontinued = 1 and UnitsInStock>0
order by UnitPrice desc;


--Q10
select UnitPrice*Quantity*(1-Discount) totalvalue, OrderID, ProductID, UnitPrice, Quantity, Discount
from OrderDetails
order by totalvalue desc
limit 1;
--order id 10981 has the highest total value after the discount





