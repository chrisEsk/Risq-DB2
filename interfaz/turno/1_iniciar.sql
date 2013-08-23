set serveroutput on;

DECLARE
    turno_comenzado int;
BEGIN
    select count(id_turno)
    into turno_comenzado
    from turnos
    where id_equipo = fn_equipo_actual()
    and num_era = fn_era_actual();
    
    IF turno_comenzado := 1 THEN
        dbms_output.put_line('Ya se comenzo el turno actual');
        EXIT;
    END IF;

    insert into turnos (id_turno, id_equipo, puntaje, num_era)
    values (seq_turnos.nextval, fn_equipo_actual(), 0, fn_era_actual());
    
    update equipos
    set fase_actual = 1
    where id_equipo = fn_equipo_actual();
END;
