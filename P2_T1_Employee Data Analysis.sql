-- Task 1: Employee Data Analysis

-- a. Find the total number of employees
SELECT COUNT(employeeNumber) AS totalEmployees FROM employees;

-- b. Find the number of employees in each office.
SELECT o.officeCode,o.city,o.country,COUNT(e.employeeNumber) AS numEmployees FROM offices o
JOIN employees e ON o.officeCode = e.officeCode
GROUP BY o.officeCode, o.city, o.country;

-- c. List all employees with their basic information.
SELECT employeeNumber,firstName,lastName,jobTitle,email,officeCode FROM employees;

-- d. Count the number of employees holding each job title
SELECT jobTitle,COUNT(employeeNumber) AS numEmployees FROM employees GROUP BY jobTitle;

-- e. Find employees who don't have a manager (reportsTo is NULL).
SELECT employeeNumber,firstName,lastName,jobTitle FROM employees WHERE reportsTo IS NULL;

-- f. List employees along with their assigned offices.
SELECT e.employeeNumber,e.firstName,e.lastName,e.jobTitle,o.officeCode,o.city,o.country FROM employees e
JOIN offices o ON e.officeCode = o.officeCode;

-- g. Identify sales representatives with the highest number of customers
Select COUNT(customers.customerNumber) AS customerCount, employees.firstName, employees.lastName   
FROM employees
JOIN customers ON employees.employeeNumber = customers.salesRepEmployeeNumber
GROUP BY employees.employeeNumber, employees.firstName, employees.lastName
ORDER BY customerCount DESC
LIMIT 1;

-- h. Find the most profitable sales representative based on total sales.
SELECT e.employeeNumber,e.firstName,e.lastName,SUM(od.quantityOrdered * od.priceEach) AS totalSales FROM employees e
JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN orders o ON c.customerNumber = o.customerNumber
JOIN orderdetails od ON o.orderNumber = od.orderNumber
GROUP BY e.employeeNumber, e.firstName, e.lastName ORDER BY totalSales DESC LIMIT 1;

-- i. Find the names of all employees who have sold more than the average sales amount for their office.
SELECT employees.firstName, employees.lastName, avg(payments.amount) as Avg_sales
FROM employees
JOIN customers on employees.employeeNumber = customers.salesRepEmployeeNumber
JOIN payments on customers.customerNumber = payments.customerNumber
GROUP BY employees.firstName, employees.lastName;











