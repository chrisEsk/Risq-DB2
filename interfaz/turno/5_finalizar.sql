set serveroutput on;

DECLARE
    cant_equipos int;
    orden_equipo_actual int;
    sig_equipo int;
    primer_equipo int;
    equipo_ganador int;
	nombre_ganador varchar(20);
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
        
        sp_reabastecer_equipos();
        
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
            
            -- copy paste de mostrar_ganador.sql
        	equipo_ganador := fn_ejercito_mayor_colonias();
            select color
            into nombre_ganador
            from equipos
            where id_equipo = equipo_ganador;
            dbms_output.put_line('Ganador:' ||nombre_ganador);
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
