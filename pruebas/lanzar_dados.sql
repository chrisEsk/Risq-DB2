set serveroutput on;
DECLARE
    result dbms_sql.number_table;
BEGIN
    result := fn_lanzar_dados(1, 0);
    dbms_output.put_line('# de dados lanzados: ' || result.count);
    
    FOR i IN 0..result.count-1 LOOP
        dbms_output.put_line('dado #' || (i+1) || ': ' || result(i));
    END LOOP;
END;
/
