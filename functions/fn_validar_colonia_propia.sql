CREATE OR REPLACE FUNCTION validarColoniaPropia
   (colonia IN NUMBER)

   RETURN NUMBER

IS
	equipo equipos.id_equipo%TYPE;
	equipoColonia equipos.id_equipo%TYPE;
	resul NUMBER;

BEGIN
	SELECT equipo_actual INTO equipo
	FROM juegos;

	SELECT id_equipo INTO equipoColonia
	FROM colonias
	WHERE id_colonia=colonia;

	IF equipo=equipoColonia
		THEN resul:=1;
		ELSE resul:=0;
	END IF;

	RETURN RESUL;
   

END validarColoniaPropia;
/