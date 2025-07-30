# intake
- intake tables are inserted into by the [Go ETL process](https://github.com/jdetok/bball-etl-go)
- the layout of intake tables directly match the JSON response from stats.nba.com endpoints 
### tables
- gm_player
- gm_team
- player
- wplayer
# league
- the league schema is for core player/league/team data
### tables 
- lg
- szn
- team
- plr
- plr_crnt
# stats
- stats schema is for player/team box scores
### tables
- pbox
- tbox
# api
- tables to use with API. should match legacy mariadb api tables in format