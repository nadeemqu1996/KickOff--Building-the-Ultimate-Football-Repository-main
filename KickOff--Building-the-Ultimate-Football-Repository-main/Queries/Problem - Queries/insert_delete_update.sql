-- INSERTING 
-------------------------------------------------------------------------------------------

-- Add a competition called CNN in competition table

INSERT INTO competitions(competition_id, name, url)
VALUES ('CNN', 'buffalo_cup', 'dummy');

--View
SELECT * FROM competitions WHERE competition_id = 'CNN';

-- Inserting match details of cnn competition: Inserting to appearances table

INSERT INTO appearances (appearance_id, competition_id, player_id, yellow_cards, red_cards, goals, assists, minutes_played)
VALUES
  (1, 'CNN', 670, 0, 0, 0, 2, 90),
  (2, 'CNN', 1323, 1, 0, 2, 1, 88),
  (3, 'CNN', 3195, 0, 1, 0, 0, 90),
  (4, 'CNN', 3259, 1, 0, 1, 3, 87),
  (5, 'CNN', 3614, 0, 0, 3, 1, 89),
  (6, 'CNN', 3804, 1, 0, 2, 1, 90),
  (7, 'CNN', 4042, 0, 0, 1, 2, 88),
  (8, 'CNN', 4112, 1, 0, 0, 2, 85),
  (9, 'CNN', 4133, 0, 0, 2, 0, 89),
  (10, 'CNN', 4219, 0, 0, 1, 1, 86);

-- View 
SELECT * FROM appearances WHERE competition_id = 'CNN';  

--Updating the goals and assists in apperarances table for competition_id = 'CNN' and player_id 670
UPDATE appearances
SET goals = 1, assists = 0
WHERE competition_id = 'CNN' AND player_id = 670;

--Updating the competition name in competition table for competition_id = 'CNN'
UPDATE competitions
SET name = 'Amherst_club'
WHERE competition_id = 'CNN';

-- Deleting the details of competition CNN in apperarances and competition table.
--Deleting the data that we created above
DELETE FROM appearances WHERE competition_id = 'CNN';
DELETE FROM competitions WHERE competition_id = 'CNN';

-------------------------------------------------------------------------------------------

-- Queries to delete in few other tables 
-- DELETING:
DELETE FROM player_position
WHERE sub_position IS NULL;

DELETE FROM players
WHERE player_id = 33100;

DELETE FROM player_code
WHERE player_id = 33100;

DELETE FROM player_code
WHERE player_id = 33100;

DELETE FROM player_position
WHERE player_id = 33100;

-------------------------------------------------------------------------------------------

--UPDATING

--Updating the player position of 1323
UPDATE player_position SET player_position = 'Central Midfield' WHERE player_id = '1323';

	
-- Updating the highest_market value of all null values with its current market value
UPDATE players
SET highest_market_value_in_eur = COALESCE(highest_market_value_in_eur, market_value_in_eur);

--Updating the player 24131 agent and market value

--View
select *
from players
where player_id = 24131

--Updating the agent and market_value_in_eur for player 24131

UPDATE players
SET agent_name = 'ES SPORT',  
    market_value_in_eur = 10000000
WHERE player_id = 24131;


-- Updating the players value based on the position they play
UPDATE players
SET market_value_in_eur = 
    CASE
        WHEN (
            SELECT sub_position
            FROM player_position
            WHERE player_position.player_id = players.player_id
        ) = 'Central Midfield' THEN 25000000
        WHEN (
            SELECT sub_position
            FROM player_position
            WHERE player_position.player_id = players.player_id
        ) = 'Goalkeeper' THEN 22000000
        WHEN (
            SELECT sub_position
            FROM player_position
            WHERE player_position.player_id = players.player_id
        ) = 'Centre-Forward' THEN 18000000
    END;

-------------------------------------------------------------------------------------------








