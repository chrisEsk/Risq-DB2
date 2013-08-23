Declare
	-- pedir color, colonia y cant regimientos
	v_color varchar2(10) := '&Color';
	v_codColonia varchar2(3) := '&Cod_Colonia';
	v_maxRegimientos number default 24;
	v_cantRegimiento number := &cantRegimientos;
	v_idEquipo number;
	v_idColonia number;
	v_cantRegActuales number;
Begin
	-- no mas de 24 reg en total en las colonias de este color
	select id_equipo into v_idEquipo 
	from equipos
	where color = v_color;

	select id_colonia into v_idColonia
	from colonias
	where id_equipo = v_idEquipo;

	select count(id_unidad) into v_cantRegActuales
	from unidades
	where id_colonia = v_idColonia;

	if v_cantRegActuales > v_maxRegimientos then
		DBMS_OUTPUT.PUT_LINE('Ya este equipo tiene los regimientos asignados en sus colonias...');
	else
		for c in 1..v_cantRegimiento loop
			INSERT INTO unidades (id_unidad, id_colonia, id_tipo_unidad) VALUES (unidades_seq.nextval, v_idColonia, 1);
		end loop;
		DBMS_OUTPUT.PUT_LINE('Se insertaron ' || v_cantRegimiento || ' en la colonia ' || v_codColonia);
	end if;
End;
/