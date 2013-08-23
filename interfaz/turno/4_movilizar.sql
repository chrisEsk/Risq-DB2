DECLARE
colonia1 varchar(3);
colonia2 varchar(3);
cant_unidades number;
tipo_unidad number;
unidades_disponibles number;

BEGIN

	SELECT COUNT(id_unidad) INTO unidades_disponibles
	FROM unidades
	WHERE id_colonia = colonia1;
	
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
	
	tipo_unidad:='&tipo_unidad' ;
	
	dbms_output.put_line(colonia1||' '||colonia2||' '||tipo_unidad||' '||unidades_disponibles);
	
END;