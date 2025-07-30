create or replace procedure lg.sp_load_team()
language plpgsql
as $$
begin
    insert into lg.team (
        lg_id, team_id, team, team_cde, team_long, team_city, team_shrt)
        select 
            0,
            a.team_id,
            a.team_abbreviation,
            a.team_code,
            b.team_name,
            a.team_city,
            a.team_name
        from intake.player a
        inner join intake.gm_team b on b.team_id = a.team_id
        group by a.team_id, a.team_abbreviation, a.team_code, b.team_name, 
            a.team_city, a.team_name
    on conflict (team_id) do nothing;

    insert into lg.team (
        lg_id, team_id, team, team_cde, team_long, team_city, team_shrt)
        select 
            1,
            a.team_id,
            a.team_abbreviation,
            a.team_code,
            b.team_name,
            a.team_city,
            a.team_name
        from intake.wplayer a
        inner join intake.gm_team b on b.team_id = a.team_id
        group by a.team_id, a.team_abbreviation, a.team_code, b.team_name, 
            a.team_city, a.team_name
    on conflict (team_id) do nothing;
end; $$;

call lg.sp_load_team();