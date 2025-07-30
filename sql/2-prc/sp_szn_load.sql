create or replace function lg.fn_szn_from_id(s_id int)
returns varchar(255)
language plpgsql
as $$
declare
    season_concat varchar(255);
begin
    select
        right(cast(s_id as varchar(10)), 4) || '-' ||
        right(cast((s_id+1) as varchar(10)), 2)
    into season_concat
    from lg.szn_type
    where cast(left(cast(s_id as varchar(10)), 1) as int) = sznt_id;
    return season_concat;
end; $$; 

create or replace function lg.fn_slong_from_id(s_id int)
returns varchar(255)
language plpgsql
as $$
declare
    season_concat varchar(255);
begin
    select 
        right(cast(s_id as varchar(10)), 4) || '-' ||
        right(cast((s_id+1) as varchar(10)), 2) || ' ' || szn_type
    into season_concat
    from lg.szn_type
    where cast(left(cast(s_id as varchar(10)), 1) as int) = sznt_id;
    return season_concat;
end; $$; 

create or replace function lg.fn_wszn_from_id(s_id int)
returns varchar(255)
language plpgsql
as $$
declare
    season_concat varchar(255);
begin
    select
        right(cast(s_id as varchar(10)), 4)
    into season_concat
    from lg.szn_type
    where cast(left(cast(s_id as varchar(10)), 1) as int) = sznt_id;
    return season_concat;
end; $$; 

create or replace function lg.fn_wslong_from_id(s_id int)
returns varchar(255)
language plpgsql
as $$
declare
    season_concat varchar(255);
begin
    select 
        right(cast(s_id as varchar(10)), 4) || ' WNBA ' || szn_type
    into season_concat
    from lg.szn_type
    where cast(left(cast(s_id as varchar(10)), 1) as int) = sznt_id;
    return season_concat;
end; $$; 

create or replace procedure lg.sp_load_szn()
language plpgsql
as $$
begin
    -- drop table if exists lg.tmp;
    -- create table lg.tmp (
    --     szn_id int, 
    --     szn varchar(255),
    --     slong varchar(255),
    --     wszn varchar(255),
    --     wslong varchar(255)
    -- );
    
    insert into lg.szn
        select 
            a.season_id, 
            b.sznt_id, 
            lg.fn_szn_from_id(a.season_id),
            lg.fn_slong_from_id(a.season_id),
            lg.fn_wszn_from_id(a.season_id),
            lg.fn_wslong_from_id(a.season_id)
            
        from intake.gm_player a
        inner join lg.szn_type b
            on cast(left(cast(a.season_id as varchar(10)), 1) as int) = b.sznt_id
        group by a.season_id, b.sznt_id
    on conflict (szn_id) do nothing;
end; $$;
call lg.sp_load_szn();
select * from lg.szn;