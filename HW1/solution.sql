-- Q1

SELECT count(*)
FROM person
WHERE deathdate > '2010-02-01';
-- 284

SELECT count(*)
FROM person
WHERE deathdate IS NULL;
-- 52759

-- Q2

SELECT COUNT(*) 
FROM (
    SELECT movieId, AVG(P.height) 
    FROM Involved I
    JOIN person P ON I.personId = P.ID
    JOIN movie M ON I.movieId = M.id
    WHERE language = 'French' 
    GROUP BY I.movieId
    HAVING AVG(P.height) > 185
) X;
-- 46

SELECT COUNT(*) 
FROM (
    SELECT movieId, AVG(P.height) 
    FROM Involved I
    JOIN person P ON I.personId = P.ID
    JOIN movie M ON I.movieId = M.id
    WHERE language = 'Portuguese' 
    GROUP BY I.movieId
    HAVING AVG(P.height) > 175
) X;
-- 26


-- Q3

SELECT COUNT(*)
FROM (
    SELECT movieId
    FROM movie_genre
    WHERE genre = 'Action'  -- Specify the desired genre
    GROUP BY movieId
    HAVING COUNT(*) > 1
) X;
-- 14

SELECT COUNT(*)
FROM (
    SELECT movieId
    FROM movie_genre
    WHERE genre = 'Thriller'  -- Specify the desired genre
    GROUP BY movieId
    HAVING COUNT(*) > 1
) X;
-- 14


-- Q4


SELECT COUNT(DISTINCT I1.personId)
FROM involved I1 
JOIN involved I2 ON I1.movieId = I2.movieId
JOIN person P ON I2.personId = P.id
WHERE I1.role = 'actor'
  AND I2.role = 'director'
  AND P.name = 'Ingmar Bergman';
-- 52

SELECT COUNT(DISTINCT I1.personId)
FROM involved I1 
JOIN involved I2 ON I1.movieId = I2.movieId
JOIN person P ON I2.personId = P.id
WHERE I1.role = 'actor'
  AND I2.role = 'director'
  AND P.name = 'Akira Kurosawa';
-- 129

-- Q5
-- Movies in 2007 with two directors involved in them 

SELECT COUNT(*) 
FROM movie M
WHERE M.year = 2007
  AND M.id IN (
    SELECT I1.movieId
    FROM involved I1
    WHERE I1.role = 'director'
    GROUP BY I1.movieId
    HAVING COUNT(*) = 2
  );
-- 15


SELECT COUNT(*) 
FROM movie M
WHERE M.year = 2010
  AND M.id IN (
    SELECT I1.movieId
    FROM involved I1
    WHERE I1.role = 'director'
    GROUP BY I1.movieId
    HAVING COUNT(*) = 2
  );
-- 9

-- Q6

-- There are 406 unique pairs of actors who have appeared together in exactly 10 movies released between 2000 and 2010.
SELECT COUNT(*)
FROM (
    SELECT I1.personId AS actor1, I2.personId AS actor2, COUNT(*) AS movie_count
    FROM involved I1
    JOIN involved I2 ON I1.movieId = I2.movieId AND I1.personId < I2.personId
    JOIN movie M ON I1.movieId = M.id
    WHERE I1.role = 'actor' AND I2.role = 'actor' AND M.year BETWEEN 2000 AND 2010
    GROUP BY I1.personId, I2.personId
    HAVING COUNT(*) = 10
) X;
-- 406

SELECT COUNT(*)
FROM (
    SELECT I1.personId AS actor1, I2.personId AS actor2, COUNT(*) AS movie_count
    FROM involved I1
    JOIN involved I2 ON I1.movieId = I2.movieId AND I1.personId < I2.personId
    JOIN movie M ON I1.movieId = M.id
    WHERE I1.role = 'actor' AND I2.role = 'actor' AND M.year BETWEEN 2000 AND 2010
    GROUP BY I1.personId, I2.personId
    HAVING COUNT(*) = 20
) X;
-- 4

-- Q7

SELECT COUNT(*)
FROM (
    SELECT M.id
    FROM movie M
    JOIN involved I ON M.id = I.movieId    
    WHERE M.year BETWEEN 2000 AND 2002
    GROUP BY M.id
    HAVING COUNT(DISTINCT I.role) = (
        SELECT COUNT(*)
        FROM role R
    )
) X;
-- 782

SELECT COUNT(*)
FROM (
    SELECT M.id
    FROM movie M
    JOIN involved I ON M.id = I.movieId    
    WHERE M.year BETWEEN 2002 AND 2004
    GROUP BY M.id
    HAVING COUNT(DISTINCT I.role) = (
        SELECT COUNT(*)
        FROM role R
    )
) X;
-- 823

-- Q8

-- with counting
SELECT COUNT(*)
FROM (
    SELECT I.personId
    FROM involved I 
    JOIN movie_genre MG ON MG.movieId = I.movieId
    JOIN genre G ON MG.genre = G.genre
    WHERE G.category = 'Newsworthy'
    GROUP BY I.personId
    HAVING COUNT(DISTINCT G.genre) = (
        SELECT COUNT(*)
        FROM genre
        WHERE category = 'Newsworthy'
    )
) X;
-- 156

-- with double negation
SELECT COUNT(P.id)
FROM person P
WHERE NOT EXISTS(
    SELECT *
    FROM genre G
    WHERE G.category = 'Newsworthy'
      AND NOT EXISTS(
        SELECT *
        FROM movie_genre MG
        JOIN involved I ON MG.movieid = I.movieid
        WHERE I.personid = P.id
          AND G.genre = MG.genre
     )
);
-- 156

SELECT COUNT(*)
FROM (
    SELECT I.personId
    FROM involved I 
    JOIN movie_genre MG ON MG.movieId = I.movieId
    JOIN genre G ON MG.genre = G.genre
    WHERE G.category = 'Newsworthy'
    GROUP BY I.personId
    HAVING COUNT(DISTINCT G.genre) = (
        SELECT COUNT(*)
        FROM genre
        WHERE category = 'Newsworthy'
    )
    AND NOT EXISTS (
        SELECT 1
        FROM involved I2
        JOIN movie_genre MG2 ON MG2.movieId = I2.movieId
        JOIN genre G2 ON MG2.genre = G2.genre
        WHERE I2.personId = I.personId
        AND G2.category = 'Popular'
        GROUP BY I2.personId
        HAVING COUNT(DISTINCT G2.genre) = (
            SELECT COUNT(*)
            FROM genre
            WHERE category = 'Popular'
        )
    )
) X;
-- 48


SELECT COUNT(*)
FROM (
    SELECT I.personId
    FROM involved I
    JOIN movie_genre MG ON I.movieId = MG.movieId
    JOIN genre G ON MG.genre = G.genre
    WHERE G.category = 'Newsworthy'
    GROUP BY I.personId
    HAVING COUNT(DISTINCT G.genre) = (
        SELECT COUNT(*)
        FROM genre
        WHERE category = 'Newsworthy'
    )
) AS PeopleInNewsworthy
WHERE PeopleInNewsworthy.personId NOT IN (
    SELECT I.personId
    FROM involved I
    JOIN movie_genre MG ON I.movieId = MG.movieId
    JOIN genre G ON MG.genre = G.genre
    WHERE G.category = 'Popular'
    GROUP BY I.personId
    HAVING COUNT(DISTINCT G.genre) = (
        SELECT COUNT(*)
        FROM genre
        WHERE category = 'Popular'
    )
);
-- 48
