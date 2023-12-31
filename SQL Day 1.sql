/*Create_Statements*/

Create Table Customers_21 (Cust_Id int(50) primary key, Cust_First_Name varchar(100), Cust_Last_name varchar(100), Cust_Phone_No varchar(12), Cust_Address varchar(1000));

/*Insert_tatements*/

INSERT INTO Customers_21 (Cust_Id, Cust_First_Name, Cust_Last_Name, Cust_Phone_No, Cust_Address)
VALUES (0001, 'Navin', 'Nishanth', '9999999999', 'No 2, Virugambakkam');
INSERT INTO Customers_21 (Cust_Id, Cust_First_Name, Cust_Last_Name, Cust_Phone_No, Cust_Address)
VALUES (0001, '', 'Nishanth', '', 'No 3, Virugambakkam');
INSERT INTO Customers_21 (Cust_Id, Cust_First_Name, Cust_Last_Name, Cust_Phone_No, Cust_Address)
VALUES (null, null, 'Nishanth', '', 'No 4, Virugambakkam');

/*Select_Statements*/

SELECT * FROM [Customers_21]

/*It displays number of rows we inserted*/

SELECT * FROM [Customers_21] WHERE Cust_First_Name IS NULL (Returns null rows)

SELECT * FROM [Customers_21] WHERE Cust_First_Name = 'Navin' (Returns the said value)

SELECT * FROM [Customers_21] WHERE Cust_First_Name not in ('Navin') (Returns the value that is not Navin)

SELECT * FROM [Customers_21] where cust_id is null and Cust_Last_name like 'Nish%' (Used a wildcard after few letters)

SELECT * FROM [Customers_21] where   Cust_Last_name like '%sh%' (Used a wildcard before and after the word 'Sh' to see how many names are actually popping up)

SELECT * FROM [Customers_21] where   Cust_Last_name like '__sh%' (Used a wildcard and a 2 underscores to denote that I dunno 2 words)

/*Update Statements :*/

UPDATE [Customers_21] 
SET Cust_Id = 3 
WHERE Cust_Id IS NULL (Updates the value in the Cust_id)

UPDATE [Customers_21] 
SET Cust_First_Name = "Niish"
WHERE Cust_First_Name IS NULL; (Updates the value in the customer name)

/*Alter Statements:*/

ALTER TABLE Customers_21
RENAME TO New_Customers_21; (Rename the table)

ALTER TABLE New_Customers_21
MODIFY COLUMN Cust_Id int(50) NOT NULL (Rename a column)

ALTER TABLE New_Customers_21
ADD COLUMN New Varchar(4); (add a new column)

Drop Delete Truncate : Drop means dropping a entire table, delete means deleting a specific instance and truncate means clear the table

drop  table [Customers_22] (drops the entire table from database)

delete * from New_Customers_21 where Cust_id = 3 (deletes the entire row)

Truncate table New_Customers_21

/*Joins Basic :

Inner Join : Its gives out only the common value
Left and Right Join : Based upon the tables you join on left or right the value changes*/

select * from customers join orders on customers.customerId = orders.customerId (Number of records 196)

select * from customers left join orders on customers.customerId = orders.customerId (Number of records 203)

select * from customers right join orders on customers.customerId = orders.customerId (Number of records 196)








