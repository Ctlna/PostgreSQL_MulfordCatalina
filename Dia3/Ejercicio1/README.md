<h1 align="center">Consultas</h1>
<p>Para realizar las consultas pedidas primero se crearon las tablas, las cuales se encuentran en "tablas.sql". Estas tablas se tuvieron encuenta al momento de realizar las consultas.</p>

La primera consulta busca devolver un listado que muestre el código de oficina y la ciudad donde hay oficinas. 
```sql
select codigo_oficina as codigo, ciudad 
from oficina;
```
