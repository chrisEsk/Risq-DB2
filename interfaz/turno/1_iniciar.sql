set serveroutput on;

DECLARE
    turno_comenzado int;
BEGIN
    select count(id_turno)
    into turno_comenzado
    from turnos
    where id_equipo = fn_equipo_actual()
    and num_era = fn_era_actual();
    
    -- verificar que no haya comenzado el turno
    IF turno_comenzado = 1 THEN
        dbms_output.put_line('Ya se comenzo el turno actual');
        RETURN;
    END IF;

    -- crear el turno
    insert into turnos (id_turno, id_equipo, puntaje, num_era)
    values (turnos_seq.nextval, fn_equipo_actual(), 0, fn_era_actual());
    
    -- actualizar la fase del equipo actual
    update equipos
    set fase_actual = 1
    where id_equipo = fn_equipo_actual();
END;
/
