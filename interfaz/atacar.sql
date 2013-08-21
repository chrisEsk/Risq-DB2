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
BEGIN
	select id_colonia into id_atacante
	from colonias
	where codigo = '&cod_atacante'
	and id_equipo = fn_equipo_actual();

	select id_colonia into id_defendiente
	from colonias
	where codigo = '&cod_defendiente'
	and fn_es_vecino(id_colonia, id_atacante) = 1; -- TODO: definir fn_es_vecino

    result_atacante := fn_lanzar_dados(id_atacante, 1);
    result_defendiente := fn_lanzar_dados(id_defendiente, 0);

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
