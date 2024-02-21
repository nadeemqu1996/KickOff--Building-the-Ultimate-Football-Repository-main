WITH best_player_each_competition AS (
    SELECT
        apper.competition_id,
		ROW_NUMBER() OVER (PARTITION BY apper.competition_id ORDER BY SUM(apper.goals) DESC) AS player_rank,
        comp.name AS competition_name,
		CONCAT(p.first_name, ' ', p.last_name) as player_name,
        SUM(apper.goals) AS total_goals    
    FROM
        appearances apper
    JOIN
        competitions comp ON apper.competition_id = comp.competition_id
	JOIN 
		players p on apper.player_id = p.player_id
    GROUP BY
        apper.competition_id, competition_name, player_name
)
SELECT
    competition_name,
    player_name AS best_player,
    total_goals
FROM
    best_player_each_competition	
WHERE
	player_rank = 1;
