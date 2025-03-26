-- Create tables for users, friends, hobbies, and users_hobbies
CREATE TABLE users (
  id INT PRIMARY KEY AUTO_INCREMENT,
  username VARCHAR(16) UNIQUE NOT NULL,
  pass VARCHAR(255) NOT NULL,
  email VARCHAR(255) UNIQUE NOT NULL,
  fname VARCHAR(32),
  lname VARCHAR(32),
  age INT UNSIGNED NOT NULL
);

CREATE TABLE friends (
  u_id INT,
  f_id INT,
  FOREIGN KEY (u_id) REFERENCES users(id),
  FOREIGN KEY (f_id) REFERENCES users(id)
);

CREATE TABLE hobbies (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(32) UNIQUE NOT NULL,
  description VARCHAR(128)
);

CREATE TABLE users_hobbies (
  u_id INT,
  h_id INT,
  FOREIGN KEY (u_id) REFERENCES users(id),
  FOREIGN KEY (h_id) REFERENCES hobbies(id)
);

