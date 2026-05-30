--Question 1
--ORDERS table
ALTER TABLE orders
ADD CONSTRAINT fk_orders_users
FOREIGN KEY (userid) REFERENCES userbase(userid);

ALTER TABLE orders
ADD CONSTRAINT fk_orders_productlist
FOREIGN KEY (productcode) REFERENCES productlist(productcode);

--REVIEWS table
ALTER TABLE reviews
ADD CONSTRAINT fk_reviews_users
FOREIGN KEY (userid) REFERENCES userbase(userid);

ALTER TABLE reviews
ADD CONSTRAINT fk_reviews_productlist
FOREIGN KEY (productcode) REFERENCES productlist(productcode);

--USERLIBRARY table
ALTER TABLE userlibrary
ADD CONSTRAINT fk_userlibrary_users
FOREIGN KEY (userid) REFERENCES userbase(userid);

ALTER TABLE userlibrary
ADD CONSTRAINT fk_userlibrary_productlist
FOREIGN KEY (productcode) REFERENCES productlist(productcode);

--Question 2
SELECT firstname || ' ' || lastname AS full_name,
       username
FROM userbase
WHERE FLOOR(months_between(SYSDATE, birthday) / 12) >= 18;

--Question 3
SELECT MAX(LENGTH(username)) AS max_username,
       AVG(LENGTH(username)) AS avg_username
FROM userbase;

--Question 4
SELECT question
FROM securityquestion
WHERE question LIKE 'What is%'
      OR question LIKE 'What was%';

--Question 5
SELECT productcode,
       MIN(rating) AS lowest_rating,
       COUNT(*) AS review_count
FROM reviews
GROUP BY productcode
ORDER BY review_count DESC;

--Question 6
SELECT productcode,
       COUNT(*) AS user_count
FROM wishlist
WHERE position = 1
GROUP BY productcode;

--Question 7
SELECT userid,
       SUM(price) AS total_spent
FROM orders
GROUP BY userid;

--Question 8
SELECT purchasedate,
       SUM(price) AS profits
FROM orders
GROUP BY purchasedate
ORDER BY profits DESC; 

--Question 9
SELECT productcode,
       SUM(hoursplayed) as total_hours
FROM userlibrary
GROUP BY productcode
ORDER BY total_hours DESC
FETCH FIRST 5 ROWS ONLY;

--Question 10
CREATE OR REPLACE VIEW user_infractions_view AS 
SELECT userid,
       COUNT(*) as infraction_num
FROM infractions
GROUP BY userid
ORDER BY infraction_num DESC;

--Question 11
CREATE OR REPLACE VIEW user_infraction_rule_view AS 
SELECT userid,
       rulenum,
       COUNT(*) AS infraction_num
FROM infractions
GROUP BY userid,
         rulenum
ORDER BY userid;

--Question 12
CREATE OR REPLACE VIEW infraction_penalty_view AS 
SELECT rulenum,
       penalty,
       COUNT(*) AS penalty_num
FROM infractions
GROUP BY rulenum,
         penalty;

--Question 13
SELECT AVG(dateupdated - datesubmitted) AS avg_turnaround,
       MAX(dateupdated - datesubmitted) AS max_turnaround,
       MIN(dateupdated - datesubmitted) AS min_turnaround
FROM usersupport
WHERE status = 'CLOSED';

--Question 14
SELECT email,
       issue,
       datesubmitted,
       COUNT(*) AS issue_num
FROM usersupport
WHERE status = 'NEW'
GROUP BY email,
         issue,
         datesubmitted
ORDER BY issue_num;

--Question 15
SELECT userid,
       firstname,
       lastname,
       password
FROM userbase
WHERE password LIKE '%' || firstname || '%'
      OR password LIKE '%' || lastname || '%';

--Question 16
SELECT publisher,
       AVG(price) AS average_price
FROM productlist
GROUP BY publisher
ORDER BY publisher;

--Question 17
CREATE OR REPLACE VIEW productdiscount_view AS
SELECT productname,
       price * 0.75 AS price_discount
FROM productlist
WHERE releasedate < ADD_MONTHS(SYSDATE, -60);

--Question 18
SELECT genre,
       MAX(price) AS max_price,
       MIN(price) as min_price
FROM productlist
GROUP BY genre;

--Question 19
CREATE OR REPLACE VIEW chatlog_view AS
SELECT *
FROM chatlog
WHERE datesent BETWEEN SYSDATE - 7 AND SYSDATE;

--Question 20
CREATE OR REPLACE VIEW new_penalties_view AS
SELECT userid,
       dateassigned,
       penalty
FROM infractions
WHERE penalty IS NOT NULL
      AND dateassigned >= ADD_MONTHS(SYSDATE, -1);
