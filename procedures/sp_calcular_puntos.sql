CREATE OR REPLACE PROCEDURE sp_calcular_puntos
    
IS
	CURSOR equipos_cursor IS 	select c.id_equipo,
						count(c.id_colonia),
						e.energia
					from colonias c
					JOIN equipos e oN(e.id_equipo=c.id_equipo)
					where c.id_equipo is not null
					group by c.id_equipo, e.energia
					order by c.id_equipo asc;

	equipo equipos.id_equipo%TYPE:=0;
	cantColonias NUMBER:=0;
	cantEnergias NUMBER:=0;
	puntos NUMBER:=0;
	cantReg NUMBER:=0;
	cantCom NUMBER:=0;
	


BEGIN
	OPEN equipos_cursor;
	
	LOOP
		IF equipos_cursor%NOTFOUND
			THEN EXIT;
		END IF;
		
		puntos:=0;

		FETCH equipos_cursor INTO equipo, cantColonias, cantEnergias;

		SELECT count(u.id_unidad) INTO cantReg
		FROM unidades u
		JOIN colonias c ON(u.id_colonia=c.id_colonia)
		WHERE u.id_tipo_unidad=1
		AND c.id_equipo=equipo;

		SELECT count(u.id_unidad) INTO cantCom
		FROM unidades u
		JOIN colonias c ON(u.id_colonia=c.id_colonia)
		WHERE u.id_tipo_unidad=2
		AND c.id_equipo=equipo;
		
		puntos:=puntos+cantReg;
		puntos:=puntos+cantEnergias;
		puntos:=puntos+cantColonias*3;
		puntos:=puntos+cantCom*2;

		UPDATE turnos
		SET puntaje=puntos
		WHERE id_equipo=equipo;
		
	END LOOP;
	
	CLOSE equipos_cursor;

END;
/