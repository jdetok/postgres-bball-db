
create or replace procedure lg.sp_plr_old_load()
language plpgsql
as $$
begin
    insert into lg.plr (
        lg_id, player_id, plr_cde, player, last_first, from_year, to_year)
        select 
            0, 
            a.player_id,
            b.playercode,
            a.player_name,
            b.display_last_comma_first,
            b.from_year,
            b.to_year
        from intake.gm_player a
        left join intake.player b on a.player_id = b.person_id 
        group by a.player_id, b.playercode, a.player_name,
                    b.display_last_comma_first, b.from_year, b.to_year
    on conflict (player_id) do nothing;

    insert into lg.plr (
        lg_id, player_id, plr_cde, player, last_first, from_year, to_year)
        select 
            1, 
            a.player_id,
            b.playercode,
            a.player_name,
            b.display_last_comma_first,
            b.from_year,
            b.to_year
        from intake.gm_player a
        left join intake.wplayer b on a.player_id = b.person_id 
        group by a.player_id, b.playercode, a.player_name,
                    b.display_last_comma_first, b.from_year, b.to_year
    on conflict (player_id) do nothing;
end; $$;

call lg.sp_plr_old_load();
