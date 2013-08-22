CREATE OR REPLACE FUNCTION fn_validar_compra
    (tipo IN NUMBER, cant IN NUMBER) 

   RETURN NUMBER

IS

   	equipo equipos.id_equipo%TYPE;
	dinero equipos.energia%TYPE;
	costoUnidad tipos_unidades.costo%TYPE;
	resul NUMBER; 

BEGIN
   	SELECT equipo_actual INTO equipo
	FROM juegos;

	SELECT energia INTO dinero
	FROM equipos
	WHERE id_equipo=equipo;

	SELECT costo INTO costoUnidad
	FROM tipos_unidades
	WHERE id_tipo_unidad=tipo;

	IF dinero<=cant*costoUnidad
		THEN resul:=1;
		ELSE RESUL:=0;
	END IF;
	RETURN resul;


END;
/
