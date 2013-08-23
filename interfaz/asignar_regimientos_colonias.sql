Declare
	-- pedir color, colonia y cant regimientos
	v_color varchar2(10) := '&Color';
	v_codColonia varchar2(3) := '&Cod_Colonia';
	v_maxRegimientos number default 24;
	v_cantRegimiento number := &cantRegimientos;
	v_idEquipo number;
	v_idColonia number;
	v_cantRegActuales number;
	v_idEquipoFetch number;

	CURSOR query is
		select id_equipo from colonias;
Begin
	-- no mas de 24 reg en total en las colonias de este color
	select id_equipo into v_idEquipo 
	from equipos
	where color = v_color;

	select sum(count(u.id_unidad)) into v_cantRegActuales
	from equipos e
	join colonias c on(c.id_equipo = e.id_equipo)
	join unidades u on(u.id_colonia = c.id_colonia)
	where e.id_equipo = v_idEquipo
	group by e.color;

	select id_colonia into v_idColonia
	from colonias 
	where codigo = v_codColonia;

	if v_cantRegActuales >= v_maxRegimientos OR v_cantRegActuales+v_cantRegimiento >= v_maxRegimientos then

		DBMS_OUTPUT.PUT_LINE('Ya este equipo tiene los regimientos asignados en sus colonias...');
	else

		OPEN query;
		LOOP
			FETCH query INTO v_idEquipoFetch;
			
			if v_idEquipoFetch = v_idEquipo then
				for c in 1..v_cantRegimiento loop
					INSERT INTO unidades (id_unidad, id_colonia, id_tipo_unidad) VALUES (unidades_seq.nextval, v_idColonia, 1);
				end loop;
			End if;
			
		EXIT WHEN query%NOTFOUND;
		END LOOP;
		CLOSE query;

		DBMS_OUTPUT.PUT_LINE('El equipo ' || v_color || ' inserto ' || v_cantRegimiento || ' en la colonia ' || v_codColonia);

		select sum(count(u.id_unidad)) into v_cantRegActuales
		from equipos e
		join colonias c on(c.id_equipo = e.id_equipo)
		join unidades u on(u.id_colonia = c.id_colonia)
		where e.id_equipo = v_idEquipo
		group by e.color;

		DBMS_OUTPUT.PUT_LINE('El equipo tiene un total de ' || v_cantRegActuales || ' regimientos.');
	end if;
End;
/