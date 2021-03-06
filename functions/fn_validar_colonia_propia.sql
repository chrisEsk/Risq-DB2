CREATE OR REPLACE FUNCTION fn_validar_colonia_propia
   (colonia IN NUMBER)

   RETURN NUMBER

IS
	equipo equipos.id_equipo%TYPE;
	equipoColonia equipos.id_equipo%TYPE;
	resul NUMBER;

BEGIN
	SELECT id_equipo INTO equipoColonia
	FROM colonias
	WHERE id_colonia=colonia;

	IF fn_equipo_actual()=equipoColonia
		THEN resul:=1;
		ELSE resul:=0;
	END IF;

	RETURN RESUL;
END;
/
