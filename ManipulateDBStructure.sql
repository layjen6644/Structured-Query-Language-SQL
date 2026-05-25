--Question 1
ALTER TABLE productlist
ADD (price NUMBER,
    description VARCHAR2(150));

UPDATE productlist
SET price = (SELECT price
            FROM storefront
            WHERE storefront.productcode = productlist.productcode
            AND rownum =1);

UPDATE productlist
SET description = (SELECT description
                  FROM storefront
                  WHERE storefront.productcode = productlist.productcode
                  AND rownum =1);

DROP TABLE storefront;

--Question 2
CREATE TABLE chatlog 
(chatid NUMBER(3), 
receiverid NUMBER(3), 
senderid NUMBER(3), 
datesent DATE, 
content VARCHAR2(250), 

CONSTRAINT pk_chatlog PRIMARY KEY (chatid), 

CONSTRAINT fk_chatlog_receiver 
    FOREIGN KEY (receiverid) 
    REFERENCES userbase(userid), 
    
    CONSTRAINT fk_chatlog_sender 
        FOREIGN KEY (senderid) 
        REFERENCES userbase(userid));

--Entered in one by one
INSERT INTO chatlog VALUES(1, 101, 102, SYSDATE, 'Hey, are you in a game?');
INSERT INTO chatlog VALUES (2, 101, 103, SYSDATE, 'What game are you in?');
INSERT INTO chatlog VALUES (3, 102, 101, SYSDATE, 'Let''s play Smash Tacos.');
INSERT INTO chatlog VALUES (4, 103, 102, SYSDATE, 'I''m studying. I can''t play right now');
INSERT INTO chatlog VALUES (5, 104, 101, SYSDATE, 'What are you doing tonight?');
INSERT INTO chatlog VALUES (6, 101, 104, SYSDATE, 'I can''t believe I beat that level.');
INSERT INTO chatlog VALUES (7, 105, 103, SYSDATE, 'What level are you on?');
INSERT INTO chatlog VALUES (8, 103, 105, SYSDATE, 'Let''s play at 8pm.');
INSERT INTO chatlog VALUES (9, 102, 104, SYSDATE, 'I NEED YOUR HELP!');
INSERT INTO chatlog VALUES (10, 104, 102, SYSDATE, 'THANKS!');

--Question 3
CREATE TABLE friendslist 
(userid NUMBER(3),
friendid NUMBER(3),

CONSTRAINT pk_friendslist PRIMARY KEY (userid, friendid),

CONSTRAINT fk_friendslist_user
    FOREIGN KEY (userid)
    REFERENCES userbase(userid),
    
CONSTRAINT fk_friendslist_friend
    FOREIGN KEY (friendid)
    REFERENCES userbase(userid));

--Entered in one by one
INSERT INTO friendslist VALUES (101, 102);
INSERT INTO friendslist VALUES (101, 103);
INSERT INTO friendslist VALUES (101, 104);
INSERT INTO friendslist VALUES (102, 101);
INSERT INTO friendslist VALUES (102, 104);
INSERT INTO friendslist VALUES (102, 103);
INSERT INTO friendslist VALUES (103, 101);
INSERT INTO friendslist VALUES (103, 102);
INSERT INTO friendslist VALUES (103, 105);
INSERT INTO friendslist VALUES (104, 101);
INSERT INTO friendslist VALUES (104, 102);
INSERT INTO friendslist VALUES (104, 103);
INSERT INTO friendslist VALUES (104, 104);
INSERT INTO friendslist VALUES (105, 101);
INSERT INTO friendslist VALUES (105, 102);

--Question 4
CREATE TABLE wishlist 
(userid NUMBER(3),
productcode VARCHAR2(5),
position NUMBER(3),

CONSTRAINT pk_wishlist PRIMARY KEY (userid, productcode),

CONSTRAINT fk_wishlist_user
    FOREIGN KEY (userid)
    REFERENCES userbase(userid),
    
CONSTRAINT fk_wishlist_product
    FOREIGN KEY (productcode)
    REFERENCES productlist(productcode));

--Entered in one by one
INSERT INTO wishlist VALUES(115, 'GAME2', 1);
INSERT INTO wishlist VALUES(114, 'GAME3', 3);
INSERT INTO wishlist VALUES(113, 'GAME6', 1);
INSERT INTO wishlist VALUES(112, 'GAME8', 2);
INSERT INTO wishlist VALUES(111, 'RPG10', 2);
INSERT INTO wishlist VALUES(110, 'VNL14', 1);
INSERT INTO wishlist VALUES(109, 'PZL11', 1);
INSERT INTO wishlist VALUES(108, 'GME13', 2);
INSERT INTO wishlist VALUES(107, 'GAME7', 3);
INSERT INTO wishlist VALUES(106, 'GAME4', 3);
INSERT INTO wishlist VALUES(105, 'GAME1', 2);
INSERT INTO wishlist VALUES(104, 'GAME5', 2);

--Question 5
CREATE TABLE userprofile
(userid NUMBER(3),
imagefile VARCHAR2(250),
description VARCHAR2(250),

CONSTRAINT pk_userprofile PRIMARY KEY (userid),

CONSTRAINT fk_userprofile_user
    FOREIGN KEY (userid)
    REFERENCES userbase(userid));

--Entered in one by one
INSERT INTO userprofile VALUES (101, 'img101.jpg', 'Gamer');
INSERT INTO userprofile VALUES (115, 'img102.jpg', 'NPC');
INSERT INTO userprofile VALUES (114, 'img103.jpg', 'N00b');
INSERT INTO userprofile VALUES (113, 'img104.jpg', 'GAMER');
INSERT INTO userprofile VALUES (112, 'img105.jpg', 'NPC');
INSERT INTO userprofile VALUES (111, 'img106.jpg', 'Puzzle Gamer');
INSERT INTO userprofile VALUES (110, 'img107.jpg', 'Streamer');
INSERT INTO userprofile VALUES (109, 'img108.jpg', 'Streamer');
INSERT INTO userprofile VALUES (108, 'img109.jpg', 'Roleplaying Gamer');
INSERT INTO userprofile VALUES (106, 'img110.jpg', 'Roleplaying Gamer');
INSERT INTO userprofile VALUES (105, 'img111.jpg', 'Coder');

--Question 6
CREATE TABLE securityquestion
(questionid NUMBER,
userid NUMBER(3),
question VARCHAR2(250),
answer VARCHAR2(250),

CONSTRAINT pk_securityquestion PRIMARY KEY (questionid),

CONSTRAINT fk_securityquestion_user
    FOREIGN KEY (userid)
    REFERENCES userbase(userid));

--Entered in one by one
INSERT INTO securityquestion VALUES (1, 101, 'What is your mom''s maiden name?', 'Brown');
INSERT INTO securityquestion VALUES (2, 102, 'What is your favorite color?', 'Brown');
INSERT INTO securityquestion VALUES (3, 103, 'What is your cat''s name?', 'Jelly');
INSERT INTO securityquestion VALUES (4, 104, 'What is your eye color?', 'Blue');
INSERT INTO securityquestion VALUES (5, 105, 'What type of car do you have?', 'Truck');
INSERT INTO securityquestion VALUES (6, 106, 'What is your favorite food?', 'Pizza');
INSERT INTO securityquestion VALUES (7, 107, 'What is your favorite movie?', 'Step Brothers');
INSERT INTO securityquestion VALUES (8, 108, 'What music do you like?', 'Country');
INSERT INTO securityquestion VALUES (9, 109, 'What state were you born in?', 'Montana');
INSERT INTO securityquestion VALUES (10, 110, 'What year were you born?', '2003');
INSERT INTO securityquestion VALUES (11, 111, 'What is your shoe size?', '8');

--Question 7
CREATE TABLE communityrules
(rulenum NUMBER(3),
title VARCHAR2(250),
description VARCHAR2(250),
severitypoint NUMBER(4),

CONSTRAINT pk_communityrules PRIMARY KEY (rulenum));

--Entered in one by one
INSERT INTO communityrules VALUES (1, 'No Harassment', 'Do not harass other users', 100);
INSERT INTO communityrules VALUES (2, 'No Inappropriate Language', 'Do not use inappropriate language', 90);
INSERT INTO communityrules VALUES (3, 'No Bullying', 'Do not bully other users', 90);
INSERT INTO communityrules VALUES (4, 'Be kind to others', 'Be courteous and kind to other users', 60);
INSERT INTO communityrules VALUES (5, 'No Rage Quitting', 'Don''t rage quit in the middle of a game', 40);
INSERT INTO communityrules VALUES (6, 'No crying', 'No crying allowed', 80);
INSERT INTO communityrules VALUES (7, 'No Stalking', 'No stalking other players', 100);
INSERT INTO communityrules VALUES (8, 'No Screaming', 'No screaming at other players', 70);
INSERT INTO communityrules VALUES (9, 'No Flirting', 'We are here to game, not to get married', 100);
INSERT INTO communityrules VALUES (10, 'HAVE FUN', 'Have the best time', 100);

--Question 8
CREATE TABLE infractions
(infractionid NUMBER,
userid NUMBER(3),
rulenum NUMBER(3),
dateassigned DATE,
penalty VARCHAR2(250),

CONSTRAINT pk_infractions PRIMARY KEY (infractionid),

CONSTRAINT fk_infractions_user 
    FOREIGN KEY (userid)
    REFERENCES userbase(userid),

CONSTRAINT fk_infractions_rules
    FOREIGN KEY (rulenum)
    REFERENCES communityrules(rulenum));

--Entered in one by one
INSERT INTO infractions VALUES(1, 101, 1, SYSDATE, 'Warning');
INSERT INTO infractions VALUES(2, 102, 2, SYSDATE, 'Locked out for 10 minutes');
INSERT INTO infractions VALUES(3, 103, 3, SYSDATE, 'Locked out for 20 minutes');
INSERT INTO infractions VALUES(4, 104, 4, SYSDATE, 'Locked out for 30 minutes');
INSERT INTO infractions VALUES(5, 105, 5, SYSDATE, 'Banned from game');
INSERT INTO infractions VALUES(6, 101, 2, SYSDATE, 'No gaming for 24 hours');
INSERT INTO infractions VALUES(7, 101, 3, SYSDATE, 'Chat disabled');
INSERT INTO infractions VALUES(8, 115, 2, SYSDATE, 'Chat disabled for life');
INSERT INTO infractions VALUES(9, 113, 8, SYSDATE, 'Account disabled for 30 days');
INSERT INTO infractions VALUES(10, 112, 10, SYSDATE, 'Account deleted');

--Question 9
CREATE TABLE usersupport
(ticketid NUMBER,
email VARCHAR2(250),
issue VARCHAR2(250),
dateSUBMITTED DATE,
dateupdated DATE,
status VARCHAR2(250),

CONSTRAINT pk_usersupport PRIMARY KEY (ticketid));

--Entered in one by one
INSERT INTO usersupport VALUES (1, 'gamer1@email.com', 'Forgot password', SYSDATE, SYSDATE, 'NEW');
INSERT INTO usersupport VALUES (2, 'gamer2@email.com', 'Forgot username', SYSDATE, SYSDATE, 'In Progress');
INSERT INTO usersupport VALUES (3, 'gamer3@email.com', 'Chat not working', SYSDATE, SYSDATE, 'In Progress');
INSERT INTO usersupport VALUES (4, 'gamer4@email.com', 'Minecraft is glitching', SYSDATE, SYSDATE, 'Closed');
INSERT INTO usersupport VALUES (5, 'gamer5@email.com', 'Player won''t move in game', SYSDATE, SYSDATE, 'New');
INSERT INTO usersupport VALUES (6, 'gamer6@email.com', 'User badwolf10 harrassing me', SYSDATE, SYSDATE, 'In Progress');
INSERT INTO usersupport VALUES (7, 'gamer7@email.com', 'Forgot password', SYSDATE, SYSDATE, 'In Progress');
INSERT INTO usersupport VALUES (8, 'gamer8@email.com', 'Game won''t open', SYSDATE, SYSDATE, 'Closed');
INSERT INTO usersupport VALUES (9, 'gamer9@email.com', 'Need to delete account', SYSDATE, SYSDATE, 'New');
INSERT INTO usersupport VALUES (10, 'gamer10@email.com', 'Account was hacked', SYSDATE, SYSDATE, 'In Progress');

--Question 10
CREATE VIEW securityquestion_view AS
SELECT DISTINCT question
FROM securityquestion;

CREATE VIEW tickets_view AS
SELECT ticketid,
       email,
       issue,
       dateupdated
FROM usersupport
WHERE status IN ('NEW', 'IN PROGRESS');

SELECT *
FROM tickets_view
ORDER BY dateupdated;
