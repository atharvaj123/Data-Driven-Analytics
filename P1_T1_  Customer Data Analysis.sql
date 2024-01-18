-- Task 1: Customer Data Analysis
USE `modelcarsdb`;

-- a. Find the total number of customers.
SELECT COUNT(customerNumber) AS 'Total Customers' FROM customers;

-- b. Find the top 10 customers by credit limit
SELECT customerNumber, customerName, creditlimit FROM customers ORDER BY creditlimit DESC LIMIT 10;

-- c. Find the average credit limit for customers in each country.
SELECT country, AVG(creditlimit) AS avg_credit_limit FROM customers GROUP BY country;

-- d. Find the number of customers in each state.
SELECT state, COUNT(customerNumber) AS num_customers FROM customers GROUP BY state;

-- e. Retrieve customer information with contact details.
SELECT customerNumber,customerName,contactFirstName,contactLastName,phone,city,state,country FROM customers;

-- f. Find customers who haven't placed any orders.
SELECT customers.customerNumber, customers.customerName FROM customers
LEFT JOIN orders ON customers.customerNumber = orders.customerNumber WHERE orders.customerNumber IS NULL;

-- g. Calculate total sales for each customer.
SELECT customers.customerNumber,customers.customerName,SUM(orderdetails.quantityOrdered) AS 'Total sales' FROM customers
LEFT JOIN orders ON customers.customerNumber = orders.customerNumber
LEFT JOIN orderdetails ON orders.orderNumber = orderdetails.orderNumber
GROUP BY customers.customerNumber, customers.customerName;

-- h. List customers with their assigned sales representatives.
SELECT customerNumber,customerName,salesRepEmployeeNumber AS 'Sales Representative' FROM customers;

-- i. Retrieve customer information with their most recent payment details.
SELECT customers.customerNumber,customers.customerName,customers.contactLastName,customers.contactFirstName,payments.paymentDate,
payments.amount FROM customers
JOIN payments ON customers.customerNumber = payments.customerNumber
WHERE (payments.customerNumber, payments.paymentDate) IN (SELECT customerNumber, MAX(paymentDate) FROM payments GROUP BY customerNumber);

-- j. Identify customers who have exceeded their credit limit
SELECT c.customerNumber,c.customerName,c.creditLimit,SUM(p.amount) AS totalAmount FROM customers c
JOIN payments p ON c.customerNumber = p.customerNumber
GROUP BY c.customerNumber, c.customerName, c.creditLimit
HAVING SUM(p.amount) > c.creditLimit;

-- k. Find the names of all customers who have placed an order for a product from a specific product line
SELECT DISTINCT customers.customerName FROM customers
JOIN orders ON customers.customerNumber = orders.customerNumber
JOIN orderdetails ON orders.orderNumber = orderdetails.orderNumber
JOIN products ON orderdetails.productCode = products.productCode
WHERE products.productLine = 'Vintage Cars';

-- l. Find the names of all customers who have placed an order for the most expensive product.
SELECT DISTINCT c.customerName FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
JOIN orderdetails od ON o.orderNumber = od.orderNumber
JOIN products p ON od.productCode = p.productCode
WHERE p.buyPrice = (SELECT MAX(buyPrice) FROM products);

-- m. Find the names of all customers who work for the same office as their sales representative.
SELECT DISTINCT c.customerName FROM customers c
JOIN employees e ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN offices o ON e.officeCode = o.officeCode
WHERE c.country = o.country;


