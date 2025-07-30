-- procedure to update lg.plr

create or replace procedure lg.sp_plr_crnt_load()
language plpgsql
as $$
begin
    insert into lg.plr_crnt (
        lg_id, team_id, player_id, plr_cde)
        select 
            0, 
            team_id,
            person_id,
            playercode
        from intake.player
    on conflict (player_id) do nothing;

    insert into lg.plr_crnt (
        lg_id, team_id, player_id, plr_cde)
        select 
            1, 
            team_id,
            person_id,
            playercode
        from intake.wplayer
    on conflict (player_id) do nothing;
end; $$;

call lg.sp_plr_crnt_load();
select * from lg.plr_crnt;