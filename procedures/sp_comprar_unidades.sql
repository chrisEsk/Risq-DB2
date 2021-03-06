CREATE OR REPLACE PROCEDURE sp_comprar_unidades(tipo IN NUMBER, cant IN NUMBER, colonia IN NUMBER)
    
IS
	compraValidada NUMBER;
	contador NUMBER := 0;
	coloniaValidada NUMBER;
	costoUnidad tipos_unidades.costo%TYPE;
	tipoUNidad tipos_unidades.nombre%TYPE;
	nomColonia colonias.nombre%TYPE;
	
	equipo equipos.id_equipo%TYPE;

	no_colonia_propia EXCEPTION;
	no_suficiente_dinero EXCEPTION;
	cantidad_no_valida EXCEPTION;

BEGIN
	IF cant <= 0
		THEN RAISE cantidad_no_valida; 
	END IF;

	equipo := fn_equipo_actual();

	compraValidada := fn_validar_compra(tipo,cant);
	
	IF compraValidada = 0
		THEN RAISE no_suficiente_dinero;
	END IF;

	coloniaValidada := fn_validar_colonia_propia(colonia);
	
	IF coloniaValidada = 0
		THEN RAISE no_colonia_propia;
	END IF;
	
	SELECT costo INTO costoUnidad
	FROM tipos_unidades
	WHERE id_tipo_unidad=tipo;

	UPDATE equipos
	SET energia=energia-costoUnidad*cant
	WHERE id_equipo=equipo;
	
	LOOP
		IF contador >= cant
			THEN EXIT;
		END IF;
		
        	INSERT INTO unidades (id_unidad, id_colonia, id_tipo_unidad)
		VALUES (unidades_seq.nextval, colonia, tipo);
		
		contador := contador + 1;
	END LOOP;

	SELECT nombre INTO nomColonia
	FROM colonias
	WHERE id_colonia=colonia;

	SELECT nombre INTO tipoUnidad
	FROM tipos_unidades
	WHERE id_tipo_unidad=tipo;

	sp_bitacora('Compr�: '||cant||' '||tipoUnidad||' en '||nomColonia);
	   
    EXCEPTION
        WHEN no_suficiente_dinero THEN
            dbms_output.put_line('No cuenta con suficientes energias');
        WHEN no_colonia_propia THEN
            dbms_output.put_line('La colonia no es del equipo');
        WHEN cantidad_no_valida THEN
            dbms_output.put_line('La cantidad de unidades no es valida');
END;
/