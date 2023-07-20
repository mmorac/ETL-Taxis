create database taxi;

use taxi;

create table staging(
id int not null auto_increment primary key,
placa varchar(20),
clase varchar(50),
marca varchar(100),
fabricacion int,
categoria varchar(100),
tipo_taxi varchar(50)
);


create table clase(
id_clase int not null auto_increment primary key,
descripcion varchar(50)
);

create table marca(
id_marca int not null auto_increment primary key,
descripcion varchar(100)
);

create table categoria(
id_categoria int not null auto_increment primary key,
descripcion varchar(100)
);

create table tipo_taxi(
id_tipo_taxi int not null auto_increment primary key,
descripcion varchar(50)
);

create table taxi(
id_taxi int not null auto_increment primary key,
placa varchar(20),
id_clase int,
id_marca int,
fabricacion int,
id_categoria int,
id_tipo_taxi int
);

ALTER TABLE taxi ADD CONSTRAINT FK_TaxiClase FOREIGN KEY taxi(id_clase) REFERENCES clase(id_clase);
ALTER TABLE taxi ADD CONSTRAINT FK_TaxiMarca FOREIGN KEY taxi(id_marca) REFERENCES marca(id_marca);
ALTER TABLE taxi ADD CONSTRAINT FK_TaxiCategoria FOREIGN KEY taxi(id_categoria) REFERENCES categoria(id_categoria);
ALTER TABLE taxi ADD CONSTRAINT FK_TaxiTipoTaxi FOREIGN KEY taxi(id_tipo_taxi) REFERENCES tipo_taxi(id_tipo_taxi);

