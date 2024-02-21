def get_query_1():
    query1 = """SELECT player_id
            , first_name
            , last_name 
            , country_of_citizenship
            , highest_market_value_in_eur
            , height_in_cm
            , foot
            , last_season
            , image_url
            FROM Players;"""
    return query1

def get_query_2():
    query2 = """
    select DISTINCT sub_position
    From player_position"""
    return query2

def get_query_3(position):
    query3 = f"""DROP FUNCTION IF EXISTS playersbyposition(character varying);

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
    SELECT * FROM playersbyposition('{position}');
        """

    return query3

def get_query_4():
    query4 = """
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
;"""
    return query4

def get_query_5(id):
    query5 = f"""
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
    WHERE a.player_id = {id}
    GROUP BY player_name;
    """
    return query5

def get_query_6(position):
    query6 = f""""""
    return query6

