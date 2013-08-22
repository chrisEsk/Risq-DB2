CREATE OR REPLACE PROCEDURE sp_comprar_unidades(tipo IN NUMBER, cant IN NUMBER, colonia IN NUMBER)
    
IS
	compraValidada NUMBER;
	contador NUMBER:=1;
	coloniaValidada NUMBER;
	equipo equipos.id_equipo%TYPE;
	no_colonia_propia EXCEPTION;
	no_suficiente_dinero EXCEPTION;
	cantidad_no_valida EXCEPTION;

BEGIN
	IF cant<=0
		THEN RAISE cantidad_no_valida; 
	END IF;

	SELECT fn_equipo_actual() INTO equipo
	FROM juegos;
	
	SELECT fn_validar_compra(tipo,cant) INTO compraValidada
	FROM dual;
	
	IF compraValidada=0
		THEN RAISE no_colonia_propia;	
	END IF;

	SELECT fn_validar_colonia_propia(colonia) INTO coloniaValidada
	FROM DUAL;
	
	IF coloniaValidada=0
		THEN RAISE no_suficiente_dinero;
	END IF;

	LOOP
		INSERT INTO unidades (id_colonia, id_tipo_unidad)
		VALUES (colonia, tipo);

		IF contador>= cant
			THEN EXIT;
		END IF;
	END LOOP;
	   
    EXCEPTION
        WHEN no_suficiente_dinero THEN
            dbms_output.put_line('No cuenta con suficientes energias');
        WHEN no_colonia_propia THEN
            dbms_output.put_line('La colonia no es del equipo');
        WHEN cantidad_no_valida THEN
            dbms_output.put_line('La cantidad de unidades no es valida');
END;
/
