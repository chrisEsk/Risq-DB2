CREATE OR REPLACE PROCEDURE sp_movilizar(id_colonia1 number, id_colonia2 number, cant_u number, tipo_u number)
AS
	v_id_equipo_col1 int;
	v_id_equipo_col2 int;
	v_cant_unidades1 int;
	v_contador int;
	v_id_colonia number(3);
	v_id_tipo_unidad number(3);
	v_son_vecinos int;
	v_equipo_actual int;
	v_desde varchar(255);
	v_hacia varchar(255);
BEGIN
	v_contador:=0;
	v_son_vecinos:=fn_son_vecinos(id_colonia1,id_colonia2);
	v_equipo_actual:=fn_equipo_actual();
	
    SELECT id_equipo INTO v_id_equipo_col1
	FROM colonias
	WHERE id_colonia = id_colonia1;
	
	SELECT id_equipo INTO v_id_equipo_col2
	FROM colonias
	WHERE id_colonia = id_colonia2;
	
	SELECT COUNT(id_unidad) INTO v_cant_unidades1
	FROM unidades
	WHERE id_colonia = id_colonia1;
	
	IF v_id_equipo_col1 = v_equipo_actual THEN
		IF v_id_equipo_col2 = v_equipo_actual THEN
			IF v_cant_unidades1>cant_u THEN
				IF v_son_vecinos= 1 THEN
					FOR v_contador IN 1 .. cant_u
					LOOP
						DELETE FROM unidades
						WHERE id_colonia=id_colonia1
						AND id_tipo_unidad=tipo_u
						AND ROWNUM =1;
						
						select nombre into v_desde
						from colonias where id_colonia = id_colonia1;
						
						select nombre into v_hacia
						from colonias where id_colonia = id_colonia2;
						
						INSERT INTO unidades (id_unidad, id_colonia, id_tipo_unidad)
						VALUES (unidades_seq.nextval,id_colonia2, tipo_u);
					END LOOP;

					sp_bitacora('Se movieron '||cant_u||' unidades desde '||v_desde||' hacia '||v_hacia);
				ELSE
					dbms_output.put_line('Estas colonias no son vecinas.');
				END IF;
			ELSE
				dbms_output.put_line('No puede dejar menos de 1 unidad en una colonia.');
			END IF;
		ELSE
		dbms_output.put_line('La colonia 2 no le pertenece.');
		END IF;	
	ELSE
		dbms_output.put_line('La colonia 1 no le pertenece.');
    END IF;
END;
/
