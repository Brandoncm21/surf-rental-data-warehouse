-- CREATE TABLAS 
CREATE TABLE PAIS (
    idPais INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

EXEC sp_rename 'PAIS.nombre', 'nombrePais', 'COLUMN';

CREATE TABLE CIUDAD (
    idCiudad INT IDENTITY(1,1) PRIMARY KEY,
    nombreCiudad VARCHAR(100) NOT NULL,
    idPais INT NOT NULL,
    FOREIGN KEY (idPais) REFERENCES PAIS(idPais) ON DELETE CASCADE
);

CREATE TABLE PLAYAS (
    idPlaya INT IDENTITY(1,1) PRIMARY KEY,
    nombrePlaya VARCHAR(100) NOT NULL,
    dificultad VARCHAR(50) NOT NULL, 
    idCiudad INT NOT NULL,
    idPais INT NOT NULL,
    FOREIGN KEY (idCiudad) REFERENCES CIUDAD(idCiudad),
    FOREIGN KEY (idPais) REFERENCES PAIS(idPais)
);

CREATE TABLE CLIENTE(
	idCliente INT IDENTITY(1,1) PRIMARY KEY,
	nombreCliente varchar(100) NOT NULL,
	tarjetaCliente varchar(100) NOT NULL,
	idCiudad INT NOT NULL,
    idPais INT NOT NULL,
    FOREIGN KEY (idCiudad) REFERENCES CIUDAD(idCiudad),
    FOREIGN KEY (idPais) REFERENCES PAIS(idPais)
);

CREATE TABLE INSTRUCTORES(
	idInstructor INT IDENTITY(1,1) PRIMARY KEY,
	nombreInstructor VARCHAR(100) NOT NULL,
	idCiudad INT NOT NULL,
    idPais INT NOT NULL,
    FOREIGN KEY (idCiudad) REFERENCES CIUDAD(idCiudad),
    FOREIGN KEY (idPais) REFERENCES PAIS(idPais)
);

CREATE TABLE TIENDA(
	idTienda INT IDENTITY(1,1) PRIMARY KEY,
	nombreTienda VARCHAR(100) NOT NULL,
	idPlaya INT NOT NULL,
	FOREIGN KEY (idPlaya) REFERENCES PLAYAS(idPlaya)
);

CREATE TABLE RENTALS(
	idRental INT IDENTITY(1,1) PRIMARY KEY,
	tamanoTabla INT NOT NULL,
	tipoTabla VARCHAR(100) NOT NULL
);

CREATE TABLE PRODUCTOS(
	idProducto INT IDENTITY(1,1) PRIMARY KEY,
	nombreProducto VARCHAR(100) NOT NULL,
	tipoProducto VARCHAR(100) NOT NULL,
	categoriaProducto VARCHAR(100) NOT NULL, 
	costoProducto INT NOT NULL, 
	descripcionProducto VARCHAR(100) NOT NULL,
	idTienda INT NOT NULL,
	FOREIGN KEY (idTienda) REFERENCES TIENDA(idTienda)
);

CREATE TABLE FACTURA_PRODUCTO(
	idFacturaProducto INT IDENTITY(1,1) PRIMARY KEY, 
	montoTotal INT NOT NULL,
	metodoPago VARCHAR(100) NOT NULL,
	idCliente INT NOT NULL,
	FOREIGN KEY (idCliente) REFERENCES CLIENTE(idCliente)
);

CREATE TABLE DETALLE_FACTURA_PRODUCTO(
	idDetalleFacturaProducto INT IDENTITY(1,1) PRIMARY KEY,
	cantidad INT NOT NULL,
	idProducto INT NOT NULL,
	idFacturaProducto INT NOT NULL,
	FOREIGN KEY (idProducto) REFERENCES PRODUCTOS(idProducto),
	FOREIGN KEY (idFacturaProducto) REFERENCES FACTURA_PRODUCTO(idFacturaProducto)
);

CREATE TABLE FACTURA_CLASE(
	idFacturaClase INT IDENTITY(1,1) PRIMARY KEY,
	montoTotal INT NOT NULL,
	metodoPago VARCHAR(100) NOT NULL,
	idCliente INT NOT NULL,
	FOREIGN KEY (idCliente) REFERENCES CLIENTE(idCliente)
);

CREATE TABLE CLASES(
	idClase INT IDENTITY(1,1) PRIMARY KEY,
	horaClase DATETIME NOT NULL,
	accesorioExtra VARCHAR(100) NOT NULL,
	costoClase INT NOT NULL,
	idRental INT NOT NULL,
	idTienda INT NOT NULL,
	idInstructor INT NOT NULL,
	FOREIGN KEY (idRental) REFERENCES RENTALS(idRental),
	FOREIGN KEY (idTienda) REFERENCES TIENDA(idTienda),
	FOREIGN KEY (idInstructor) REFERENCES INSTRUCTORES(idInstructor)
);

CREATE TABLE FACTURA_CLASES(
    idClase INT NOT NULL,
    idFacturaClase INT NOT NULL,
    PRIMARY KEY (idClase, idFacturaClase),
    FOREIGN KEY (idClase) REFERENCES CLASES(idClase),
    FOREIGN KEY (idFacturaClase) REFERENCES FACTURA_CLASE(idFacturaClase)
);


-- INSERTS PAIS
INSERT INTO PAIS (nombrePais) VALUES
('Argentina'),
('Brasil'),
('Chile'),
('Colombia'),
('México'),
('Perú'),
('Uruguay'),
('Venezuela'),
('Paraguay'),
('Ecuador'),
('Bolivia'),
('Guatemala'),
('Cuba'),
('Honduras'),
('El Salvador'),
('Nicaragua'),
('Costa Rica'),
('Panamá'),
('República Dominicana'),
('Puerto Rico'),
('Jamaica'),
('Belice'),
('Barbados'),
('Trinidad y Tobago'),
('Guyana'),
('Surinam'),
('Bahamas'),
('Santa Lucía'),
('San Vicente y las Granadinas'),
('Granada'),
('Antigua y Barbuda');

-- INSERTS DE CIUDAD
INSERT INTO CIUDAD (nombreCiudad, idPais) VALUES
('Buenos Aires', 1),  -- Argentina
('Río de Janeiro', 2),  -- Brasil
('Santiago', 3),  -- Chile
('Bogotá', 4),  -- Colombia
('Ciudad de México', 5),  -- México
('Lima', 6),  -- Perú
('Montevideo', 7),  -- Uruguay
('Caracas', 8),  -- Venezuela
('Asunción', 9),  -- Paraguay
('Quito', 10),  -- Ecuador
('La Paz', 11),  -- Bolivia
('Guatemala', 12),  -- Guatemala
('La Habana', 13),  -- Cuba
('Tegucigalpa', 14),  -- Honduras
('San Salvador', 15),  -- El Salvador
('Managua', 16),  -- Nicaragua
('San José', 17),  -- Costa Rica
('Ciudad de Panamá', 18),  -- Panamá
('Santo Domingo', 19),  -- República Dominicana
('San Juan', 20),  -- Puerto Rico
('Kingston', 21),  -- Jamaica
('Belmopan', 22),  -- Belice
('Bridgetown', 23),  -- Barbados
('Puerto España', 24),  -- Trinidad y Tobago
('Georgetown', 25),  -- Guyana
('Paramaribo', 26),  -- Surinam
('Nassau', 27),  -- Bahamas
('Castries', 28),  -- Santa Lucía
('Kingstown', 29),  -- San Vicente y las Granadinas
('St. George’s', 30);

-- INSERTS DE PLAYAS
INSERT INTO PLAYAS (nombrePlaya, dificultad, idCiudad, idPais) VALUES
('Playa Mar del Plata', 'Media', 1, 1),  -- Buenos Aires, Argentina
('Copacabana', 'Alta', 2, 2),  -- Río de Janeiro, Brasil
('Playa de Viña del Mar', 'Baja', 3, 3),  -- Santiago, Chile
('Playa de San Andrés', 'Alta', 4, 4),  -- Bogotá, Colombia
('Playa del Carmen', 'Media', 5, 5),  -- Ciudad de México, México
('Playa de Punta Sal', 'Alta', 6, 6),  -- Lima, Perú
('Playa de Punta del Este', 'Baja', 7, 7),  -- Montevideo, Uruguay
('Playa El Agua', 'Alta', 8, 8),  -- Caracas, Venezuela
('Playa de Areguá', 'Baja', 9, 9),  -- Asunción, Paraguay
('Playa de Montañita', 'Alta', 10, 10),  -- Quito, Ecuador
('Playa de la Isla del Sol', 'Media', 11, 11),  -- La Paz, Bolivia
('Playa de Tulum', 'Alta', 12, 12),  -- Guatemala, Guatemala
('Varadero', 'Baja', 13, 13),  -- La Habana, Cuba
('Playa de La Ceiba', 'Media', 14, 14),  -- Tegucigalpa, Honduras
('Playa El Tunco', 'Alta', 15, 15),  -- San Salvador, El Salvador
('Playa de San Juan del Sur', 'Baja', 16, 16),  -- Managua, Nicaragua
('Playa Hermosa', 'Media', 17, 17),  -- San José, Costa Rica
('Playa Blanca', 'Alta', 18, 18),  -- Ciudad de Panamá, Panamá
('Playa Boca Chica', 'Baja', 19, 19),  -- Santo Domingo, República Dominicana
('Playa Flamenco', 'Alta', 20, 20),  -- San Juan, Puerto Rico
('Seven Mile Beach', 'Baja', 21, 21),  -- Kingston, Jamaica
('Placencia', 'Media', 22, 22),  -- Belmopan, Belice
('Carlisle Bay', 'Alta', 23, 23),  -- Bridgetown, Barbados
('Maracas Bay', 'Baja', 24, 24),  -- Puerto España, Trinidad y Tobago
('Shell Beach', 'Media', 25, 25),  -- Georgetown, Guyana
('Playa de Galibi', 'Alta', 26, 26),  -- Paramaribo, Surinam
('Cable Beach', 'Baja', 27, 27),  -- Nassau, Bahamas
('Reduit Beach', 'Media', 28, 28),  -- Castries, Santa Lucía
('Playa de Bequia', 'Alta', 29, 29),  -- Kingstown, San Vicente y las Granadinas
('Grand Anse', 'Baja', 30, 30);

-- INSERTS DE TIENDA
INSERT INTO TIENDA (nombreTienda, idPlaya) VALUES
('Tienda Mar del Plata', 1), 
('Tienda Copacabana', 2),
('Tienda Viña del Mar', 3),
('Tienda San Andrés', 4),
('Tienda Playa del Carmen', 5),
('Tienda Punta Sal', 6),
('Tienda Punta del Este', 7),
('Tienda El Agua', 8),
('Tienda Areguá', 9),
('Tienda Montañita', 10),
('Tienda Isla del Sol', 11),
('Tienda Tulum', 12),
('Tienda Varadero', 13),
('Tienda La Ceiba', 14),
('Tienda El Tunco', 15),
('Tienda San Juan del Sur', 16),
('Tienda Playa Hermosa', 17),
('Tienda Playa Blanca', 18),
('Tienda Boca Chica', 19),
('Tienda Flamenco', 20),
('Tienda Seven Mile', 21),
('Tienda Placencia', 22),
('Tienda Carlisle Bay', 23),
('Tienda Maracas Bay', 24),
('Tienda Shell Beach', 25),
('Tienda Galibi', 26),
('Tienda Cable Beach', 27),
('Tienda Reduit Beach', 28),
('Tienda Bequia', 29),
('Tienda Grand Anse', 30),
('Tienda Ponta Negra', 1),
('Tienda Cayo Coco', 2),
('Tienda La Jolla', 3),
('Tienda El Conchal', 4),
('Tienda Puka Beach', 5),
('Tienda Mismaloya', 6),
('Tienda Punta Cana', 7),
('Tienda Barra de Navidad', 8),
('Tienda Zicatela', 9),
('Tienda Costa Azul', 10);

-- INSERTS CLIENTE
INSERT INTO CLIENTE (nombreCliente, tarjetaCliente, idCiudad, idPais) VALUES
('Carlos Pérez', '1234-5678-9012-3456', 1, 1),
('Ana López', '2345-6789-0123-4567', 2, 2),
('Luis García', '3456-7890-1234-5678', 3, 3),
('María Rodríguez', '4567-8901-2345-6789', 4, 4),
('José Martínez', '5678-9012-3456-7890', 5, 5),
('Sofía González', '6789-0123-4567-8901', 6, 6),
('Pedro Fernández', '7890-1234-5678-9012', 7, 7),
('Marta Sánchez', '8901-2345-6789-0123', 8, 8),
('Juan Díaz', '9012-3456-7890-1234', 9, 9),
('Laura Álvarez', '0123-4567-8901-2345', 10, 10),
('Miguel Rodríguez', '1234-5678-9012-3456', 11, 11),
('Elena Martínez', '2345-6789-0123-4567', 12, 12),
('Andrés López', '3456-7890-1234-5678', 13, 13),
('Raquel Fernández', '4567-8901-2345-6789', 14, 14),
('Javier González', '5678-9012-3456-7890', 15, 15),
('Patricia García', '6789-0123-4567-8901', 16, 16),
('David Pérez', '7890-1234-5678-9012', 17, 17),
('Carmen Sánchez', '8901-2345-6789-0123', 18, 18),
('Antonio López', '9012-3456-7890-1234', 19, 19),
('Isabel Fernández', '0123-4567-8901-2345', 20, 20),
('Ricardo Álvarez', '1234-5678-9012-3456', 21, 21),
('Sonia Martínez', '2345-6789-0123-4567', 22, 22),
('Cristian Díaz', '3456-7890-1234-5678', 23, 23),
('Eva González', '4567-8901-2345-6789', 24, 24),
('Fernando Rodríguez', '5678-9012-3456-7890', 25, 25),
('Alicia Sánchez', '6789-0123-4567-8901', 26, 26),
('Enrique García', '7890-1234-5678-9012', 27, 27),
('Mónica López', '8901-2345-6789-0123', 28, 28),
('Óscar Fernández', '9012-3456-7890-1234', 29, 29),
('Beatriz Pérez', '0123-4567-8901-2345', 30, 30),
('Felipe Álvarez', '1234-5678-9012-3456', 1, 1),
('Raúl Martínez', '2345-6789-0123-4567', 2, 2),
('Julia González', '3456-7890-1234-5678', 3, 3),
('Ricardo Pérez', '4567-8901-2345-6789', 4, 4),
('Tania Sánchez', '5678-9012-3456-7890', 5, 5),
('Rafael Fernández', '6789-0123-4567-8901', 6, 6),
('Elisa García', '7890-1234-5678-9012', 7, 7),
('Oscar Díaz', '8901-2345-6789-0123', 8, 8);

-- INSERTS INSTRUCTORES
INSERT INTO INSTRUCTORES (nombreInstructor, idCiudad, idPais) VALUES
('Carlos Torres', 1, 1),
('Ana Rodríguez', 2, 2),
('Luis Fernández', 3, 3),
('Marta González', 4, 4),
('José Sánchez', 5, 5),
('Isabel Martínez', 6, 6),
('Pedro López', 7, 7),
('Carmen Pérez', 8, 8),
('David García', 9, 9),
('Laura Martínez', 10, 10),
('Ricardo Hernández', 11, 11),
('Fernando Jiménez', 12, 12),
('Raquel López', 13, 13),
('Antonio García', 14, 14),
('Sofía Sánchez', 15, 15),
('Héctor Pérez', 16, 16),
('Elena Martínez', 17, 17),
('José Luis Rodríguez', 18, 18),
('Patricia Fernández', 19, 19),
('Carlos García', 20, 20),
('Laura González', 21, 21),
('Raúl Sánchez', 22, 22),
('María López', 23, 23),
('Juan Rodríguez', 24, 24),
('Ana García', 25, 25),
('Javier Fernández', 26, 26),
('Beatriz Sánchez', 27, 27),
('Francisco Pérez', 28, 28),
('Verónica Martínez', 29, 29),
('Miguel Hernández', 30, 30),
('Lucía Jiménez', 1, 1),
('Alberto Rodríguez', 2, 2),
('Pablo Sánchez', 3, 3),
('Carla López', 4, 4),
('Antonio Martínez', 5, 5),
('Cristina Pérez', 6, 6),
('Eduardo Fernández', 7, 7),
('Inés García', 8, 8),
('Sergio López', 9, 9),
('Montserrat Hernández', 10, 10);

-- INSERTS RENTALS
INSERT INTO RENTALS (tamanoTabla, tipoTabla) VALUES
(5, 'Shortboard'),
(6, 'Longboard'),
(7, 'Fish'),
(6, 'Shortboard'),
(8, 'Gun'),
(5, 'Funboard'),
(7, 'Longboard'),
(5, 'Shortboard'),
(6, 'Fish'),
(7, 'Funboard'),
(9, 'Gun'),
(6, 'Shortboard'),
(5, 'Longboard'),
(8, 'Fish'),
(6, 'Funboard'),
(7, 'Gun'),
(5, 'Shortboard'),
(9, 'Longboard'),
(6, 'Fish'),
(7, 'Funboard'),
(6, 'Shortboard'),
(8, 'Gun'),
(7, 'Longboard'),
(5, 'Fish'),
(6, 'Funboard'),
(7, 'Shortboard'),
(9, 'Gun'),
(6, 'Longboard'),
(5, 'Fish'),
(7, 'Shortboard'),
(8, 'Funboard'),
(6, 'Gun'),
(5, 'Longboard'),
(7, 'Fish'),
(6, 'Shortboard'),
(8, 'Funboard'),
(9, 'Gun'),
(6, 'Longboard'),
(7, 'Fish'),
(5, 'Shortboard'),
(6, 'Funboard'),
(8, 'Longboard'),
(7, 'Gun'),
(9, 'Fish'),
(6, 'Shortboard'),
(5, 'Funboard'),
(8, 'Longboard'),
(7, 'Fish'),
(6, 'Gun');

-- BULKS PARA LLENAR TABLAS FACTURA_CLASE, FACTURAS_CLASES Y CLASES
BULK INSERT surfSA.ext.FACTURA_CLASE
FROM 'C:\Users\malum\Documents\Fidelitas\DataWarehouse\factura_clase.csv'
WITH (
    FORMAT = 'CSV', -- Indica que el archivo es CSV (Requiere SQL Server 2017+)
    FIELDTERMINATOR = ',', -- Separador de campos
    ROWTERMINATOR = '\n',  -- Fin de línea
    FIRSTROW = 2, -- Salta la primera fila si contiene encabezados
    TABLOCK -- Mejora el rendimiento en grandes volúmenes de datos
);

TRUNCATE TABLE surfSA.ext.FACTURA_CLASE;
TRUNCATE TABLE surfSA.ext.CLASES;
TRUNCATE TABLE surfSA.ext.FACTURA_CLASES;


DBCC CHECKIDENT ('surfSA.ext.FACTURA_CLASE', RESEED, 1);
DBCC CHECKIDENT ('surfSA.ext.CLASES', RESEED, 1);
DBCC CHECKIDENT ('surfSA.ext.FACTURA_CLASES', RESEED, 1);

BULK INSERT surfSA.ext.CLASES
FROM 'C:\Users\malum\Documents\Fidelitas\DataWarehouse\clases.csv'
WITH
(
    FIELDTERMINATOR = ',',  -- El delimitador de campo (en este caso, coma)
    ROWTERMINATOR = '\n',   -- El terminador de fila (puede ser \n o \r\n, dependiendo del sistema)
    FIRSTROW = 2           -- Si el archivo tiene encabezado, se salta la primera fila
);

BULK INSERT surfSA.ext.FACTURA_CLASES
FROM 'C:\Users\malum\Documents\Fidelitas\DataWarehouse\factura_clases.csv'
WITH
(
    FIELDTERMINATOR = ',',  -- El delimitador de campo, en este caso coma
    ROWTERMINATOR = '\n',   -- El terminador de fila (salto de línea)
    FIRSTROW = 2           -- Salta la primera fila si contiene encabezados
);