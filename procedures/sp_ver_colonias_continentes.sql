CREATE OR REPLACE PROCEDURE sp_ver_colonias_continentes
--muestra las colonias que NO han sido asignadas a un equipo
AS
	CURSOR slt_colonias IS
		select col.codigo codigo, col.nombre colonia, con.nombre continente
		from colonias col
		join continentes con using (id_continente)
		where col.id_equipo is null;
	v_cont number default 0;
BEGIN
   FOR c IN slt_colonias LOOP
		DBMS_OUTPUT.PUT_LINE(lpad(c.codigo, 15) || lpad(c.colonia, 15) || lpad(c.continente, 15));
		v_cont := v_cont + 1;
	END LOOP;
	DBMS_OUTPUT.PUT_LINE(v_cont || ' rows');
END;
/