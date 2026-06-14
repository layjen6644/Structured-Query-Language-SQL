--Question 1
SELECT userid
FROM userbase
MINUS
SELECT userid
FROM orders
ORDER BY userid;

--Question 2
SELECT productcode
FROM productlist
MINUS
SELECT productcode
FROM reviews
ORDER BY productcode;

--Question 3
SELECT userid,
       firstname,
       lastname,
       username,
       password,
       email,
       birthday,
       walletfunds,
       'Adult' AS adult_or_minor
FROM userbase
WHERE birthday <= ADD_MONTHS(SYSDATE, - 216)
UNION ALL
SELECT userid,
       firstname,
       lastname,
       username,
       password,
       email,
       birthday,
       walletfunds,
       'Minor' AS adult_or_minor
FROM userbase
WHERE birthday > ADD_MONTHS(SYSDATE, - 216)
ORDER BY userid;

--Question 4
SELECT productname,
       productcode,
       publisher,
       genre,
       releasedate,
       price,
       description,
       'ON SALE' AS status
FROM productlist
WHERE price <= 20
UNION ALL
SELECT productname,
       productcode,
       publisher,
       genre,
       releasedate,
       price,
       description,
       'BASE PRICE' AS status
FROM productlist
WHERE price > 20
ORDER BY productname;

--Question 5
SELECT userid
FROM userlibrary
WHERE productcode = 'GAME6'
INTERSECT
SELECT userid
FROM userprofile
WHERE imagefile IS NOT NULL
ORDER BY userid;

-Question 6
SELECT productcode
FROM wishlist
WHERE position = 1
    OR position = 2
INTERSECT
SELECT productcode
FROM reviews
WHERE rating >= 3
ORDER BY productcode;

--Question 7
SELECT a.username,
       a.birthday,
       b.username,
       b.birthday
FROM userbase a,
     userbase b
WHERE a.birthday = b.birthday
    AND a.userid != b.userid
ORDER BY a.username;

--Question 8
SELECT *
FROM userlibrary
CROSS JOIN wishlist;

--Question 9
SELECT username AS NAME,
       'User' AS TYPE
FROM userbase
UNION ALL
SELECT productname,
       'Product'
FROM productlist;

--Question 10
SELECT senderid AS userid,
       content AS details,
       'CHAT SENT' AS activity
FROM chatlog
UNION ALL
SELECT userid, 
       description,
       'PROFILE LABEL CREATED'
FROM userprofile;

--Question 11
SELECT username
FROM userbase
WHERE userid IN (
    SELECT userid 
    FROM userbase
    MINUS
    SELECT userid
    FROM infractions)
ORDER BY username;

--Question 12
SELECT title,
       description
FROM communityrules
WHERE rulenum IN (
     SELECT rulenum
     FROM communityrules
     MINUS
     SELECT rulenum
     FROM infractions)
ORDER BY title;

--Question 13
SELECT username,
       email
FROM userbase
WHERE userid IN (
    SELECT userid
    FROM userbase
    INTERSECT
    SELECT userid
    FROM infractions)
ORDER BY username;

--Question 14
SELECT dateassigned
FROM infractions
INTERSECT
SELECT datesubmitted 
FROM usersupport;

--Question 15
SELECT a.title,
       b.penalty
FROM communityrules a,
     infractions b
WHERE a.rulenum = b.rulenum
ORDER BY title;

--Question 16
SELECT rulenum,
       title,
       description,
       severitypoint,
       'BANNABLE' as outcome
from communityrules
WHERE severitypoint >= 10
UNION ALL
SELECT rulenum,
       title,
       description,
       severitypoint,
       'APPEALABLE'
from communityrules
WHERE severitypoint < 10
    OR severitypoint IS NULL
ORDER BY rulenum;

--Question 17
SELECT ticketid,
       email,
       issue,
       datesubmitted,
       dateupdated,
       status,
       'HIGH PRIORITY' AS priority 
FROM usersupport
WHERE status != 'CLOSED'
    AND dateupdated < SYSDATE - 7
UNION ALL
SELECT ticketid,
       email,
       issue,
       datesubmitted,
       dateupdated,
       status,
       'NORMAL PRIORITY'  
FROM usersupport
WHERE status = 'CLOSED'
   OR dateupdated >= SYSDATE - 7
ORDER BY ticketid;

--Question 18
SELECT *
FROM usersupport
CROSS JOIN infractions;

--Question 19
SELECT ticketid,
       dateupdated
FROM usersupport
WHERE status = 'CLOSED'
  AND dateupdated = TRUNC(SYSDATE);

--Question 20
SELECT userid,
       'JOINED' AS activity_type,
       NULL AS activity_date
FROM userbase
UNION ALL
SELECT userid,
       'INFRACTION' AS activity_type,
       dateassigned AS activity_date
FROM infractions
ORDER BY userid;
