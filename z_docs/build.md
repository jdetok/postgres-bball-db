# postgres bball database build docs
- documentation on building postgres database & inserting data with go ETL process
- a script will be written orchestrating the contents of this documentation
# postgres server
- run in a docker container configured with Dockerfile/docker compose
## docker-entrypoint-initdb.d
.sql files in /sql (on the host machine) are copied into /docker-entrypoint-initdb.d in the container on image build. these files are executed when the container is built. the files run in alphanumeric order based on their file name.
## /sql/0-init
- create_schemas.sql - first file to run on container build
    - database schemas are created
    - NOTE: there is no need for a "create database" statement. the database set to the "POSTGRES_DB" variable in .env file will be automatically created with the container.
## /sql/1-tbl
- contains files with DDL (and some insert) statements to create the database tables for each schema
- the order these tables are created is essential - create statements for tables that are referenced by other tables MUST be executed before the referencing tables
- there are some insert statements included in between some of the create table statements, particularly into the `lg.league`, `lg.szn_type`, `lg.szn`, and `lg.team` tables. these include placeholder rows (like 0 for team, which is often used for players without an assigned team)
## /sql/2-prc
- contains plpgsql functions and stored procedures. MUST be run after tables are created
- primarily processes data inserted into the tables in the `intake` schema to load to the `lg` and `stats` schemas
# inserting data
- the data loaded into this DB is sourced from stats.nba.com via HTTP requests written in Go. 
- all data from this process is loaded into tables within the `intake` schema. the layout of these tables coincide directly with the layout of returned JSON from stats.nba.com
## intake.gm_player
- PLAYER game logs via leaguegamelog are inserted here
## intake.gm_team
- TEAM game logs via leaguegamelog are inserted here
## intake.player
- NBA players from commonallplayers endpooint are inserted here
## intake.wplayer
- WNBA players from commonallplayers endpooint are inserted here
