-- Task 2: Product Data Analysis

-- a. List all products with their basic information.
SELECT productCode,productName,productLine,productScale,productVendor,quantityInStock,buyPrice,MSRP FROM products;

-- b. List all products with their product lines information.
SELECT p.productCode,p.productName,p.productLine,pl.textDescription AS productLineDescription, p.productScale,p.productVendor,
p.quantityInStock,p.buyPrice,p.MSRP FROM products p
JOIN productlines pl ON p.productLine = pl.productLine;

-- c. Count the number of products in each product line. 
SELECT pl.productLine,pl.textDescription AS productLineDescription,COUNT(p.productCode) AS numberOfProducts FROM productlines pl
LEFT JOIN products p ON pl.productLine = p.productLine GROUP BY pl.productLine, pl.textDescription;

-- d. Find the product line with the highest average product price
SELECT pl.productLine,pl.textDescription AS productLineDescription,COUNT(p.productCode) AS numberOfProducts FROM productlines pl
LEFT JOIN products p ON pl.productLine = p.productLine GROUP BY pl.productLine, pl.textDescription;

-- e. Find all products with a price above or below a certain amount (MSRP should be between 50 and 100)
SELECT productCode, productName, MSRP FROM products WHERE MSRP BETWEEN 50 AND 100;

-- g. Identify products with low inventory levels (less than a specific threshold value 10 of quantityInStock).
SELECT productCode,productName,quantityInStock FROM products WHERE quantityInStock < 10;

-- h. List products along with their descriptions
SELECT p.productCode,p.productName,p.productDescription,pl.textDescription AS productLineDescription FROM products p
JOIN productlines pl ON p.productLine = pl.productLine;

-- i. Retrieve the most expensive product based on MSRP.
SELECT productCode, productName,MSRP FROM products ORDER BY MSRP DESC LIMIT 1;

-- j. Calculate total sales for each product.
SELECT p.productCode,p.productName,SUM(od.quantityOrdered * od.priceEach) AS totalSales FROM products p
JOIN orderdetails od ON p.productCode = od.productCode
JOIN orders o ON od.orderNumber = o.orderNumber
GROUP BY p.productCode, p.productName;

-- k. Identify the best-selling products based on total sales.
SELECT p.productCode, p.productName, SUM(od.quantityOrdered * od.priceEach) AS totalSales FROM products p
JOIN orderdetails od ON p.productCode = od.productCode
JOIN orders o ON od.orderNumber = o.orderNumber
GROUP BY p.productCode, p.productName ORDER BY totalSales DESC;

-- l. Identify the most profitable product line based on total sales.
SELECT pl.productLine, pl.textDescription AS productLineDescription, SUM(od.quantityOrdered * od.priceEach) AS totalSales FROM productlines pl
JOIN products p ON pl.productLine = p.productLine
JOIN orderdetails od ON p.productCode = od.productCode
GROUP BY pl.productLine, pl.textDescription ORDER BY totalSales DESC LIMIT 1;

-- m. Find the best-selling product within each product line.
SELECT products.productCode, products.productName, products.productLine, SUM(orderdetails.quantityOrdered * orderdetails.priceEach) AS totalSalesAmount
from  products JOIN orderdetails ON products.productCode = orderdetails.productCode
GROUP BY productLine, productCode, productName
HAVING totalSalesAmount = ( SELECT SUM(quantityOrdered * priceEach) FROM orderdetails as od
WHERE  od.productCode = products.productCode GROUP BY od.productCode
ORDER BY SUM(od.quantityOrdered * od.priceEach) DESC LIMIT 1);

-- n. Retrieve products with low inventory levels (less than a threshold value 10 of quantityInStock) within specific product lines ('Classic Cars', 'Motorcycles'). 
SELECT productCode,productName,quantityInStock,productLine FROM products WHERE quantityInStock < 10
AND productLine IN ('Classic Cars', 'Motorcycles');

-- o. Find the names of all products that have been ordered by more than 10 customers
SELECT p.productCode, p.productName,COUNT(DISTINCT o.customerNumber) AS numCustomers FROM products p
JOIN orderdetails od ON p.productCode = od.productCode
JOIN orders o ON od.orderNumber = o.orderNumber
GROUP BY p.productCode, p.productName
HAVING COUNT(DISTINCT o.customerNumber) > 10;

-- p. Find the names of all products that have been ordere more than the average number of orders for their product line
Select products.productName, products.productLine, avg(orderdetails.quantityOrdered) as quantity_ordered
from products
join orderdetails on products.productCode = orderdetails.productCode
group by products.productCode, products.productName, products.productLine
having avg(orderdetails.quantityOrdered) >  quantity_ordered;













