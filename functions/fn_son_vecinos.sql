CREATE OR REPLACE FUNCTION fn_son_vecinos(px IN number, py IN varchar2)
RETURN number
AS
	v_x number;
	v_y number;
	v_es_vecino number default 0;
Begin

	select count(id_colonia) INTO v_es_vecino
	from colonias 
	where x in (px, px+1, px-1) 
	and y in (py, py+1, py-1) 
	and id_colonia != p_id_colonia 
	and id_colonia = p_id_colonia_2;
	return es_vecino;

End;
/