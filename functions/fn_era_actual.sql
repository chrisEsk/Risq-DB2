create or replace function fn_era_actual
 
return int 
is
    
	id_era_actual int;

begin
    
	select era_actual into id_era_actual
    
	from (	select era_actual
          
		from juegos
    ) 
	where rownum = 1;
    
    
return id_era_actual;

end;
/