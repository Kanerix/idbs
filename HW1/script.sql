-- # Question 1:

-- Example
SELECT COUNT(*) AS person_count
FROM person
WHERE deathdate > DATE '2010-02-01';

-- Correct
SELECT COUNT(*) AS person_count
FROM person
WHERE deathdate IS NULL;

-- # Question 2:

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

-- # Question 3

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

-- # Question 4

-- Example
SELECT COUNT(DISTINCT p.id) AS "actor_count"
FROM involved i 
JOIN person p ON i.personid = p.id
JOIN (
	SELECT m.id FROM involved i
	JOIN person p ON i.personid = p.id
	JOIN movie m ON i.movieid = m.id
	WHERE i."role" = 'director' AND p."name" = 'Ingmar Bergman'
) m ON i.movieid = m.id;

-- Correct
SELECT COUNT(DISTINCT p.id) AS "actor_count"
FROM involved i 
JOIN person p ON i.personid = p.id
JOIN (
	SELECT m.id FROM involved i
	JOIN person p ON i.personid = p.id
	JOIN movie m ON i.movieid = m.id
	WHERE i."role" = 'director' AND p."name" = 'Akira Kurosawa'
) m ON i.movieid = m.id;

-- # Question 5

-- Example
SELECT COUNT(*) AS "movie_count"
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
SELECT COUNT(*) AS "movie_count"
FROM (
	SELECT COUNT(p.id) FROM involved i
	JOIN person p ON i.personid = p.id
	JOIN movie m ON i.movieid = m.id
	WHERE i."role" = 'director' AND m."year" = 2010
	GROUP BY m.id
	HAVING COUNT(p.id) = 2
)
AS subquery;

-- # Question 6

-- Example


-- Correct


-- # Question 7

-- Example
SELECT COUNT(DISTINCT m.id) AS "movie_count"
FROM movie m
WHERE m.year BETWEEN 2000 AND 2002
AND NOT EXISTS (
    SELECT *
    FROM role r
    WHERE NOT EXISTS (
        SELECT *
        FROM involved i
        WHERE i.movieid = m.id
    )
);

-- Correct





































