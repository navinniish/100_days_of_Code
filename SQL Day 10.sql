---Today we are gonna see the BIGQUERY : Firstly let us understand what's BQ. BQ means data warehouse where you can store the data and  
---It can handle datasets of various sizes, from gigabytes to petabytes, by automatically distributing and parallelizing queries across multiple nodes.

---Today we are see what functions are really used in the BQ

-- At first we create a new table :
CREATE TABLE CustomerOrders (
  customer_name STRING,
  order_date DATE,
  order_amount FLOAT64
);
-- Insert data
INSERT INTO CustomerOrders (customer_name, order_date, order_amount)
VALUES
  ('Alice', '2023-08-01', 150.00),
  ('Bob', '2023-08-02', 200.00),
  ('Alice', '2023-08-03', 100.00),
  ('Bob', '2023-08-04', 250.00),
  ('Carol', '2023-08-05', 180.00);

-- Create customer purchases
CREATE TABLE CustomerPurchases (
  customer STRUCT<name STRING, age INT64, gender STRING>,
  products_1 ARRAY<STRING>,
  products_2 ARRAY<STRING>
);

-- Insert sample data into the CustomerPurchases table
INSERT INTO CustomerPurchases (customer, products_1, products_2)
VALUES
  (STRUCT('John', 25, 'Male'), ['itemA', 'itemB', 'itemC'], ['itemD', 'itemE']),
  (STRUCT('Alice', 30, 'Female'), ['itemX', 'itemY'], ['itemZ']);


---I will explain you what is struct function later



---Now lets use the array functions available

---Array_Agg

SELECT ARRAY_AGG(order_amount) AS order_amounts
FROM CustomerOrders
WHERE customer_name = 'Alice';

--This functions finds where the name alice is and then aggregates the result based on the alice

---Array concat function : This table concats the information available in product arrays (all_products) and customer information from the CustomerPurchases table. 

SELECT
  ARRAY_CONCAT(products_1, products_2) AS all_products,
  customer.name,
  customer.age,
  customer.gender
FROM CustomerPurchases;

---Array Length Function : The array length function is used to find the length of arrays:


SELECT
  ARRAY_LENGTH(review_ratings) AS num_reviews
FROM ProductReviews;

---In this example, the query retrieves the product names and the length of the review_ratings arrays using the ARRAY_LENGTH function.  


--_Struct Function : THis function is used while makinga  table or creating the table


INSERT INTO CustomerPurchases (customer, products_1, products_2)
VALUES
  (STRUCT('John', 25, 'Male'), ['itemA', 'itemB', 'itemC'], ['itemD', 'itemE']),
  (STRUCT('Alice', 30, 'Female'), ['itemX', 'itemY'], ['itemZ']);

select customer.name, customer.age, customer.gender from CustomerPurchases

---Here customername and age and gender are embedded in a string called as customer we are now taking it out

--ST_GEOPOINT : The ST_GEOGPOINT function constructs a geography point using latitude and longitude coordinates.

SELECT
  ST_GEOGPOINT(-122.4194, 37.7749) AS san_francisco;


---ST_DISTANCE : The ST distance used to calculate one geography point and another geography point

SELECT
  ST_DISTANCE(
    ST_GEOGPOINT(-122.4194, 37.7749),
    ST_GEOGPOINT(-118.2437, 34.0522)
  ) AS distance_in_meters;


---ST WITHIN - Checks if one geography object is within another.

SELECT
  ST_WITHIN(
    ST_GEOGPOINT(-122.4194, 37.7749),
    ST_GEOGFROMTEXT('POLYGON((-123.0 37.0, -123.0 38.0, -121.0 38.0, -121.0 37.0, -123.0 37.0))')
  ) AS within_polygon;


/*Here note that polygon has been used as function because they are commonly used to represent geographic features like city boundaries, 
  country borders, regions, and more. They play a crucial role in geospatial analysis and mapping, helping you analyze relationships and characteristics of specific geographic areas.*/

---JSON Functions

---JSON_EXTRACT_SCALAR : The JSON_EXTRACT_SCALAR Function is the only reason I use GBQ for. Now what this does is that it extracts name in the json file 

SELECT JSON_EXTRACT_SCALAR('{"name": "John", "age": 30}', '$.name') AS name;

-- Output: John

---we also have similar function for JSON_EXTRACT_SCALAR that is JSON_QUERY but it returns as string

SELECT JSON_QUERY('{"name": "John", "age": 30}', '$.name') AS name; ---In this example we have used json query as a function which returns "John"

----JSON value: This query extracts the scalar values in a Json. So what's the diff : use JSON_EXTRACT_SCALAR when you want to extract a single scalar value, 
--and use JSON_QUERY when you want to preserve the JSON structure and extract objects or arrays. Choose the function that suits your specific extraction needs and desired output format.

---and JSON_OBJECT and JSON_ARRAY inserts the perspective Objects and Arrays !! 

---Now why is that I took a day long to write BG : Because BQ is the future and you must know about it more and more read !! Spread the word

---Note that BQ having trillions of data must be read by using a timestamp

/*
Start with a Clear Goal:
Clearly define your objective before writing any code. Understand what insights or results you want to obtain from your query. No

Use Descriptive Names:
Choose meaningful names for tables, columns, and aliases. This improves code readability and makes it easier for others to understand your queries.

Use Comments:
Add comments to explain complex parts of your code, the purpose of queries, and any assumptions you're making. This helps both you and others who read your code in the future.

Minimize Data Scanned:
BigQuery charges based on the amount of data processed. Use filters and WHERE clauses to limit the amount of data read from tables, especially when working with large datasets.

*Avoid Using SELECT :
Instead of selecting all columns with SELECT *, explicitly list the columns you need. This reduces unnecessary data transfer and can lead to more efficient query execution.

Use Table Wildcards:
When working with partitioned or time-series data, use table wildcards to query multiple tables at once. This can simplify queries and improve performance.

Aggregate Thoughtfully:
Use aggregate functions (e.g., SUM, COUNT, AVG) judiciously. Be aware of how grouping affects your results and choose appropriate grouping columns.

Use Proper JOINs:
Use JOINs to combine data from different tables. Understand the differences between INNER JOIN, LEFT JOIN, and other types of JOINs and choose the right one for your needs.

Consider Subqueries and CTEs:
Complex queries can benefit from breaking them down into subqueries or using Common Table Expressions (CTEs) for better organization and readability.

Optimize ORDER BY:
If you use ORDER BY, consider using it only when necessary. ORDER BY can be resource-intensive, especially for large datasets.

Use Analytic Functions Wisely:
Analytic functions (e.g., ROW_NUMBER, RANK, LAG) can be powerful for creating advanced analyses, but they can also impact performance. Use them with care.

Test with LIMIT:
When developing queries, use LIMIT to test your results before running the full query. This prevents accidentally running resource-intensive operations.

Check Query Execution Plan:
Use the Query Execution Plan to understand how your query is being executed. It can help identify potential bottlenecks or areas for optimization.

Use BigQuery Documentation:
Refer to BigQuery's official documentation for in-depth information about functions, best practices, and optimization techniques. 


BECAUSE NOTE THAT BQ IS FULL OF COSTS !!!! COSTS !!!! COSTS !!!!! So optimize your query and then use it wisely*/





