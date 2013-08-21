INSERT INTO equipos (id_equipo, color, energia, fase_actual, orden)
VALUES (1, 'rojo', 20, 0, 1);

INSERT INTO equipos (id_equipo, color, energia, fase_actual, orden)
VALUES (2, 'verde', 20, 0, 2);

-- alaska
update colonias set id_equipo = 1 where id_colonia = 1;
-- canada
update colonias set id_equipo = 2 where id_colonia = 2;
