/*Lab 6B - Adam El Soudi*/

-- Uppgift 1

-- a)
-- Jag valde att lägga till ett id på varje tabell, förutom på item och orders, och gjorde det till min primary key på alla förutom log tabellen.
CREATE TABLE customer (
id INT PRIMARY KEY AUTO_INCREMENT NOT NULL UNIQUE, 
email VARCHAR(50) NOT NULL UNIQUE, name VARCHAR(50) NOT NULL, 
city VARCHAR(50) NOT NULL
);

CREATE TABLE orders (
number INT PRIMARY KEY NOT NULL UNIQUE, 
status VARCHAR(50), 
created DATETIME, 
sent DATETIME
);

-- Jag lägger till ett kolumn för category_id i tabellen item för att senare kunna koppla item till category.
CREATE TABLE item (
number INT PRIMARY KEY NOT NULL UNIQUE, 
name VARCHAR(50) NOT NULL, 
stock INT NOT NULL, 
price INT NOT NULL, 
category_id INT NOT NULL
);

CREATE TABLE log (
id INT NOT NULL, 
date_time DATETIME NOT NULL
);

CREATE TABLE category (
id INT PRIMARY KEY AUTO_INCREMENT NOT NULL UNIQUE, 
name VARCHAR(50) NOT NULL UNIQUE
);

-- Jag skapar en ny tabell som heter order_items för uppgifterna 5 och 6.
CREATE TABLE order_items (
    id INT PRIMARY KEY AUTO_INCREMENT NOT NULL UNIQUE,
    order_number INT NOT NULL,
    item_number INT NOT NULL,
    quantity INT NOT NULL,
    FOREIGN KEY (order_number) REFERENCES orders (number),
    FOREIGN KEY (item_number) REFERENCES item (number)
);


-- b)
-- Jag skapar en custumer_notes tabell där customers kan skriva en review om hur deras order gick.
CREATE TABLE customer_notes (
    id INT PRIMARY KEY AUTO_INCREMENT NOT NULL UNIQUE,
    customer_id INT NOT NULL,
    order_id INT NOT NULL,
    note VARCHAR(200) NOT NULL,
    date_time DATETIME NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customer (id)
);

SELECT * FROM orders;
-- Uppgift 2

-- a)
DROP PROCEDURE insert_customer;
DELIMITER //
CREATE PROCEDURE insert_customer(IN email VARCHAR(50), IN name VARCHAR(50), IN city VARCHAR(50))
	BEGIN
		INSERT INTO customer VALUES(id, email, name, city);
	END //
DELIMITER ;

DROP PROCEDURE insert_orders;
DELIMITER //
CREATE PROCEDURE insert_orders(IN number VARCHAR(50), IN status VARCHAR(50), IN created DATETIME, IN sent DATETIME)
	BEGIN
		INSERT INTO orders (number, status, created, sent) VALUES (number, status, created, sent);
	END //
DELIMITER ;

DROP PROCEDURE insert_item;
DELIMITER //
CREATE PROCEDURE insert_item(IN number VARCHAR(50), IN name VARCHAR(50), IN stock INT, IN price INT, IN category_id INT)
	BEGIN
		INSERT INTO item VALUES(number, name, stock, price, category_id);
	END //
DELIMITER ;

DROP PROCEDURE insert_log;
DELIMITER //
CREATE PROCEDURE insert_log(IN date_time DATETIME)
	BEGIN
		INSERT INTO log (id, date_time) VALUES (id, date_time);
	END //
DELIMITER ;

DROP PROCEDURE insert_category;
DELIMITER //
CREATE PROCEDURE insert_category(IN name VARCHAR(50))
	BEGIN
		INSERT INTO category (id, name) VALUES (id, name);
	END //
DELIMITER ;

DROP PROCEDURE insert_customer_notes;
DELIMITER //
CREATE PROCEDURE insert_customer_notes(IN customer_id INT, IN order_id INT, IN note VARCHAR(200), IN date_time DATETIME)
	BEGIN
		INSERT INTO customer_notes VALUES(id, customer_id, order_id, note, date_time);
	END //
DELIMITER ;


-- b)
CALL insert_customer('jane.doe@example.com', 'Jane Doe', 'New York');
CALL insert_customer('john.smith@example.com', 'John Smith', 'London');
CALL insert_customer('mike.brown@example.com', 'Mike Brown', 'Paris');
CALL insert_customer('jennifer.lee@example.com', 'Jennifer Lee', 'Tokyo');
CALL insert_customer('brian.johnson@example.com', 'Brian Johnson', 'Sydney');
SELECT * FROM customer;


CALL insert_orders('1', 'processing', '2022-01-01 10:00:00', null);
CALL insert_orders('2', 'sent', '2022-02-01 10:00:00', '2022-02-02 10:00:00');
CALL insert_orders('3', 'arrived at customer', '2022-03-01 10:00:00', '2022-03-02 10:00:00');
CALL insert_orders('4', 'open', '2022-04-01 10:00:00', null);
CALL insert_orders('5', 'processing', '2022-05-01 10:00:00', null);
CALL insert_orders('6', 'sent', '2022-06-01 10:00:00', '2022-06-02 10:00:00');
CALL insert_orders('7', 'arrived at customer', '2022-07-01 10:00:00', '2022-07-02 10:00:00');
CALL insert_orders('8', 'open', '2022-08-01 10:00:00', null);
CALL insert_orders('9', 'processing', '2022-09-01 10:00:00', null);
CALL insert_orders('10', 'sent', '2022-10-01 10:00:00', '2022-10-02 10:00:00');
CALL insert_orders('11', 'arrived at customer', '2023-01-01 10:00:00', '2023-01-12 10:00:00');
CALL insert_orders('12', 'arrived at customer', '2023-01-29 10:00:00', '2023-02-08 10:00:00');
CALL insert_orders('13', 'arrived at customer', '2023-02-10 10:00:00', '2023-02-18 10:00:00');
CALL insert_orders('14', 'arrived at customer', '2023-02-13 10:00:00', '2023-02-19 10:00:00');
SELECT * FROM orders;


SELECT * FROM item;
CALL insert_item('1', 'laptop', 10, 1000, 1);
CALL insert_item('2', 'phone', 20, 800, 1);
CALL insert_item('3', 'Red Dead Redemtion 2', 30, 700, 5);
CALL insert_item('4', 'Pan', 40, 600, 2);
CALL insert_item('5', 'headphones', 50, 500, 6);
CALL insert_item('6', 'Star Wars: Episode IV - A New Hope', 60, 400, 7);
CALL insert_item('7', 'Pizza', 70, 300, 8);
CALL insert_item('8', 'Notebook', 80, 200, 10);
CALL insert_item('9', 'Hoodie', 90, 100, 3);
CALL insert_item('10', 'Jurassic Park', 100, 900, 7);
CALL insert_item('11', 'Jurassic Park 2', 4, 900, 7);
CALL insert_item('12', 'Jurassic Park 3', 4, 900, 7);
CALL insert_item('13', 'Star Wars: Episode V - The Empire Strikes Back', 4, 900, 7);
CALL insert_item('14', 'Star Wars: Episode VI - Return of the Jedi', 0, 900, 7);
SELECT * FROM item;


CALL insert_category('Electronics');
CALL insert_category('Home appliances');
CALL insert_category('Fashion');
CALL insert_category('Sports');
CALL insert_category('Video Games');
CALL insert_category('Music');
CALL insert_category('Movies');
CALL insert_category('Food');
CALL insert_category('Beauty');
CALL insert_category('Office supplies');
SELECT * FROM category;

CALL insert_customer_notes(1, 3, 'This order was delivered on time and in perfect condition!', '2023-02-20 13:45:00');
CALL insert_customer_notes(2, 7, 'I was really happy with the quality of the items in this order.', '2023-02-19 18:30:00');
CALL insert_customer_notes(3, 11, 'This order arrived late and some of the items were damaged.', '2023-02-19 18:30:00');
CALL insert_customer_notes(4, 12, 'The delivery person was very friendly and helpful with bringing the order inside.', '2023-02-19 18:30:00');
CALL insert_customer_notes(1, 13, 'I accidentally entered the wrong address for this order and had to call customer service to fix it. They were very patient and helpful.', '2023-02-19 18:30:00');
CALL insert_customer_notes(5, 14, 'Everything went well and pleasently.', '2023-02-19 18:30:00');
SELECT * FROM customer_notes;

SELECT * FROM customer;

-- Uppgift 3
DROP PROCEDURE show_item;

DELIMITER //
CREATE PROCEDURE show_item(IN item_id INT)
BEGIN
    SELECT * FROM item 
    WHERE number = item_id; 
    INSERT INTO log (id, date_time) VALUES (item_id, NOW());
END //
DELIMITER ;

CALL show_item(3);
SELECT * FROM log;

-- Uppgift 4
CREATE VIEW hot_items AS	
SELECT number, name, COUNT(*) AS view_count
FROM (
  SELECT item.number, item.name
  FROM log
  JOIN item ON log.id = item.number
  ORDER BY log.date_time DESC
  LIMIT 500
) AS recent_logs
GROUP BY number, name
ORDER BY view_count DESC
LIMIT 3;

SELECT * FROM hot_items;
   

-- Uppgift 5
DROP PROCEDURE add_item_to_order;

DELIMITER //
CREATE PROCEDURE add_item_to_order (IN order_number INT, IN item_number INT, IN no_of_items INT)
BEGIN
    DECLARE available_stock INT;
    DECLARE added_items INT;
    DECLARE order_status VARCHAR(50);
    
    START TRANSACTION;
    SELECT stock INTO available_stock
    FROM item
    WHERE number = item_number;

    SELECT status INTO order_status
    FROM orders
    WHERE number = order_number;

    IF item_number = (SELECT number FROM item WHERE number = item_number) AND order_number = (SELECT number FROM orders WHERE number = order_number) THEN
        IF order_status != "open" THEN
            SELECT "Order not open" AS result;
            ROLLBACK;
        ELSEIF available_stock = 0 THEN
            SELECT "No items in order" AS result;
            ROLLBACK;
        ELSE
            IF no_of_items > available_stock THEN
                SET added_items = available_stock;
                UPDATE item SET stock = 0
                WHERE number = item_number;
            ELSE
                SET added_items = no_of_items;
                UPDATE item SET stock = stock - added_items
                WHERE number = item_number;
            END IF;

            IF EXISTS (SELECT * FROM order_items WHERE order_items.order_number = order_number AND order_items.item_number = item_number) THEN
                UPDATE order_items SET quantity = quantity + added_items
                WHERE order_items.order_number = order_number AND order_items.item_number = item_number;
            ELSE
                INSERT INTO order_items (order_number, item_number, quantity) VALUES (order_number, item_number, added_items);
            END IF;
            SELECT CONCAT(added_items, " item(s) added to order ", order_number) AS result;
            COMMIT;
        END IF;
    ELSE
        SELECT "Item or Order does not exist" AS result;
        ROLLBACK;
    END IF;
END //
DELIMITER ;


CALL add_item_to_order(8,11,1000);
CALL remove_item_from_order(8,2,1000);

-- Här blir result: "Order not open"
	CALL add_item_to_order(9,5,10);

-- Här blir result: "No items in order"
	CALL add_item_to_order(8,14,10);
    
-- Här blir result: 5 item(s) added to order 8
	CALL add_item_to_order(8,1,5);

-- Här blir result: "Item or Order does not exist"
	CALL add_item_to_order(11,15,10);

SELECT * FROM order_items;
SELECT * FROM orders;
SELECT * FROM item;

-- Uppgift 6
DROP PROCEDURE remove_item_from_order;
DELIMITER //
CREATE PROCEDURE remove_item_from_order(IN order_number INT, IN item_number INT, IN no_of_items INT)
BEGIN
    DECLARE available_quantity INT;
    DECLARE removed_items INT;
    DECLARE order_status VARCHAR(50);
    DECLARE result_message VARCHAR(255);

START TRANSACTION;
    SELECT quantity INTO available_quantity
    FROM order_items
    WHERE order_items.item_number = item_number AND order_items.order_number = order_number;

    SELECT status INTO order_status
    FROM orders
    WHERE number = order_number;

    IF item_number = (SELECT number FROM item WHERE item.number = item_number) AND order_number = (SELECT number FROM orders WHERE orders.number = order_number) THEN
        IF order_status != "open" THEN
            SET result_message = "Order not open";
            ROLLBACK;
        ELSE
            IF no_of_items > available_quantity THEN
                SET removed_items = available_quantity;
            ELSE
                SET removed_items = no_of_items;
            END IF;

            UPDATE order_items SET quantity = quantity - removed_items
            WHERE order_items.order_number = order_number AND order_items.item_number = item_number;

            UPDATE item SET stock = stock + removed_items
            WHERE item.number = item_number;

            IF (SELECT quantity FROM order_items WHERE order_items.item_number = item_number AND order_items.order_number = order_number) = 0 THEN
                DELETE FROM order_items
                WHERE order_items.item_number = item_number AND order_items.order_number = order_number;
            END IF;
            SET result_message = CONCAT(removed_items, " item(s) removed from order ", order_number);
        END IF;
    ELSE
        SET result_message = "Item or Order does not exist";
        ROLLBACK;
    END IF;
    COMMIT;
    SELECT result_message AS result;
END //
DELIMITER ;

-- Här blir result: "Order not open"
	CALL remove_item_from_order(9,5,10);
    
-- Här blir result: 5 item(s) removed from order 8
	CALL remove_item_from_order(8,1,5);

-- Här blir result: "Item or Order does not exist"
	CALL remove_item_from_order(20,1,1);

CALL remove_item_from_order(8,2,1000);
SELECT * FROM order_items;
SELECT * FROM orders;
SELECT * FROM item;
SELECT * FROM low_stock_items;
CALL remove_item_from_order(8, 13, 90);
CALL add_item_to_order(8,13,91);


-- Uppgift 7

CREATE TABLE low_stock_items (
  item_id INT PRIMARY KEY,
  item_name VARCHAR(50),
  stock_level INT
);

DROP TRIGGER insert_low_stock_items;

DELIMITER //
CREATE TRIGGER insert_low_stock_items
AFTER INSERT ON item
FOR EACH ROW
BEGIN
	IF NEW.stock <= 4 THEN
		INSERT INTO low_stock_items (item_id, item_name, stock_level)
		VALUES (NEW.number, NEW.name, NEW.stock);
	END IF;
END //
DELIMITER ;


DROP TRIGGER update_low_stock_items;

DELIMITER //
CREATE TRIGGER update_low_stock_items
AFTER UPDATE ON item
FOR EACH ROW
BEGIN
    IF NEW.stock <= 4 THEN
        IF EXISTS (SELECT * FROM low_stock_items WHERE item_id = NEW.number) THEN
            UPDATE low_stock_items
            SET stock_level = NEW.stock
            WHERE item_id = NEW.number;
        ELSE
            INSERT INTO low_stock_items (item_id, item_name, stock_level)
            VALUES (NEW.number, NEW.name, NEW.stock);
        END IF;
    ELSE
        DELETE FROM low_stock_items WHERE item_id = NEW.number;
    END IF;
END //
DELIMITER ;

SELECT * FROM low_stock_items;


-- Uppgift 8
/*show_order(order_id), orders_history(n_days)
a) Jag skapar en procedure som visar en order med en rad för varje item där pris för item, hur många items det är och vad totala priset för raden blir. */

DROP PROCEDURE show_order;

DELIMITER //
CREATE PROCEDURE show_order(IN order_id INT)
BEGIN
    SELECT item.number AS item_id, item.name AS item_name, item.price, order_items.quantity, item.price * order_items.quantity AS total_price
    FROM orders
    JOIN order_items ON orders.number = order_items.order_number
    JOIN item ON order_items.item_number = item.number
    WHERE orders.number = order_id;
END //
DELIMITER ;

CALL show_order(8);

-- b)
DROP PROCEDURE orders_history;

DELIMITER //
CREATE PROCEDURE orders_history(IN n_days INT)
BEGIN
	SELECT orders.number AS order_id, SUM(item.price * order_items.quantity) AS total_value
    FROM orders
    JOIN order_items ON orders.number  = order_items.order_number
    JOIN item ON order_items.item_number = item.number
    WHERE DATEDIFF(NOW(), orders.created) <= n_days
    GROUP BY order_id;
END //
DELIMITER ;

SELECT * FROM orders;
-- order_id 4 har datumet 2022-04-01 och order_id 8 har datumet 2022-08-01

-- När man kallar på orders_history är n_date hur många dagar man vill kolla tillbaka.
CALL orders_history(327);


-- Uppgift 9
-- Den här funktionen returnerar den senaste "noten" som en customer har gjort. 
DROP FUNCTION get_latest_note_for_customer;

DELIMITER //
CREATE FUNCTION get_latest_note_for_customer(customer_id INT) 
RETURNS VARCHAR(200)
DETERMINISTIC
BEGIN
    DECLARE latest_note VARCHAR(200);
    
    SELECT customer_notes.note INTO latest_note
    FROM customer_notes
    WHERE customer_notes.customer_id = customer_id
    ORDER BY customer_notes.date_time DESC
    LIMIT 1;
    
    RETURN latest_note;
END //
DELIMITER ;

SELECT * FROM customer_notes;
SELECT get_latest_note_for_customer(1); 

-- Uppgift 10
-- Jag skapade en procedur som ränkar ut medel längden på customer_notes (reviews) och grupperar det per år.
DROP PROCEDURE average_note_length_by_year;
DELIMITER //
CREATE PROCEDURE average_note_length_by_year()
BEGIN
    SELECT YEAR(customer_notes.date_time) AS year, AVG(LENGTH(customer_notes.note)) AS avg_length
    FROM customer_notes
    GROUP BY YEAR(customer_notes.date_time);
END //
DELIMITER ;

CALL average_note_length_by_year();

-- Uppgift 11
-- Jag lägger till ett kollumn i customer tabellen för att sen skapa en trigger som håller koll på hur många notes en customer har.
ALTER TABLE customer ADD COLUMN note_count INT DEFAULT 0;


DROP TRIGGER update_customer_note_count;

DELIMITER //
CREATE TRIGGER update_customer_note_count
AFTER INSERT ON customer_notes
FOR EACH ROW
BEGIN
    UPDATE customer SET note_count = note_count + 1 WHERE id = NEW.customer_id;
END //
DELIMITER ;

-- Lägger till några rader i customer_notes-tabellen
INSERT INTO customer_notes (customer_id, order_id, note, date_time) VALUES (1, 1, 'Bra service!', NOW());


SELECT id, name, note_count FROM customer;
SELECT * FROM customer;
SELECT * FROM customer_notes;

-- Uppgift 12
-- Jag skapar en materialiserad vy som visar det totala antalet beställda varor per kategori.
DROP TABLE mv_total_items_ordered_per_category;
CREATE TABLE mv_total_items_ordered_per_category (
  category_name VARCHAR(50),
  total_items_ordered INT,
  last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (category_name)
);

DROP TRIGGER tr_mv_total_items_ordered_per_category;
DELIMITER //
CREATE TRIGGER tr_mv_total_items_ordered_per_category
AFTER INSERT ON order_items
FOR EACH ROW
BEGIN
  INSERT INTO mv_total_items_ordered_per_category (category_name, total_items_ordered)
    SELECT 
      category.name AS category_name, 
      SUM(order_items.quantity) AS total_items_ordered
    FROM 
      order_items 
      JOIN item ON order_items.item_number = item.number 
      JOIN category ON item.category_id = category.id 
    WHERE
      category.id = (SELECT category_id FROM item WHERE number = NEW.item_number)
    GROUP BY 
      category.name
  ON DUPLICATE KEY UPDATE
    total_items_ordered = VALUES(total_items_ordered);
END //
DELIMITER ;

DROP TRIGGER tr_mv_total_items_ordered_per_category_update;
DELIMITER //
CREATE TRIGGER tr_mv_total_items_ordered_per_category_update
AFTER UPDATE ON item
FOR EACH ROW
BEGIN
  INSERT INTO mv_total_items_ordered_per_category (category_name, total_items_ordered)
    SELECT 
      category.name AS category_name, 
      SUM(order_items.quantity) AS total_items_ordered
    FROM 
      order_items 
      JOIN item ON order_items.item_number = item.number 
      JOIN category ON item.category_id = category.id 
    WHERE
      category.id = NEW.category_id
    GROUP BY 
      category.name
  ON DUPLICATE KEY UPDATE
    total_items_ordered = VALUES(total_items_ordered);
END //
DELIMITER ;

SELECT * FROM mv_total_items_ordered_per_category;

CALL add_item_to_order(8,2,5);

SELECT * FROM order_items;
SELECT * FROM item;
SELECT * FROM category;
