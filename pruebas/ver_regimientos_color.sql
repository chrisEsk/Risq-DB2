select c.nombre as Colonia, e.color as Color, count(u.id_unidad) as Cant_Unidades
from equipos e
join colonias c on(c.id_equipo = e.id_equipo)
join unidades u on(u.id_colonia = c.id_colonia)
where e.color = 'negro'
group by c.nombre, e.color
/