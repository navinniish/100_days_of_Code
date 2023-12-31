/*Today we are going to see common functions in SQL. */

/*Into command: This command is used for copying table*/

SELECT * INTO b FROM a WHERE c = 1;

/*This puts into B where a has c value as 1. Remember that you are copying a table that requires admin-level access. If you have read only you can't use the keyword into*/

/*Distinct command: This command is used in places where we need distinct counts*/

select distinct id from a ;

/*This command selects the distinct id from a. For ex: if you have 2 numbers of the same value this one pulls up 1.*/

/*isnull or ifnull function: We can substitute the null function by using this. */

select isnull(id,'0') from a

/*If a value is null then it substitutes 0. We can also add text in this*/

select isnull(id, 'navin') from a

/*Coalesce function:*/

/*This function is similar to isnull, but we can use more columns here. The SQL Coalesce function evaluates the arguments passed 
and always returns first non-null value from the defined argument list.*/

select Coalesce(id, productname, productid, 'Navin') from a

/*Here it picks the first nonnull value and returns my name if all are null. I use this when I do data migration.*/

/*collate : This is a weird function that I use to pickup words that are similar using a join. Let me show you an example*/

/*table a contains (id, name) table b contains (name, product) but here we are using strings to join. Whenever we are using string to join we need to make sure no extra spaces or nothing is there 
with it and also it should match correctly that is the reason we are using collate*/

SELECT a.id, a.name, b.product
FROM a
LEFT JOIN b ON a.name COLLATE Latin1_General_CS_AS = b.name COLLATE Latin1_General_CS_AS;

/*COLLATE Latin1_General_CS_AS performs a left join between tables "a" and "b" based on the "name" column, using the specified collation Latin1_General_CS_AS for case-sensitive comparison.*/

 /*You can also use :

Here are some different types of collation that are commonly used in various situations:

- Latin1_General_CI_AS: This collation is not sensitive to case but is sensitive to accents. It's often used for general purposes when comparing strings.
- Latin1_General_CS_AS: This collation is both case-sensitive and accent-sensitive, meaning it takes both factors into account when comparing strings.
- Latin1_General_BIN: This binary collation treats strings as binary values, ignoring both case and accents. It's useful when you need to make exact binary comparisons.
- SQL_Latin1_General_CP1_CI_AS: Similar to Latin1_General_CI_AS, this collation is case-insensitive and accent-sensitive, but also has additional code page support.
- Latin1_General_100_CS_AS_SC: This collation is specific to SQL Server 2017 and is case-sensitive, accent-sensitive, and supports supplementary characters.
- Latin1_General_BIN2: This binary collation has enhanced support for supplementary characters and was introduced in SQL Server 2012. */

  /*Top clause: This is used to get the top of the dataset you use. Top(10) or top(100) it will give it to you*/

Select top(10) id from a ; /* it selects top 10 ids and gives it to you */

/*As clause: Alias clause is also called as as clause because we use as a command to denote*/

select id as IDD from a; Here as is used as an alias

/*Using wildcards with Like:

'[0-9]%': Matches strings that start with a digit.
'[A-Za-z]%': Matches strings that start with a letter, regardless of case.
'%[^0-9]%': Matches strings that contain at least one character that is not a digit. This is very much useful for taking out the 

Using one with like gives you the value that you want. I used in data migration and it was very useful*/

/*INSERT INTO command: This command works just like into command */

INSERT INTO b
SELECT id, name as Name_Product FROM a
WHERE id = 3;

/*Here we can select the columns we want to import to B.*/

/*Case condition : So far the case condition has been the best use of SQL because you can literally do anything with the case condition*/

SELECT name,
       CASE 
           WHEN age < 18 THEN 'Child'
           WHEN age BETWEEN 18 AND 65 THEN 'Adult'
           ELSE 'Senior'
       END AS category
FROM a;

/*Here it is self explanatory why I said case is awsm !

Use it with join also :*/

SELECT a.id, a.name, b.score,
       CASE 
           WHEN b.score >= 90 THEN 'A'
           WHEN b.score >= 80 THEN 'B'
           WHEN b.score >= 70 THEN 'C'
           ELSE 'D'
       END AS grade
FROM a
LEFT JOIN b ON a.id = b.id;

/*Use it in where condition also :*/

SELECT id, name, age
FROM a
WHERE 
    CASE 
        WHEN age < 18 THEN 1
        WHEN age > 60 THEN 1
        ELSE 0
    END = 1;

/*Use case in ordering also :*/

SELECT id, name, age
FROM a
ORDER BY
    CASE 
        WHEN age < 18 THEN 1
        WHEN age BETWEEN 18 AND 30 THEN 2
        ELSE 3
    END;
/*We can use case statement anywhere and this is just an example. Going forward we can see where we can use case statements and we can learn !! Onwards and Upwards !!*/

























