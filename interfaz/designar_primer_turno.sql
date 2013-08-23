Declare
	v_cantReg1 number;
	v_cantReg2 number;
	v_cantReg3 number;
	v_cantReg4 number;
	v_cantReg5 number;

Begin
	--cada equipo debe tener 24 regs en total.
	select sum(count(u.id_unidad)) into v_cantReg1
	from equipos e
	join colonias c on(c.id_equipo = e.id_equipo)
	join unidades u on(u.id_colonia = c.id_colonia)
	where e.id_equipo = 1
	group by e.color;

	select sum(count(u.id_unidad)) into v_cantReg2
	from equipos e
	join colonias c on(c.id_equipo = e.id_equipo)
	join unidades u on(u.id_colonia = c.id_colonia)
	where e.id_equipo = 2
	group by e.color;

	select sum(count(u.id_unidad)) into v_cantReg3
	from equipos e
	join colonias c on(c.id_equipo = e.id_equipo)
	join unidades u on(u.id_colonia = c.id_colonia)
	where e.id_equipo = 3
	group by e.color;

	select sum(count(u.id_unidad)) into v_cantReg4
	from equipos e
	join colonias c on(c.id_equipo = e.id_equipo)
	join unidades u on(u.id_colonia = c.id_colonia)
	where e.id_equipo = 4
	group by e.color;

	select sum(count(u.id_unidad)) into v_cantReg5
	from equipos e
	join colonias c on(c.id_equipo = e.id_equipo)
	join unidades u on(u.id_colonia = c.id_colonia)
	where e.id_equipo = 5
	group by e.color;

	if
		v_cantReg1 = 24 AND
		v_cantReg2 = 24 AND
		v_cantReg3 = 24 AND
		v_cantReg4 = 24 AND
		v_cantReg5 = 24 AND
		then
		--ordenar equipos a lo random

		--DBMS_RANDOM.value(low => 1, high => 5)
		update equipos set orden = 5 where id_equipo = 1;
		update equipos set orden = 5 where id_equipo = 1;
		update equipos set orden = 5 where id_equipo = 1;
		update equipos set orden = 5 where id_equipo = 1;
		update equipos set orden = 5 where id_equipo = 1;


	else
		DBMS_OUTPUT.PUT_LINE('Algun equipo no tiene 24 regimientos asignados... executar pruebas/ver_regimientos_color.sql');
	end if;

	

	update juegos set equipo_actual = n where 1 = 1;
End;
/