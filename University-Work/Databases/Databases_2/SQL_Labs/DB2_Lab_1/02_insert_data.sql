-- Insert data into the Movies table
INSERT INTO Movies (title, year, rating) VALUES    
  ("Star Wars - The Last Jedi", 2017, 9),        -- Movie 1
  ("The Emoji Movie", 2016, 1),                   -- Movie 2
  ("The Matrix", 1999, 9),                        -- Movie 3
  ("The Shawshank Redemption", 1994, 10),         -- Movie 4
  ("Titanic", 1997, 8),                           -- Movie 5
  ("Wargames", 1983, 7),                          -- Movie 6
  ("The Imitation Game", 2014, 8),                -- Movie 7
  ("Don't Look Up", 2014, 8),                     -- Movie 8
  ("Eternal Sunshine", 2004 , 9),                 -- Movie 9
  ("The Reader", 2008, 8);                        -- Movie 10

-- Insert data into the Genres table
INSERT INTO Genres (name) VALUES
  ("Action"), -- Genre 1
  ("Comedy"), -- Genre 2
  ("Drama"),  -- Genre 3
  ("Sci-fi"); -- Genre 4 

-- Insert data into the MoviesGenres table (linking movies and genres)
INSERT INTO MoviesGenres VALUES 
(1, 1), -- Movie 1, Action
(1, 4), -- Movie 1, Sci-fi
(2, 2), -- Movie 2, Comedy
(2, 3), -- Movie 2, Drama
(3, 1), -- Movie 3, Action
(3, 3), -- Movie 3, Drama
(3, 4), -- Movie 3, Sci-fi
(4, 3), -- Movie 4, Drama
(5, 3), -- Movie 5, Drama
(6, 1), -- Movie 6, Action
(6, 3), -- Movie 6, Drama
(7, 3), -- Movie 7, Drama
(8, 3), -- Movie 8, Drama
(8, 2), -- Movie 8, Comedy
(9, 2), -- Movie 9, Comedy
(10, 3); -- Movie 10, Drama

