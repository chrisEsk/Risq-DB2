set serveroutput on;
set lines 120;

DECLARE
    w int := 8;
    h int := 5;
    w_c int := 10;
    outp1 varchar2(255) := '';
    outp2 varchar2(255) := '';
    outp3 varchar2(255) := '';
    CURSOR cur_colonias is select id_colonia,
    codigo, nombre,
    x, y, equipos.color as color_equipo
    from colonias
    left join equipos on colonias.id_equipo = equipos.id_equipo
    order by y asc, x asc;
BEGIN
    FOR c IN cur_colonias LOOP
        
        outp1 := outp1 || rpad('| ' || c.codigo, w_c);
        outp2 := outp2 || rpad('| ' || c.nombre, w_c);
        outp3 := outp3 || rpad('| ' || c.color_equipo, w_c);
                
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
