Declare
	v_cantReg1 number;
	v_cantReg2 number;
	v_cantReg3 number;
	v_cantReg4 number;
	v_cantReg5 number;
	CURSOR getEquipos is
		select id_equipo from equipos order by dbms_random.value;
	i number := 0;
	v_colorPrimerTurno varchar2(10);
	v_idEquipo varchar2(3);
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
		v_cantReg5 = 24 
		then
		--ordenar equipos a lo random
		for equipo in getEquipos loop
			i := i + 1;
			update equipos set orden = i where equipo.id_equipo = id_equipo;
		end loop;

		select color, id_equipo into v_colorPrimerTurno, v_idEquipo from equipos
		where orden = 1;

		DBMS_OUTPUT.PUT_LINE('EL primer equipo en jugar es: ' ||  v_colorPrimerTurno);
		update juegos set equipo_actual = v_idEquipo;

	else
		DBMS_OUTPUT.PUT_LINE('Algun equipo no tiene 24 regimientos asignados...');
		DBMS_OUTPUT.PUT_LINE('Ejecutar ver_cant_regimientos_equipos.sql o pruebas/ver_regimientos_color.sql');
	end if;
End;
/
