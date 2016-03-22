/* MOVIE SQL - PART 2 */

/*
Find all fantasy movies using
the many to many join between movies
and genres through movie_genre table.

TWO options are below
 */

SELECT m.title
FROM movies m
JOIN movie_genre mg ON m.movieid = mg.movieid
WHERE mg.genre_id = 15;

SELECT m.title, g.genres
FROM movies m
JOIN movie_genre mg ON m.movieid = mg.movieid
JOIN genre g ON mg.genre_id = g.id
WHERE g.genres = 'Fantasy';


/*
For each genre find the total number
of reviews as well as the average review
sort by highest average review.
*/

SELECT g.genres, COUNT(r.rating), AVG(r.rating)
FROM ratings r
JOIN movies m ON m.movieid = r.movieid
JOIN movie_genre mg on mg.movieid = m.movieid
JOIN genre g on g.id = mg.genre_id
GROUP BY g.genres
ORDER BY COUNT(r.rating) DESC;

/*
Create a new table called actors
(We are going to pretend the actor can only play in
one movie) The table should include name,
character name, foreign key to movies and date of birth
at least plus an id field.
 */

CREATE TABLE public.actors
(
    actorid SERIAL PRIMARY KEY,
    name VARCHAR (50),
    charname VARCHAR (50),
    movieid INT NOT NULL,
    dob DATE
);

/*
 Pick 3 movies and create insert statements
 for 10 actors each. You should use the multi
 value insert statements
*/

         -- Movie #1: Jumanji --
INSERT INTO actors(name, charname, movieid, dob)
    VALUES('Robin Williams', 'Alan Parish', 2, '1951-07-21'),
    ('Jonathan Hyde', 'Van Pelt', 2, '1948-05-21'),
    ('Kirsten Dunst', 'Judy Shepherd', 2, '1982-04-30'),
    ('Bradley Pierce', 'Peter Shepherd', 2, '1982-10-23'),
    ('Bonnie Hunt', 'Sarah Whittle', 2, '1961-09-22'),
    ('Bebe Neuwirth', 'Norah Shepherd', 2, '1958-12-31'),
    ('David Alan Grier', 'Carl Bentley', 2, '1955-06-30'),
    ('Patricia Clarkson', 'Carol Parrish', 2, '1959-12-29'),
    ('Adam Hann-Byrd', 'Young Alan', 2, '1982-02-23');

            -- Movie #2: Grumpier Old Men --
INSERT INTO actors(name, charname, movieid, dob)
    VALUES('Walter Matthau', 'Max Goldman', 3, '1920-10-01'),
    ('Jack Lemmon', 'John Gustafson', 3, '1925-02-08'),
    ('Sophia Loren', 'Maria Coletta', 3, '1934-09-20'),
    ('Ann Margret', 'Ariel Gustofson', 3, '1941-04-28'),
    ('Burgess Meridith', 'Grandpa Gustofson', 3, '1907-09-16'),
    ('Daryl Hannah', 'Melanie Gustafson', 3, '1960-12-03'),
    ('Kevin Pollak', 'Jacob Goldman', 3, '1957-10-30'),
    ('Katie Sagona', 'Alli', 3, '1989-11-26'),
    ('Ann Guilbert', 'Mama Ragetti', 3, '1928-10-16'),
    ('James Andelin', 'Sven', 3, '1917-09-27');

        -- Movie #3: Waiting to Exhale --
INSERT INTO actors(name, charname, movieid, dob)
    VALUES('Whitney Houston', 'Savannah Jackson', 4, '1963-08-09'),
    ('Angela Bassett', 'Bernadine Harris', 4, '1958-08-16'),
    ('Loretta Devine', 'Gloria Matthews', 4, '1949-09-21'),
    ('Lela Rochon', 'Robin Stokes', 4, '1964-04-17'),
    ('Gregory Hines', 'Marvin King', 4, '1946-02-14'),
    ('Dennis Haysbert', 'Keneth Dawkins', 4, '1954-06-02'),
    ('Mykelti Williamson', 'Troy', 4, '1957-03-04'),
    ('Michael Beach', 'John Harris Sr.', 4, '1963-10-30'),
    ('Leon', 'Russell', 4, '1962-03-08'),
    ('Wendell Pierce', 'Sven', 4, '1963-12-08');


/*
Create a new column in the movie table to
hold the MPAA rating. UPDATE 5 different movies
to their correct rating
 */

ALTER TABLE movies ADD mpaa_Rating VARCHAR(5);

UPDATE movies
SET mpaa_rating = 'NC-17'
WHERE movieid = 1;

UPDATE movies
SET mpaa_rating = 'PG-13'
WHERE movieid in (2, 3, 4, 5);























/* MOVIE SQL - PART 1 */

SELECT * FROM movies;

SELECT title, movieid FROM movies
LIMIT 10:

SELECT * FROM movies WHERE movieid = 485;

SELECT movieid FROM movies WHERE title = 'Made in America (1993)';

SELECT * FROM movies
ORDER BY title ASC
LIMIT 10;

SELECT * FROM movies WHERE title LIKE '%(2002)%';

SELECT * FROM movies WHERE title like '%Godfather%';
SELECT title FROM movies WHERE movieid=858;

SELECT * FROM movies WHERE genres like '%Comedy%';

/****** REVISED CODE to use 2002 instead of 1992******/
SELECT * FROM movies WHERE genres like '%Comedy%' and title like '%2002%';

/****** REVISED CODE ******/
SELECT m.title, t.tag, m.genres
FROM movies m
JOIN tags t ON m.movieid = t.movieid
WHERE lower(genres) LIKE '%comedy%' AND lower(tag) LIKE '%death%';

SELECT * FROM movies WHERE title LIKE '%Super%' AND (title LIKE '%2001%' OR title LIKE '%2002%');

SELECT m.title, r.rating
FROM movies m JOIN ratings r ON m.movieid = r.movieid
WHERE m.title = 'Godfather, The (1972)';

SELECT m.title, r.rating
FROM movies m JOIN ratings r ON m.movieid = r.movieid
WHERE m.title = 'Godfather, The (1972)'
ORDER BY r.timestamp ASC;

SELECT m.title, l.imdbid, m.genres
FROM movies m JOIN links l ON m.movieid = l.movieid
WHERE m.title LIKE '%(2005)%' and m.genres LIKE '%Comedy%';

SELECT m.title, r.rating
FROM movies m LEFT JOIN ratings r ON m.movieid = r.movieid
WHERE r.rating is NULL;


SELECT AVG(r.rating), count(r.rating)
FROM movies m LEFT JOIN ratings r ON m.movieid = r.movieid
WHERE m.title = 'Godfather, The (1972)'

SELECT count(movieid) FROM movies
WHERE genres LIKE '%Horror%'


SELECT AVG(rating)
FROM ratings
WHERE userid = '35';

SELECT count(rating), userid
FROM ratings
GROUP BY userid
ORDER BY count(rating) DESC
LIMIT 1;


SELECT AVG(rating), userid
FROM ratings
GROUP BY userid
ORDER BY AVG(rating) DESC
LIMIT 1;

SELECT userid, AVG(rating), count(rating)
FROM ratings
GROUP BY userid
HAVING count(rating) > 50
ORDER BY AVG(rating) DESC;

SELECT m.title, AVG(r.rating)
FROM movies m LEFT JOIN ratings r ON m.movieid = r.movieid
GROUP BY m.title
HAVING AVG(r.rating) > 4
ORDER BY AVG(r.rating);


SELECT g.genres, count(r.rating), AVG(r.rating)
FROM ratings r JOIN movie_genre mg ON r.movieid = mg.movieid
JOIN genre g ON mg.genre_id = g.id
GROUP BY g.genres
ORDER BY AVG(r.rating) DESC;
