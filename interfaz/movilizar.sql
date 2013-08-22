set serveroutput on;
set lines 120;

DECLARE
colonia1 varchar;
colonia2 varchar;
cant_unidades number;
tipo_unidad number;
unidades_disponibles number;

BEGIN

	SELECT COUNT(id_unidad) INTO unidades_disponibles
	FROM unidades
	WHERE id_colonia = colonia1;
	
	DBMS_OUTPUT.PUT_LINE('Ingrese la colonia de la que desea sacar los regimientos.');
	colonia1:=$;

	DBMS_OUTPUT.PUT_LINE('Ingrese la colonia en la que desea ingresar los regimientos.');
	colonia2:=$;
	
	DBMS_OUTPUT.PUT_LINE('Ingrese el tipo de unidad: ');
	DBMS_OUTPUT.PUT_LINE('1 para regimientos. ');
	DBMS_OUTPUT.PUT_LINE('2 para comandantes. ');
	colonia2:=$;
	
	DBMS_OUTPUT.PUT_LINE('Ingrese la cantidad de unidades que desea movilizar:');
	DBMS_OUTPUT.PUT_LINE(unidades_disponibles ||'unidades disponibles');	
	cant_unidades:=$;
END;