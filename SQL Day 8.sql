---Today we are gonna see about what are SQL server, Snowflake, PostGreSQL, BigQuery and MySQL level functions as a Data Scientist or Data Analyst 

---SQL server

---Before that :

---Lets create a table

CREATE TABLE Users (
    UserID INT PRIMARY KEY,
    UserName VARCHAR(50),
    Email VARCHAR(100)
);

-- Insert sample data

INSERT INTO Users (UserID, UserName, Email)
VALUES
    (1, 'John Doe', 'john@example.com'),
    (2, 'Jane Smith', 'jane@example.com'),
    (3, 'Robert Johnson', 'robert@gmail.com'),
    (4, 'Mary Brown', 'mary@example.com');

---PATINDEX - This is called PATtern INDEX. It identifies a particular pattern and then it shows you whats the correct answer is depending upon your need

SELECT
    UserID,
    UserName,
    Email,
    PATINDEX('%@%', Email) AS AtSymbolPosition
FROM Users;

---We are getting the postion of '@' and we use patiindex. 
  
---We can also use patindex in : Suppose we have a string called  '/f/a/@/d/f/' and we need @ so what we do :

DECLARE @string2 VARCHAR(100) = '/f/a/@/d/f/';
SELECT SUBSTRING(@string2, PATINDEX('%@%', @string2), 1) AS ExtractedSymbol;

---We do this !!

---Left function and Right Function : Left takes left and right takes right

DECLARE @string VARCHAR(50) = 'Navin Niish';
SELECT LEFT(@string, 5) AS Extracted; -- Returns 'Navin'
DECLARE @string VARCHAR(50) = 'Example Text';
SELECT RIGHT(@string, 5) AS Extracted; -- Returns 'Niish'

---Lets explore this more : I want Niish

DECLARE @string VARCHAR(100) = '/Navin/Niish/Age-/is/27';

SELECT LEFT(
    SUBSTRING(@string, PATINDEX('%/Niish/%', @string) + 7, LEN(@string)),
    CHARINDEX('/', SUBSTRING(@string, PATINDEX('%/Niish/%', @string) + 7, LEN(@string))) - 1
) AS ExtractedSubstring;


---You got it !!!

---Now comes the best function of all : Replace !!!
---You can replace anything and everything using replace !

DECLARE @string VARCHAR(100) = '/Navin/Niish/Age-/is/27';

--- Remove leading characters until '/Niish/' using REPLACE

DECLARE @cleanedString VARCHAR(100) = REPLACE(@string, '/Navin/', '');

SELECT @cleanedString AS CleanedString; --- Returns 'Niish/Age-/is/27'

---STUFF FUNCTION : REPLACES THE PARTICULAR STRING BY USING THE STRING THAT YOU GIVE

DECLARE @string VARCHAR(100) = '/Navin/Niish/Age-/is/27';

DECLARE @startPos INT = CHARINDEX('/Niish/', @string);



DECLARE @result VARCHAR(100) = STUFF(@string, 1, @startPos + LEN('/Niish/') - 1, '');

DECLARE @endPos INT = CHARINDEX('/', @result);

SELECT LEFT(@result, @endPos - 1) AS ExtractedSubstring; -- Returns 'Niish'

/* Find the position of '/Niish/'
-- Use STUFF to remove characters before '/Niish/' and extract 'Niish'
-- Find the position of the next '/'
-- Extract the desired substring using LEFT */

----These are the SQL server based functions ! 

--- Snowflake Specific !

--> DATE_TRUNC : This function truncates (TRUNC) to a date or date to a specified level of precision say year of the month, month etc

SELECT DATE_TRUNC('YEAR', CURRENT_TIMESTAMP()); -- Truncate to the beginning of the current year

--> LAST_QUERY_ID : Every query you run in a warehouse like snowflake has a ID; To see the previous query's ID we use LAST_QUERY_ID

SELECt last_query_id();

--Our snowflake owners or database architects have the Query ID

--> LATERAL function : Used to perform the subquery that takes the columns from other tables

--- Create the 'orders' table
CREATE TABLE orders (
    order_id INT,
    order_date DATE
);

-- Insert data into the 'orders' table
INSERT INTO orders (order_id, order_date)
VALUES
    (1, '2023-08-21'),
    (2, '2023-08-22');

-- Create the 'order_items' table
CREATE TABLE order_items (
    order_id INT,
    item_id INT,
    item_name VARCHAR(50)
);

-- Insert data into the 'order_items' table
INSERT INTO order_items (order_id, item_id, item_name)
VALUES
    (1, 101, 'Item A'),
    (1, 102, 'Item B'),
    (2, 103, 'Item C');

---and Now we use the lateral :

SELECT * 
FROM orders o, 
LATERAL (SELECT * FROM order_items i WHERE o.order_id = i.order_id);

---Simpleee !!!

--> Flatten Method: This is my favorite in the SnowFlake DB because this is what I use the maximum !!

--Create a table
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    order_date DATE
);

---Create another table
CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    items ARRAY,
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

---Insert values into it

INSERT INTO orders (order_id, order_date)
VALUES
    (1, '2023-08-01'),
    (2, '2023-08-02');

INSERT INTO order_items (order_item_id, order_id, items)
VALUES
    (101, 1, ARRAY['item1', 'item2']),
    (102, 1, ARRAY['item3']),
    (103, 2, ARRAY['item4'])

---Now its time to use our Lateral Flatten 

SELECT o.order_id, oi.value AS item
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id,
LATERAL FLATTEN(input => oi.items) AS t(item);

---So thats all we can see BigQuery and PostGreSQL in other session





