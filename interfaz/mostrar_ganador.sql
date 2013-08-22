set serveroutput on;


DECLARE
	equipo_ganador int;
	nombre_ganador varchar(20);
BEGIN
	equipo_ganador := fn_ejercito_mayor_colonias();
	select color
	into nombre_ganador
	from equipos
	where id_equipo = equipo_ganador;
	dbms_output.put_line('Ganador:' ||nombre_ganador);

END;
/
