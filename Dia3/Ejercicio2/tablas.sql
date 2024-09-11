create table departamento(
    id int primary key not null,
    nombre varchar(50) not null
);
create table profesor (
    id int primary key not null,
    nif varchar(9),
    nombre varchar(25) not null,
    apellido1 varchar(50) not null,
    apellido2 varchar(50),
    ciudad varchar(25) not null,
    direccion varchar(50) not null,
    telefono varchar(9),
    fecha_nacimiento date,
    sexo enum('H','M'),
    id_departamento int references departamento (id)
);
create table curso_escolar(
    id int primary key not null,
    anyo_inicio year(4) not null,
    anyo_fin year(4) not null
);
create table grado(
    id int primary key not null,
    nombre varchar(100) not null
);
create table alumno(
    id int primary key not null,
    nif varchar(9) not null,
    nombre varchar(25) not null,
    apellido1 varchar(50) not null,
    apellido2 varchar(50),
    ciudad varchar(25) not null,
    direccion varchar(50) not null,
    telefono varchar(9),
    fecha_nacimiento date,
    sexo enum('H','M'),
);
create table asignatura(
    id int primary key not null,
    nombre varchar(100) not null,
    creditos float not null,
    tipo enum('si','no') not null,
    curso tinyint not null,
    cuatrimestre tinyint not null,
    id_profesor int references profesor(id),
    id_grado int references grado(id) not null
);
create table alumno_se_matricula_asignatura(
    id_alumno int references alumno(id) not null,
    id_asignatura int references asignatura(id) not null,
    id_curso_escolar references curso_escolar(id) not null
);