set serveroutput on;

accept cod_atacante prompt 'Codigo colonia atacante: '
accept cod_defendiente prompt 'Codigo colonia defendiente: '

DECLARE
    result_atacante dbms_sql.number_table;
    result_defendiente dbms_sql.number_table;
    status int;
    id_atacante int := -1;
    id_defendiente int := -1;
    cod_defendiente varchar2(3);
    cod_atacante varchar2(3);
    cantidad int := 0;
    id_equipo_atacante int;
    id_equipo_defendiente int;
    cantidad_restante int;
    cantidad_atacante int;
    cantidad_minima int := 2;
    solo_comandantes int := 0;
    bitacora varchar(255) := '';
    color_atacante varchar(20);
    color_defendiente varchar(20);
    nombre_atacante varchar(255);
    nombre_defendiente varchar(255);
    perdidas_atacante int := 0;
    perdidas_defendiente int := 0;
    v_fase_actual int;
BEGIN
  
    -- buscar la fase del equipo actual;
    select fase_actual into v_fase_actual 
    from equipos
    where id_equipo = fn_equipo_actual();
    
    -- actualizar la fase del equipo actual
    IF v_fase_actual = 3 THEN
    	dbms_output.put_line('Ya finalizo la  de ataque');
   	return;
    ELSE
        update equipos
        set fase_actual = 2
        where id_equipo = fn_equipo_actual();
    END IF;
    
  -- busca el id de la colonia atacante
    select id_colonia,id_equipo, nombre
    into id_atacante,id_equipo_atacante,nombre_atacante
    from colonias
    where codigo = upper('&cod_atacante')
    and id_equipo = fn_equipo_actual();
    
  -- busca el id de la colonia defendiente
    select id_colonia, id_equipo , nombre
    into id_defendiente, id_equipo_defendiente,nombre_defendiente
    from colonias
    where codigo = upper('&cod_defendiente');

      -- buscar la cantidad de regimientos en la colonia atacante
      select count(id_unidad)
      into cantidad_atacante
      from unidades 
      where id_colonia = id_atacante;

  -- verifica si la colinia cumple con la cantidad minima para atacar
  IF cantidad_atacante > cantidad_minima THEN
      -- verifica que las colonias sean vecinas
    IF fn_son_vecinos(id_defendiente, id_atacante) = 1 THEN

          -- verifica que las colonias no sean del mismo equipo
        IF fn_equipo_actual() != id_equipo_defendiente THEN
            
            -- busca el color del equipo atacante
            select color into nombre_atacante
            from equipos 
            where id_equipo = id_equipo_atacante;
            
            --busca el nombre del equipo defendiente
            select color into nombre_defendiente
            from equipos 
            where id_equipo = id_equipo_defendiente;
            
            -- se lanzan los dados
            result_atacante := fn_lanzar_dados(id_atacante, 1);
            result_defendiente := fn_lanzar_dados(id_defendiente, 0);
			
            -- determina la menor cantidad de pares a comparar
            IF result_atacante.count > result_defendiente.count THEN
              cantidad := result_defendiente.count;
            ELSE 
              cantidad := result_atacante.count;
            END IF;
			
            -- determina el ganador de cada par y elimina los regimientos
            FOR i IN 0..cantidad-1 LOOP
              IF result_atacante(i) > result_defendiente(i) THEN
                perdidas_defendiente := perdidas_defendiente + 1;
                sp_eliminar_unidad(id_defendiente);
              ELSE
                perdidas_atacante := perdidas_atacante + 1;
                sp_eliminar_unidad(id_atacante);
				
              END IF;
            END LOOP;
            
            bitacora := 'El equipo ' || color_atacante || ' ataco al equipo ' || color_defendiente || '. ';
            sp_bitacora(bitacora);
            bitacora := 'El equipo ' || color_atacante || ' ataco con la colonia ' || nombre_atacante || '. ';
            sp_bitacora(bitacora);
            bitacora := 'El equipo ' || color_defendiente || ' defendio con la colonia ' || nombre_defendiente || '. ';
            sp_bitacora(bitacora);
            bitacora := 'El equipo ' || color_atacante || ' perdio ' || perdidas_atacante || ' unidades. ';
            sp_bitacora(bitacora);
            bitacora := 'El equipo ' || color_atacante || ' perdio ' || perdidas_defendiente || ' unidades. ';
            sp_bitacora(bitacora);
			
			
            -- busca la cantidad de regimientos restantes de la colonia defendiente
            select count(*) 
            into cantidad_restante
            from unidades 
            where id_colonia = id_defendiente;
			
			
            -- verificar si la colonia defendientes aun tienen unidades
            IF cantidad_restante = 0 THEN
            
              -- busca la cantidad de regimientos de la colonia atacante
              select count(id_unidad)
              into solo_comandantes
              from unidades 
              where id_colonia = id_atacante 
              and id_tipo_unidad = 1;

              -- translada la colonia al atacante
              update colonias 
              set id_equipo = (select id_equipo from colonias where id_colonia = id_atacante)
              where id_colonia = id_defendiente;
              bitacora := 'El equipo ' || color_atacante || ' gano ' || nombre_defendiente || '. ';
              sp_bitacora(bitacora);
			  
			  --define si se pasan regimientos o comandantes
              IF solo_comandantes > 0 THEN
                sp_movilizar(id_atacante, id_defendiente, 1, 1);
              ELSE
                sp_movilizar(id_atacante, id_defendiente, 1, 2);
              END IF;
            END IF;
      ELSE
        dbms_output.put_line('Las colonias pertenecen al mismo equipo.');
      END IF;

    ELSE
      dbms_output.put_line('Las colonias no son vecinas');
    END IF;
  ELSE
    dbms_output.put_line('La colonia no cumple con la minima cantidad para realizar el ataque.');
  END IF;
  
    EXCEPTION                 
        WHEN no_data_found THEN

            dbms_output.put_line('--ERROR--');
            IF id_atacante = -1 THEN
                dbms_output.put_line('No se encontro la colonia atacante');
            END IF;

            IF id_defendiente = -1 THEN
                dbms_output.put_line('No se encontro la colonia defendiente');
            END IF;
END;
/
