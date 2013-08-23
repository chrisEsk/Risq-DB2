CREATE OR REPLACE PROCEDURE sp_actualizar_orden_equipos
    
IS

	ord NUMBER:=1;
	equipo equipos.id_equipo%TYPE;
	CURSOR eqs_cursor is 	SELECT id_equipo
				FROM turnos
				WHERE num_era=fn_era_actual()
				ORDER BY puntaje desc;
 
	
BEGIN
	OPEN eqs_cursor;
	LOOP
		IF eqs_cursor%NOTFOUND
			THEN EXIT;
		END IF;

		FETCH eqs_cursor INTO equipo;

		UPDATE equipos
		SET orden=ord
		WHERE id_equipo=equipo;

		ord:=ord+1;
	END LOOP;
END;
/
