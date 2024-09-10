create table gama_producto (
	gama varchar(50) primary key,
	descripcion_texto text,
	descripcion_html text,
	imagen varchar(256)
);
create table producto (
	codigo_producto varchar(15) primary key,
	nombre varchar(70) not null,
	gama varchar(50) references gama_producto(gama) not null,
	dimensiones varchar(25),
	proveedor varchar(50),
	descripcion text,
	cantidad_en_stock smallint not null,
	precio_venta decimal(15,2) not null,
	precio_proveedor decimal(15,2)
);
create table oficina(
	codigo_oficina varchar(10) primary key,
	ciudad varchar(30) not null,
	pais varchar(50) not null,
	region varchar(50),
	codigo_postal varchar(10) not null,
	telefono varchar(20) not null,
	linea_direccion1 varchar(50) not null,
	linea_direccion2 varchar(50)
);
create table empleado (
	codigo_empleado int primary key,
	nombre varchar(50) not null,
	apellido1 varchar(50) not null,
	apellido2 varchar(50),
	extension varchar(10) not null,
	email varchar(100) not null,
	codigo_oficina varchar(10) references oficina(codigo_oficina) not null,
	codigo_jefe int references empleado(codigo_empleado),
	puesto varchar(50)
);
create table cliente(
	codigo_cliente int primary key,
	nombre_cliente varchar(50) not null,
	nombre_contacto varchar(30),
	apellido_contacto varchar(30),
	telefono varchar(15) not null,
	fax varchar(15) not null,
	linea_direccion1 varchar(50),
	linea_direccion2 varchar(50),
    ciudad varchar(50) not null,
    region varchar(50),
    pais varchar(50),
    codigo_postal varchar(10),
    codigo_empleado_rep_ventas int references empleado(codigo_empleado),
    limite_credito decimal(15,2)
);
create table pago (
	codigo_cliente int references cliente(codigo_cliente)not null,
    forma_pago varchar(40) not null,
    id_transaccion varchar(50) primary key,
    fecha_pago date not null,
    total decimal(15,2) not null
);
create table pedido(
	codigo_pedido int primary key,
    fecha_pedido date not null,
    fecha_esperada date not null,
    fecha_entrega date,
    estado varchar(15) not null,
    comentarios text,
    codigo_cliente int references cliente(codigo_cliente) not null
);
create table detalle_pedido(
	codigo_pedido int references pedido(codigo_pedido) not null,
    codigo_producto varchar(15) references producto(codigo_producto) not null,
    cantidad int not null,
    precio_unidad decimal(15,2) not null,
    numero_linea smallint not null
);
