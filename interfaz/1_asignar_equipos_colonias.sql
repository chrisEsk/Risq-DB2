Declare
	v_color varchar2(10) := '&Color';
	v_idEquipo number;
	v_cantColonias number;
	v_cod1 varchar2(3) := '&Codigo_1';
	v_cod2 varchar2(3) := '&Codigo_2';
	v_cod3 varchar2(3) := '&Codigo_3';
	v_cod4 varchar2(3) := '&Codigo_4';
	v_cod5 varchar2(3) := '&Codigo_5';
	v_cod6 varchar2(3) := '&Codigo_6';
	v_cod7 varchar2(3) := '&Codigo_7';
	v_cod8 varchar2(3) := '&Codigo_8';
Begin
	select id_equipo INTO v_idEquipo
	from equipos
	where color = v_color;
	select count(id_equipo) INTO v_cantColonias from colonias where id_equipo = v_idEquipo;
	if v_cantColonias = 8 then
		DBMS_OUTPUT.PUT_LINE('Este equipo ya tiene 8 colonias');
	else
		update colonias set id_equipo = v_idEquipo where codigo = v_cod1;
		update colonias set id_equipo = v_idEquipo where codigo = v_cod2;
		update colonias set id_equipo = v_idEquipo where codigo = v_cod3;
		update colonias set id_equipo = v_idEquipo where codigo = v_cod4;
		update colonias set id_equipo = v_idEquipo where codigo = v_cod5;
		update colonias set id_equipo = v_idEquipo where codigo = v_cod6;
		update colonias set id_equipo = v_idEquipo where codigo = v_cod7;
		update colonias set id_equipo = v_idEquipo where codigo = v_cod8;
	end if;

	
End;
/
