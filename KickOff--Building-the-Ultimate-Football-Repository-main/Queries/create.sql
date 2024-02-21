-- Table: public.competitions

DROP TABLE IF EXISTS public.competitions;

CREATE TABLE IF NOT EXISTS public.competitions
(
    competition_id character varying COLLATE pg_catalog."default" NOT NULL,
    name character varying COLLATE pg_catalog."default",
    url character varying COLLATE pg_catalog."default",
    CONSTRAINT competitions_pkey PRIMARY KEY (competition_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.competitions
    OWNER to postgres;

-- Table: public.appearances
	
DROP TABLE IF EXISTS public.appearances;
 
CREATE TABLE IF NOT EXISTS public.appearances
(
    appearance_id character varying COLLATE pg_catalog."default" NOT NULL,
    competition_id character varying COLLATE pg_catalog."default",
    yellow_cards integer,
    red_cards integer,
    goals integer,
    assists integer,
    minutes_played integer,
    player_id integer,
    CONSTRAINT appearances_pkey PRIMARY KEY (appearance_id),
    CONSTRAINT appearances_competition_id_fkey FOREIGN KEY (competition_id)
        REFERENCES public.competitions (competition_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
 
TABLESPACE pg_default;
 
ALTER TABLE IF EXISTS public.appearances
    OWNER to postgres;
-- Index: appearances_btree_player_id
 
DROP INDEX IF EXISTS public.appearances_btree_player_id;
 
CREATE INDEX IF NOT EXISTS appearances_btree_player_id
    ON public.appearances USING hash
    (player_id)
    TABLESPACE pg_default;
-- Index: appearances_index_competitionid
 
DROP INDEX IF EXISTS public.appearances_index_competitionid;
 
CREATE INDEX IF NOT EXISTS appearances_index_competitionid
    ON public.appearances USING hash
    (competition_id COLLATE pg_catalog."default")
    TABLESPACE pg_default;
	
-- Table: public.clubs
 
DROP TABLE IF EXISTS public.clubs;
 
CREATE TABLE IF NOT EXISTS public.clubs
(
    club_id integer NOT NULL,
    domestic_competition_id character varying COLLATE pg_catalog."default",
    squad_size integer,
    average_age real,
    foreigners_number integer,
    foreigners_percentage real,
    national_team_players integer,
    stadium_seats integer,
    stadium_name character varying COLLATE pg_catalog."default",
    last_season integer,
    CONSTRAINT clubs_pkey PRIMARY KEY (club_id),
    CONSTRAINT clubs_domestic_competition_id_fkey FOREIGN KEY (domestic_competition_id)
        REFERENCES public.competitions (competition_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
 
TABLESPACE pg_default;
 
ALTER TABLE IF EXISTS public.clubs
    OWNER to postgres;
	
-- Table: public.clubs_code
 
-- DROP TABLE IF EXISTS public.clubs_code;
 
CREATE TABLE IF NOT EXISTS public.clubs_code
(
    club_id integer NOT NULL,
    club_code character varying COLLATE pg_catalog."default",
    CONSTRAINT clubs_code_pkey PRIMARY KEY (club_id),
    CONSTRAINT clubs_code_club_id_fkey FOREIGN KEY (club_id)
        REFERENCES public.clubs (club_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
 
TABLESPACE pg_default;
 
ALTER TABLE IF EXISTS public.clubs_code
    OWNER to postgres;
	
-- Table: public.games
 
-- DROP TABLE IF EXISTS public.games;
 
CREATE TABLE IF NOT EXISTS public.games
(
    game_id integer NOT NULL,
    competition_id character varying COLLATE pg_catalog."default",
    season integer,
    round character varying COLLATE pg_catalog."default",
    date character varying COLLATE pg_catalog."default",
    aggregate character varying COLLATE pg_catalog."default",
    competition_type character varying COLLATE pg_catalog."default",
    CONSTRAINT games_pkey PRIMARY KEY (game_id),
    CONSTRAINT games_competition_id_fkey FOREIGN KEY (competition_id)
        REFERENCES public.competitions (competition_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
 
TABLESPACE pg_default;
 
ALTER TABLE IF EXISTS public.games
    OWNER to postgres;
	
-- Table: public.games_away_club
 
-- DROP TABLE IF EXISTS public.games_away_club;
 
CREATE TABLE IF NOT EXISTS public.games_away_club
(
    away_club_id integer,
    away_club_position integer,
    away_club_goals integer,
    away_club_manager_name character varying COLLATE pg_catalog."default",
    away_club_name character varying COLLATE pg_catalog."default",
    game_id integer NOT NULL,
    CONSTRAINT games_away_club_pkey PRIMARY KEY (game_id),
    CONSTRAINT games_away_club_game_id_fkey FOREIGN KEY (game_id)
        REFERENCES public.games (game_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
 
TABLESPACE pg_default;
 
ALTER TABLE IF EXISTS public.games_away_club
    OWNER to postgres;
	
-- Table: public.games_home_club
 
-- DROP TABLE IF EXISTS public.games_home_club;
 
CREATE TABLE IF NOT EXISTS public.games_home_club
(
    home_club_id integer,
    home_club_position integer,
    home_club_goals integer,
    home_club_manager_name character varying COLLATE pg_catalog."default",
    home_club_name character varying COLLATE pg_catalog."default",
    game_id integer NOT NULL,
    CONSTRAINT games_home_club_pkey PRIMARY KEY (game_id),
    CONSTRAINT games_home_club_game_id_fkey FOREIGN KEY (game_id)
        REFERENCES public.games (game_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
 
TABLESPACE pg_default;
 
ALTER TABLE IF EXISTS public.games_home_club
    OWNER to postgres;
	
-- Table: public.competitions_country
 
-- DROP TABLE IF EXISTS public.competitions_country;
 
CREATE TABLE IF NOT EXISTS public.competitions_country
(
    competition_id character varying COLLATE pg_catalog."default" NOT NULL,
    country_name character varying COLLATE pg_catalog."default",
    CONSTRAINT competitions_country_pkey PRIMARY KEY (competition_id),
    CONSTRAINT competitions_country_competition_id_fkey FOREIGN KEY (competition_id)
        REFERENCES public.competitions (competition_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
 
TABLESPACE pg_default;
 
ALTER TABLE IF EXISTS public.competitions_country
    OWNER to postgres;
	
-- Table: public.competitions_domestic_league
 
-- DROP TABLE IF EXISTS public.competitions_domestic_league;
 
CREATE TABLE IF NOT EXISTS public.competitions_domestic_league
(
    competition_id character varying COLLATE pg_catalog."default" NOT NULL,
    domestic_league_code character varying COLLATE pg_catalog."default",
    CONSTRAINT competitions_domestic_league_pkey PRIMARY KEY (competition_id),
    CONSTRAINT competitions_domestic_league_competition_id_fkey FOREIGN KEY (competition_id)
        REFERENCES public.competitions (competition_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
 
TABLESPACE pg_default;
 
ALTER TABLE IF EXISTS public.competitions_domestic_league
    OWNER to postgres;
	
-- Table: public.competitions_type
 
-- DROP TABLE IF EXISTS public.competitions_type;
 
CREATE TABLE IF NOT EXISTS public.competitions_type
(
    competition_id character varying COLLATE pg_catalog."default" NOT NULL,
    type "char",
    CONSTRAINT competitions_type_pkey PRIMARY KEY (competition_id),
    CONSTRAINT competitions_type_competition_id_fkey FOREIGN KEY (competition_id)
        REFERENCES public.competitions (competition_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
 
TABLESPACE pg_default;
 
ALTER TABLE IF EXISTS public.competitions_type
    OWNER to postgres;

-- Table: public.competition_current_club
 
-- DROP TABLE IF EXISTS public.competition_current_club;
 
CREATE TABLE IF NOT EXISTS public.competition_current_club
(
    player_id integer NOT NULL,
    current_club_name character varying COLLATE pg_catalog."default",
    current_club_domestic_competition_id character varying COLLATE pg_catalog."default",
    CONSTRAINT competition_current_club_pkey PRIMARY KEY (player_id),
    CONSTRAINT competition_current_club_current_club_domestic_competition_fkey FOREIGN KEY (current_club_domestic_competition_id)
        REFERENCES public.competitions (competition_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
 
TABLESPACE pg_default;
 
ALTER TABLE IF EXISTS public.competition_current_club
    OWNER to postgres;
	
-- Table: public.players
 
-- DROP TABLE IF EXISTS public.players;
 
CREATE TABLE IF NOT EXISTS public.players
(
    player_id integer NOT NULL,
    first_name character varying COLLATE pg_catalog."default",
    last_name character varying COLLATE pg_catalog."default",
    last_season integer,
    country_of_citizenship character varying COLLATE pg_catalog."default",
    foot "char",
    height_in_cm integer,
    market_value_in_eur bigint,
    highest_market_value_in_eur bigint,
    agent_name character varying COLLATE pg_catalog."default",
    image_url character varying COLLATE pg_catalog."default",
    CONSTRAINT players_pkey PRIMARY KEY (player_id),
    CONSTRAINT players_player_id_fkey FOREIGN KEY (player_id)
        REFERENCES public.competition_current_club (player_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
 
TABLESPACE pg_default;
 
ALTER TABLE IF EXISTS public.players
    OWNER to postgres;
-- Index: player_index_player_name
 
-- DROP INDEX IF EXISTS public.player_index_player_name;
 
CREATE INDEX IF NOT EXISTS player_index_player_name
    ON public.players USING btree
    (first_name COLLATE pg_catalog."default" ASC NULLS LAST, last_name COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
	
-- Table: public.player_birth
 
-- DROP TABLE IF EXISTS public.player_birth;
 
CREATE TABLE IF NOT EXISTS public.player_birth
(
    player_id integer NOT NULL,
    city_of_birth character varying COLLATE pg_catalog."default",
    CONSTRAINT player_birth_pkey PRIMARY KEY (player_id),
    CONSTRAINT player_birth_player_id_fkey FOREIGN KEY (player_id)
        REFERENCES public.players (player_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
 
TABLESPACE pg_default;
 
ALTER TABLE IF EXISTS public.player_birth
    OWNER to postgres;
	
-- Table: public.player_code
 
-- DROP TABLE IF EXISTS public.player_code;
 
CREATE TABLE IF NOT EXISTS public.player_code
(
    player_id integer NOT NULL,
    player_code character varying COLLATE pg_catalog."default",
    CONSTRAINT player_code_pkey PRIMARY KEY (player_id),
    CONSTRAINT player_code_player_id_fkey FOREIGN KEY (player_id)
        REFERENCES public.players (player_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
 
TABLESPACE pg_default;
 
ALTER TABLE IF EXISTS public.player_code
    OWNER to postgres;
	
-- Table: public.player_position
 
-- DROP TABLE IF EXISTS public.player_position;
 
CREATE TABLE IF NOT EXISTS public.player_position
(
    player_id integer NOT NULL,
    "position" "char",
    sub_position character varying COLLATE pg_catalog."default",
    CONSTRAINT player_position_pkey PRIMARY KEY (player_id),
    CONSTRAINT player_position_player_id_fkey FOREIGN KEY (player_id)
        REFERENCES public.players (player_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
 
TABLESPACE pg_default;
 
ALTER TABLE IF EXISTS public.player_position
    OWNER to postgres;
