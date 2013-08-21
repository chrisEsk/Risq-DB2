create or replace function fn_lanzar_dados (id_colonia int, es_atacante boolean)
return dbms_sql.number_table
is
    arreglo dbms_sql.number_table;
    dados_especiales int;
    dados_regulares int;
    valor_especial int;
    valor_regular int;
    temp int;
    bandera int := 1;
begin
    -- cantidad de dados especiales a lanzar
    select count(id_unidad)
    into dados_especiales
    from unidades
    where id_tipo_unidad = 2
    and id_colonia = id_colonia;

    -- cantidad de dados regulares a lanzar
    select count(id_unidad)
    into dados_regulares
    from unidades
    where id_tipo_unidad = 1
    and id_colonia = id_colonia;

    -- los atacantes lanzan n - 1 dados regulares
    if es_atacante then
        dados_regulares := dados_regulares - 1;
    end if;

    -- valor maximo para los dados regulares
    select poder_max into valor_regular
    from tipos_unidades
    where id_tipo_unidad = 1;

    -- valor maximo para los dados especiales
    select poder_max into valor_especial
    from tipos_unidades
    where id_tipo_unidad = 2; 
    
    -- lanzamiento de de dados especiales
    for i in 0..dados_especiales loop
        arreglo(i) := dbms_random.value(1, valor_especial);
    end loop;

    -- lanzamiento de dados regulares
    for i in dados_especiales..dados_regulares + dados_especiales loop
        arreglo(i) := dbms_random.value(1, valor_regular);
    end loop;

    -- ordenar resultados obtenidos de mayor a menor
    for i in 0..dados_regulares + dados_especiales loop
    	bandera := 0;
    	for j in 0..dados_regulares + dados_especiales - 1 loop 
    		if arreglo(j+1) > arreglo(j)
    		then
    			temp := arreglo(j);
    			arreglo(j) := arreglo(j+1);
    			arreglo(j+i) := temp;
    			bandera := 1;
    		end if;
    	end loop;
    end loop;
    
    return arreglo;
end;
/
