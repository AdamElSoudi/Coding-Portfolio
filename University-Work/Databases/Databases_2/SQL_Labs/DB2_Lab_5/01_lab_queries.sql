-- Lab 5 Adam El Soudi & Gustav Grip




-- Uppgift 1

CREATE TABLE users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE accounts (
  id INT AUTO_INCREMENT PRIMARY KEY,
  amount DECIMAL(10, 2) NOT NULL CHECK (amount >= 0)
);

CREATE TABLE transfers (
  id INT AUTO_INCREMENT PRIMARY KEY,
  account_id INT NOT NULL,
  amount DECIMAL(10, 2) NOT NULL CHECK (amount >= 0),
  note TEXT,
  t_datetime DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (account_id) REFERENCES Accounts (id)
);

CREATE TABLE owners (
  user_id INT NOT NULL,
  account_id INT NOT NULL,
  PRIMARY KEY (user_id, account_id),
  FOREIGN KEY (user_id) REFERENCES Users (id),
  FOREIGN KEY (account_id) REFERENCES Accounts (id)
);


-- Uppgift 2

INSERT INTO users (username) VALUES
  ('gustavus_bankman'), ('adamus_prime'), ('joakim_von_anka'), ('adis_engis'), ('franc_o');


INSERT INTO accounts (amount) VALUES
(1537269),
(59637),
(69420),
(957638),
(19070323),
(987654),
(500),
(20),
(100000),
(54726),
-- Gemensamma konton
(100000),
(200000);

INSERT INTO owners (user_id, account_id) VALUES
  (1, 1), (1, 2),
  (2, 3), (2, 4),
  (3, 5), (3, 6),
  (4, 7), (4, 8),
  (5, 9), (5, 10),
  (4, 11), (5, 11),
  (1, 12), (2, 12);

SELECT * FROM owners;

-- Uppgift 3
DROP VIEW users_accounts;

CREATE VIEW user_accounts AS 
SELECT users.id AS user_id, username AS user, accounts.id AS account_id, accounts.amount AS amount FROM users
    JOIN owners ON users.id = owners.user_id
    JOIN accounts ON accounts.id = owners.account_id
    ORDER BY accounts.id;

SELECT user_id FROM user_accounts WHERE account_id = 12;

SELECT * FROM user_accounts WHERE user_id = 2 ORDER BY account_id ASC;

-- Uppgift 4

DROP PROCEDURE deposit;

DELIMITER //
CREATE PROCEDURE deposit(IN account_id INT, IN amount DECIMAL (10,2))
BEGIN
START TRANSACTION;
	IF EXISTS (SELECT 1 FROM accounts WHERE id = account_id) THEN
		IF amount > 0 THEN
		UPDATE accounts
		SET amount = accounts.amount + amount
		WHERE id = account_id;
		INSERT INTO transfers
		SET account_id = account_id, amount = amount, note = "Deposit", t_datetime = NOW();

	ELSE
		SELECT 'ERROR: amount is not > 0';
		ROLLBACK;
		END IF;
	ELSE
		SELECT 'ERROR: Account does not exist';
		ROLLBACK;
	END IF;
COMMIT;
END //
DELIMITER ;

CALL deposit(3, 1000000);

SELECT * FROM transfers WHERE date;


-- Uppgift 5

DROP PROCEDURE withdraw;

DELIMITER //
CREATE PROCEDURE withdraw(IN account_id INT, IN amount DECIMAL (10,2))
BEGIN
START TRANSACTION;
IF EXISTS (SELECT 1 FROM accounts WHERE id = account_id) THEN
    
IF amount > (SELECT accounts.amount FROM accounts WHERE id = account_id) THEN
SELECT 'ERROR: amount is too large' AS status;
END IF;

IF amount <= 0 THEN
SELECT 'ERROR: amount is not > 0' AS status;

ELSE IF amount <= (SELECT accounts.amount FROM accounts WHERE id = account_id) THEN
UPDATE accounts
SET amount = accounts.amount - amount
WHERE id = account_id;

INSERT INTO transfers (account_id, amount, note, t_datetime) VALUES
     (account_id, amount, 'Withdrawal', NOW());
END IF;
END IF;
ELSE SELECT ('ERROR: Account does not exist');
END IF;
COMMIT;
END //
DELIMITER ;

CALL withdraw(100,10);

SELECT * FROM transfers;


-- Uppgift 6

DROP PROCEDURE show_transfers;

DELIMITER //
CREATE PROCEDURE show_transfers(IN account_id INT)
	BEGIN
    SELECT * FROM transfers
    WHERE transfers.account_id = account_id
    ORDER BY t_datetime DESC;
    END //
DELIMITER ;

CALL show_transfers(11);

-- Uppgift 7

DROP FUNCTION no_of_owners;
DELIMITER //
CREATE FUNCTION no_of_owners(account_id INT)
RETURNS INT
DETERMINISTIC
BEGIN
DECLARE funktion INT;
SELECT COUNT(*) INTO funktion
FROM users
JOIN owners ON users.id = owners.user_id
JOIN accounts ON accounts.id = owners.account_id
WHERE accounts.id = account_id;

RETURN funktion;
END //
DELIMITER ;

SELECT id, no_of_owners(id) AS no_of_owners, amount FROM Accounts ORDER BY no_of_owners DESC;

-- Uppgift 8

DROP PROCEDURE total_deposits_by_user;

DELIMITER //
CREATE PROCEDURE total_deposits_by_user(IN account_id INT)
	BEGIN
    SELECT account_id, SUM(amount) AS total_deposit FROM transfers 
    WHERE note = "Deposit" AND transfers.account_id = account_id;
    END //
    DELIMITER ;
    
CALL total_deposits_by_user(11);

-- Uppgift 9

DROP VIEW big_banks;
CREATE VIEW big_banks AS SELECT username, accounts.amount FROM users
    JOIN owners ON users.id = owners.user_id
    JOIN accounts ON accounts.id = owners.account_id
    WHERE accounts.amount > 1000000
    ORDER BY accounts.amount DESC;

SELECT * FROM big_banks;

-- Uppgift 10

START TRANSACTION;

-- uppdaterar konto nummer 11 med nytt saldo = 250
    UPDATE accounts 
    SET amount = 250
    WHERE accounts.id = 11;

-- savepoint för saldo 250 på kontonr. 11
    SAVEPOINT konto_250;
      SELECT * FROM user_accounts;

-- uppdaterar konto nummer 11 med nytt saldo = 500
    UPDATE accounts 
    SET amount = 500
    WHERE accounts.id = 11;

-- savepoint för saldo: 500 på kontonr. 11
    SAVEPOINT konto_500;
      SELECT * FROM user_accounts;

-- återgår till savepoint 'konto_250'
    ROLLBACK TO konto_250;
    SELECT * FROM user_accounts;

    -- commitar transaktion
    COMMIT;


-- Uppgift 11

-- a)
CREATE USER 'kim'@'localhost' IDENTIFIED BY 'pass1';
CREATE USER 'alex'@'localhost' IDENTIFIED BY 'pass2';
CREATE USER 'app'@'localhost' IDENTIFIED BY 'pass3';

-- b)
GRANT SELECT, UPDATE ON lab5.* TO 'kim'@'localhost';
GRANT SELECT, UPDATE ON lab5.* TO 'alex'@'localhost';
GRANT SELECT, UPDATE ON lab5.* TO 'app'@'localhost';

-- c)
REVOKE UPDATE ON lab5.* FROM 'alex'@'localhost';

-- d) INTE KLAR!!!!!!
ALTER USER 'alex'@'localhost' WITH MAX_QUERIES_PER_HOUR 200;


-- e)
GRANT INSERT ON lab5.* TO 'kim'@'localhost';

-- f)
REVOKE INSERT ON lab5.* FROM 'kim'@'localhost';

-- Uppgift 12

/*Tilldela db_read till Alex, db_write till Kim och db_sproc till app.
c) Skriv query för att lista rättigheter för Kim.
d) Skriv query för att lista rättigheter för db_write*/


-- a)
CREATE ROLE "db_read";
GRANT SELECT ON lab5.* TO "db_read";

CREATE ROLE "db_write";
GRANT INSERT, UPDATE ON lab5.* TO "db_write";

CREATE ROLE "db_sproc";
GRANT EXECUTE ON PROCEDURE lab5.* TO "db_sproc";

-- b)
GRANT "db_read" TO 'kim'@'localhost';
GRANT "db_write" TO 'alex'@'localhost';
GRANT "db_sproc" TO 'app'@'localhost';

-- c)
SHOW GRANTS FOR 'kim'@'localhost';

-- d)
SHOW GRANTS FOR "db_write";
