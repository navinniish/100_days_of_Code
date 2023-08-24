---Lets see about Postgresql and BigQuery 

---Now if you learn sql learn MQSQL + Postgresql + Snowflake because these days the systems are using snowflake and I will tell you why you should learn Snowflake as soon as you complete
----Snowflake. You will learn about the functions in postgresql that are being used in snowflake and vice versa. Now postgresql handles Json data and Array data. I will tell you here how to handle
----Each one of them so that you will know.

---So lets create a table
CREATE TABLE json_data (
    id serial PRIMARY KEY,
    data jsonb
);

INSERT INTO json_data (data)
VALUES ('{"key1": "value1", "key2": "value2"}');

--> Retrieve all rows
SELECT * FROM json_data;

--> Retrieve specific fields from JSON
SELECT data->'key1' AS value1 FROM json_data;

--> Filter rows based on JSON field
SELECT * FROM json_data WHERE data->>'key1' = 'value1';

/*Note this here : 
->: Get a JSON object field as text.
->>: Get a JSON object field as text, cast to text.
#>: Get a JSON object at a specified path as text array.
#>>: Get a JSON object at a specified path as text.*/

---jsonb_agg - json_b_agg is used for aggregating json data

select jsonb_agg(data) from json_data GROUP BY id;


---jsonb_extract_path_text : this function is the best function in postgresql. Used to take out the functions within the json.

select jsonb_extract_path_text(data, 'key') as value from json_data ---(this answer is value1 because json_b is extracted)

---Now array functions are also postgresqls strength ! Lets see array functions : What is an array (for non programming folks) : Think of it like this, you
---  are given a bag full of stuff and that is an array. Let me say you some functions that will help you do what with the bag

CREATE TABLE employee (
    id serial PRIMARY KEY,
    name text,
    skills text[]
);

INSERT INTO employee (name, skills)
VALUES
    ('John Doe', ARRAY['Java', 'SQL', 'Python']),
    ('Jane Smith', ARRAY['Python', 'JavaScript', 'CSS']),
    ('Michael Johnson', ARRAY['C++', 'Java', 'SQL']);

---Creating a array - Buying the stuff

SELECT ARRAY['Chocolate', 'S', 100] AS bag; 

---You will get {'Chocolate', 'S', 100}. This curly braces indicate a array

---How to index

SELECT skills[3] AS third_skill FROM employee WHERE id = 1; ---This selects third skill of an employee if it doesnt have anything it will return null, you can use this in snowflake too

---How to append

SELECT array_append(skills, 'Ruby') AS updated_skills FROM employee WHERE id = 2;

---This returns  {Python,JavaScript,CSS,Ruby}

---array_postion : this points out where our element is

SELECT array_position(skills, 'Java') AS java_position FROM employee WHERE id = 3;

---We can use array postion to know where is a array and then perform operations like we did on charindex and then we can also use array_length function also

--Unnest : What is unnest? Bag is torn. Thats all :D Coming to unnest , we use unnest to "remove" the bag and to put 'each' of them to the shopkeeper for identifying

SELECT unnest(skills) AS single_skill FROM employee WHERE id = 2;

---here we are unnesting a bag called skills 

---We can union an array by using array_union and we can intersect an array by using array_intersect

CREATE TABLE interests (
    person_id serial PRIMARY KEY,
    hobbies text[]
);

INSERT INTO interests (hobbies)
VALUES
    (ARRAY['Reading', 'Cooking', 'Hiking']),
    (ARRAY['Cooking', 'Swimming']),
    (ARRAY['Hiking', 'Photography', 'Painting']);


select array_intersect(i1.hobbies, i2.hobbies) AS common_hobbies
FROM interests i1, interests i2
WHERE i1.person_id = 1 AND i2.person_id = 3;


select array_union(i1.hobbies, i2.hobbies) AS common_hobbies
FROM interests i1, interests i2
WHERE i1.person_id = 1 AND i2.person_id = 3;

---:D thats it postgresql can come in handy !! I used : https://extendsclass.com/postgresql-online.html


---Snowflake Warehouse ! Snowflake is a collection of databases used as storage in cloud by using AWS or any other cloud service

CREATE OR REPLACE TABLE sales (
    product_id INT,
    sale_date DATE,
    amount DECIMAL(10, 2)
);

INSERT INTO sales (product_id, sale_date, amount)
VALUES
    (1, '2023-08-01', 150.00),
    (2, '2023-08-02', 200.00),
    (1, '2023-08-03', 120.00),
    (3, '2023-08-04', 75.00),
    (2, '2023-08-05', 220.00),
    (3, '2023-08-06', 90.00),
    (1, '2023-08-07', 180.00),
    (2, '2023-08-08', 250.00);

SELECT *
FROM sales
SAMPLE (0.3); -- Sampling 30% of the data

---WE CAN EVEN SAMPLE 100% BUT WHY?

---Nw converting your datetime

SELECT CONVERT_TIMEZONE('America/New_York', sale_timestamp) AS sale_time_local
FROM sales;

---You can easily convert your datetime functions by using this;

--Tommorrow is the last day of SQL I will take GBQ tomorrow !











