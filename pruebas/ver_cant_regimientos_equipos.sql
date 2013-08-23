select e.color, count(u.id_unidad) as cant_reg
from equipos e
join colonias c on(c.id_equipo = e.id_equipo)
join unidades u on(u.id_colonia = c.id_colonia)
group by e.color
/