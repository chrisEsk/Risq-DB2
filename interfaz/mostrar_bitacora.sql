set serveroutput on;
set lines 120;

DECLARE
    cursor b_cur is
    select e.color, b.descripcion, t.num_era
    from bitacora b
    join turnos t on t.id_turno = b.id_turno
    join equipos e on t.id_equipo = e.id_equipo;
    
    outp varchar2(255) := '';
BEGIN
    outp := outp || lpad('EQUIPO', 10);
    outp := outp || lpad('ERA', 3);
    outp := outp || lpad('DESCRIPCION', 100);
    
    dbms_output.put_line(outp);
    
    FOR b_rec in b_cur LOOP
        outp := lpad(b_rec.color, 10);
        outp := outp || lpad(b_rec.num_era, 3);
        outp := outp || lpad(b_rec.descripcion, 100);
        dbms_output.put_line(outp);
    END LOOP;
END;
/
