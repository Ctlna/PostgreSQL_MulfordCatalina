create table personas(
id SERIAL primary key not null,
nombre text not null,
apellido text not null,
municipio_nacimiento text not null,
municipio_domicilio text not null
);
create table regiones(
id SERIAL primary key not null,
region text not null,
departamento text not null,
codigo_departamento text not null,
municipio text not null,
codigo_municipio text not null
);

