create or replace function fn_lanzar_dados (p_id_colonia int, es_atacante int)
return dbms_sql.number_table
is
    arreglo dbms_sql.number_table;
    dados_especiales int;
    dados_regulares int;
    valor_especial int;
    valor_regular int;
    temp int;
    bandera int := 1;
    contador int := 0;
begin
    -- cantidad de dados especiales a lanzar
    select count(id_unidad)
    into dados_especiales
    from unidades
    where id_tipo_unidad = 2
    and id_colonia = p_id_colonia;

    -- cantidad de dados regulares a lanzar
    select count(id_unidad)
    into dados_regulares
    from unidades
    where id_tipo_unidad = 1
    and id_colonia = p_id_colonia;
    
    -- los atacantes lanzan n - 1 dados regulares
    if es_atacante = 1 then
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
    for i in 0..dados_especiales - 1 loop
        arreglo(i) := 1 + mod(abs(dbms_random.random()), valor_especial);
        dbms_output.put_line(i);
    end loop;
    
    -- lanzamiento de dados regulares
    for i in dados_especiales..dados_regulares + dados_especiales - 1 loop
        arreglo(i) := 1 + mod(abs(dbms_random.random()), valor_regular);
        dbms_output.put_line(i);
    end loop;

    -- ordenar resultados obtenidos de mayor a menor
    while contador <= arreglo.count loop
        bandera := 0;
        contador := contador + 1;
        for j in 0..arreglo.count - 2 loop 
            if arreglo(j+1)>arreglo(j)
            then
                temp := arreglo(j);
                arreglo(j) := arreglo(j+1);
                arreglo(j+1) := temp;
                bandera := 1;

            end if;
        end loop;
    end loop;
    dbms_output.put_line(arreglo.count);
    return arreglo;
end;
/
