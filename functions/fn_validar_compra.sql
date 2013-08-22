CREATE OR REPLACE FUNCTION fn_validar_compra
    (tipo IN NUMBER, cant IN NUMBER) 

   RETURN NUMBER

IS
   	equipo equipos.id_equipo%TYPE;
	dinero equipos.energia%TYPE;
	costoUnidad tipos_unidades.costo%TYPE;
	resul NUMBER; 

BEGIN
	SELECT energia INTO dinero
	FROM equipos
	WHERE id_equipo = fn_equipo_actual();

	SELECT costo INTO costoUnidad
	FROM tipos_unidades
	WHERE id_tipo_unidad=tipo;

	IF dinero < cant*costoUnidad
		THEN resul := 0;
		ELSE resul := 1;
	END IF;
	RETURN resul;


END;
/
