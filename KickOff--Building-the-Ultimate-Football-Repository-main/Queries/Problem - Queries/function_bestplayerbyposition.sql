DROP FUNCTION IF EXISTS playersbyposition(character varying);

CREATE FUNCTION playersbyposition(position_required VARCHAR(255))
RETURNS TABLE (
    player_name VARCHAR(255),
    avg_goals DECIMAL(10, 2),
    avg_yellow_cards DECIMAL(10, 2),
    avg_red_cards DECIMAL(10, 2),
    avg_minutes_played DECIMAL(10, 2),
    overall_rank INT,
    position1 VARCHAR(255)
)
AS
$$
WITH players_ranking AS (
    SELECT
        CONCAT(p.first_name, ' ', p.last_name) as player_name,
        AVG(a.goals) AS avg_goals,
        AVG(a.yellow_cards) AS avg_yellow_cards,
        AVG(a.red_cards) AS avg_red_cards,
        AVG(a.minutes_played) AS avg_minutes_played,
        RANK() OVER (ORDER BY MAX(a.goals) DESC, MAX(a.minutes_played) DESC, MIN(a.yellow_cards) ASC, MIN(a.red_cards) ASC) AS player_rank,
        pp.sub_position AS position1
    FROM
        players p
    JOIN
        appearances a ON p.player_id = a.player_id
    JOIN
        player_position pp ON p.player_id = pp.player_id
	
    GROUP BY player_name, sub_position
)
SELECT
    player_name,
    round(avg_goals,3),
    round(avg_yellow_cards,3),
    round(avg_red_cards,3),
    round(avg_minutes_played,3),
    player_rank,
    position1
FROM
    players_ranking
WHERE
    position1 = position_required
ORDER BY
    player_rank, avg_minutes_played DESC
Limit 10;
$$ LANGUAGE SQL;

--Please run the below function by changing desired position required to get top 10 best player


SELECT * FROM playersbyposition('Left Winger');
SELECT * FROM playersbyposition('Goalkeeper');
































