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

-- ----------- Consultas multitabla (Composición interna)

--1. Devuelve un listado con los datos de todas las alumnas que se han matriculado alguna vez en el Grado en Ingeniería Informática (Plan 2015).
create view alumnos_inge as
select a.nombre, a.apellido1, a.apellido2, a.nif
from alumno a
join alumno_se_matricula_asignatura am on a.id = am.id_alumno
join asignatura asi on am.id_asignatura = asi.id
join grado g on asi.id_grado = g.id
where a.sexo = 'M' and g.nombre = 'Grado en Ingeniería Informática (Plan 2015)';

select *
from alumnos_inge;

--2. Devuelve un listado con todas las asignaturas ofertadas en el Grado en Ingeniería Informática (Plan 2015).
select a.* 
from asignatura a
join grado g on a.id_grado = g.id
where g.nombre = 'Ingeniería Informática';

-- 3. Listado de profesores con el nombre del departamento.
select p.apellido1, p.apellido2, p.nombre, d.nombre as nombre_departamento 
from persona p
join profesor prof on p.id = prof.id_profesor
join departamento d on prof.id_departamento = d.id
order by p.apellido1, p.apellido2, p.nombre;

-- 4. Asignaturas y cursos escolares del alumno con NIF específico.
select a.nombre, ce.anyo_inicio, ce.anyo_fin 
from asignatura a
join alumno_se_matricula_asignatura am on a.id = am.id_asignatura
join curso_escolar ce on am.id_curso_escolar = ce.id
join persona p on am.id_alumno = p.id
where p.nif = '26902806M';
-- toca especificar un nif que ya está registrado

-- 5. Departamentos con profesores que imparten en Ingeniería Informática.
select distinct d.nombre 
from departamento d
join profesor prof on d.id = prof.id_departamento
join asignatura a on prof.id_profesor = a.id_profesor
join grado g on a.id_grado = g.id
where g.nombre = 'Ingeniería Informática';

-- 6. Alumnos matriculados en asignaturas durante el curso 2018/2019.
select p.* 
from persona p
join alumno_se_matricula_asignatura am on p.id = am.id_alumno
join curso_escolar ce on am.id_curso_escolar = ce.id
where ce.anyo_inicio = 2018 and ce.anyo_fin = 2019;

-- ----------------------------------------Consultas multitabla (Composición externa)

-- 1. Listado de profesores y sus departamentos.
select d.nombre as nombre_departamento, p.apellido1, p.apellido2, p.nombre 
from profesor prof
left join persona p on prof.id_profesor = p.id
left join departamento d on prof.id_departamento = d.id
order by d.nombre, p.apellido1, p.apellido2, p.nombre;

-- 2. Profesores no asociados a un departamento.
select p.* 
from persona p
left join profesor prof on p.id = prof.id_profesor
where p.tipo = 'profesor' and prof.id_departamento is null;
-- todos los profesores están registrados en un departamento

-- 3. Departamentos sin profesores asociados.
select d.* 
from departamento d
left join profesor prof on d.id = prof.id_departamento
where prof.id_profesor is null;

-- 4. Profesores que no imparten ninguna asignatura.
select p.* 
from persona p
left join profesor prof on p.id = prof.id_profesor
left join asignatura a on prof.id_profesor = a.id_profesor
where p.tipo = 'profesor' and a.id is null;

-- 5. Asignaturas sin profesor asignado.
select * 
from asignatura 
where id_profesor is null;

-- 6. Departamentos con asignaturas no impartidas en ningún curso.
select d.nombre as nombre_departamento, a.nombre as nombre_asignatura 
from departamento d
join profesor prof on d.id = prof.id_departamento
join asignatura a on prof.id_profesor = a.id_profesor
left join alumno_se_matricula_asignatura am on a.id = am.id_asignatura
where am.id_asignatura is null;

-- ---------------------Consultas resumen

-- 1. Número total de alumnas.
select COUNT(*) 
from persona 
where tipo = 'alumno' and sexo = 'M';

-- 2. Número de alumnos nacidos en 1999.
select COUNT(*) 
from persona 
where tipo = 'alumno' and EXTRACT(YEAR
from fecha_nacimiento) = 1999;

-- 3. Número de profesores por departamento.
select d.nombre as nombre_departamento, COUNT(prof.id_profesor) as num_profesores 
from departamento d
join profesor prof on d.id = prof.id_departamento
group by d.id 
order by num_profesores DESC;

-- 4. Número de profesores por departamento incluyendo departamentos sin profesores.
select d.nombre as nombre_departamento, COUNT(prof.id_profesor) as num_profesores 
from departamento d
left join profesor prof on d.id = prof.id_departamento
group by d.id 
order by num_profesores DESC;

-- 5. Número de asignaturas por grado.
select g.nombre, COUNT(a.id) as num_asignaturas 
from grado g
left join asignatura a on g.id = a.id_grado
group by g.id 
order by num_asignaturas DESC;

-- 6. Grados con más de 40 asignaturas asociadas.
select g.nombre, COUNT(a.id) as num_asignaturas 
from grado g
join asignatura a on g.id = a.id_grado
group by g.id 
having COUNT(a.id) > 40;
-- no hay ningún grado con mas de 40 asignaturas asignadas

-- 7. Suma de créditos por tipo de asignatura y grado.
select g.nombre as nombre_grado, a.tipo, SUM(a.creditos) as total_creditos 
from grado g
join asignatura a on g.id = a.id_grado
group by g.nombre, a.tipo 
order by total_creditos DESC;

-- 8. Número de alumnos matriculados por curso escolar.
select ce.anyo_inicio, COUNT(distinct am.id_alumno) as num_alumnos 
from curso_escolar ce
left join alumno_se_matricula_asignatura am on ce.id = am.id_curso_escolar
group by ce.anyo_inicio;

-- 9. Número de asignaturas impartidas por profesor.
select p.id, p.nombre, p.apellido1, p.apellido2, COUNT(a.id) as num_asignaturas 
from persona p
left join profesor prof on p.id = prof.id_profesor
left join asignatura a on prof.id_profesor = a.id_profesor
where p.tipo = 'profesor'
group by p.id 
order by num_asignaturas DESC;

-- -------------------- Más Consultas:

-- 1. Datos del alumno más joven.
select * 
from persona 
where tipo = 'alumno' 
order by fecha_nacimiento DESC 
limit 1;

-- 2. Profesores no asociados a un departamento.
select * 
from persona 
where tipo = 'profesor' and id not in (
  select id_profesor 
  from profesor
);
-- todos los profesores están asociados a un departamento

-- 3. Departamentos sin profesores asociados.
select * 
from departamento 
where id not in (
  select id_departamento 

from profesor
);

-- 4. Profesores asociados a departamentos que no imparten ninguna asignatura.
select * 
from persona 
where tipo = 'profesor' and id in (
  select id_profesor 

from profesor 
  where id_profesor not in (
    select id_profesor 
  
  from asignatura
  )
);

-- 5. Asignaturas sin profesor asignado.
select * 
from asignatura 
where id_profesor is null;

-- 6. Departamentos que no han impartido asignaturas en ningún curso escolar.
select d.* 
from departamento d
where d.id not in (
  select prof.id_departamento 

from profesor prof
  join asignatura a on prof.id_profesor = a.id_profesor
  join alumno_se_matricula_asignatura am on a.id = am.id_asignatura
);