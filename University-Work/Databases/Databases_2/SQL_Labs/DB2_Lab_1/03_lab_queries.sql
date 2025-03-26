/*Lab 1*/

-- Uppgift 1
-- Denna query skapar en vy som kombinerar information från tabellerna "Movies" och "Genres" och ger kolumnerna "title" och "genre"
CREATE VIEW MovieGenre AS 
SELECT Movies.title AS title, Genres.name AS genre FROM Movies
	JOIN MoviesGenres ON Movies.id = MoviesGenres.m_id
	JOIN Genres ON MoviesGenres.g_id = Genres.id;


-- Uppgift 2
-- Denna query skapar en vy som ger kolumnerna "title" och "year" från tabellen "Movies" och sorterar dem i alfabetisk ordning.
CREATE VIEW MoviesYears AS SELECT Movies.title AS title, Movies.year AS year FROM Movies ORDER BY title;



-- Uppgift 3
-- Denna query skapar en vy som ger alla kolumner från tabellen "Movies" där värdet i kolumnen "rating" är 8 eller högre.
CREATE VIEW TopRated AS SELECT * FROM Movies WHERE Movies.rating >= 8;



-- Uppgift 4
-- Denna query skapar en vy som ger kolumnen "genres" från tabellen "Genres" och räknar antalet filmer i varje genre (GROUP BY genres) 
-- och ger kolumnen "movies_in_genre".
CREATE VIEW GenreCount AS SELECT Genres.name AS genres, COUNT(*) AS movies_in_genre FROM Genres
	JOIN MoviesGenres ON Genres.id = MoviesGenres.g_id
	JOIN Movies ON MoviesGenres.m_id = Movies.id
	GROUP BY genres;



-- Uppgift 5
-- Skapar en vy med namnet "GenreRatings" som visar genrens namn och genomsnittsbetyget för alla filmer i den genren.
-- Vyn använder sig av tre tabeller: Genres, MoviesGenres och Movies.
DROP VIEW GenreRatings;

CREATE VIEW GenreRatings AS SELECT Genres.name AS Genre, AVG(Movies.rating) AS Avg_Rating
FROM Genres
JOIN MoviesGenres ON Genres.id = MoviesGenres.g_id
JOIN Movies ON MoviesGenres.m_id = Movies.id
GROUP BY Genre;

SELECT Genre
FROM GenreRatings
ORDER BY avg_rating DESC
LIMIT 1;


-- Uppgift 6
-- Skapar två tabeller, Actors och ActorsMovies. Actors-tabellen har ett ID som primärnyckel och ett namn-fält som inte får vara tomt.
-- ActorsMovies-tabellen har fält för actor_id och movie_id och har foreign keys för att referera till Actors och Movies tabellerna.
CREATE TABLE Actors 
	(id INTEGER PRIMARY KEY AUTO_INCREMENT, name TEXT NOT NULL);

CREATE TABLE ActorsMovies (
  a_id INTEGER NOT NULL,   
  m_id INTEGER NOT NULL
);

ALTER TABLE  ActorsMovies
    ADD CONSTRAINT FK_Actors FOREIGN KEY (a_id) REFERENCES Actors(id);

ALTER TABLE ActorsMovies
	ADD CONSTRAINT FK_Movies FOREIGN KEY (m_id) REFERENCES Movies(id);



-- Uppgift  7
-- Lägger till 10 skådespelare i Actors-tabellen och relaterar dem till filmer i ActorsMovies-tabellen.
insert into Actors (id, name) values (1, 'Irena Satchell');
insert into Actors (id, name) values (2, 'Adelina Fremantle');
insert into Actors (id, name) values (3, 'Hildagard Wear');
insert into Actors (id, name) values (4, 'Ara Oseland');
insert into Actors (id, name) values (5, 'Darn Ferrer');
insert into Actors (id, name) values (6, 'Patrizio Pears');
insert into Actors (id, name) values (7, 'Briny Wogan');
insert into Actors (id, name) values (8, 'Brock Jeandeau');
insert into Actors (id, name) values (9, 'Shem Merrett');
insert into Actors (id, name) values (10, 'Klara Pruckner');

INSERT INTO ActorsMovies VALUES 
(1, 1), (2,1), (3, 2), (3, 3), (4, 4), (4, 5), (5, 6), (6, 7), (7, 8), (7, 9),(8, 10), (8, 9),(9, 8), (9, 7), (10,6), (10, 5);



-- Uppgift 8
-- Skapar en vy med namnet "MoviesDoneByActor" som visar skådespelarnas namn och antalet filmer de medverkat i.
-- Vyn använder sig av tre tabeller: Movies, ActorsMovies och Actors.
CREATE VIEW MoviesDoneByActor AS SELECT Actors.name AS actors, COUNT(*) AS actors_in_movie FROM Movies
	JOIN ActorsMovies ON Movies.id = ActorsMovies.m_id
	JOIN Actors ON Actors.id = ActorsMovies.a_id
	GROUP BY actors; 
