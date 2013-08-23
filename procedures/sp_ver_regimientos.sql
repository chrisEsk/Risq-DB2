CREATE OR REPLACE PROCEDURE sp_ver_regimientos(p_color varchar2)
IS
    CURSOR query(p_color) IS
    	select c.nombre as nombre, e.color as color, count(u.id_unidad) as unidades
		from equipos e
		join colonias c on(c.id_equipo = e.id_equipo)
		join unidades u on(u.id_colonia = c.id_colonia)
		where e.color = p_color
		group by c.nombre, e.color;
		v_cont number default 0;

BEGIN
    FOR c IN query LOOP
		DBMS_OUTPUT.PUT_LINE(lpad(c.nombre, 15) || lpad(e.color, 15) || lpad(c.unidades, 15));
		v_cont := v_cont + 1;
	END LOOP;
	DBMS_OUTPUT.PUT_LINE(v_cont || ' rows');
END;
/
