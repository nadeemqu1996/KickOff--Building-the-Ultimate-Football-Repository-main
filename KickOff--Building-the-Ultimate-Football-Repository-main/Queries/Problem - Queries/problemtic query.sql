------------------------------------------	
--PROBLEMTIC QUERY 1: To FIND THE PLAYER STATISTICS
EXPLAIN ANALYZE 
SELECT 
	CONCAT(p.first_name, ' ', p.last_name) AS player_name,
	SUM(a.goals) AS total_goals,
	SUM(a.assists) AS total_assists,
	SUM(a.yellow_cards) AS total_yellow_cards,
	SUM(a.red_cards) AS total_red_cards,
	SUM(a.minutes_played) AS total_minutes_played
	FROM appearances a

JOIN 
	players p on a.player_id = p.player_id
	
WHERE a.player_id = 557

GROUP BY player_name;
------------------------------------------	
--PROBLEMTIC QUERY 2: To FIND THE PLAYER MATCH DETAILS
EXPLAIN ANALYZE 
SELECT
    player_id,
    AVG(goals),
    AVG(assists),
    MAX(minutes_played)
    FROM appearances
where player_id = 123
GROUP BY player_id;

------------------------------------------	
--PROBLEMTIC QUERY 3: To FIND THE PLAYER MATCH DETAILS
EXPLAIN ANALYZE 
SELECT 
	competition_id, 
	sum(yellow_cards) as total_yellow_cards, 
	sum(red_cards)as total_red_cards, 
	sum(goals) as goals,
	sum(minutes_played)as total_mintues_played
FROM appearances
group by competition_id;
------------------------------------------	


























































----