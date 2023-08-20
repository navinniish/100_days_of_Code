/*Today we are gonna see about operators in SQL along with the aggregate functions*/

/*Addition operator : + */

SELECT 1+1

/*Here it selects 1 and then adds 1. So we get 2. Similarly, we can use the (-) subtraction operator*/

SELECT 22222-111111

/*Here it subtracts the value. Sometimes in some SQLs you cant use directly you have to use the 'dual' command*/

That is: SELECT 22222*111111 from Dual (here the dual acts as a table retrieving the rows)

/*Multiplication Operator: You can use the multiplication operator also in SQL (*)*/

SELECT 22222*111111

/*Division Operator: The division operator is used to divide the numerator by the denominator*/

SELECT 22222/111111

/*Modulo Operator: % Modulo operator divides the left-hand side by right-hand side and notes the quotient*/

SELECT 22222%111111

/*These are all the Arithmetic Operators

Now let's see the comparison operators. Comparison operators return only binary values (True or False) in the form of 0 and 1*/

SELECT 22222<111111

/*Here it checks 22222 is less than 11111 and returns 1 because it knows it is false*/

SELECT 22222>111111

/*While doing this it checks 22222 is greater than 11111 and returns 0 because it knows it is true*/

/*We can use the customer Database. !! */

SELECT *  FROM [Customers] where CustomerID > 2 /* (This returns the customer id that is greater than 2)*/

SELECT *  FROM [Customers] where CustomerID >= 2 /* (Greater than or equal to) This returns whether the given number is greater than or equal to 2*/

SELECT *  FROM [Customers] where CustomerID <= 2 /* (Less than or equal to)  This returns whether a given number is lesser than or equal to 2*/

SELECT *  FROM [Customers] where CustomerID <> 2 or SELECT *  FROM [Customers] where CustomerID != 2 /*(Not equal to)This returns whether a given number is not equal to 2*/

/*Now logical operators like and or not . Just likes the gates we studied in 12th*/

SELECT *  FROM [Customers] where CustomerID >	 2 and CustomerID < 4 /*[And verifies both condition are satisfied]*/


SELECT *  FROM [Customers] where CustomerID >	 2 or CustomerID < 4 /*[or verifies either one of the condition are satisfied]*/

SELECT *  FROM [Customers] where  not CustomerID > 4 /*[ Not checks the reverse of the conditional operator applied)*/

SELECT *  FROM [Customers] where CustomerID between   4 and 8 /*[Between checks the condition is between the number 4 and 8 and gives the answer]*/

SELECT ProductName , ProductID
FROM Products
WHERE ProductID = ANY (SELECT ProductID FROM OrderDetails WHERE Quantity = 1) /*[This condition checks where the quantity = 1 and returns any of the value)*/

SELECT ProductName , ProductID
FROM Products
WHERE ProductID = ALL (SELECT ProductID FROM OrderDetails WHERE Quantity = 1) /*(This query returns 0 results because there are obiously greater than 10)*/

SELECT ProductName , ProductID
FROM Products
WHERE ProductID is null /*(This one gives the value where the productid is null)*/

/*So that is all about operators !! */










