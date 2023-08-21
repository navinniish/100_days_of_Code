--Lets get our hands on in SQL--

/*Retrieve the top 3 customers who have made the highest total purchases across different products, excluding any customers who have ever returned a product. Include their total spent amount.*/

-- Create Customers table
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50)
);

-- Insert values into Customers table
INSERT INTO Customers (customer_id, customer_name)
VALUES
    (101, 'John'),
    (102, 'Mary'),
    (103, 'Robert');

-- Create Orders table
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Insert values into Orders table
INSERT INTO Orders (order_id, customer_id, order_date)
VALUES
    (1, 101, '2023-01-15'),
    (2, 102, '2023-02-20'),
    (3, 103, '2023-03-05');

-- Create OrderDetails table
CREATE TABLE OrderDetails (
    order_detail_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    returned INT,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

-- Insert values into OrderDetails table
INSERT INTO OrderDetails (order_detail_id, order_id, product_id, quantity, returned)
VALUES
    (1, 1, 201, 5, 0),
    (2, 1, 202, 3, 0),
    (3, 2, 201, 2, 1),
    (4, 2, 203, 4, 0),
    (5, 3, 202, 2, 0),
    (6, 3, 204, 3, 0);


---Question : Retrieve the top 3 customers who have made the highest total purchases across different products, excluding any customers who have ever returned a product. 
---Include their total spent amount.

---First I will tell you how to approach the problem.

---1. Select all the customers who made purchases  and sum it up

SELECT c.customer_id,
       c.customer_name,
       SUM(od.quantity * p.price) AS total_spent
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN OrderDetails od ON o.order_id = od.order_id
JOIN Products p ON od.product_id = p.product_id
GROUP BY c.customer_id, c.customer_name

---2. We need to order by to get the top 3
  
SELECT c.customer_id,
       c.customer_name,
       SUM(od.quantity * p.price) AS total_spent
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN OrderDetails od ON o.order_id = od.order_id
JOIN Products p ON od.product_id = p.product_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_spent DESC
LIMIT 3

---Now comes the where condition, where we do the magic
    SELECT DISTINCT customer_id
    FROM OrderDetails
    WHERE returned = 1
---We know that returned =1 means item is returned so we are cancelling out on this. 
--So the final query would be :

SELECT c.customer_id,
       c.customer_name,
       SUM(od.quantity * p.price) AS total_spent
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN OrderDetails od ON o.order_id = od.order_id
JOIN Products p ON od.product_id = p.product_id
WHERE c.customer_id NOT IN (
    SELECT DISTINCT customer_id
    FROM OrderDetails
    WHERE returned = 1
)
GROUP BY c.customer_id, c.customer_name
ORDER BY total_spent DESC
LIMIT 3;


---Second Question !! This time more complex ones 

---Lets us create a table and insert 

-- Create Products table
CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    category VARCHAR(50),
    price DECIMAL(10, 2)
);

-- Insert values into Products table
INSERT INTO Products (product_id, product_name, category, price)
VALUES
    (201, 'Product A', 'Category X', 10),
    (202, 'Product B', 'Category Y', 15),
    (203, 'Product C', 'Category X', 20),
    (204, 'Product D', 'Category Z', 25);

---Question : Retrieve the customer ID, customer name, product category, total spent in that category, and the percentage of their total spending that the category represents, for the top-spending customer in each category.

--So we are first gonna find : total spent in that category, and the percentage of their total spending that the category represents 

        SUM(od.quantity * pr.price) AS total_spent_in_category,
        SUM(od.quantity * pr.price) / SUM(SUM(od.quantity * pr.price)) OVER (PARTITION BY c.customer_id) * 100 AS category_percentage
        ROW_NUMBER() OVER (PARTITION BY category ORDER BY total_spent_in_category DESC) AS category_rank

---  These three are the toughest !! So I want you to go over the window functions!

---We have to do the first two :
          
SELECT
        c.customer_id,
        c.customer_name,
        p.category,
        SUM(od.quantity * pr.price) AS total_spent_in_category,
        SUM(od.quantity * pr.price) / SUM(SUM(od.quantity * pr.price)) OVER (PARTITION BY c.customer_id) * 100 AS category_percentage
    FROM Customers c
    JOIN Orders o ON c.customer_id = o.customer_id
    JOIN OrderDetails od ON o.order_id = od.order_id
    JOIN Products pr ON od.product_id = pr.product_id
    GROUP BY c.customer_id, c.customer_name, p.category

---- Then we have to do the other 1

RankedCategorySpending AS (
    SELECT
        customer_id,
        customer_name,
        category,
        total_spent_in_category,
        category_percentage,
        ROW_NUMBER() OVER (PARTITION BY category ORDER BY total_spent_in_category DESC) AS category_rank
    FROM CategorySpending

---- Now there comes the last

WITH CategorySpending AS (
    SELECT
        c.customer_id,
        c.customer_name,
        p.category,
        SUM(od.quantity * pr.price) AS total_spent_in_category,
        SUM(od.quantity * pr.price) / SUM(SUM(od.quantity * pr.price)) OVER (PARTITION BY c.customer_id) * 100 AS category_percentage
    FROM Customers c
    JOIN Orders o ON c.customer_id = o.customer_id
    JOIN OrderDetails od ON o.order_id = od.order_id
    JOIN Products pr ON od.product_id = pr.product_id
    GROUP BY c.customer_id, c.customer_name, p.category
),
RankedCategorySpending AS (
    SELECT
        customer_id,
        customer_name,
        category,
        total_spent_in_category,
        category_percentage,
        ROW_NUMBER() OVER (PARTITION BY category ORDER BY total_spent_in_category DESC) AS category_rank
    FROM CategorySpending
)
SELECT
    customer_id,
    customer_name,
    category,
    total_spent_in_category,
    category_percentage
FROM RankedCategorySpending

---Now we have to put category = 1

          
WITH CategorySpending AS (
    SELECT
        c.customer_id,
        c.customer_name,
        p.category,
        SUM(od.quantity * pr.price) AS total_spent_in_category,
        SUM(od.quantity * pr.price) / SUM(SUM(od.quantity * pr.price)) OVER (PARTITION BY c.customer_id) * 100 AS category_percentage
    FROM Customers c
    JOIN Orders o ON c.customer_id = o.customer_id
    JOIN OrderDetails od ON o.order_id = od.order_id
    JOIN Products pr ON od.product_id = pr.product_id
    GROUP BY c.customer_id, c.customer_name, p.category
),
RankedCategorySpending AS (
    SELECT
        customer_id,
        customer_name,
        category,
        total_spent_in_category,
        category_percentage,
        ROW_NUMBER() OVER (PARTITION BY category ORDER BY total_spent_in_category DESC) AS category_rank
    FROM CategorySpending
)
SELECT
    customer_id,
    customer_name,
    category,
    total_spent_in_category,
    category_percentage
FROM RankedCategorySpending
WHERE category_rank = 1;

---That's all for today !!          
          

