create or replace function fn_equipo_actual
return int
is
    id_equipo_actual int;
begin
    select equipo_actual into id_equipo_actual
    from (select equipo_actual
          from juegos
    ) where rownum = 1;
    
    return id_equipo_actual;
end;
/
