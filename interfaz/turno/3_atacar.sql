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
    id_equipo_defendiente int;
    cantidad_restante int;
    cantidad_atacante int;
    cantidad_minima int := 2;
    solo_comandantes int := 0;
BEGIN
  -- busca el id de la colonia atacante
	select id_colonia into id_atacante
	from colonias
	where codigo = '&cod_atacante'
	and id_equipo = fn_equipo_actual();

  -- busca el id de la colonia defendiente
	select id_colonia, id_equipo 
  into id_defendiente, id_equipo_defendiente
	from colonias
	where codigo = '&cod_defendiente';

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
            FOR i IN 0..cantidad LOOP
              IF result_atacante(i) > result_defendiente(i) THEN
                sp_eliminar_unidad(id_defendiente);
              ELSE
                sp_eliminar_unidad(id_atacante);
              END IF;
            END LOOP;
            
            -- busca la cantidad de regimientos restantes de la colonia defendiente
            select count(*) 
            into cantidad_restante
            from colonias 
            where id_equipo = id_equipo_defendiente;

            -- verificar si la colonia defendientes aun tienen unidades
            IF cantidad_restante = 0 THEN

              -- busca la cantidad de regimientos de la colonia atacante
              select count(id_unidad)
              into solo_comandantes
              from unidades 
              where id_colonia = id_atacante 
              and id_tipo_unidad = 1;

              --define si se pasan regimientos o comandantes
              IF solo_comandantes > 0 THEN
                sp_movilizar(id_atacante, id_defendiente, 1, 1);
              ELSE
                sp_movilizar(id_atacante, id_defendiente, 1, 2);
              END IF;

              -- translada la colonia al atacante
              update colonias 
              set id_equipo = (select id_equipo from colonias where id_colonia = id_atacante)
              where id_colonia = id_defendiente;
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