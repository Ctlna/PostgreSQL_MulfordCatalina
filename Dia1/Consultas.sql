create database dia1;

create table fabricante(
	codigo int not null,
	nombre varchar(100),
	primary key (codigo)
);
	
create table producto(
	codigo int not null,
	nombre varchar (100),
	precio double precision,
	codigo_fabricante int,
	foreign key (codigo_fabricante)references fabricante(codigo),
	primary key (codigo)
);

INSERT INTO fabricante (codigo, nombre) VALUES
(1, 'Asus'),
(2, 'Lenovo'),
(3, 'Hewlett-Packard'),
(4, 'Samsung'),
(5, 'Seagate'),
(6, 'Crucial'),
(7, 'Gigabyte'),
(8, 'Huawei'),
(9, 'Xiaomi'); 
INSERT INTO producto (codigo, nombre, precio, codigo_fabricante) VALUES
(1, 'Disco duro SATA3 1TB', 86.99, 5),
(2, 'Memoria RAM DDR4 8GB', 120, 6),
(3, 'Disco SSD 1 TB', 150.99, 4),
(4, 'GeForce GTX 1050Ti', 185, 7),
(5, 'GeForce GTX 1080 Xtreme', 755, 6),
(6, 'Monitor 24 LED Full HD', 202, 1),
(7, 'Monitor 27 LED Full HD', 245.99, 1),
(8, 'Portátil Yoga 520', 559, 2),
(9, 'Portátil Ideapad 320', 444, 2),
(10, 'Impresora HP Deskjet 3720', 59.99, 3),
(11, 'Impresora HP Laserjet Pro M26nw', 180, 3); 


-- 1. Lista el nombre de todos los productos que hay en la tabla producto.
select nombre from producto;

-- 2. Lista los nombres y los precios de todos los productos de la tabla producto.
select nombre, precio from producto;

-- 3. Lista todas las columnas de la tabla producto.
select column_name as column_producto
from information_schema.columns
where table_name = 'producto';

-- 4. Lista el nombre de los productos, el precio en euros y el precio en dólares estadounidenses 
-- (USD).
create function euros(precio double precision) -- Parametros y tipo de dato
returns double precision as $$ -- Tipo de dato que retorna
begin
    return precio * 0.90; -- retorno
end;
$$ LANGUAGE plpgsql;
select nombre, euros(precio) as Precio_Euros,precio as Precio_Dolares 
from producto;

/* 5. Lista el nombre de los productos, el precio en euros y el precio en dólares
estadounidenses (USD). Utiliza los siguientes alias para las columnas: nombre de producto, euros, 
dólares.*/
select nombre as nombre_de_producto, euros(precio) as Precio_Euros,precio as Precio_Dolares 
from producto;

/* 6. Lista los nombres y los precios de todos los productos de la tabla producto, convirtiendo 
los nombres a mayúscula.*/
select UPPER(nombre), precio
from producto;

/* 7. Lista los nombres y los precios de todos los productos de la tabla producto, convirtiendo los 
nombres a minúscula.*/
select lower(nombre), precio
from producto;

/*8. Lista el nombre de todos los fabricantes en una columna, y en otra columna obtenga en 
mayúsculas los dos primeros caracteres del nombre del fabricante.*/
select nombre
from fabricante;
-- Continuara