/*day2 */

/*What is groupby? Group by the name itself tells we are grouping by it. Group by what it does it that it groups for ex : */

SELECT CategoryID, Sum(Price) FROM [Products] group by CategoryID 

/*Here it groups based on category id and gives the sum of price. We can calculate avg min max by using it.*/

/*Min :*/ SELECT CategoryID, min(Price) FROM [Products] group by CategoryID (This calculation gives the what is the minimum price of a product in the category)

/*Max :*/ SELECT CategoryID, max(Price) FROM [Products] group by CategoryID (This calculation gives the what is the maximum price of a product in the category)

/*Count :*/ SELECT SupplierID, Count(ProductName) FROM [Products] group by SupplierID (This calculation gives the what is the Counts of a product in the category)

/*Now we can go deeper into this groupby and add a having. What is having? Having is a clause used with group by (Most of times) and it is used with aggregate functions and where "where" is not used

Ex : */

SELECT SupplierID, Count(ProductName) as C FROM [Products] group by SupplierID
having c > 3 [Here the having clause used to get the counts that are going to be greater than 3)

SELECT SupplierID, Count(ProductName) as C FROM [Products] group by SupplierID
having c < 3 and c > 1 (Here having is used to get that counts that are lesser than 3 and greater than 1) 

Order by Clause : Now orderby its just order it by ascending or descending

SELECT SupplierID, Count(ProductName) as C FROM [Products] group by SupplierID
having  c > 1 order by c desc [This is just orders by descending] 

/*and if you just use order by it does by default ascending :*/

SELECT SupplierID, Count(ProductName) as C FROM [Products] group by SupplierID
having  c > 1 order by c

/*Three with Join : */

SELECT s.SupplierID,SupplierName, Count(ProductName) as C FROM [Products] p 
join suppliers s on s.SupplierID = p.SupplierID
group by s.SupplierID, SupplierName
having  c > 1 order by c desc

/*We got the supplier name counted by the productname and grouped by the supplier id having count greater than 1 ordered by desc...!!!

Now we continue from the prev day of using where !!!*/

SELECT s.SupplierID,SupplierName, Count(ProductName) as C FROM [Products] p 
join suppliers s on s.SupplierID = p.SupplierID
where SupplierName like 'A%'
group by s.SupplierID, SupplierName
having  c > 1 order by c desc

/*It now picks up only where the names start from A*/


SELECT s.SupplierID,SupplierName, Count(ProductName) as C FROM [Products] p 
join suppliers s on s.SupplierID = p.SupplierID
where SupplierName like any ('A%', 'B%')
group by s.SupplierID, SupplierName
having  c > 1 order by c desc

/*Now it picks up two characters namely A and B because we have included them in the like statement*/


SELECT s.SupplierID,SupplierName, Count(ProductName) as C FROM [Products] p 
join suppliers s on s.SupplierID = p.SupplierID
where SupplierName not like any ('A%', 'B%')
group by s.SupplierID, SupplierName
having  c > 1 order by c desc

/*Now it picks up characters other than A and B because we have included them in the like statement*/


SELECT s.SupplierID,SupplierName, Count(ProductName) as C FROM [Products] p 
join suppliers s on s.SupplierID = p.SupplierID
where SupplierName not in ('Pavlova, Ltd.	')
group by s.SupplierID, SupplierName
having  c > 1 order by c desc

/*Now it picks up only characters other than 'Pavlova, Ltd.	' because we have included them in the in statement and have also put not operators.*/



