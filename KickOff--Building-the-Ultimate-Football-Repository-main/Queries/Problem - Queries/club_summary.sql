SELECT
	c.club_id,
	c.squad_size,
	c.average_age,
	c.foreigners_number,
	c.foreigners_percentage,
	c.national_team_players,
	c.stadium_name,
	c.stadium_seats,
	SUM(ghc.home_club_goals) AS total_home_goals	
FROM
	clubs c
LEFT JOIN
	games_home_club ghc ON c.club_id = ghc.home_club_id
GROUP BY
	c.club_id
ORDER BY
	total_home_goals desc, national_team_players;
	

	




