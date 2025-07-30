create table lg.league (
    lg_id int primary key,
    lg_cde varchar(10) unique,
    lg varchar(10) unique,
    lg_name varchar(255)
);

insert into lg.league values 
    (0, 'nba', 'NBA', 'National Basketball Association'),
    (1, 'wnba', 'WNBA', 'Women''s National Basketball Association'),
    (9, 'misc', 'MISC', 'Temporary/Miscellaneous League');

create table lg.szn_type (
    sznt_id int primary key,
    sznt_cde varchar(2) not null,
    szn_type varchar(255)
);

insert into lg.szn_type values 
    (1, 'PS', 'Pre-Season'),
    (2, 'RG', 'Regular Season'),
    (3, 'PS', 'All-Star'),
    (4, 'PO', 'Playoffs'),
    (5, 'PI', 'Play-In Tournament'),
    (6, 'NC', 'NBA Cup');

create table lg.szn (
    szn_id int primary key,
    sznt_id int references lg.szn_type(sznt_id),
    szn varchar(255),
    szn_desc varchar(255),
    wszn varchar(255),
    wszn_desc varchar(255)
);

create table lg.team (
    team_id bigint primary key,
    lg_id int references lg.league(lg_id),
    team varchar(10),
    team_cde varchar(255),
    team_name varchar(255),
    team_city varchar(255)
);

create table lg.plr (
    player_id bigint primary key,
    lg_id int references lg.league(lg_id),
    player varchar(255),
    plr_cde varchar(255),
    last_first varchar(255),
    from_year varchar(4),
    to_year varchar(4)
);

create table lg.plr_crnt (
    player_id bigint primary key references lg.plr(player_id),
    player varchar(255),
    team_id bigint references lg.team(team_id),
    lg_id int references lg.league(lg_id)
);