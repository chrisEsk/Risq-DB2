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

	--buscar el id del tipo_unidad;

	select id_tipo_unidad into id_tipo
	from tipos_unidades
	where nombre='&tipo';
	

	--buscar id colonia destino;
	select id_colonia into id_col
	from colonias
	where codigo='&cod_col';

	--realizar compra;
	sp_comprar_unidades(id_tipo, cant, id_col);
END;