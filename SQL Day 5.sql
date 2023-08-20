/* Date and Time Functions*/

/* Some of the date and time functions are self explainatory*/

select year(current_date())  
select month(current_date())  
select week(current_date())  
select day(current_date())  or select dayofmonth(current_date())  
select dayname(current_date())  
select dayofweekiso(current_date())  
select dayofyear(current_date())  
select last_day(current_date())  /*Gives the last day of the current month*/
select monthname(current_date())  
SELECT YEAROFWEEK(CURRENT_DATE);
SELECT YEAROFWEEKISO(CURRENT_DATE);

/*Some String Functions*/

/*Concat or Concat_WS :*/ 

Select concat(First_Name,' ', Last_Name) as FullName from Customers

/*This query concats the columns having first name and last name and combines it as fullname this can be used in many situations.*/

SELECT CONCAT_WS(' ', 'Navin', 'Niish');

/*In this query, the space ' ' is used as the separator between the two strings. The result will be 'Navin Niish'.*/

/*Substr or Substring or Instr*/

select substring('Navin', 2,5) /*The result will be 'avin', which is the substring starting from the second character ('a') and spanning 5 characters*/

SELECT SUBSTRING('Navin', INSTR('Navin', 'a') + 1, 5); /*INSTR('Navin', 'a') finds the starting position of the first occurrence of 'a' within the string 'Navin'. 
The + 1 is used to start the extraction from the character immediately after the found position.*/

SELECT SUBSTR('Navin', INSTR('Navin', 'a') + 1, 5); /*Using INSTR in combination with SUBSTR allows you to extract substrings based on the position of certain characters within the input string.*/

/*CharIndex , Patiindex*/

/*Charindex as the name suggests - It  finds the starting position of the first occurrence of 'string' within the string 'Navin'*/

 SELECT SUBSTRING('Navin', CHARINDEX('a', 'Navin') + 1, 5);  /* finds the starting position of the first occurrence of 'a' within the string 'Navin'*/

/*Now lets see something cool*/

/* We have a string like /a/b/c/d-109/a/b/c/d we need to take out d-109 how can we do it*/

DECLARE @inputString VARCHAR(100) = '/a/b/c/d-109/a/b/c/d';

SELECT 
    SUBSTRING(
        @inputString, 
        CHARINDEX('d-', @inputString) + 2, 
        CHARINDEX('/', @inputString, CHARINDEX('d-', @inputString)) - CHARINDEX('d-', @inputString) - 2
    ) AS extractedValue;

/*This is how you do it. It was so cool to me to figure out these but I did it. !!*/

/*I have even written a medium post : https://medium.com/@navinniish001/substring-and-patindex-and-charindex-the-headaches-of-every-data-analyst-e6e3719f47c6*/

/*Now lets see some more string functions we can use!!*/

select length('Navin') /*Length or Len function tells you the length of the string*/

/*Format function : This is used in most of the date function*/

SELECT FORMAT(CONVERT(DATE, '22-01-1939', 105), 'd');

/*The format function has many values in it. It includes : https://www.sqlshack.com/a-comprehensive-guide-to-the-sql-format-function/ many functionalities that are listed here in this website*/

/*Lower = Translates the string into a lowercase Upper = Translates a string into upper case*/

select lower('Navin') , upper('Nzbin') 

/*always remember to use strings only*/

---Trim functions : Trim, LTrim, Rtrim

SELECT TRIM(' Navin Niish  ') AS TRIM;
-- Output: 'Navin Niish'

SELECT LTRIM('  Navin Niish') AS left_trimmed_string;
-- Output: 'Navin Niish'

SELECT RTRIM('Navin Niish  ') AS right_trimmed_string;
-- Output: 'Navin Niish'

--Stuff command : This is acts as substitute command in SQL

SELECT STUFF('Navin Niish', 1, 4, 'Kavi');
---Output Kavin Niish

---Thats all the functions you will use in SQL. Now from tmrw I will teach  you SQL server, PostGreSQL, Snowflake, Google Big Query and Amazon Aurora 
--













