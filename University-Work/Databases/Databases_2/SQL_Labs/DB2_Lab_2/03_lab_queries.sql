/*Lab 2 - Adam El Soudi & Gustav Grip*/

-- Uppgift 1
-- Skapar en vy som heter all_users som visar användarnamnet och antalet vänner för varje användare i friends-tabellen.
-- Detta görs genom att göra en JOIN mellan tabellerna friends och users på id, och sedan gruppera resultaten efter användarnamnet.
CREATE VIEW all_users AS SELECT users.username AS users, COUNT(*) AS no_of_friends FROM friends
    JOIN users ON users.id = friends.f_id
    GROUP BY users;

SELECT * FROM all_users;

-- Uppgift 2
-- kapar en vy som visar användarnamnet och namnet på vännerna för varje användare i users-tabellen.
-- Detta görs genom att göra JOINs mellan tabellerna users, friends och users igen för att matcha u_id och f_id.
CREATE VIEW friends_list AS SELECT u.username, f.username AS friendname FROM users u
    JOIN friends ON friends.u_id = u.id
    JOIN users f ON friends.f_id = f.id;
    
SELECT * FROM friends_list;
-- Uppgift 3
-- Skapar en ny procedur med namnet user_email som, när den körs, returnerar förnamn och email för alla användare i users-tabellen.
DROP PROCEDURE IF EXISTS user_email

DELIMITER //
CREATE PROCEDURE user_email()
BEGIN
SELECT users.fname, users.email FROM users;
END // 
DELIMITER ;

CALL user_email();

-- Uppgift 4
-- Skapar en ny procedur med namnet add_hobby som tar emot två parametrar, hobby_name och hobby_desc, och lägger till en
-- ny rad i hobbies-tabellen med dessa värden.

DROP PROCEDURE add_hobby;

DELIMITER //
CREATE PROCEDURE add_hobby(IN hobby_name VARCHAR(32), IN hobby_desc VARCHAR(128))
BEGIN 
INSERT INTO hobbies (name, description) VALUES (hobby_name, hobby_desc);
END //
DELIMITER ;

SELECT * FROM hobbies;
CALL add_hobby("hej", "hej2");

-- Uppgift 5
-- Skapar en ny procedur med namnet add_user som tar emot sex parametrar, username, pass, fname, lname, email, och age, och
-- lägger till en ny rad i users-tabellen med dessa värden.
DROP PROCEDURE IF EXISTS add_user;
DELIMITER //
CREATE PROCEDURE add_user(IN username VARCHAR(32), IN  pass VARCHAR(32), IN email VARCHAR(32), IN fname VARCHAR(32), IN lname VARCHAR(32), IN age VARCHAR(32))
BEGIN
INSERT INTO users (username, pass, email, fname, lname, age) VALUES (username, pass, email, fname, lname, age);
SELECT LAST_INSERT_ID() AS "New User";
INSERT INTO users_hobbies(u_id, h_id) VALUES (LAST_INSERT_ID(), 1) ;
END //
DELIMITER ;

SELECT * FROM users;
CALL add_user("Adam1233", "pass1", "mail", "Adam", "El", 20);

-- Uppgift 6
-- Skapar en ny procedur med namnet add_friendship som tar emot två parametrar, id_a och id_b, och lägger till två rader i 
-- friends-tabellen. Dessa rader representerar vänskapsförhållandet mellan användare med id_a och id_b, så att båda användarna är varandras vänner.
DROP PROCEDURE IF EXISTS add_friendship;
DELIMITER //
CREATE PROCEDURE add_friendship(IN id_a INT, IN id_b INT)
BEGIN
INSERT INTO friends (u_id, f_id) VALUES (id_a, id_b);
INSERT INTO friends (u_id, f_id) VALUES (id_b, id_a);
END //
DELIMITER ;

CALL add_friendship(22, 1);
SELECT * FROM friends;

-- Uppgift 7
-- Dessa två triggers kontrollerar om en ny användare som försöker läggas till eller uppdateras har en ålder som är 15 eller äldre.
-- Om inte, kommer ett felmeddelande att visas.

DELIMITER //
CREATE TRIGGER agecheck_before_insert
BEFORE INSERT ON users
FOR EACH ROW
BEGIN
  IF NEW.age < 15 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Age must be 15 or greater';
  END IF;
END //
DELIMITER ;

DELIMITER //
INSERT INTO users VALUES(20, "Adam1232", "pass12", "mail2", "Adam2", "El2", 10);

CREATE TRIGGER agecheck_before_update
BEFORE UPDATE ON users
FOR EACH ROW
BEGIN
  IF NEW.age < 15 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Age must be 15 or greater';
  END IF;
END //
DELIMITER ;

UPDATE users SET age = 14 WHERE id = 19;

-- Uppgift 8
-- Denna funktion skapar en hälsning till en användare med det angivna förnamnet.
DROP FUNCTION IF EXISTS greeting;

DELIMITER //
CREATE FUNCTION greeting (fname VARCHAR(32))
RETURNS VARCHAR(32) DETERMINISTIC
BEGIN
	DECLARE gr VARCHAR(32);
    SET gr = CONCAT("Welcome ", fname, "!");
    RETURN gr;
    END;
    //
    DELIMITER ;

SELECT greeting("Adam");

-- Uppgift 9
-- Denna procedur föreslår vänner för en användare med det angivna användarnamnet. Den hämtar först gemensamma vänner och sedan
-- föreslår användare som inte redan är vänner med den angivna användaren. Det finns en begränsning på tre förslag.

DROP PROCEDURE suggest_friends;

DELIMITER //
CREATE PROCEDURE suggest_friends(IN user VARCHAR(20))

BEGIN
IF ((SELECT COUNT(u3.id) FROM users u1
    JOIN friends f1 ON f1.u_id = u1.id
    JOIN users u2 ON u2.id = f1.f_id
    JOIN friends f2 ON f2.u_id = u2.id
    JOIN users u3 ON f2.f_id = u3.id
    WHERE u1.id != u3.id AND u3.id NOT IN (SELECT f_id FROM friends WHERE u_id = u1.id) AND u1.username = user
    ORDER BY u1.username LIMIT 3) < 1) THEN SELECT 'no friends';
        ELSE 
SELECT u1.username, u2.username AS mutual_friends, u3.username AS suggested_friends FROM users u1
    JOIN friends f1 ON f1.u_id = u1.id
    JOIN users u2 ON u2.id = f1.f_id
    JOIN friends f2 ON f2.u_id = u2.id
    JOIN users u3 ON f2.f_id = u3.id
    WHERE u1.id != u3.id AND u3.id NOT IN (SELECT f_id FROM friends WHERE u_id = u1.id) AND u1.username = user
    ORDER BY u1.username
    LIMIT 3;
    END IF;

END //
DELIMITER ;

CALL suggest_friends('cersei');

-- Uppgift 10
-- Denna procedur tar bort en användare med det angivna ID:t och alla relaterade poster i tabellerna "users_hobbies" och "friends"
DROP PROCEDURE delete_user;

DELIMITER //
CREATE PROCEDURE delete_user(id INT)
BEGIN
DELETE FROM friends WHERE friends.u_id = id OR friends.f_id = id;
DELETE FROM users_hobbies WHERE users_hobbies.u_id = id;
DELETE FROM users WHERE users.id = id;
END //
DELIMITER ;

CALL delete_user(23);

-- Uppgift 11
-- Denna procedur listar alla hobbies och hur många användare som har dem.
DROP PROCEDURE list_hobbies_count;

DELIMITER //
CREATE PROCEDURE list_hobbies_count()
BEGIN
    SELECT h.name, COUNT(uh.h_id) as hobby_count
    FROM hobbies h
    JOIN users_hobbies uh ON h.id = uh.h_id
    GROUP BY h.name;
END //
DELIMITER ;

CALL list_hobbies_count();


-- Uppgift 12
-- Denna funktion skapar ett avsked till en användare med det angivna förnamnet.
DROP FUNCTION IF EXISTS goodbye;

DELIMITER //
CREATE FUNCTION goodbye (fname VARCHAR(32))
RETURNS VARCHAR(32) DETERMINISTIC
BEGIN
	DECLARE gb VARCHAR(32);
    SET gb = CONCAT("Goodbye ", fname, "!");
    RETURN gb;
    END;
    //
    DELIMITER ;

SELECT goodbye('John');
