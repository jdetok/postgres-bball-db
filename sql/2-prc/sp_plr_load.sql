-- procedure to update lg.plr

create or replace procedure lg.sp_load_plr()
language plpgsql
as $$
begin
	drop table if exists lg.tmp;
	create table lg.tmp (c1 int, c2 int);
    insert into lg.tmp values (1, 2);

    insert into lg.plr (
        player_id, lg_id, player, plr_cde, last_first, from_year, to_year)
        select 
            person_id,
            0, 
            display_first_last,
            playercode,
            display_last_comma_first,
            from_year,
            to_year
        from intake.player
    on conflict (player_id) do nothing;

    insert into lg.plr (
        player_id, lg_id, player, plr_cde, last_first, from_year, to_year)
        select 
            person_id,
            1, 
            display_first_last,
            playercode,
            display_last_comma_first,
            from_year,
            to_year
        from intake.wplayer
    on conflict (player_id) do nothing;
end; $$;

call lg.sp_load_plr();
select * from lg.tmp;