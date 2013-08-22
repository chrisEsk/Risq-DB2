-- devuelve el puntaje del turno de un equipo en la era actual
create or replace function fn_get_puntaje (p_id_equipo int)
return int
is
    p int;
begin
    select puntaje into p
    from (select puntaje from turnos
          where id_equipo = p_id_equipo
          and num_era = fn_era_actual()
          order by id_turno desc
         )
    where rownum = 1;
    
    return p;
end;
/
