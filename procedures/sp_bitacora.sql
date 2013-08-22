CREATE OR REPLACE PROCEDURE sp_bitacora (p_descripcion varchar)
IS
    v_id_turno int;
BEGIN
    v_id_turno := fn_turno_actual();

    insert into bitacora (id_bitacora, id_turno, descripcion)
    values (bitacora_seq.nextval, v_id_turno, p_descripcion);
END;
/
