---Today we are gonna see about window functions !!

---What are window functions? Are they group by?

---Now this question is often asked in the interview. The major difference btwn group by and window functions is that group by groups the rows. Meanwhile window functions do not
---GROUP BY reduces the number of rows in the result set by creating summary rows, while window functions retain all rows in the result set but add calculated values to each row.
---GROUP BY is used for aggregation at a group level, while window functions focus on calculations across a set of related rows for each individual row.
----Window functions provide more flexibility in performing complex analytical tasks without altering the structure of the result set.

--Or jus say : 
--The major difference btwn group by and window functions is that group by groups the rows. Meanwhile window functions do not because they are used for analytical functions. Simple

---How to use a window function :

---window function over (partition by order by )

--So lets go !!

---What are the different types of window function that you can use as a data analyst:

---Row Number : We use row number to put a row number to your row. Hint : You can also select the top 3 salaries by using row number

SELECT row_number() over (partition by CustomerID order by CustomerID desc) as rn FROM Customers;

with a  as (select row_number() over (partition by userid order by salary desc) as rn , userid, salary from workers) select * from a where rn = 7

---thats it you have found out what it takes to be!!

---Rank and Dense Rank: Know this - rank skips and dense rank doesnt skip. Note this. This is very important
---I found this on google : In summary, the key difference between RANK() and DENSE_RANK() lies in how they handle tied values. RANK() leaves gaps in the ranking sequence, while DENSE_RANK() provides a continuous sequence without skipping ranks.

---Dense Rank
  
WITH a AS (
    SELECT DENSE_RANK() OVER (PARTITION BY userid ORDER BY salary DESC) AS rn,
           userid,
           salary
    FROM workers
)
SELECT *
FROM a
WHERE rn = 7;

---Rank
WITH a AS (
    SELECT  RANK() OVER (PARTITION BY userid ORDER BY salary DESC) AS rn,
           userid,
           salary
    FROM workers
)
SELECT *
FROM a
WHERE rn = 7;

---Here whats the difference. ?

/**Rank gives Only one value as 7 meanwhile dense rank gives all the values that are in the 7th rank. Both queries aim to retrieve 
rows representing the 7th highest salary within each user's partition. The key difference between them lies in how RANK() and DENSE_RANK()
handle tied values. If there are tied salaries, RANK() might skip a rank, 
leading to potential gaps in the ranking sequence, while DENSE_RANK() would maintain a continuous sequence without skipping ranks for tied values.*/

---Now lead and lag function. This question is important because they asked me in the Cartesian consulting Interview

SELECT
    order_id,
    order_date,
    amount,
    LAG(order_date) OVER (ORDER BY order_date) AS prev_order_date,
    LEAD(order_date) OVER (ORDER BY order_date) AS next_order_date,
    LAG(amount) OVER (ORDER BY order_date) AS prev_amount,
    LEAD(amount) OVER (ORDER BY order_date) AS next_amount
FROM Sales;


----Now lead gives a value that will happen lag gives a value that has happened before. Simple
----Lead - Leading values LAG - Lagging values
---Lead is asked when they say find the moving avg of products
---as soon as u hear moving avg u can say that they are referring to lead and as soon as u get the question

SELECT
    date,
    sales_amount,
    (sales_amount + LEAD(sales_amount, 1) OVER (ORDER BY date) + LEAD(sales_amount, 2) OVER (ORDER BY date)) / 3 AS moving_avg
FROM DailySales;

---use this query !!


---Ntile function : N-number of tile specifically divides each number of rows into the value that you pass on.

SELECT student_id, score,
       NTILE(4) OVER (ORDER BY score) AS quartile
FROM Scores;


/*Here, the NTILE(4) function divides the scores into four groups, trying to keep the number of rows in each group as equal as possible.

In summary, the NTILE() function is useful for dividing data into equal-sized segments, 
which can be helpful for various analytical purposes like calculating percentiles, quartiles, and other statistical measures.

You can use ntile function to calculate moving avg also but that's a little tricky so stick to the using of lead*/

---These are all the window functions that you might wanna use. There are somemore too like list_agg but they are used in postgre and snowflake. I will tell about them in the coming classes
