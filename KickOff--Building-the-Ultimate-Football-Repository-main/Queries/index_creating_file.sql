-- INDEXING

-- DROPPING INDEX 

DROP INDEX IF EXISTS player_index_player_id;
DROP INDEX IF EXISTS game_index_seson;
DROP INDEX IF EXISTS player_index_player_name;
DROP INDEX IF EXISTS appearances_index_Competitionid;
DROP INDEX IF EXISTS appearances_player_id;
DROP INDEX IF EXISTS game_index_Competitionid;
DROP INDEX IF EXISTS index_competition;

--CREATING AN INDEX
CREATE INDEX appearances_player_id ON appearances (player_id);

--B-TREE INDEX
CREATE INDEX player_index_player_id on players USING btree(player_id);
CREATE INDEX game_index_seson on games USING btree(season);

--MULTI INDEX
CREATE INDEX player_index_player_name on players(first_name, last_name);
CREATE INDEX index_competition
ON appearances (competition_id, yellow_cards, red_cards, goals, minutes_played);

-- HASH INDEX
CREATE INDEX appearances_index_Competitionid ON appearances USING HASH (competition_id);
CREATE INDEX game_index_Competitionid  on games USING HASH (competition_id);



