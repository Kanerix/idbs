/* Question A
 * 
 * The empire ‘Great Britain’ consists of 4 countries. How many countries does the
 * empire ‘Iberian’ consist of?
 */

-- Example
SELECT COUNT(*) FROM empires e
WHERE e.empire = 'Great Britain';

-- Correct
SELECT COUNT(*) FROM empires e
WHERE e.empire = 'Iberian';

/* Question B
 * 
 * There are 4 countries that are present on more than one continent. How many of
 * these countries are partially in Asia?
 */

-- Example
SELECT COUNT(*) FROM (
	SELECT coun.code FROM countries_continents cc
	JOIN continents cont ON cont.continent = cc.continent 
	JOIN countries coun ON coun.code = cc.countrycode
	GROUP BY coun.code
	HAVING COUNT(*) > 1
) X;

-- Correct
SELECT COUNT(*) FROM (
	SELECT coun.code FROM countries_continents cc
	JOIN continents cont ON cont.continent = cc.continent 
	JOIN countries coun ON coun.code = cc.countrycode
	GROUP BY coun.code
	HAVING COUNT(*) > 1 
		AND SUM(CASE WHEN cont.continent = 'Asia' THEN 1 ELSE 0 END) > 0
) X;

/* Question C
 * 
 * In the countries of North America that have more than 80 million inhabitants, there
 * are a total of 111,946,176 people who speak Spanish, according to the statistics in
 * the database. How many people who speak Spanish exist in the countries of Europe
 * that have more than 50 million inhabitants?
 */

-- Example


-- Correct


/* Question D
 * 
 * According to the database, two languages are spoken in all countries of ‘Benelux’.
 * How many languages are spoken in all countries of ‘Danish Empire’?
 */






