CREATE OR REPLACE function fn_validar_duenio_continente (equipo in number)
return number
    
IS
	
	Cursor resultado is select count(*) colonias,
				id_equipo,
				id_continente
				from colonias
				group by id_continente, id_equipo
				having count(*) >= 1
				order by id_continente;
	cantCols NUMBER;
	eq NUMBER;
	cont NUMBER;
	resul NUMBER:=-1;
	
BEGIN
	OPEN resultado;
	LOOP	
		fetch resultado into cantCols, eq, cont;
		IF resultado%NOTFOUND
			THEN EXIT;
		END IF;
		IF (cont=1) and (cantCols=8) and (eq=equipo)
			then resul:=cont;
		END IF;
		IF (cont=2) and (cantCols=4) and (eq=equipo)
			then resul:=cont;
		END IF;
		IF (cont=3) and (cantCols=7) and (eq=equipo)
			then resul:=cont;
		END IF;
		IF (cont=4) and (cantCols=6) and (eq=equipo)
			then resul:=cont;
		END IF;
		IF (cont=5) and (cantCols=4) and (eq=equipo)
			then resul:=cont;
		END IF;
		IF (cont=6) and (cantCols=11) and (eq=equipo)
			then resul:=cont;
		END IF;
	END LOOP;
	CLOSE resultado;

	return resul;

END;
