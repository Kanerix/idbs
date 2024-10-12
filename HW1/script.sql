/* 
 * Question 1:
 * The person relation contains 284 entries with a registered death date after ‘2010-02-01’.
 * How many entries do not have a registered death date?
 */

-- Example
SELECT COUNT(*) AS person_count
FROM person
WHERE deathdate > DATE '2010-02-01';

-- Correct
SELECT COUNT(*) AS person_count
FROM person
WHERE deathdate IS NULL;

/*
 * Question 2:
 * In the database, there are 46 movies in the French language for which the average
 * height of all the people involved is greater than 185 centimeters (ignoring people with
 * unregistered height). What is the number of movies in the Portuguese language for
 * which the average height of all people involved is greater than 175 centimeters?
 */

-- Example
SELECT COUNT(*) AS movie_count
FROM (
	SELECT m.id, AVG(p.height) AS "avg_height"
	FROM involved i
	JOIN movie m ON i.movieid = m.id
	JOIN person p ON i.personid = p.id
	WHERE m."language" = 'French' AND p.height IS NOT NULL
	GROUP BY m.id
	HAVING AVG(p.height) > 185
)
AS subquery;

-- Correct
SELECT COUNT(*) AS movie_count
FROM (
	SELECT m.id, AVG(p.height) AS "avg_height"
	FROM involved i
	JOIN movie m ON i.movieid = m.id
	JOIN person p ON i.personid = p.id
	WHERE m."language" = 'Portuguese' AND p.height IS NOT NULL
	GROUP BY m.id
	HAVING AVG(p.height) > 175
)
AS subquery;

/*
 * Question 3
 * The movie genre relation does not have a primary key, which can lead to a movie
 * having more than one entry with the same genre. As a result, there are 14 movies
 * in movie genre that have the genre ‘Action’ assigned to them more than once. How
 * many movies in movie genre have the genre ‘Thriller’ assigned to them more than
 * once?
 */

-- Example
SELECT COUNT(*) AS movie_count
FROM (
	SELECT COUNT(m.id) FROM movie m
	JOIN movie_genre mg ON m.id = mg.movieid
	WHERE mg.genre = 'Action'
	GROUP BY m.id
	HAVING COUNT(m.id) > 1
)
AS subquery;

-- Correct
SELECT COUNT(*) AS movie_count
FROM (
	SELECT COUNT(m.id) FROM movie m
	JOIN movie_genre mg ON m.id = mg.movieid
	WHERE mg.genre = 'Thriller'
	GROUP BY m.id
	HAVING COUNT(m.id) > 1
)
AS subquery;

/*
 * Question 4
 * According to the information in the database, 52 different people acted in movies
 * directed by ‘Ingmar Bergman’. How many different people acted in movies directed
 * by ‘Akira Kurosawa’?
 */ 

-- Example
SELECT COUNT(DISTINCT p.id) AS person_count
FROM involved i 
JOIN person p ON i.personid = p.id
JOIN (
	SELECT m.id FROM involved i
	JOIN person p ON i.personid = p.id
	JOIN movie m ON i.movieid = m.id
	WHERE i."role" = 'director' AND p."name" = 'Ingmar Bergman'
) m ON i.movieid = m.id;

-- Correct
SELECT COUNT(DISTINCT p.id) AS person_count
FROM involved i 
JOIN person p ON i.personid = p.id
JOIN (
	SELECT m.id FROM involved i
	JOIN person p ON i.personid = p.id
	JOIN movie m ON i.movieid = m.id
	WHERE i."role" = 'director' AND p."name" = 'Akira Kurosawa'
) m ON i.movieid = m.id;

/*
 * Question 5
 * Of all the movies produced in 2007, there are 15 that have two directors involved
 * in them. How many movies produced in 2010 have two directors involved in them?
 */

-- Example
SELECT COUNT(*) AS movie_count
FROM (
	SELECT COUNT(p.id) FROM involved i
	JOIN person p ON i.personid = p.id
	JOIN movie m ON i.movieid = m.id
	WHERE i."role" = 'director' AND m."year" = 2007
	GROUP BY m.id
	HAVING COUNT(p.id) = 2
)
AS subquery;

-- Correct
SELECT COUNT(*) AS movie_count
FROM (
	SELECT COUNT(p.id) FROM involved i
	JOIN person p ON i.personid = p.id
	JOIN movie m ON i.movieid = m.id
	WHERE i."role" = 'director' AND m."year" = 2010
	GROUP BY m.id
	HAVING COUNT(p.id) = 2
)
AS subquery;

/*
 * Question 6
 * There are 406 unique pairs of actors who have appeared together in exactly 10 movies
 * released between 2000 and 2010. How many unique pairs of actors have appeared
 * together in exactly 20 movies released between 2000 and 2010?
 */

-- Example
SELECT COUNT(*)
FROM (
    SELECT i1.personId AS actor1, i2.personId AS actor2, COUNT(*) AS movie_count
    FROM involved i1
    JOIN involved i2 ON i1.movieId = i2.movieId AND i1.personId < i2.personId
    JOIN movie M ON I1.movieId = M.id
    WHERE i1.role = 'actor'
        AND i2.role = 'actor'
        AND m.year BETWEEN 2000 AND 2010
    GROUP BY i1.personId, i2.personId
    HAVING COUNT(*) = 10
)
AS subquery;

-- Correct
SELECT COUNT(*)
FROM (
    SELECT i1.personId AS actor1, i2.personId AS actor2, COUNT(*) AS movie_count
    FROM involved i1
    JOIN involved i2 ON i1.movieId = i2.movieId AND i1.personId < i2.personId
    JOIN movie m ON i1.movieId = m.id
    WHERE i1.role = 'actor'
        AND i2.role = 'actor'
        AND m.year BETWEEN 2000 AND 2010
    GROUP BY i1.personId, i2.personId
    HAVING COUNT(*) = 20
)
AS subquery;

/*
 * Question 7
 * Of all the movies produced between 2000 and 2002, there are 782 that have entries
 * registered in involved for all roles defined in the roles relation. How many movies
 * produced between 2002 and 2004 have entries registered in involved for all roles
 * defined in the roles relation?
 */

-- Example
SELECT COUNT(*) AS movie_count
FROM (
	SELECT COUNT(DISTINCT i."role")
	FROM involved i
	JOIN person p ON i.personid = p.id
	JOIN movie m ON i.movieid = m.id
	WHERE m."year" BETWEEN 2000 AND 2002
	GROUP BY m.id
	HAVING COUNT(DISTINCT i."role") = (SELECT COUNT(*) FROM role)
)
AS subquery;

-- Correct
SELECT COUNT(*) AS movie_count
FROM (
	SELECT COUNT(DISTINCT i."role")
	FROM involved i
	JOIN person p ON i.personid = p.id
	JOIN movie m ON i.movieid = m.id
	WHERE m."year" BETWEEN 2002 AND 2004
	GROUP BY m.id
	HAVING COUNT(DISTINCT i."role") = (SELECT COUNT(*) FROM ROLE)
)
AS subquery;

/*
 * Question 8
 * The number of people who have played a role in movies of all genres in the category
 * ‘Newsworthy’ is 156. How many people have played a role in movies of all genres
 * in the category ‘Newsworthy’ but have not played any role in movies that cover all
 * genres in the category ‘Popular’?
 */

-- Example
SELECT COUNT(DISTINCT p.id) FROM involved i
JOIN person p ON i.personid = p.id
JOIN movie m ON i.movieid = m.id
WHERE m.id IN (
	SELECT m.id FROM movie_genre mg
	JOIN movie m ON mg.movieid = m.id
	JOIN genre g ON mg.genre = g.genre
	WHERE g.category = 'Newsworthy'
	GROUP BY m.id
	HAVING COUNT(g.genre) = (
		SELECT COUNT(g.genre) FROM genre g 
		WHERE g.category = 'Newsworthy'
	)
);

-- Correct
SELECT COUNT(DISTINCT p.id) FROM involved i
JOIN person p ON i.personid = p.id
JOIN movie m ON i.movieid = m.id
WHERE m.id IN (
	SELECT m.id FROM movie_genre mg
	JOIN movie m ON mg.movieid = m.id
	JOIN genre g ON mg.genre = g.genre
	WHERE g.category = 'Newsworthy'
	GROUP BY m.id
	HAVING COUNT(g.genre) = (
		SELECT COUNT(g.genre) FROM genre g 
		WHERE g.category = 'Newsworthy'
	)
)
AND p.id NOT IN (
	SELECT m.id FROM movie_genre mg
	JOIN movie m ON mg.movieid = m.id
	JOIN genre g ON mg.genre = g.genre
	WHERE g.category = 'Popular'
	GROUP BY m.id
	HAVING COUNT(g.genre) = (
		SELECT COUNT(g.genre) FROM genre g 
		WHERE g.category = 'Popular'
	)
);
