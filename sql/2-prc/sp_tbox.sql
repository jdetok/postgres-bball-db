-- work in progress, need to make season load first

create or replace procedure stats.sp_tbox()
language plpgsql
as $$
begin

end; $$;
call stats.sp_tbox();
select * from stats.tbox;