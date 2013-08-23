set serveroutput on;
set verify off;
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

	v_id1 number;
	v_id2 number;
	v_id3 number;
	v_id4 number;
	v_id5 number;
	v_id6 number;
	v_id7 number;
	v_id8 number;

Begin
	select id_equipo INTO v_idEquipo
	from equipos
	where color = v_color;
	select count(id_equipo) INTO v_cantColonias from colonias where id_equipo = v_idEquipo;
	if v_cantColonias >= 8 then
		DBMS_OUTPUT.PUT_LINE('Este equipo ya tiene 8 colonias');
	else
		--si una colonia ya esta asociada a otra, va a dar el error: NO DATA FOUND
		select id_colonia into v_id1 from colonias where codigo = v_cod1 and id_equipo is null;
		select id_colonia into v_id2 from colonias where codigo = v_cod2 and id_equipo is null;
		select id_colonia into v_id3 from colonias where codigo = v_cod3 and id_equipo is null;
		select id_colonia into v_id4 from colonias where codigo = v_cod4 and id_equipo is null;
		select id_colonia into v_id5 from colonias where codigo = v_cod5 and id_equipo is null;
		select id_colonia into v_id6 from colonias where codigo = v_cod6 and id_equipo is null;
		select id_colonia into v_id7 from colonias where codigo = v_cod7 and id_equipo is null;
		select id_colonia into v_id8 from colonias where codigo = v_cod8 and id_equipo is null;

		if
		v_id1 is null or
		v_id2 is null or
		v_id3 is null or
		v_id4 is null or
		v_id5 is null or
		v_id6 is null or
		v_id7 is null or
		v_id8 is null then
			DBMS_OUTPUT.PUT_LINE('Una de las colonias seleccionadas ya pertenece a otro equipo.');
		else
			update colonias set id_equipo = v_idEquipo where codigo = v_cod1;
			update colonias set id_equipo = v_idEquipo where codigo = v_cod2;
			update colonias set id_equipo = v_idEquipo where codigo = v_cod3;
			update colonias set id_equipo = v_idEquipo where codigo = v_cod4;
			update colonias set id_equipo = v_idEquipo where codigo = v_cod5;
			update colonias set id_equipo = v_idEquipo where codigo = v_cod6;
			update colonias set id_equipo = v_idEquipo where codigo = v_cod7;
			update colonias set id_equipo = v_idEquipo where codigo = v_cod8;

			INSERT INTO unidades (id_unidad, id_colonia, id_tipo_unidad) VALUES (unidades_seq.nextval, v_id1, 1);
			INSERT INTO unidades (id_unidad, id_colonia, id_tipo_unidad) VALUES (unidades_seq.nextval, v_id2, 1);
			INSERT INTO unidades (id_unidad, id_colonia, id_tipo_unidad) VALUES (unidades_seq.nextval, v_id3, 1);
			INSERT INTO unidades (id_unidad, id_colonia, id_tipo_unidad) VALUES (unidades_seq.nextval, v_id4, 1);
			INSERT INTO unidades (id_unidad, id_colonia, id_tipo_unidad) VALUES (unidades_seq.nextval, v_id5, 1);
			INSERT INTO unidades (id_unidad, id_colonia, id_tipo_unidad) VALUES (unidades_seq.nextval, v_id6, 1);
			INSERT INTO unidades (id_unidad, id_colonia, id_tipo_unidad) VALUES (unidades_seq.nextval, v_id7, 1);
			INSERT INTO unidades (id_unidad, id_colonia, id_tipo_unidad) VALUES (unidades_seq.nextval, v_id8, 1);
			DBMS_OUTPUT.PUT_LINE('Las colonias se han asociado');

		end if;

	end if;

	
End;
/
