-- devuelve si el juego ha terminado
create or replace function fn_juego_terminado
return int
is
    v_era_actual int;
    v_cant_eras int;
    p int;
begin
    select era_actual, cant_eras
    into v_era_actual, v_cant_eras
    from juegos
    where 1 = 1;
    
    p := 0;
    
    IF v_era_actual > v_cant_eras THEN
        p := 1;
    END IF;
    
    return p;
end;
/
