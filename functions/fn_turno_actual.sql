create or replace function fn_turno_actual
return int
is
    id_turno_actual int;
begin
    select id_turno into id_turno_actual
    from (select id_turno
          from turnos
          order by id_turno desc
    ) where rownum = 1;
    
    return id_turno_actual;
end;
/
