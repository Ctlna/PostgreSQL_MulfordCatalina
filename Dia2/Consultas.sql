-- Muestre las regions con sus departamentos. Generar una columna con la cantidad de municipios por departamento.
select region, departamento, count(municipio) as total_municipios
from regiones
group by region, departamento;

-- Muestre los departamentos con sus municipios. Generar una columna con el codigo del municipio completo (codigo del departamento y municipio concatenados)
select departamento, municipio, concat(codigo_departamento,codigo_municipio) as Codigo_Municipio_Completo
from regiones;

-- agregar y TERMINAR
alter table regiones
add column total_trabajadores int;

alter table regiones
add column total_habitantes int;
