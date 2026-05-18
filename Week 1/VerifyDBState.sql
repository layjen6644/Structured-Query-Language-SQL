--Layla Jenkins
--Question 1
SELECT user_id,
       username,
       created,
       password_change_date
FROM user_users;

--Question 2
SELECT * 
FROM user_tables;

--Question 3
--To be ran separately
DESC orders;
DESC productlist;
DESC reviews;
DESC storefront;
DESC userbase;
DESC userlibrary;

--Question 4
--To be ran separately
SELECT *
FROM orders;
SELECT *
FROM productlist;
SELECT *
FROM reviews;
SELECT *
FROM storefront;
SELECT *
FROM userbase;
SELECT *
FROM userlibrary;

--Question 5
SELECT table_name,
       constraint_name,
       constraint_type,
       status
FROM user_constraints;

--Question 6
SELECT view_name,
       text
FROM user_views;

--Question 7
SELECT username
FROM user_users
ORDER BY username;

--Question 8
SELECT firstname,
       lastname,
       username,
       password,
       email
FROM userbase
WHERE email LIKE '%yahoo%';

--Question 9
SELECT username,
       birthday,
       walletfunds
FROM userbase
WHERE walletfunds < 25;

--Question 10
SELECT userid,
       productcode,
       hoursplayed
FROM userlibrary
WHERE hoursplayed > 100;

--Question 11
SELECT productcode,
       hoursplayed
FROM userlibrary
WHERE hoursplayed < 10;

--Question 12
SELECT DISTINCT publisher
FROM productlist;

--Question 13
SELECT productname,
       releasedate,
       publisher,
       genre
FROM productlist
ORDER BY genre;

--Question 14
SELECT productcode,
       publisher,
       genre
FROM productlist
WHERE genre = 'Strategy';

--Question 15
SELECT productcode,
       description,
       price
FROM storefront
WHERE price > 25
ORDER BY price DESC;

--Question 16
SELECT inventoryid,
       price
FROM storefront
ORDER BY price;

--Question 17
SELECT productcode,
       review,
       rating
FROM reviews
WHERE rating = 1;

--Question 18
SELECT productcode,
       review,
       rating
FROM reviews
WHERE rating >= 4;

--Question 19
SELECT DISTINCT userid
FROM orders;

--Question 20
SELECT *
FROM orders
ORDER BY purchasedate;
