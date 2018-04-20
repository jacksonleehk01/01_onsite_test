-- By Jackson Lee
-- Q1 
SELECT
	articles.id as article_id,
	articles.title as title,
	count( 1 ) as like_received
FROM
	articles as articles
JOIN clickstream as event ON
	event.objectId = articles.id
Where
	event.time BETWEEN '2017-04-01 00:00:00' AND '2017-04-01 23:59:59'
	AND event.action = 'LIKE_ARTICLE'
GROUP BY 1,2
ORDER BY 3 DESC
LIMIT 100;

-- Q2
--I believe there will be billions of record in such event(clickstream) table,
--so I would prefer joinning the Unique Visitor result-set (2017-04-02 to 08)
--with a TEMP table to find user_id that have FIRST_INSTALL_event on 2018-04-01,
--instead of sub-query

CREATE TEMP TABLE first_install_on_20170401 AS (
SELECT
	DISTINCT
	event.user_id
FROM
	clickstream as event
Where
	event.time BETWEEN '2017-04-01 00:00:00' AND '2017-04-01 23:59:59'
	AND event.action = 'FIRST_INSTALL'
);

--the final answer
SELECT 
	COUNT(DISTINCT event.userId)
FROM
	clickstream as event
JOIN first_install_on_20170401 as first_install ON
first_install.userId = event.userId
Where
	event.time BETWEEN '2017-04-02 00:00:00' AND '2017-04-08 23:59:59'
AND 
	event.action IS NOT NULL;

