set serveroutput on;
set lines 120;

DECLARE
    w int := 8;
    h int := 5;
    w_c int := 10;
    cant_reg int;
    cant_com int;
    outp1 varchar2(255) := '';
    outp2 varchar2(255) := '';
    outp3 varchar2(255) := '';
    CURSOR cur_colonias is
    select
        codigo, colonias.nombre, id_colonia,
        x, y, equipos.color as color_equipo,
        continentes.nombre as nombre_continente
    from colonias
    left join equipos
    on colonias.id_equipo = equipos.id_equipo
    left join continentes
    on colonias.id_continente = continentes.id_continente
    order by y asc, x asc;
BEGIN
    FOR c IN cur_colonias LOOP
        select count(id_unidad) into cant_com from unidades
        where id_tipo_unidad = 1
        and id_colonia = c.id_colonia;
        select count(id_unidad) into cant_reg from unidades
        where id_tipo_unidad = 2
        and id_colonia = c.id_colonia;
        
        outp1 := outp1 || rpad('| ' || c.nombre, w_c);
        outp2 := outp2 || rpad('| ' || cant_com || ' ' || cant_reg, w_c);
        outp3 := outp3 || rpad('| ' || c.color_equipo, w_c - 3) || ' ' || substr(c.nombre_continente, 0, 2);
                
        IF c.x = w-1 THEN
            dbms_output.put_line(outp1 || ' |');
            dbms_output.put_line(outp2 || ' |');
            dbms_output.put_line(outp3 || ' |');
            outp1 := '';
            outp2 := '';
            outp3 := '';
            
            IF c.y < h-1 THEN
                dbms_output.put_line(rpad('-', w*w_c, '-'));
            END IF;
        END IF;
    END LOOP;
END;
/
