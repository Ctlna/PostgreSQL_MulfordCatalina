-- Crear tipos ENUM
create  type sexo as enum ('H', 'M');
create  type tipo_asig as enum ('básica', 'obligatoria', 'optativa');

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
    sexo sexo not null,
    id_departamento int references departamento (id)
);
create table curso_escolar(
    id int primary key not null,
    anyo_inicio integer not null,
    anyo_fin integer not null
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
    sexo sexo not null
);
create table asignatura(
    id int primary key not null,
    nombre varchar(100) not null,
    creditos float not null,
    tipo tipo_asig not null,
    curso smallint not null,
    cuatrimestre smallint not null,
    id_profesor int references profesor(id),
    id_grado int references grado(id) not null
);
create table alumno_se_matricula_asignatura(
    id_alumno int not null,
    id_asignatura int not null,
    id_curso_escolar int not null,
    primary key (id_alumno, id_asignatura, id_curso_escolar),
    foreign key (id_alumno) references alumno(id),
    foreign key (id_asignatura) references asignatura(id),
    foreign key (id_curso_escolar) references curso_escolar(id)
);