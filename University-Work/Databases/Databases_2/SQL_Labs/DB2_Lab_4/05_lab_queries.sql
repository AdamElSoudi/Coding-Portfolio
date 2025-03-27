-- Lab 4 
-- Adam El Soudi & Gustav Grip

-- Uppgift 1

/*DELETE: När en anställd som är manager i en avdelning eller supervisor för ett projekt raderas från tabellen employees, 
kommer värdet av FK i de relaterade raderna i tabellerna departments eller projects att sättas till NULL. Detta innebär att den
relaterade avdelningen eller projektet inte längre kommer att ha en manager eller supervisor kopplad till sig.

UPDATE: När ID:t för en anställd som är manager i en avdelning eller supervisor för ett projekt ändras i tabellen employees, 
kommer alla FK-värden i de relaterade raderna i tabellerna departments eller projects att uppdateras för att matcha det nya ID:t.*/
ALTER TABLE departments
ADD CONSTRAINT FK_manager
  FOREIGN KEY (manager)
  REFERENCES employees(id)
  ON DELETE SET NULL
  ON UPDATE CASCADE;

ALTER TABLE projects
ADD CONSTRAINT FK_supervisor
	FOREIGN KEY (supervisor)
    REFERENCES employees(id)
	ON DELETE SET NULL
	ON UPDATE CASCADE;


-- Detta säkerställer att när en anställd eller ett projekt raderas, så raderas alla motsvarande poster i project_members tabellen
-- Samma gäller när en anställd eller ett projekt uppdateras, så uppdateras alla motsvarande poster i project_members tabellen

ALTER TABLE project_members
    ADD CONSTRAINT FK_employees
    FOREIGN KEY (e_id)
    REFERENCES employees(id)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

ALTER TABLE project_members
ADD CONSTRAINT FK_project
	FOREIGN KEY (p_id)
    REFERENCES projects(id)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

    
-- Uppgift 2
/*Tar bort den främmande nyckeln FK_supervisor från projects-tabellen, ändrar kolumnen name till VARCHAR(50) NOT NULL,
ändrar kolumnen supervisor till INT NOT NULL och lägger till en unik index på kolumnen name. Sedan lägger till tillbaka
FK_supervisor-begränsningen med en referens till employees-tabellen.*/
ALTER TABLE projects
DROP FOREIGN KEY FK_supervisor;

ALTER TABLE projects 
CHANGE COLUMN name name VARCHAR(50) NOT NULL ,
CHANGE COLUMN supervisor supervisor INT NOT NULL ,
ADD UNIQUE INDEX name_UNIQUE (name ASC) VISIBLE;
;

ALTER TABLE projects 
ADD CONSTRAINT FK_supervisor
  FOREIGN KEY (supervisor)
  REFERENCES employees (id)
  ON DELETE CASCADE
  ON UPDATE CASCADE;


-- Uppgift 3
/*Ändrar kolumnen title i employees-tabellen till VARCHAR(50) NOT NULL DEFAULT 'training', ändrar kolumnen department till INT NOT NULL,
tar bort begränsningen FK_manager från departments-tabellen, ändrar kolumnen department i departments-tabellen till VARCHAR(50) NOT NULL, 
ändrar kolumnen manager till INT NOT NULL och lägger till en unik index på kolumnen department. Sedan lägger till tillbaka 
FK_manager-begränsningen med en referens till employees-tabellen.*/
ALTER TABLE employees 
CHANGE COLUMN title title VARCHAR(50) NOT NULL DEFAULT 'training';

ALTER TABLE employees 
CHANGE COLUMN department department INT NOT NULL ;

ALTER TABLE departments 
DROP FOREIGN KEY FK_manager;

ALTER TABLE departments 
CHANGE COLUMN department department VARCHAR(50) NOT NULL ,
CHANGE COLUMN manager manager INT NOT NULL ,
ADD UNIQUE INDEX department_UNIQUE (department ASC) VISIBLE;
;
ALTER TABLE departments 
ADD CONSTRAINT FK_manager
  FOREIGN KEY (manager)
  REFERENCES employees (id)
  ON DELETE CASCADE
  ON UPDATE CASCADE;



-- Uppgift 4
-- Lägger till en index på kolumnen last_name i employees-tabellen och gör kolumnen login unik.
ALTER TABLE employees
	ADD INDEX (last_name);
    
ALTER TABLE employees
	CHANGE COLUMN login login VARCHAR(50) UNIQUE;
    

-- Uppgift 5

-- a)
-- Ändrar så att kolumnet name i tabellen projects är varchar med en maxlängd på 25 tecken istället för varchar 50 tecken.
ALTER TABLE projects
	CHANGE COLUMN name name VARCHAR(25);
  
-- b)
-- Ändrar så att kolumnet id i tabellen departments är typen MEDIUMINT
ALTER TABLE departments
	CHANGE COLUMN id id MEDIUMINT;

-- c)
--  Sätter typen till ENUM med följande värden: "dr", "mr", "ms", "mrs", "rev", "honorable" för kolumnet id i tabellen employees.
ALTER TABLE employees
	CHANGE COLUMN title title ENUM("dr", "mr", "ms", "mrs", "rev", "honorable");
    
-- d)
-- Gör kolumnet login till varchar 50 och kolumnet birth_date till typen DATE i tabellen employees.
ALTER TABLE employees
	CHANGE COLUMN login login VARCHAR(50) NOT NULL;
ALTER TABLE employees
    CHANGE COLUMN birth_date birth_date DATE NOT NULL;
    
-- e)
-- Gör att email kolumnet i tabellen employees är varchar 50 och unikt.
ALTER TABLE employees
	CHANGE COLUMN email email VARCHAR(50) UNIQUE;

INSERT INTO employees VALUES("50000", 'rev', 'Isa1', 'Petti1', 'ipetti01', '3', '1982-10-27', 'ipetti0@cnn.com', '405081', 
							 '584-31-9289', '2019-01-01', '634-82-9586', '442-73-0877', 'Morbi porttitor lorem id ligula. Suspendisse ornare consequat
                             lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.\n\nFusce consequat. Nulla nisl. Nunc nisl.\n\nDuis 
                             bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. 
                             Duis at velit eu est congue elementum.\n\nIn hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis,
                             diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.');



-- Uppgift 6
/*Skapar en vy som heter "salary_data_dept". Vyn hämtar data från tabellen "departments" och "employees" genom en JOIN-operation.
Därefter räknar vyn ut det lägsta lönevärdet, det högsta lönevärdet, medellönen och antalet anställda för varje avdelning. 
Resultatet grupperas sedan efter avdelning.*/
CREATE VIEW salary_data_dept AS
SELECT departments.department AS department, 
MIN(employees.salary) AS minimum_salary, 
MAX(employees.salary) AS max_salary, 
AVG(employees.salary) AS average_salary, 
COUNT(employees.login) AS total_employees
FROM departments
JOIN employees ON employees.department = departments.id
GROUP BY department;

SELECT * FROM salary_data_dept;

-- Uppgift 7
/*Skapar en funktion som heter "retirement_status". Funktionen tar en födelsedatum som argument och returnerar en sträng som beskriver 
anställdens pensionsstatus. Funktionen räknar ut anställdens nuvarande ålder och antal år kvar till pensionsåldern 65. 
Beroende på antal år kvar returnerar funktionen en beskrivning av pensionsstatusen.*/
DROP FUNCTION retirement_status;

DELIMITER //
CREATE FUNCTION retirement_status(birth_date DATE)
RETURNS varchar(50)
DETERMINISTIC
BEGIN
DECLARE years_left INT;
DECLARE current_age INT;
DECLARE result VARCHAR(50);

SET current_age = (TIMESTAMPDIFF(YEAR, birth_date, NOW()));
SET years_left = 65 - current_age;

IF years_left > 5 THEN
SET result = 'more than 5 years left';
ELSEIF years_left <= 5 AND years_left > 0 THEN
SET result = CONCAT(years_left, ' year(s) left');
ELSEIF years_left = 0 THEN
SET result = 'Up for retirement';
ELSE
SET result = 'Retired?';
END IF;

RETURN result;
END //
DELIMITER ;

/*Skapar en vy som heter "retirement_status_view". Denna vy hämtar data från tabellen "employees". 
För varje rad i tabellen, anropas funktionen "retirement_status" och resultatet läggs till som en ny kolumn i vyn. 
Vyn sorteras sedan efter avdelning och födelsedatum.*/
DROP VIEW retirement_status_view;

CREATE VIEW retirement_status_view AS
SELECT title, first_name, last_name, TIMESTAMPDIFF(YEAR, birth_date, NOW()), birth_date, department, retirement_status(birth_date) FROM employees 
WHERE TIMESTAMPDIFF(YEAR, birth_date, NOW()) >= 55
ORDER BY department, birth_date;


SELECT * FROM retirement_status_view;


-- Uppgift 8
DROP TABLE total_salary;
CREATE TABLE total_salary (
    salary INT
);
ALTER TABLE total_salary ADD last_update DATE;

INSERT INTO total_salary (salary)
SELECT SUM(salary) FROM employees;

-- insert
DROP TRIGGER salary_insert;
DELIMITER //
CREATE TRIGGER salary_insert 
BEFORE INSERT ON employees FOR EACH ROW
BEGIN
UPDATE total_salary
    SET salary = total_salary.salary + NEW.salary;
    UPDATE total_salary
    SET last_update = NOW();
END //
DELIMITER ;

-- update
DROP TRIGGER salary_update;
DELIMITER //
CREATE TRIGGER salary_update 
BEFORE UPDATE ON employees FOR EACH ROW
BEGIN
UPDATE total_salary
    SET salary = total_salary.salary - NEW.salary;
    UPDATE total_salary
    SET salary = total_salary.salary + salary;
    UPDATE total_salary
    SET last_update = NOW();
END //
DELIMITER ;

-- delete
DROP TRIGGER salary_delete;
DELIMITER //
CREATE TRIGGER salary_delete 
BEFORE DELETE ON employees FOR EACH ROW
BEGIN
UPDATE total_salary
    SET total_salary.salary = total_salary.salary - OLD.salary;
    UPDATE total_salary
    SET last_update = NOW();
END //
DELIMITER ;


INSERT INTO employees VALUES (1337 ,'Mr', 'moska', 'kilbröd', 'hejsan', '2', '1982-10-28', 'ipabe0@cnn.com', '40508', '584-31-9289', 
'2019-01-01', '634-82-9582', '442-73-0875', 'Morbi porttitor lorem id ligula.');
-- först var det 39366201, nu är det '39406709'.
SELECT SUM(salary) FROM total_salary; 

UPDATE employees SET salary = 10000000 WHERE id = 1337;

DELETE FROM employees WHERE id = 1337;

SELECT * FROM employees;


-- Uppgift 9

-- a)
-- Skapar en ny tabell som heter hr_notes som tar in kolumnet hr_notes från tabellen employees och sen raderar det kolumnet från employees tabellen.
CREATE TABLE hr_notes (
e_id INTEGER PRIMARY KEY AUTO_INCREMENT, notes TEXT);

INSERT INTO hr_notes (notes) SELECT hr_notes FROM employees;

ALTER TABLE hr_notes
ADD CONSTRAINT FK_notes
  FOREIGN KEY (e_id)
  REFERENCES employees(id)
  ON DELETE CASCADE
  ON UPDATE CASCADE;

SELECT * FROM hr_notes;


ALTER TABLE employees
DROP COLUMN hr_notes;

-- b)
SELECT id,last_name, first_name, notes 
FROM employees
JOIN hr_notes ON employees.id = hr_notes.e_id 
ORDER BY id ASC;


-- Uppgift 10
-- Skapar en trigger som ser till att man inte kan sänka en employees lön eller höja den med mer än 10%.

DROP TRIGGER salary_restriction;
DELIMITER //
CREATE TRIGGER salary_restriction
BEFORE UPDATE ON employees
FOR EACH ROW
BEGIN
  IF NEW.salary < OLD.salary THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Du kan inte sänka lönen";
  ELSEIF NEW.salary > OLD.salary * 1.10 THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Du kan inte höja lönen med mer än 10%";
  END IF;
END//
DELIMITER ;

SELECT * FROM employees;
UPDATE employees SET salary = 48508 WHERE id=1;



-- Uppgift 11
-- Skapar en vy som visar average age för varje department.
DROP VIEW departments_age;

CREATE VIEW departments_age AS 
    SELECT department AS department_id, AVG(TIMESTAMPDIFF(YEAR, birth_date, NOW())) as avg_age
    FROM employees 
    GROUP BY department 
    ORDER BY department;

SELECT * FROM departments_age;


-- Uppgift 12
-- Skapar en procedure som ser hur många år varje employee har jobbat och sorterar dem från dem som har jobbat flest år till minst.
DROP PROCEDURE total_years_worked;

DELIMITER //
CREATE PROCEDURE total_years_worked()
BEGIN
  SELECT 
    last_name, 
    TIMESTAMPDIFF(YEAR, start_date, NOW()) AS years_worked 
  FROM employees ORDER BY years_worked DESC;
END//
DELIMITER ;


CALL total_years_worked();
