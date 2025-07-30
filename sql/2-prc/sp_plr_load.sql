-- procedure to update lg.plr

create or replace procedure lg.sp_load_plr()
language plpgsql
as $$
begin
    insert into lg.plr (
        lg_id, player_id, plr_cde, player, last_first, from_year, to_year)
        select 
            0, 
            person_id,
            playercode,
            display_first_last,
            display_last_comma_first,
            from_year,
            to_year
        from intake.player
    on conflict (player_id) do nothing;

    insert into lg.plr (
        lg_id, player_id, plr_cde, player, last_first, from_year, to_year)
        select 
            1, 
            person_id,
            playercode,
            display_first_last,
            display_last_comma_first,
            from_year,
            to_year
        from intake.wplayer
    on conflict (player_id) do nothing;
end; $$;

call lg.sp_load_plr();
select * from lg.tmp;