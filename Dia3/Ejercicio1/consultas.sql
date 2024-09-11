-- Consultas:

--1. Listado con el código de oficina y la ciudad donde hay oficinas.
select codigo_oficina as codigo, ciudad 
from oficina;

--2. Listado con la ciudad y el teléfono de las oficinas de España.
select ciudad, telefono
from oficina
where pais = 'España';

--3. Lista nombre, apellidos y email de los empleados cuyo jefe tiene un código de jefe igual a 7.
select nombre, apellido1, apellido2, email
from empleado
where codigo_jefe = 7;

--4. Lista el puesto, nombre, apellidos y email del jefe de la empresa.
select puesto, nombre, apellido1, apellido2, email
from empleado
where puesto = 'Director General';

--5. Lista con nombre, apellidos y puesto de aquellos empleados que no sean representantes de ventas.
select nombre, apellido1, apellido2, puesto
from empleado
where puesto != 'Representante Ventas';

--6. Lista con el nombre de los todos los clientes españoles.
select nombre_cliente
from cliente
where pais = 'España';

--7. Lista con los distintos estados por los que puede pasar un pedido.
select distinct estado
from pedido;

/*8. Lista con el código de cliente de aquellos clientes que realizaron algún pago en 2008. Tenga en 
 *cuenta que deberá eliminar aquellos códigos de cliente que aparezcan repetidos. Resuelva la consulta:*/
select c.codigo_cliente 
from cliente c
left join pago p on p.codigo_cliente = c.codigo_cliente 
where extract ( year from p.fecha_pago) = 2008;

--9. Lista con el código de pedido, código de cliente, fecha esperada y fecha de entrega de los pedidos
--que no han sido entregados a tiempo.
select codigo_pedido , codigo_cliente , fecha_esperada , fecha_entrega 
from pedido
where fecha_entrega > fecha_esperada ;

--10. Lista con el código de pedido, código de cliente, fecha esperada y fecha de entrega de los pedidos
--cuya fecha de entrega ha sido al menos dos días antes de la fecha esperada.


