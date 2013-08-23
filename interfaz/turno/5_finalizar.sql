set serveroutput on;

DECLARE
    cant_equipos int;
    orden_equipo_actual int;
    sig_equipo int;
    primer_equipo int;
BEGIN
    select count(id_equipo)
    into cant_equipos
    from equipos;

    select orden
    into orden_equipo_actual
    from equipos
    where id_equipo = fn_equipo_actual();
    
    IF orden_equipo_actual = cant_equipos THEN
        dbms_output.put_line('Se ha finalizado la era');
        
        select id_equipo
        into primer_equipo
        from equipos
        where orden = 1;
        
        -- el siguiente equipo va a ser el primer equipo
        update juegos
        set equipo_actual = primer_equipo,
            era_actual = era_actual + 1 -- incrementar la era
        where 1 = 1;
        
        IF fn_juego_terminado() = 1 THEN
            dbms_output.put_line('Ha terminado el juego');
        END IF;
    ELSE
        select id_equipo
        into sig_equipo
        from equipos
        where orden = orden_equipo_actual + 1;
        
        -- actualizar el equipo actual en la tabla juegos
        update juegos
        set equipo_actual = sig_equipo
        where 1 = 1;
    END IF;
END;
/
