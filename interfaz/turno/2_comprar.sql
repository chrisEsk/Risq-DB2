set serveroutput on;

accept cant prompt 'Cantidad: '

accept tipo prompt 'Tipo de unidad: '

accept cod_col prompt 'Codigo de colonia destino: '

DECLARE
	tipo VARCHAR2(50);
	id_tipo tipos_unidades.id_tipo_unidad%TYPE;
	cant NUMBER:=&cant;
	cod_col VARCHAR2(3);
	id_col colonias.id_colonia%TYPE;
	v_fase_actual int;
BEGIN
    -- buscar la fase del equipo actual;
    select fase_actual into v_fase_actual 
    from equipos
    where id_equipo = fn_equipo_actual();
    
    IF v_fase_actual = 2 THEN
    	dbms_output.put_line('Ya finalizo la  de ataque');
   	return;
    END IF;

	--buscar el id del tipo_unidad;

	select id_tipo_unidad into id_tipo
	from tipos_unidades
	where nombre=initcap('&tipo');
	

	--buscar id colonia destino;
	select id_colonia into id_col
	from colonias
	where codigo=upper('&cod_col');

	--realizar compra;
	sp_comprar_unidades(id_tipo, cant, id_col);
END;
/
