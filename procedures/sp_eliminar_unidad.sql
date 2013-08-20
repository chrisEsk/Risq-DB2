CREATE OR REPLACE PROCEDURE sp_eliminar_unidad (p_id_colonia int)
IS
    v_id_unidad int;
    v_id_tipo_unidad int;  
BEGIN
    select id_unidad, id_tipo_unidad
    into v_id_unidad, v_id_tipo_unidad
    from (
        select id_unidad, id_tipo_unidad
        from Unidades
        where id_colonia = p_id_colonia 
        order by id_tipo_unidad
    )
    where rownum = 1;
    
    IF v_id_unidad IS NOT NULL THEN
        -- TODO: agregar a bitacora
        delete from Unidades
        where id_unidad = v_id_unidad;
    END IF;
END;
/
