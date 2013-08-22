CREATE OR REPLACE PROCEDURE sp_calcular_puntos
    
IS
	cantTerritorios NUMBER:=0;
	cantEnergias equipos.energia%TYPE:=0;
	cantReg	NUMBER:=0;
	cantCom	NUMBER:=0;
	cant NUMBER:=0;
	puntos NUMBER:=0;

	equipoActual equipos.id_equipo%TYPE;
	turnoActual turnos.id_turno%TYPE;
	id_col colonias.id_colonia%TYPE;
	
	CURSOR cols_cursor IS SELECT id_colonia FROM colonias;

BEGIN
	equipoActual:=fn_equipo_actual();
	turnoActual:=fn_turno_actual();
	
	SELECT energia INTO cantEnergias
	FROM equipos
	WHERE id_equipo=equipoActual;

	OPEN cols_cursor;	
	LOOP
		IF cols_cursor%NOTFOUND
			THEN EXIT;
		END IF;
		
		FETCH cols_cursor INTO id_col;
		IF fn_validar_colonia_propia(id_col)=1
			THEN
				cantTerritorios:=cantTerritorios+1;
			
				SELECT count(id_unidad) INTO cant
				FROM unidades
				WHERE id_colonia=id_col
				AND id_tipo_unidad=1;
			
				cantReg:=cantReg+cant;
			
				SELECT count(id_unidad) INTO cant
				FROM unidades
				WHERE id_colonia=id_col
				AND id_tipo_unidad=2;

				cantCom:=cantCom+cant;
		END IF;
		
	END LOOP;
	CLOSE cols_cursor;
	
	puntos:=puntos+cantEnergias;
	puntos:=puntos+cantReg;	
	puntos:=puntos+cantTerritorios*3;
	puntos:=puntos+cantCom*2;

	UPDATE turnos
	SET puntaje=puntos
	WHERE id_turno=turnoActual
	AND id_equipo=equipoActual;
	   
EXCEPTION
	WHEN NO_DATA_FOUND THEN cant:=0;     
END;
/