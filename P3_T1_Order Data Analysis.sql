-- Task 1: Order Data Analysis

-- a. List all orders with their basic information
SELECT orderNumber,orderDate,requiredDate,shippedDate,status FROM orders;

-- b. Find all order details for a particular order (order number=12345).
SELECT od.orderNumber,od.productCode,od.quantityOrdered,od.priceEach,od.orderLineNumber,o.orderDate,o.requiredDate,o.shippedDate,o.status
FROM orderdetails od JOIN orders o ON od.orderNumber = o.orderNumber
WHERE od.orderNumber = 12345;

-- c. Find all order details for a particular product (Choose any product of your choice).
SELECT orderNumber,productCode,quantityOrdered,priceEach,orderLineNumber FROM orderdetails WHERE productCode = 'S24_3969';

-- d. Find the total quantity ordered for a particular product (Choose any product of your choice).
SELECT productCode,SUM(quantityOrdered) AS totalQuantityOrdered FROM orderdetails WHERE productCode = 'S18_2248'
GROUP BY productCode;

-- e. Find all orders placed on a particular date (orderDate = '2023-09-28').
SELECT orderNumber, customerNumber,orderDate,requiredDate,shippedDate,status FROM orders WHERE orderDate = '2023-09-28';

-- f. Find all orders placed by a particular customer (Choose any customer of your choice)
SELECT orderNumber,orderDate,requiredDate,shippedDate,status FROM orders WHERE customerNumber = 486;

-- g. Find the total number of orders placed in a particular month (orderDate between '2023-09-01' AND '2023-09-30')
SELECT COUNT(*) AS totalOrders FROM orders WHERE orderDate BETWEEN '2023-09-01' AND '2023-09-30';

-- h. Find the average order amount for each customer
SELECT c.customerNumber, c.customerName, AVG(od.quantityOrdered * od.priceEach) AS avgOrderAmount FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
JOIN orderdetails od ON o.orderNumber = od.orderNumber
GROUP BY c.customerNumber, c.customerName;

-- i. Find the number of orders placed in each month.
SELECT EXTRACT(MONTH FROM orderDate) AS orderMonth,COUNT(*) AS numberOfOrders FROM orders GROUP BY orderMonth
ORDER BY orderMonth;

-- j. Identify orders that are still pending shipment (status = 'Pending’)
SELECT orderNumber, orderDate, requiredDate, shippedDate, status FROM orders WHERE status = 'Pending';

-- k. List orders along with customer details.
SELECT o.orderNumber, o.orderDate, o.requiredDate, o.shippedDate, o.status, c.customerNumber, c.customerName, c.contactLastName,
c.contactFirstName,c.phone,c.addressLine1,c.addressLine2,c.city,c.state,c.postalCode,c.country FROM orders o
JOIN customers c ON o.customerNumber = c.customerNumber;

-- l. Retrieve the most recent orders (based on order date).
SELECT orderNumber,orderDate,requiredDate,shippedDate, status FROM orders ORDER BY orderDate DESC LIMIT 15;

-- m. Calculate total sales for each order
SELECT o.orderNumber,SUM(od.quantityOrdered * od.priceEach) AS totalSales FROM orders o
JOIN orderdetails od ON o.orderNumber = od.orderNumber GROUP BY o.orderNumber;

-- n. Find the highest-value order based on total sales
SELECT o.orderNumber,SUM(od.quantityOrdered * od.priceEach) AS totalSales FROM orders o
JOIN orderdetails od ON o.orderNumber = od.orderNumber GROUP BY o.orderNumber ORDER BY totalSales DESC LIMIT 1;

-- o. List all orders with their corresponding order details
SELECT o.orderNumber,o.orderDate, o.requiredDate,o.shippedDate,o.status,od.productCode,od.quantityOrdered,od.priceEach,od.orderLineNumber
FROM orders o JOIN orderdetails od ON o.orderNumber = od.orderNumber;

-- p. List the most frequently ordered products.
SELECT p.productCode, p.productName,COUNT(od.productCode) AS orderFrequency FROM products p
JOIN orderdetails od ON p.productCode = od.productCode GROUP BY p.productCode, p.productName
ORDER BY orderFrequency DESC;

-- q. Calculate total revenue for each order
SELECT o.orderNumber,SUM(od.quantityOrdered * od.priceEach) AS totalRevenue FROM orders o
JOIN orderdetails od ON o.orderNumber = od.orderNumber GROUP BY o.orderNumber;

-- r. Identify the most profitable orders based on total revenue
SELECT o.orderNumber,SUM(od.quantityOrdered * od.priceEach) AS totalRevenue FROM orders o
JOIN orderdetails od ON o.orderNumber = od.orderNumber GROUP BY o.orderNumber ORDER BY totalRevenue DESC LIMIT 10; 

-- s. List all orders with detailed product information
SELECT o.orderNumber, o.orderDate,o.requiredDate,o.shippedDate,o.status,od.productCode,p.productName,od.quantityOrdered,od.priceEach,
od.orderLineNumber FROM orders o JOIN orderdetails od ON o.orderNumber = od.orderNumber
JOIN products p ON od.productCode = p.productCode;

-- t. Identify orders with delayed shipping (shippedDate > requiredDate).
SELECT orderNumber,orderDate,requiredDate,shippedDate, status FROM orders WHERE shippedDate > requiredDate;

-- u. Find the most popular product combinations within orders.
SELECT od1.productCode AS product1, od2.productCode AS product2,COUNT(*) AS combinationCount FROM orderdetails od1
JOIN orderdetails od2 ON od1.orderNumber = od2.orderNumber AND od1.productCode < od2.productCode
GROUP BY od1.productCode, od2.productCode ORDER BY combinationCount DESC
LIMIT 5;

-- v. Calculate revenue for each order and identify the top 10 most profitable.
SELECT o.orderNumber,SUM(od.quantityOrdered * od.priceEach) AS totalRevenue FROM orders o
JOIN orderdetails od ON o.orderNumber = od.orderNumber GROUP BY o.orderNumber ORDER BY totalRevenue DESC LIMIT 10;
