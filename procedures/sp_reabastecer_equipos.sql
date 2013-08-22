-- llamar al comienzo de cada era
CREATE OR REPLACE PROCEDURE sp_reabastecer_equipos
AS
	CURSOR cur_equipos IS
		select id_equipo
		from equipos;
	v_energias int;
	v_regimientos int;
	v_puntaje int;

	v_id_colonia int;
BEGIN
    FOR e IN cur_equipos LOOP
        v_puntaje := fn_get_puntaje(e.id_equipo);
        v_energias := v_puntaje / 4;
        v_regimientos := v_puntaje / 5;
        
        update equipos
        set energia = energia + v_energias
        where id_equipo = e.id_equipo;
        
        -- TODO: preguntar en que colonia se quieren agregar los regimientos nuevos?
        select id_colonia into v_id_colonia
        from (select id_colonia
              from colonias
              where id_equipo = e.id_equipo)
        where rownum = 1;
        
        FOR i in 0..v_regimientos LOOP
            INSERT INTO unidades (id_unidad, id_colonia, id_tipo_unidad)
		    VALUES (unidades_seq.nextval, v_id_colonia, 1);
	    END LOOP;
	    
    END LOOP;
END;
/
