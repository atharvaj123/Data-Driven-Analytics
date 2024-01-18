-- Task 2: Office Data Analysis

-- a. List all offices with their basic information
SELECT officeCode,city,phone,addressLine1,addressLine2,state,country,postalCode FROM offices;

-- b. Count the number of employees working in each office
SELECT o.officeCode,o.city,COUNT(e.employeeNumber) AS 'Total Employees' FROM offices o
LEFT JOIN employees e ON o.officeCode = e.officeCode GROUP BY o.officeCode, o.city;

-- c. Identify offices with less than a certain number of employees.
SELECT o.officeCode,o.city,COUNT(e.employeeNumber) AS numEmployees FROM offices o
LEFT JOIN employees e ON o.officeCode = e.officeCode
GROUP BY o.officeCode, o.city
HAVING COUNT(e.employeeNumber) < 5;

-- d. List offices along with their assigned territories.
SELECT officeCode,city,country,territory FROM offices;

-- e. Find offices that have no employees assigned to them.
SELECT o.officeCode,o.city,o.country FROM offices o
LEFT JOIN employees e ON o.officeCode = e.officeCode
WHERE e.employeeNumber IS NULL;

-- f. Retrieve the most profitable office based on total sales
SELECT o.officeCode,o.city,o.country,SUM(od.quantityOrdered * od.priceEach) AS totalSales FROM offices o
JOIN employees e ON o.officeCode = e.officeCode
JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN orders ord ON c.customerNumber = ord.customerNumber
JOIN orderdetails od ON ord.orderNumber = od.orderNumber
GROUP BY o.officeCode, o.city, o.country
ORDER BY totalSales DESC LIMIT 1;

-- g. Find the total number of offices
SELECT COUNT(*) AS 'Total Offices' FROM offices;

-- h. Find the office with the highest number of employees.
SELECT o.officeCode,o.city,o.country,COUNT(e.employeeNumber) AS numEmployees FROM offices o
JOIN employees e ON o.officeCode = e.officeCode
GROUP BY o.officeCode, o.city, o.country
ORDER BY numEmployees DESC LIMIT 1;

-- i. Find the average credit limit for customers in each office.
SELECT o.officeCode,o.city,o.country,AVG(c.creditLimit) AS avgCreditLimit FROM offices o
JOIN employees e ON o.officeCode = e.officeCode
JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
GROUP BY o.officeCode, o.city, o.country;

-- j. Find the number of offices in each country.
SELECT country,COUNT(officeCode) AS numOffices FROM offices
GROUP BY country;

