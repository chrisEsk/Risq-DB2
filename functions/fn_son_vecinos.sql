CREATE OR REPLACE FUNCTION fn_son_vecinos(id_colonia1 number, id_colonia2 number)
RETURN number
AS
	v_x number;
	v_y number;
	v_es_vecino number;
BEGIN
    select x, y
    into v_x, v_y
    from colonias
    where id_colonia = id_colonia1;

	select count(id_colonia) into v_es_vecino
	from colonias
	where x in (v_x, v_x+1, v_x-1) 
	and y in (v_y, v_y+1, v_y-1) 
	and id_colonia != id_colonia1
	and id_colonia = id_colonia2;
	
	return v_es_vecino;
END;
/
