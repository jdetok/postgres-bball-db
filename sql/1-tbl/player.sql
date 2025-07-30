create table league.lg (
    lg_id int primary key,
    lg_cde varchar(10) unique,
    lg varchar(10) unique,
    lg_name varchar(255)
);

insert into league.lg values 
    (0, 'nba', 'NBA', 'National Basketball Association'),
    (1, 'wnba', 'WNBA', 'Women''s National Basketball Association'),
    (9, 'misc', 'MISC', 'Temporary/Miscellaneous League');

create table league.team (
    team_id bigint primary key,
    lg_id int references league.lg(lg_id),
    team varchar(10),
    team_name varchar(255),
    team_city varchar(255)
);

create table player.all (
    player_id bigint primary key,
    player varchar(255),
    last_first varchar(255),
    lg_id int references league.lg(lg_id)
);

create table player.current (
    player_id bigint primary key references player.all(player_id),
    player varchar(255),
    last_first varchar(255),
    team_id bigint references league.team(team_id),
    lg_id int references league.lg(lg_id)
);

create table player.box (
    game_id bigint not null,
    team_id bigint not null references league.team(team_id),
    lg_id int references league.lg(lg_id),
    player_id bigint not null references player.all(player_id),
    player varchar(255),
    matchup varchar(50),
    wl varchar(1),
    mins int,
    pts int,
    ast int,
    reb int,
    stl int,
    blk int,
    tov int,
    oreb int,
    dreb int,
    foul int,
    pm int,
    fgm int,
    fga int,
    fgp numeric(5, 4),
    f3m int,
    f3a int,
    f3p numeric(5, 4),
    ftm int,
    fta int,
    ftp numeric(5, 4),
    primary key (game_id, player_id)
);