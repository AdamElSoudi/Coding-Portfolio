-- Insert sample data into users table
INSERT INTO users (username, pass, email, fname, lname, age) VALUES
  ('arya', 'XPlgTwYDBD', 'agirl@example.com', 'Arya', 'Stark', 15),
  ('snow', 'ojPgMdpezTDr', 'snow@example.com', 'Jon', 'Snow', 20),
  ('sansa', 'sy3NCbR', 'sansa_stark@example.com', 'Sansa', 'Stark', 18),
  ('motherofdragons', 'VkDvqBIeq', 'daenerys@example.com', 'Daenerys', 'Targaryan', 20),
  ('theimp', 'jlEpzx5PY3A', 'theimp@example.com', 'Tyrion', 'Lannister', 30),
  ('jorah', 'GezN4CzXkjI', 'iamjorah@example.com', 'Jorah', 'Mormont', 48),
  ('sam', 'Rk3eHqoNmwp', 'iheartbooks@example.com', 'Samwell', 'Tarly', 21),
  ('cersei', 'wvk74vdiED', 'lookatme@example.com', 'Cersei', 'Lannister', 36),
  ('jamie', 'puMd8mf7eax', 'thethingsido@example.com', 'Jamie', 'Lannister', 36);

-- Insert sample data into hobbies table
INSERT INTO hobbies (name, description) VALUES
  ('Swords', 'When the sword of rebellion is drawn, the sheath should be thrown away.'),
  ('Books', 'So many books, so little time.'),
  ('Gold', 'Brass shines as fair to the ignorant as gold to the goldsmiths.'),
  ('Dragons', 'I do not care what comes after; I have seen the dragons on the wind of morning.');

-- Insert sample data into friends table
INSERT INTO friends (u_id, f_id) VALUES
  (1, 2), (1, 3),
  (2, 1), (2, 3), (2, 4), (2, 5), (2, 7),
  (3, 1), (3, 2), (3, 5),
  (4, 2), (4, 5), (4, 6),
  (5, 2), (5, 3), (5, 4), (5, 6), (5, 9),
  (6, 4), (6, 5),
  (7, 2),
  (8, 9),
  (9, 8), (9, 5);

-- Insert sample data into users_hobbies table
INSERT INTO users_hobbies (u_id, h_id) VALUES
  (1, 1),
  (2, 1), (2, 4),
  (3, 2), (2, 3),
  (4, 1), (4, 4),
  (5, 2), (5, 3), (5, 4),
  (6, 1), (6, 3),
  (7, 2),
  (8, 3),
  (9, 1);

