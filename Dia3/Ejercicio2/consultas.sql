--1. Lista con el primer apellido, segundo apellido y el nombre de todos los alumnos. El listado deberá estar ordenado alfabéticamente de menor a mayor por el primer apellido, segundo apellido y nombre.
select apellido1, apellido2, nombre
from alumno
order by apellido1, apellido2, nombre asc;

--2. nombre y los dos apellidos de los alumnos que no han dado de alta su número de teléfono en la base de datos.
select nombre, apellido1, apellido2
from alumno
where telefono is null;

--3. Devuelve el listado de los alumnos que nacieron en 1999.
select *
from alumno
where year(fecha_nacimiento)=1999;

--4. Lista de profesores que no han dado de alta su número de teléfono en la base de datos y además su nif termina en K.
select *
from profesor
where telefono is null
and nif like '%K';

--5. Lista de las asignaturas que se imparten en el primer cuatrimestre, en el tercer curso del grado que tiene el identificador 7.
select nombre
from asignatura
where cuatrimestre = 1
and curso = 3
and id_grado = 7;