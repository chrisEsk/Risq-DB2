set serveroutput on;

DECLARE
colonia1 varchar(3);
colonia2 varchar(3);
cant_unidades number;
tipo_unidad number;
BEGIN
	
	-- busca el id de la colonia de la que se desean sacar unidades
	select id_colonia into colonia1
	from colonias
	where codigo = '&colonia1'
	and id_equipo = fn_equipo_actual();
	
	-- busca el id de la colonia en la que se desean introducir unidades
	select id_colonia into colonia2
	from colonias
	where codigo = '&colonia2'
	and id_equipo = fn_equipo_actual();
	
	tipo_unidad := '&tipo_unidad';
	cant_unidades := &cant_unidades;
	
	IF colonia1 != null THEN
		IF colonia2 != null THEN
			sp_movilizar(colonia1, colonia2, cant_unidades, tipo_unidad);
		ELSE
			dbms_output.put_line('La colonia 2 no existe.');
		END IF;
	ELSE
		dbms_output.put_line('La colonia 1 no existe.');
	END IF;
END;
/
