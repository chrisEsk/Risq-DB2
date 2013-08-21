DECLARE
    result_atacante dbms_sql.number_table;
    result_defendiente dbms_sql.number_table;
    cod_atacante varchar2(3) := '&Atacante';
    cod_defediente varchar2(3) := '&Defendiente';
   	status int;
   	id_atacante int;
   	id_defediente int;
BEGIN

	select id_colonia into id_atacante
	from colonias
	where codigo = cod_atacante;

	select id_colonia into id_defediente
	from colonias
	where codigo = cod_defediente;

    result_atacante := fn_lanzar_dados(id_atacante, 1);
    result_defendiente := fn_lanzar_dados(id_defediente, 0);

    EXCEPTION
		WHEN NO_DATA_FOUND THEN dbms_output.put_line('No data found.');

END;
/
