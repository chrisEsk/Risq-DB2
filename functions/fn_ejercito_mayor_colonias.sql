create or replace function fn_ejercito_mayor_colonias 
return int
    
is
     id_mayor int;
begin
    select id_equipo
    into id_mayor
    from (select count(id_colonia), id_equipo
        from colonias a 
        group by id_equipo
        order by count(id_colonia) desc) ;

    return id_mayor;
end;
/
