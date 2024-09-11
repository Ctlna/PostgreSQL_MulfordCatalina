-- Consultas normales:

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

select distinct codigo_cliente
from pago
where fecha_pago between '2008-01-01' and '2008-12-31';

--9. Lista con el código de pedido, código de cliente, fecha esperada y fecha de entrega de los pedidos
--que no han sido entregados a tiempo.
select codigo_pedido , codigo_cliente , fecha_esperada , fecha_entrega 
from pedido
where fecha_entrega > fecha_esperada ;

--10. Lista con el código de pedido, código de cliente, fecha esperada y fecha de entrega de los pedidos
--cuya fecha de entrega ha sido al menos dos días antes de la fecha esperada.
select codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega
from pedido
where fecha_entrega <= fecha_esperada - INTERVAL '2 days';

select codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega
from pedido
where fecha_entrega <= fecha_esperada - INTERVAL '2 days';

--11. Pedidos rechazados en 2009
select codigo_pedido
from pedido
where estado = 'Rechazado' and extract(YEAR from fecha_pedido) = 2009;

--12. Pedidos entregados en enero de cualquier año
select codigo_pedido
from pedido
where extract(MONTH FROM fecha_entrega) = 1;

--13. Pagos en el año 2008 mediante Paypal, ordenados de mayor a menor
select *
from pago
where extract(YEAR FROM fecha_pago) = 2008 and forma_pago = 'PayPal'
ORDER by total DESC;

--14. Formas de pago únicas en la tabla pago
select distinct forma_pago
from pago;

--15. Productos de la gama Ornamentales con más de 100 unidades en stock, ordenados por precio de venta
select *
from producto
where gama = 'Ornamentales' AND cantidad_en_stock > 100
ORDER by precio_venta DESC;

--16. Clientes de Madrid cuyo representante de ventas tenga el código 11 o 30
select nombre_cliente
from cliente
where ciudad = 'Madrid' AND codigo_empleado_rep_ventas IN (11, 30);


-- ------------ Consultas Multitablas:

-- 1. Nombre de cada cliente y nombre y apellido de su representante de ventas
select c.nombre_cliente, e.nombre, e.apellido1
from  cliente c
inner join empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado;

-- 2. Nombre de los clientes que hayan realizado pagos y nombre de sus representantes de ventas
select c.nombre_cliente, e.nombre, e.apellido1
from  cliente c
inner join empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
inner join pago p ON c.codigo_cliente = p.codigo_cliente;

-- 3. Nombre de los clientes que no hayan realizado pagos junto con el nombre de sus representantes de ventas
select c.nombre_cliente, e.nombre, e.apellido1
from  cliente c
left join empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
left join pago p ON c.codigo_cliente = p.codigo_cliente
where p.codigo_cliente IS NULL;

-- 4. Nombre de los clientes que han hecho pagos y nombre de sus representantes junto con la ciudad de la oficina
select c.nombre_cliente, e.nombre, e.apellido1, o.ciudad
from cliente c
inner join empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
inner join oficina o ON e.codigo_oficina = o.codigo_oficina
inner join pago p ON c.codigo_cliente = p.codigo_cliente;

-- 5. Nombre de los clientes que no han hecho pagos y nombre de sus representantes junto con la ciudad de la oficina
select c.nombre_cliente, e.nombre, e.apellido1, o.ciudad
from cliente c
left join empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
left join oficina o ON e.codigo_oficina = o.codigo_oficina
left join pago p ON c.codigo_cliente = p.codigo_cliente
where p.codigo_cliente is null;

-- 6. Dirección de las oficinas que tienen clientes en Fuenlabrada
select cliente.nombre_cliente, empleado.nombre, oficina.ciudad, oficina.linea_direccion1, cliente.ciudad
from pago
inner join cliente on pago.codigo_cliente = cliente.codigo_cliente
inner join empleado on cliente.codigo_empleado_rep_ventas = empleado.codigo_empleado
inner join oficina on empleado.codigo_oficina = oficina.codigo_oficina
where cliente.ciudad = 'Fuenlabrada';

-- 7. Nombre de los clientes y el nombre de sus representantes junto con la ciudad de la oficina
select c.nombre_cliente, e.nombre, e.apellido1, o.ciudad
from cliente c
inner join empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
inner join oficina o ON e.codigo_oficina = o.codigo_oficina;

-- 8. Nombre de los empleados junto con el nombre de su jefe y el nombre del jefe de su jefe
select emp.nombre as NombreEmpleado, jef.nombre as NombreJefe, jef2.nombre as NombreJefe2
from empleado emp
left join empleado jef on emp.codigo_jefe = jef.codigo_empleado
left join empleado jef2 on jef.codigo_jefe = jef2.codigo_empleado;

-- 9. Nombre de clientes a los que no se les ha entregado a tiempo un pedido
select distinct c.nombre_cliente
from cliente c
inner join pedido p ON c.codigo_cliente = p.codigo_cliente
where p.fecha_entrega > p.fecha_esperada;

-- 10. Diferentes gamas de producto que ha comprado cada cliente
select distinct c.nombre_cliente, p.gama
from cliente c
inner join pedido pd ON c.codigo_cliente = pd.codigo_cliente
inner join detalle_pedido dp ON pd.codigo_pedido = dp.codigo_pedido
inner join producto p ON dp.codigo_producto = p.codigo_producto;

-- ----------- Consulta externa:

-- 1. Clientes que no han realizado ningún pago
select c.nombre_cliente
from cliente c
left join pago p ON c.codigo_cliente = p.codigo_cliente
where p.codigo_cliente IS NULL;

-- 2. Clientes que no han realizado ningún pedido
select c.nombre_cliente
from cliente c
left join pedido p ON c.codigo_cliente = p.codigo_cliente
where p.codigo_pedido IS NULL;

-- 3. Clientes que no han realizado ningún pago y los que no han realizado ningún pedido
select c.nombre_cliente
from cliente c
left join pago p ON c.codigo_cliente = p.codigo_cliente
left join pedido pd ON c.codigo_cliente = pd.codigo_cliente
where p.codigo_cliente IS NULL AND pd.codigo_pedido IS NULL;

-- 4. Empleados que no tienen una oficina asociada
select e.nombre, e.apellido1
from empleado e
where e.codigo_oficina IS NULL;

-- 5. Empleados que no tienen un cliente asociado
select e.nombre, e.apellido1
from empleado e
left join cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas
where c.codigo_cliente IS NULL;

-- 6. Empleados sin cliente asociado junto con datos de la oficina
select e.nombre, e.apellido1, o.linea_direccion1, o.ciudad
from empleado e
left join oficina o ON e.codigo_oficina = o.codigo_oficina
left join cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas
where c.codigo_cliente IS NULL;

-- 7. Clientes que no tienen pedido ni pago
select c.nombre_cliente
from cliente c
left join pedido p ON c.codigo_cliente = p.codigo_cliente
left join pago pa ON c.codigo_cliente = pa.codigo_cliente
where p.codigo_pedido IS NULL AND pa.codigo_cliente IS NULL;
