1.  cual colonia quiere usar para atacar?
2.  cual colonia quiere atacar?
3.  lanzamiento de dados:
   
    n := select count(*) from regimientos where colonia = c_atacante
    m := select count(*) from comandantes where colonia = c_atacante
  
    colonia atacante lanza n-1 dados regulares
    colonia atacante lanza m dados especiales

    n := select count(*) from regimientos where colonia = c_atacada
    m := select count(*) from comandantes where colonia = c_atacada

    colonia atacada lanza n dados regulares
    colonia atacada lanza m dados especiales

4.  comparacion
    ordenar dados de mayor a menor
    se comparan los dados mayores de cada equipo

    eliminar_regimiento => elimina regimiento en una colonia,
                          si no hay regimientos, elimina comandantes

    for each (a, b) in dados:
       if a > b:
           eliminar_regimiento(c_atacada)
       else:
           eliminar_regimiento(c_atacante)
   
    si la colonia atacada pierde todos los regimientos y comandantes, la colonia pasa a
    ser del atacante. se debe mover un regimiento de la colonia atacante a la colonia
    obtenida

5.  se puede atacar otra vez