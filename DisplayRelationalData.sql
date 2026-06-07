--Question 1
SELECT a.username,
       MIN(b.rating) AS lowest_rating
FROM userbase a
LEFT JOIN reviews b
    ON a.userid = b.userid
GROUP BY a.username
ORDER BY a.username;

--Question 2
SELECT a.email,
       b.question,
       b.answer
FROM userbase a
LEFT JOIN securityquestion b
    ON a.userid = b.userid;

--Question 3
SELECT a.firstname,
       a.email,
       a.walletfunds
FROM userbase a
LEFT JOIN wishlist b
    ON a.userid = b.userid
WHERE b.userid IS NULL;

--Question 4
SELECT a.username,
       COUNT(b.orderid) AS total_orders
FROM userbase a
LEFT JOIN orders b
    ON a.userid = b.userid
GROUP BY a.username
ORDER BY a.username;

--Question 5
SELECT a.username,
       FLOOR(MONTHS_BETWEEN(SYSDATE, a.birthday) / 12) AS age
FROM userbase a
INNER JOIN orders b
    ON a.userid = b.userid
WHERE b.purchasedate >= SYSDATE - 180;

--Question 6
SELECT a.username,
       a.birthday,
       COUNT(b.userid) AS total_friends
FROM userbase a
INNER JOIN friendslist b
    ON a.userid = b.userid
GROUP BY a.username,
         a.birthday
HAVING COUNT(b.userid) = (
    SELECT MAX(friend_count)
    FROM (
        SELECT COUNT(userid) AS friend_count
        FROM friendslist
        GROUP BY userid));

--Question 7
SELECT a.productname,
       a.releasedate,
       a.price,
       a.description
FROM productlist a
INNER JOIN wishlist b
    ON a.productcode = b.productcode;

--Question 8
SELECT a.productname,
       MAX(b.rating) as highest_rating,
       COUNT(b.rating) AS number_of_reivews
FROM productlist a
INNER JOIN reviews b
    ON a.productcode = b.productcode
GROUP BY a.productname
ORDER BY highest_rating DESC;

--Question 9
CREATE OR REPLACE VIEW product_rating_view AS 
SELECT a.productname,
       a.genre,
       b.rating
FROM productlist a
INNER JOIN reviews b
    ON a.productcode = b.productcode
WHERE b.rating = 1
    OR b.rating = 5;

SELECT productname,
       genre,
       rating
FROM product_rating_view
ORDER BY rating ASC;

--Question 10
SELECT a.genre,
       COUNT(b.productcode) AS order_count
FROM productlist a
INNER JOIN orders b
    ON a.productcode = b.productcode
GROUP BY a.genre
ORDER BY a.genre ASC;

--Question 11
CREATE OR REPLACE VIEW publisher_game_stats_view AS
SELECT a.publisher,
       AVG(a.price) AS average_price,
       SUM(b.hoursplayed) AS total_hours_played
FROM productlist a
INNER JOIN userlibrary b
    ON a.productcode = b.productcode
GROUP BY a.publisher;

SELECT *
FROM publisher_game_stats_view
ORDER BY publisher ASC;

--Question 12
SELECT a.publisher,
       SUM(b.price) AS total_spent
FROM productlist a
INNER JOIN orders b
    on a.productcode = b.productcode
GROUP BY a.publisher
ORDER BY total_spent DESC;

--Question 13
SELECT a.username,
       a.email,
       b.ticketid,
       b.issue
FROM userbase a
INNER JOIN usersupport b
    ON a.email = b.email
WHERE b.status = 'NEW' 
    OR b.status = 'IN PROGRESS' 
ORDER BY b.dateupdated DESC;

--Question 14
SELECT a.username,
       COUNT(b.ticketid) AS total_tickets
FROM userbase a
INNER JOIN usersupport b
    ON a.email = b.email
GROUP BY a.username
ORDER BY a.username;

--Question 15
SELECT a.userid,
       a.email
FROM userbase a
INNER JOIN usersupport b
    ON a.email = b.email
WHERE a.email LIKE '%' || a.firstname || '%'
    OR a.email LIKE '%' || a.lastname || '%'
    OR a.email LIKE '%' || a.firstname || a.lastname || '%';

--Question 16
SELECT a.email
FROM usersupport a
LEFT JOIN userbase b
    ON a.email = b.email
WHERE (a.status = 'NEW'
    OR a.status = 'IN PROGRESS')
    AND b.email is NULL;

--Question 17
SELECT a.ticketid,
       b.firstname,
       b.lastname,
       b.username
FROM usersupport a
INNER JOIN userbase b
    ON a.email = b.email
WHERE a.issue LIKE '%' || b.username || '%';

--Question 18
SELECT a.username,
       a.password
FROM userbase a
INNER JOIN usersupport b
    ON a.email = b.email;

--Question 19
CREATE OR REPLACE VIEW user_penalty_view AS
SELECT a.username,
       b.dateassigned,
       b.penalty
FROM userbase a
INNER JOIN infractions b
    ON a.userid = b.userid
WHERE b.dateassigned >= SYSDATE - 30
    AND b.penalty IS NOT NULL;

SELECT *
FROM user_penalty_view;

--Question 20
SELECT a.username,
       a.email
FROM userbase a
LEFT JOIN infractions b
    ON a.userid = b.userid
    AND b.dateassigned >= SYSDATE - 120
WHERE FLOOR(MONTHS_BETWEEN(SYSDATE, a.birthday) /12) >= 18
    AND b.userid IS NULL;

--Question 21
SELECT a.username,
       b.dateassigned,
       c.rulenum || ' ' || c.title AS guideline_name
FROM userbase a
INNER JOIN infractions b
    ON a.userid = b.userid
INNER JOIN communityrules c
    ON b.rulenum = c.rulenum;

--Question 22
SELECT a.userid,
       a.username,
       a.email,
       SUM(c.severitypoint) as total_points
FROM userbase a
INNER JOIN infractions b
    ON a.userid = b.userid
INNER JOIN communityrules c
    ON b.rulenum = c.rulenum
GROUP BY a.userid,
         a.username,
         a.email
ORDER BY a.userid;

--Question 23
SELECT a.title,
       a.description,
       b.penalty
FROM communityrules a
INNER JOIN infractions b
    ON a.rulenum = b.rulenum;

--Question 24
SELECT a.username,
       COUNT(b.userid) AS total_infractions
FROM userbase a
INNER JOIN infractions b
    ON a.userid = b.userid
GROUP BY a.username
HAVING COUNT(b.userid) >= 15;





