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
