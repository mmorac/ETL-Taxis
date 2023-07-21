create database taxis;

use taxis;

create table taxi_stg(
id int not null auto_increment primary key,
placa varchar(20),
clase varchar(50),
marca varchar(100),
ano_fabricacion int,
categoria varchar(100),
tipo_taxi varchar(50)
);

/*

En caso de querer agregar una columna que haya olvidado, la sintaxis es la siguiente:

ALTER TABLE <nombre_tabla> ADD COLUMN <nombre_campo> <tipo_valor>;

*/

/*
CREAR TABLAS DE DIMENSIÓN
*/

CREATE TABLE clase(
id_clase INT NOT NULL auto_increment PRIMARY KEY,
descripcion_clase varchar(50)
);

CREATE TABLE marca(
id_marca INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
descripcion_marca varchar(100)
);

CREATE TABLE categoria(
id_categoria INT NOT NULL auto_increment PRIMARY KEY,
descripcion_categoria varchar(100)
);

CREATE TABLE tipo_taxi(
id_tipo_taxi INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
descripcion_tipo_taxi varchar(50)
);

/*
CREAR LA TABLA DE HECHOS
*/

CREATE TABLE taxi(
id_taxi INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
placa varchar(20),
id_clase int,
id_marca int,
ano_fabricacion int,
id_categoria int,
id_tipo_taxi int
);

/*
SINTAXIS PARA CREAR LLAVES FORÁNEAS

ALTER TABLE <nombre_tabla> ADD CONSTRAINT <nombre_constraint> FOREIGN KEY <tabla_origen>(<llave_foránea>) REFERENCES <tabla_destino>(<identificador>);

*/

ALTER TABLE taxi ADD CONSTRAINT FK_TaxiClase FOREIGN KEY taxi(id_clase) REFERENCES clase(id_clase);
ALTER TABLE taxi ADD CONSTRAINT FK_TaxiMarca FOREIGN KEY taxi(id_marca) REFERENCES marca(id_marca);
ALTER TABLE taxi ADD CONSTRAINT FK_TaxiCategoria FOREIGN KEY taxi(id_categoria) REFERENCES categoria(id_categoria);
ALTER TABLE taxi ADD CONSTRAINT FK_TaxiTipoTaxi FOREIGN KEY taxi(id_tipo_taxi) REFERENCES tipo_taxi(id_tipo_taxi);


/*
CONSULTAR LOS VALORES EN LAS TABLAS DE DIMENSIÓN PARA VERIFICAR QUÉ SE DEBE LIMPIAR
*/
select distinct(marca) from taxi_stg;
select distinct(clase) from taxi_stg;
select distinct(categoria) from taxi_stg;
select distinct(tipo_taxi) from taxi_stg;
select distinct(ano_fabricacion) from taxi_stg;

/*
DATA PARA LIMPIAR:

Carros fabricados en el año 0
Marcas no registradas
Categoria no registrada
Tipo "Noid"

*/

delete from taxi_stg where ano_fabricacion = 0;
delete from taxi_stg where marca like '%Marca%no%registrada%';
delete from taxi_stg where categoria like '%Categoria%no%registrada%';
delete from taxi_stg where tipo_taxi = 'Noid';

/*
LLENAR TABLA DE HECHOS
*/
/*
SELECT PARA OBTENER LOS DATOS DE LA TABLA DE HECHOS
*/
select placa, id_clase, id_marca, ano_fabricacion, id_categoria, id_tipo_taxi from taxi_stg
join clase on taxi_stg.clase = clase.descripcion_clase
join marca on taxi_stg.marca = marca.descripcion_marca
join categoria on taxi_stg.categoria = categoria.descripcion_categoria
join tipo_taxi on taxi_stg.tipo_taxi = tipo_taxi.descripcion_tipo_taxi;

/*

CONSULTAR LOS DATOS DE LA TABLA DE HECHOS
*/

select * from taxi;