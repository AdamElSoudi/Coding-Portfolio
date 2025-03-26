-- Lab 3 - Adam El Soudi & Gustav Grip

-- Uppgift 1


-- a)
-- Hämtar veckodagen för den sista dagen i nuvarande månad.
SELECT DAYNAME(LAST_DAY(NOW())) AS 'Sista dagen nuvarande månad';

-- b)
-- Hämtar veckodagen för första dagen i nästa månad.
SELECT DAYNAME(DATE_ADD(LAST_DAY(NOW()), INTERVAL 1 DAY)) AS 'Veckodag på första dagen i nästa månad';

-- c)
-- Hämtar veckodagen för nyårsafton 2025.
SELECT DAYNAME('2025-12-31') AS 'Veckodag på nyårsafton 2025';


-- Uppgift 2
-- Beräknar antalet dagar sedan 2021-08-30 till nuvarande datum.
SELECT DATEDIFF(NOW(), '2021-08-30') AS 'Antal dagar sedan 2021-08-30';

-- Uppgift 3
-- Skapar en procedur som räknar ner antalet minuter tills lunchtid.
DROP PROCEDURE lunch_countdown;
    
DELIMITER //
CREATE PROCEDURE lunch_countdown()
BEGIN
  IF NOW() < TIME("12:00:00") THEN
    SELECT TIMESTAMPDIFF(MINUTE, NOW(), TIME("12:00:00")) AS minutes_until_lunch;
  ELSEIF NOW() > TIME("12:00:00") THEN
    SELECT TIMESTAMPDIFF(MINUTE, NOW(), TIME("12:00:00") + INTERVAL 1 DAY) AS minutes_until_lunch;
  END IF;
END //
DELIMITER ;

CALL lunch_countdown();

-- Uppgift 4
-- Skapar en vy som hämtar födelsedatum från användare födda i februari
CREATE VIEW born_in_february AS SELECT birthdate FROM users WHERE MONTH(birthdate) = 2;

-- Uppgift 5
-- Skapar en procedur som hämtar namn från användare som har födelsedag på en viss månad och dag.
DELIMITER //
CREATE PROCEDURE happy_birthday(IN month INT, IN day INT)
BEGIN
  SELECT first_name, last_name FROM users
  WHERE MONTH(birthdate) = month AND DAY(birthdate) = day;
END; //
DELIMITER ;

CALL happy_birthday(2,22);

-- Uppgift 6
-- Skapar en funktion som beräknar åldern för en användare baserat på födelsedatum.
DELIMITER //
CREATE FUNCTION age(birthdate DATE)
RETURNS INT
DETERMINISTIC
BEGIN
  RETURN TIMESTAMPDIFF(YEAR, birthdate, CURDATE());
END; //
DELIMITER ;

SELECT first_name, last_name, birthdate, age(birthdate) FROM users ORDER BY birthdate DESC;

-- Uppgift 7
-- Skapar två triggers (en insert och en update) som kontrollerar att födelsedatum inte är i framtiden när man lägger till eller uppdaterar en användare.
DELIMITER //
CREATE TRIGGER insert_time_trigger
BEFORE INSERT ON users
FOR EACH ROW
BEGIN
  IF NEW.birthdate > CURDATE() THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Birthdate cannot be in the future';
  END IF;
END; //

CREATE TRIGGER update_time_trigger
BEFORE UPDATE ON users
FOR EACH ROW
BEGIN
  IF NEW.birthdate > CURDATE() THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Birthdate cannot be in the future';
  END IF;
END; //
DELIMITER ;

-- Uppgift 8
-- Skapar en vy som hämtar order-ID och antal timmar sedan ordern skickades från affären och inte har anlänt till kunden.

DROP VIEW orders_sent_but_not_recieved;

CREATE VIEW orders_sent_but_not_recieved AS
SELECT orders.id, 
TIMESTAMPDIFF(HOUR, sent_from_store, NOW()) AS time_in_transit_in_hours,
TIMESTAMPDIFF(MINUTE, sent_from_store, NOW()) -
TIMESTAMPDIFF(HOUR, sent_from_store, NOW()) * 60 AS time_in_transit_in_minutes
FROM orders
WHERE sent_from_store IS NOT NULL AND arrived_at_customer IS NULL;

SELECT * FROM orders_sent_but_not_recieved;

-- Uppgift 9
-- Skapar en vy som hämtar de 5 snabbaste leveranserna baserat på leveranstiden.

DROP VIEW fastest_delivery;

CREATE VIEW fastest_delivery AS
SELECT orders.id, (arrived_at_customer - sent_from_store) AS delivery_time
FROM orders
WHERE arrived_at_customer IS NOT NULL AND sent_from_store IS NOT NULL
ORDER BY delivery_time
LIMIT 5;

SELECT * FROM fastest_delivery;


-- Uppgift 10
-- Skapar en procedur som hämtar order-ID och status för order, baserat på om ordern är på väg, 
-- har skickats, har förlorats, är snabb eller långsam.

DROP PROCEDURE IF EXISTS order_status;

DELIMITER //
CREATE PROCEDURE order_status()
BEGIN
  SELECT orders.id, 
    CASE
      WHEN sent_from_store IS NULL THEN 'Processing'
      WHEN arrived_at_customer IS NULL AND TIMESTAMPDIFF(HOUR, sent_from_store, NOW()) <= 14 * 24 THEN 'Sent'
      WHEN arrived_at_customer IS NULL AND TIMESTAMPDIFF(HOUR, sent_from_store, NOW()) > 14 * 24 THEN 'Lost?'
      WHEN TIMESTAMPDIFF(HOUR, sent_from_store, arrived_at_customer) <= 120 THEN 'Fast'
      ELSE 'Slow'
    END AS status
  FROM orders;
END //
DELIMITER ;

CALL order_status();

SELECT * FROM orders;

-- Uppgift 11
-- Skapar en trigger som sätter mottaget datum på affären när en order läggs till.
DROP TRIGGER tr_set_received_at_store;

DELIMITER //
CREATE TRIGGER tr_set_received_at_store
BEFORE INSERT ON orders
FOR EACH ROW
BEGIN
IF NEW.received_at_store IS NULL THEN
SET NEW.received_at_store = NOW();
END IF;
END//
DELIMITER ;

INSERT INTO orders (id) VALUES (3002);
SELECT * FROM orders;



-- Uppgift 12
-- Skapar en procedure som räknar ut totala ordrar.
DROP PROCEDURE total_orders;

DELIMITER //
CREATE PROCEDURE total_orders()
BEGIN
SELECT COUNT(orders.id) AS nr_of_orders
FROM orders;
END //
DELIMITER ;

CALL total_orders();

