WITH PlayerScore_calculated AS (
    SELECT
        CONCAT(player.first_name, ' ', player.last_name) as player_name,
        SUM(a.goals) AS total_goals,
        SUM(a.red_cards) AS total_red_cards,
        SUM(a.yellow_cards) AS total_yellow_cards,
        SUM(a.minutes_played) AS total_minutes_played,
        COUNT(a.appearance_id) as total_match
    FROM
        players player
    JOIN
        appearances a ON player.player_id = a.player_id
    GROUP BY player_name
)
, 
Ratingscore AS (
    SELECT
        pc.player_name,
        ((pc.total_goals * 0.4) + (pc.total_match * 0.2) + (-pc.total_red_cards * 0.1) + (-pc.total_yellow_cards * 0.05) + (pc.total_minutes_played * 0.05)) as player_rating
    FROM
        PlayerScore_calculated pc
)
SELECT
    rv.player_name,
    Round((rv.player_rating - MIN(rv.player_rating) OVER ()) * 10 / (MAX(rv.player_rating) OVER () - MIN(rv.player_rating) OVER ()),1) as rating
FROM 
    Ratingscore as rv
ORDER BY
    rating DESC;