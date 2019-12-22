USE PersonalTrainer;

-- Select all rows and columns from the Exercise table.
-- 64 rows
--------------------
SELECT *
FROM Exercise;

-- Select all rows and columns from the Client table.
-- 500 rows
--------------------
SELECT *
FROM Client;

-- Select all columns from Client where the City is Metairie.
-- 29 rows
--------------------
SELECT * FROM Client WHERE City LIKE 'Metairie';
-- Is there a Client with the ClientId '818u7faf-7b4b-48a2-bf12-7a26c92de20c'?
-- nope
SELECT * FROM Client WHERE ClientId LIKE '818u7faf-7b4b-48a2-bf12-7a26c92de20c';
--------------------

-- How many rows in the Goal table?
-- 17 rows
SELECT * FROM Goal;
--------------------

-- Select Name and LevelId from the Workout table.
-- 26 rows
SELECT Name, LevelId FROM Workout;
--------------------

-- Select Name, LevelId, and Notes from Workout where LevelId is 2.
-- 11 rows
SELECT Name, LevelId, Notes FROM Workout WHERE LevelId LIKE '2';
--------------------

-- Select FirstName, LastName, and City from Client 
-- where City is Metairie, Kenner, or Gretna.
-- 77 rows
SELECT FirstName, LastName, City FROM Client WHERE City IN ('Metairie', 'Kenner', 'Gretna');
--------------------

-- Select FirstName, LastName, and BirthDate from Client
-- for Clients born in the 1980s.
-- 72 rows
SELECT FirstName, LastName, BirthDate FROM Client WHERE BirthDate BETWEEN '1980-01-01' AND '1989-12-31';
--------------------

-- Write the query above in a different way. 
-- If you used BETWEEN, you can't use it again.
-- If you didn't use BETWEEN, use it!
-- Still 72 rows
SELECT FirstName, LastName, BirthDate FROM Client WHERE BirthDate > '1979-12-31' AND BirthDate < '1990-01-01';
--------------------

-- How many rows in the Login table have a .gov EmailAddress?
-- 17 rows
SELECT * FROM Login WHERE EmailAddress LIKE '%.gov';
--------------------

-- How many Logins do NOT have a .com EmailAddress?
-- 122 rows
SELECT * FROM Login WHERE EmailAddress NOT LIKE '%.com';
--------------------

-- Select first and last name of Clients without a BirthDate.
-- 37 rows
SELECT FirtName, LastName FROM Clients WHERE BirthDate = NULL;
--------------------

-- Select the Name of each ExerciseCategory that has a parent.
-- (ParentCategoryId value is not null)
-- 12 rows
SELECT * FROM ExerciseCategory WHERE ParentCategoryId IS NOT NULL; 
--------------------

-- Select Name and Notes of each level 3 Workout that
-- contains the word 'you' in its Notes.
-- 4 rows
SELECT Name, Notes FROM Workout WHERE LevelId = 3 AND Notes LIKE '%you%';
--------------------

-- Select FirstName, LastName, City from Clients who have a LastName
-- that starts with L,M, or N and who live in LaPlace.
-- 5 rows

SELECT FirstName, LastName, City 
FROM Client 
WHERE City = 'LaPlace' AND 
(LastName LIKE 'L%' OR LastName LIKE 'M%' OR LastName LIKE 'N%');

--------------------

-- Select InvoiceId, Description, Price, Quantity, ServiceDate 
-- and the line item total, a calculated value, where the line item total
-- is between 15 and 25 dollars.
-- 667 rows
SELECT InvoiceId, Description, Price, Quantity, ServiceDate, Price*Quantity AS 'LineItemTotal'
FROM invoicelineitem
WHERE Price*Quantity <= 25 AND Price*Quantity >= 15;
--------------------

-- Does the Client, Estrella Bazely, have a Login? 
-- If so, what is her email address?
-- This requires two queries:
-- First, select a Client record for Estrella Bazely. Does it exist?
-- Second, if it does, select a Login record that matches its ClientId.
SELECT *
FROM Client
WHERE LastName LIKE 'Bazely' AND FirstName LIKE 'Estrella';
SELECT ClientId
FROM  

--------------------

-- What are the Goals of the Workout with the Name 'This Is Parkour'?
-- You need three queries!:
-- 1. Select the WorkoutId from Workout where Name equals 'This Is Parkour'.
-- 2. Select GoalId from WorkoutGoal where the WorkoutId matches the WorkoutId
--    from your first query.
-- 3. Select everything from Goal where the GoalId is one of the GoalIds from your
--    second query.
-- 1 row, 3 rows, 3 rows
--------------------
