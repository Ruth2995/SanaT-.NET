-- OBJETIVO: PROGRAMAR LOS PROCESOS DE LA BASE DE DATOS SANA T HOLISTIC
-- DESARROLLADO POR: 
-- 		HERNANDEZ NUÑEZ CARLA GABRIELA
-- 		LOPEZ ESQUIVEL METZTONALLI
-- 		TORRES ROMERO CLAUDIA RUTH
-- 		UVALLE BECERRIL ABRIL ARIADNE
-- FECHA DE CREACIÓN: 14 NOVIEMBRE 2023
-- FECHA DE ENTREGA: 4 DE DICIEMBRE DE 2023

/*1. CREAR LA BASE DE DATOS */
-- DROP DATABASE BD_SanaT;
-- CREATE DATABASE BD_SanaT;

/*2. ACTIVAR LA BASE DE DATOS A UTILIZAR */
USE BD_SanaT;

/*3. CREAR LAS TABLAS DE LA BASE DE DATOS */
CREATE TABLE SAN_CATEGORIA
(
	CAT_ID 				INT  NOT NULL PRIMARY KEY AUTO_INCREMENT,
	CAT_Nombre			NVARCHAR(200) 	NOT NULL,	
	CAT_Estatus			CHAR(1) 		NOT NULL
)ENGINE=innodb;

CREATE TABLE SAN_PROVEDDOR
(
	PRO_ID				INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    PRO_Nombre			NVARCHAR(40)	 NOT NULL,
	PRO_Ciudad			NVARCHAR(100)	 NOT NULL,	 	
	PRO_Municipio		NVARCHAR(60),
	PRO_Estado			NVARCHAR(60),
	PRO_CodigoPostal	INT				 NOT NULL,
	PRO_Telefono		VARCHAR(12)
)ENGINE=innodb;

CREATE TABLE SAN_ROL (
    ROL_ID				INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    ROL_Nombre		 	NVARCHAR(100),
	ROL_Estatus			INT 			NOT NULL,
    ROL_FechaRegistro	TIMESTAMP		NOT NULL
)ENGINE=innodb;

CREATE TABLE SAN_USUARIO (
    USU_ID 					INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    ROL_ID	 				INT NOT NULL,
    USU_Nombre 				NVARCHAR(50) NOT NULL,
    USU_ApellidoPaterno 	NVARCHAR(50) NOT NULL,
    USU_ApellidoMaterno 	NVARCHAR(50),
	USU_Municipio			NVARCHAR(60),
	USU_Estado				NVARCHAR(60),
    USU_Correo				NVARCHAR(80)	 NOT NULL,
	USU_Celular				VARCHAR(30),
    USU_Usuario 			NVARCHAR(50),
    USU_Contrasena 			NVARCHAR(50),
    USU_Estatus				INT				NOT NULL,
    USU_FechaRegistro 		TIMESTAMP		NOT NULL,
	-- LLAVE FORANEA
	FOREIGN KEY (ROL_ID) REFERENCES SAN_ROL(ROL_ID)
	ON DELETE CASCADE ON UPDATE CASCADE 
)ENGINE=innodb;

CREATE TABLE SAN_PRODUCTO
(
	ROD_ID					INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	ROD_Nombre				NVARCHAR(200) 	NOT NULL,
    ROD_Ingredientes		NVARCHAR(200)	NOT NULL,
	ROD_Descripcion			NVARCHAR(250) 	NOT NULL,
	ROD_Presentacion		NVARCHAR(250) 	NOT NULL,
	CAT_ID					INT				NOT NULL,
	ROD_SaborTipo			NVARCHAR(250) 	NOT NULL,
	ROD_Cantidad			INT			 	NOT NULL,
	ROD_GramosMil			NVARCHAR(250) 	NOT NULL,
	ROD_Precio				FLOAT		 	NOT NULL,
	ROD_ModoUso				NVARCHAR(250) 	NOT NULL,
	ROD_Estatus				INT				NOT NULL,
	ROD_Imagen				NVARCHAR(250) 	NOT NULL,
	ROD_Fecha				TIMESTAMP		NOT NULL,
	PRO_ID					INT				NOT NULL,
	FOREIGN KEY (CAT_ID) REFERENCES SAN_CATEGORIA(CAT_ID),
	FOREIGN KEY (PRO_ID) REFERENCES SAN_PROVEDDOR(PRO_ID)
	ON DELETE CASCADE ON UPDATE CASCADE 
)ENGINE=innodb;

-- TABLAS TRANSACCIONALES
-- USUARIO-PRODUCTO ---> COMPRA PARA EL USUARIO VENTA PARA LA EMPRESA
CREATE TABLE SAN_COMPRA
(
	COM_ID				INT	NOT NULL PRIMARY KEY AUTO_INCREMENT,
	USU_ID				INT	 	  		NOT NULL,
	COM_FechaCompra		TIMESTAMP		NOT NULL,
	COM_Total			FLOAT			NOT NULL,
	COM_Estatus			INT NOT NULL,
	COM_IVA				FLOAT NOT NULL,
	-- LLAVES FORANEAS
	FOREIGN KEY (USU_ID) REFERENCES SAN_USUARIO(USU_ID)
	ON DELETE CASCADE ON UPDATE CASCADE	
)ENGINE=innodb;

-- DETALLES DE LAS COMPRAS DE USUARIOS
CREATE TABLE SAN_DETALLE_COMPRA
(
	DET_ID				INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    DET_FechaPedido		DATE			NOT NULL,
    DET_Cantidad		INT				NOT NULL,
    DET_Total			FLOAT				NOT NULL,
    COM_ID				INT				NOT NULL,
    ROD_ID				INT 			NOT NULL,
    -- LLAVES FORANEAS
	FOREIGN KEY (COM_ID) REFERENCES SAN_COMPRA(COM_ID),
    FOREIGN KEY (ROD_ID) REFERENCES SAN_PRODUCTO(ROD_ID)
	ON DELETE CASCADE ON UPDATE CASCADE	    
)ENGINE=innodb;

-- INVENTARIO DE PRODUCTOS
CREATE TABLE SAN_INVENTARIO
(
	INV_ID				INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	ROD_ID				INT				NOT NULL,
	INV_Cantidad		INT				NOT NULL,
	-- LLAVES FORANEAS
	FOREIGN KEY (ROD_ID) REFERENCES SAN_PRODUCTO(ROD_ID)
	ON DELETE CASCADE ON UPDATE CASCADE 
)ENGINE=innodb;

-- INSERTAR REGISTROS
SHOW tables;

INSERT INTO SAN_CATEGORIA VALUES
(1, 'Nutricional', 1),
(2, 'Herbal', 1),
(3, 'Jabón', 1),
(4, 'Aceite esencial', 1),
(5, 'Nutricosmética', 1),
(6, 'Extracto', 1),
(7, 'Cápsula', 1),
(8, 'Kidz', 1),
(9, 'Caramelo', 1),
(10, 'Jarabe', 1),
(11, 'Kit familiar', 1),
(12, 'Óleo', 1),
(13, 'Biofacial', 1),
(14, 'Biofacial men', 1),
(15, 'BEMO', 1),
(16, 'Infusión', 1),
(17, 'Hogar', 1);

INSERT INTO SAN_PROVEDDOR VALUES
(NULL, 'Blen', 'CDMX', 'Gustavo A.Madero', 'México', '07720', '5616579516');

INSERT INTO SAN_ROL VALUES
(1, 'Administrador', 1, NOW()),
(2, 'Empleado', 1, NOW()),
(3, 'Cliente', 1, NOW());

INSERT INTO SAN_USUARIO VALUES
(1, 1, 'Ruth', 'Torres', 'Romero', 'Tizayuca', 'Mexico', '213111088@upmh.edu.mx', '5617162532', 'adminRuth', 'adminRuthP1', 1, NOW()),
(2, 1, 'Metztonalli', 'Lopez', 'Esquivel', 'Zapotlan', 'Chihuahua', '213111964@upmh.edu.mx', '7711191853', 'Metz', 'adminMetzP2', 1, NOW()),
(3, 1, 'Carla', 'Hernandez', 'Nuñez', 'Zapotlan', 'Chihuahua', '213110196@upmh.edu.mx', '7791249474', 'Carlita', 'adminCarlaP3', 1, NOW()),
(4, 1, 'Ariadne', 'Uvalle', 'Becerril', 'Zapotlan', 'Chihuahua', '213111718@upmh.edu.mx', '7711995115', 'Ari', 'adminAriP4', 1, NOW()),
(5, 2, 'Gabriela', 'Nuñez', 'Castillo', 'Zapotlan', 'Chihuahua', 'empleado1@gmail.com', '7714757573', 'Gaby', 'EmpleGaby', 1, NOW()),
(6, 2, 'Laura', 'Martin', 'Garcia', 'Tizayuca', 'México', 'empleado2@gmail.com', '5512751008', 'Laura', 'EmpleLaura', 1, NOW()),
(7, 3, 'Pedro', 'Hernández', 'Gonzalez', 'Tolcayuca', 'México', 'pedrito@gmail.com', '5523891945', 'Pedrin', '1234', 1, NOW()),
(8, 3, 'Juan', 'Rodríguez', 'García', 'Pachuca de Soto', 'Hidalgo', 'juanrodriguez@gmail.com', '7123456789', 'JuanRodriguez_124', 'A3b', 1, '2023-01-03 08:00:00'),
(9, 3, 'María', 'Pérez', 'Rodríguez', 'Monterrey', 'Nuevo León', 'mariaperez@gmail.com', '7212345678', 'MariaPerez_457', '9Xz2', 1, '2023-02-14 16:35:00'),
(10, 3, 'Pedro', 'González', 'López', 'Guadalajara', 'Jalisco', 'pedrogonzalez@gmail.com', '7345678912', 'PedroGonzalez_790', 'P1zQ', 1, '2023-03-29 14:15:00'),
(11, 3, 'Ana', 'Martínez', 'González', 'Tijuana', 'Baja California', 'anamartinez@gmail.com', '7489123456', 'AnaMartinez_322', 'd7KM', 0, '2023-04-30 07:20:00'),
(12, 3, 'Carlos', 'López', 'Pérez', 'Mérida', 'Yucatán', 'carloslopez@gmail.com', '7532109876', 'CarlosLopez_655', 'R8aE', 1, '2023-05-07 18:50:00'),
(13, 3, 'Laura', 'Sánchez', 'Martínez', 'Hermosillo', 'Sonora', 'laurasanchez@gmail.com', '7654321098', 'LauraSanchez_988', 'm2Lp', 0, '2023-06-18 13:25:00'),
(14, 3, 'Antonio', 'Torres', 'Fernández', 'Cancún', 'Quintana Roo', 'antoniotorres@gmail.com', '7698765432', 'AntonioTorres_235', 'sT4x', 1, '2023-07-21 22:10:00'),
(15, 3, 'Isabel', 'García', 'Sánchez', 'San Luis Potosí', 'San Luis Potosí', 'isabelgarcia@gmail.com', '7723456789', 'IsabelGarcia_568', '5dJZ', 1, '2023-08-11 09:30:00'),
(16, 3, 'José', 'Fernández', 'Ramírez', 'Morelia', 'Michoacán', 'josefernandez@gmail.com', '7812345670', 'JoseFernandez_891', 'h9Uq', 0, '2023-09-16 10:05:00'),
(17, 3, 'Carmen', 'González', 'Torres', 'Querétaro', 'Querétaro', 'carmengonzalez@gmail.com', '7923456781', 'CarmGonzalez_1235', 'C7wR', 1, '2023-10-29 19:15:00'),
(18, 3, 'Luis', 'Ramírez', 'Díaz', 'Tuxtla Gutiérrez', 'Chiapas', 'luisramirez@gmail.com', '7045678902', 'LuisRamirez_5679', 'Yp3Q', 1, '2023-11-15 15:55:00'),
(19, 3, 'Marta', 'Díaz', 'Vargas', 'Ciudad Juárez', 'Chihuahua', 'martadiaz@gmail.com', '7143210987', 'MartaDiaz_9013', '6fXzK', 1, '2023-12-01 12:40:00'),
(20, 3, 'Roberto', 'Castro', 'Morales', 'Cuernavaca', 'Morelos', 'robertocastro@gmail.com', '7256789012', 'RobertoCastro_3457', 'Gt5D', 0, '2023-01-23 20:30:00'),
(21, 3, 'Sofía', 'Moreno', 'Castro', 'Chilpancingo', 'Guerrero', 'sofiaramos@gmail.com', '7365432109', 'SofiaMoreno_7891', 'B2sN', 1, '2023-02-07 10:20:00'),
(22, 3, 'Manuel', 'Vargas', 'Romero', 'Toluca', 'Estado de México', 'manuelvargas@gmail.com', '7478901234', 'ManuelVargas_12346', 'L7cR', 1, '2023-03-02 08:45:00'),
(23, 3, 'Elena', 'Morales', 'Jiménez', 'Oaxaca de Juárez', 'Oaxaca', 'elenamorales@gmail.com', '7578901231', 'ElenaMorales_67891', 'i3VX', 1, '2023-04-14 17:50:00'),
(24, 3, 'Miguel', 'Jiménez', 'Herrera', 'Aguascalientes', 'Aguascalientes', 'migueljimenez@gmail.com', '7610987654', 'MigueJimenez_23457', 'oR9A', 0, '2023-05-08 14:00:00'),
(25, 3, 'Andrea', 'Romero', 'Cruz', 'Puebla', 'Puebla', 'andrearomero@gmail.com', '7743210987', 'AndreaRomero_78902', 'Wv8Z', 1, '2023-06-12 21:30:00'),
(26, 3, 'David', 'Herrera', 'Ortega', 'Xalapa', 'Veracruz', 'davidherrera@gmail.com', '7856789010', 'DavidHerrera_34568', '4kPT', 1, '2023-07-03 11:40:00'),
(27, 3, 'Patricia', 'Cruz', 'Ruiz', 'Saltillo', 'Coahuila', 'patriciacruz@gmail.com', '7910987654', 'PatriciaCruz_89013', 'u1QJ', 1, '2023-08-18 19:25:00'),
(28, 3, 'Francisco', 'Ortega', 'Molina', 'Durango', 'Durango', 'franciscoortega@gmail.com', '7023456789', 'FranciscoOrtega_12346', 'Zs7W', 0, '2023-09-22 07:50:00'),
(29, 3, 'Carolina', 'Ruiz', 'Flores', 'Zacatecas', 'Zacatecas', 'carolinaruiz@gmail.com', '7132109876', 'CarolinaRuiz_67891', 'eK9L', 1, '2023-10-05 15:05:00'),
(30, 3, 'Javier', 'Molina', 'Rojas', 'Colima', 'Colima', 'javiermolina@gmail.com', '7245678901', 'JavierMolina_23457', 'Q6fM', 1, '2023-11-09 12:10:00'),
(31, 3, 'Raquel', 'Herrera', 'Silva', 'La Paz', 'Baja California Sur', 'raquelherrera@gmail.com', '7354321098', 'RaquelHerrera_78902', 'HnV4', 1, '2023-12-25 17:45:00'),
(32, 3, 'Diego', 'Flores', 'Núñez', 'Campeche', 'Campeche', 'diegoflores@gmail.com', '7465432109', 'DiegoFlores_12346', 'Fd5I', 0, '2023-01-03 08:00:00'),
(33, 3, 'Beatriz', 'Rojas', 'Medina', 'Sinaloa', 'Sinaloa', 'beatrizrojas@gmail.com', '7578901234', 'BeatrizRojas_67891', 'x3GY', 1, '2023-02-28 14:45:00'),
(34, 3, 'Andrés', 'Silva', 'Paredes', 'Nayarit', 'Nayarit', 'andressilva@gmail.com', '7698765432', 'AndresSilva_23457', '8jLp', 1, '2023-03-10 10:15:00'),
(35, 3, 'Natalia', 'Núñez', 'Espinosa', 'Zacatecas', 'Zacatecas', 'natalianunez@gmail.com', '7777777777', 'NataliaNunez_78902', 'N4rO', 0, '2023-04-05 16:20:00'),
(36, 3, 'Guillermo', 'Medina', 'Mendoza', 'Ciudad Victoria', 'Tamaulipas', 'guillermomedina@gmail.com', '7888888888', 'GuilMedina_12346', 'T2Xq', 1, '2023-05-20 09:55:00');

INSERT INTO SAN_PRODUCTO VALUES
(1, 'Malteada 7 BENE', 'Avena, cocoa, mezcla de vitaminas y minerales, aminoácidos y achicoria.', 'Aporta energía para iniciar el día. Brinda vitaminas, minerales y fibra. Complementa la alimentación en personas veganas.', 'Polvo para diluir', 1, 'Cocoa Natural', 1, '15g', 29, 'Diluir un sobre en 250 ml de leche o lechada. Tomar por las mañanas.',1,'~/PRODUCTOS/1.png', now(),1),
(2, 'Formula 12 Herba DTX', 'Clorofila, alfalfa, perejil, apio, goji, aceite esencial de menta y aceite, esencia de hierbabuena.', 'Depura el organismo, obesidad, sobre peso, hígado graso, con escaso consumo de frutas y verduras. Activa órganos depurativos, elimina lo que el cuerpo no necesita.','Ampolleta', 1, 'Menta', 5, '10ml', 99, 'Diluir 20ml en 1 litro de agua.',1,'~/PRODUCTOS/2.png', now(),1),
(3, 'Formula 12 Herba DTX', 'Clorofila, alfalfa, perejil, apio, goji, aceite esencial de menta y aceite, esencia de hierbabuena.', 'Depura el organismo, obesidad, sobre peso, hígado graso, con escaso consumo de frutas y verduras. Activa órganos depurativos, elimina lo que el cuerpo no necesita.','Concentrado para diluir', 1, 'Menta', 1, '500ml', 319, 'Diluir 20ml en 1 litro de agua.',1,'~/PRODUCTOS/3.png', now(),1),
(4, 'Formula 07 SBT', 'Té verde, nopal, alga, espirulina, piña, lúpulo y L-carnitina.', 'Cuida el peso y favorece las evacuaciones, aporta energía previa al ejercicio. Activa órganos depurativos y elimina lo que el cuerpo no necesita, ayudando al control del peso.','Ampolleta', 1, 'Té verde', 5, '10ml', 99, 'Tomar 40ml /1L',1,'~/PRODUCTOS/4.png', now(),1),
(5, 'Formula 07 SBT', 'Té verde, nopal, alga, espirulina, piña, lúpulo y L-carnitina.', 'Cuida el peso y favorece las evacuaciones, aporta energía previa al ejercicio. Activa órganos depurativos y elimina lo que el cuerpo no necesita, ayudando al control del peso.','Concentrado para diluir', 1, 'Té verde', 1, '500ml', 319, 'Tomar 40ml /1L',1,'~/PRODUCTOS/5.png', now(),1),
(6, 'Formula 05 AG', 'Colágeno, ácido hialurónico, té verde, uva y frutos rojos.', 'Para la artritis o osteoartritis, dolor de ligamentos, tendones. Fortalecimiento de cabello, uñas, piel. Contiene propiedades que ayudan en el desgaste articular y apoya en la generación de colágeno.', 'Pastillas', 1, 'Arandano', 1, '15g', 36, 'Diluir un sobre en agua al día.',1,'~/PRODUCTOS/6.png', now(),1),
(7, 'Formula 05 AG', 'Colágeno, ácido hialurónico, té verde, uva y frutos rojos.', 'Para la artritis o osteoartritis, dolor de ligamentos, tendones. Fortalecimiento de cabello, uñas, piel. Contiene propiedades que ayudan en el desgaste articular y apoya en la generación de colágeno.','Pastillas', 1, 'Arandano', 15, '15g', 509, 'Diluir un sobre en agua al día.',1,'~/PRODUCTOS/7.png', now(),1),
(8, 'Formula 04 ATX', 'Noni, mangostán, goji, semilla de uva y arándanos.', 'Ayuda a la menopausia, andropausia, altos niveles de grasas en sangre, retrasa el envejecimiento. Tiene un efecto antienvejecimiento prematuro y ayuda a la regeneración y respiración de células.', 'Concentrado para diluir', 1, 'Frutos rojos', 1, '500ml', 364, 'Tomar 20ml 2 veces al día (antes del desayuno y cena).',1,'~/PRODUCTOS/8.png', now(),1),
(9, 'Shot invernal', 'Jengibre, hongo del tíbet y vitamina C.', 'Para personas inmunodeprimidas con gripa o resfriado común, con problemas respiratorios. Refuerza el sistema inmune para prevenir o tratar afecciones del sistema respiratorio.', 'Polvo para diluir', 1, 'Jengibre', 1, '10g', 17.5, 'Disolver un sobre en agua y tomar después de comida.',1,'~/PRODUCTOS/9.png', now(),1),
(10, 'Formula 18 coffee', 'Café arabico, té verde, hongo shitake y hongo melena de león.', 'Para despertar con un efecto estimulante. Contiene propiedades estimulantes y nutritivas que ayudan a brindar energía y bienestar.', 'Polvo para diluir', 1, 'Café arabico', 1, '5g', 19.9, 'Agregar un sobre en una taza con agua caliente (250ml)',1,'~/PRODUCTOS/10.png', now(),1),
(11, 'Formula 18 coffee', 'Café arabico, té verde, hongo shitake y hongo melena de león.', 'Para despertar con un efecto estimulante. Contiene propiedades estimulantes y nutritivas que ayudan a brindar energía y bienestar.','Polvo para diluir', 1, 'Café arabico', 10, '5g', 244, 'Agregar un sobre en una taza con agua caliente (250ml)',1,'~/PRODUCTOS/11.png', now(),1),
(12, 'Formula 06 Bio-P', 'Moringa, maracuya, hierba mate, jengibre, ginseng.', 'Para la mala nutrición o estres. Brinda un aporte de vitaminas y minerales para cubrir deficiencias.', 'Polvo para diluir', 1, 'Lima limón', 1, '7g', 17.5, 'Mezclar un sobre en agua o jugo.',1,'~/PRODUCTOS/12.png', now(),1),
(13, 'Formula 06 Bio-P', 'Moringa, maracuya, hierba mate, jengibre, ginseng.', 'Para la mala nutrición o estres. Brinda un aporte de vitaminas y minerales para cubrir deficiencias.', 'Polvo para diluir', 1, 'Lima limón', 10, '7g', 209, 'Mezclar un sobre en agua o jugo.',1,'~/PRODUCTOS/13.png', now(),1),
(14, 'Formula 16 fibra', 'Linaza, nopal, eneldo, chía, jengibre, hierbabuena, tomillo, melisa y té verde.', 'Alivia el estreñimiento, hemorroides o colitis. Efecto laxante leve y ayuda a calmar malestares intestinales estimulando el tránsito intestinal.', 'Polvo para diluir', 1, 'Piña', 1, '7g', 22, 'Tomar un sobre disuelto en un vaso de agua.',1,'~/PRODUCTOS/14.png', now(),1),
(15, 'Formula 16 fibra', 'Linaza, nopal, eneldo, chía, jengibre, hierbabuena, tomillo, melisa y té verde.', 'Alivia el estreñimiento, hemorroides o colitis. Efecto laxante leve y ayuda a calmar malestares intestinales estimulando el tránsito intestinal.', 'Polvo para diluir', 1, 'Piña', 1, '70g', 209, 'Tomar un sobre disuelto en un vaso de agua.',1,'~/PRODUCTOS/15.png', now(),1),
(16, 'Formula 15 FEM+PLUS', 'Flor y hojas de trébol rojo, cola de caballo, grosella negra.', 'Producto femenino para problemas hormonales, rendimiento, libido y fertilidad. Aporta elementos naturales, vitaminas y minerales que favorecen al rendimiento físico y mental durante el día, y la regeneración de tejidos en la noche.', 'Pastillas', 1, 'No especificado', 90, '500mg', 319, 'Dos cápsulas en el día y una en la noche.',1,'~/PRODUCTOS/16.png', now(),1),
(17, 'Formula 17 HOM+PLUS', 'Rhodiolina, maca, grosella y cola de caballo.', 'Producto masculino para fortalecer el organismo, aumenta rendimiento, libido y fertilidad. Aporta elementos naturales, vitaminas y minerales que favorecen el rendimiento físico y mental durante el día, y la regeneración de tejidos en la noche.', 'Pastillas', 1, 'No especificado', 90, '500mg', 319, 'Dos cápsulas en el día y una en la noche.',1,'~/PRODUCTOS/17.png', now(),1),
(18, 'Formula 01 AlgaSilicio', 'Silicio, alga espirulina y colágeno.', 'Para problemas tiroideos, hipertensión, artritis o osteoartritis. Ayuda a controlar grasas en sangre, problemas articulares y promueve la generación de colágeno.', 'Pastillas', 1, 'No especificado', 30, '220mg', 274, 'Tomar una tableta al día acompañado de alimento.',1,'~/PRODUCTOS/18.png', now(),1),
(19, 'Formula 08 SBT', 'Sacha inchi, quinoa, avena, proteína de chícharo.', 'Complementa un mal desayuno o cena. Snack nutritivo y completo, complementa la alimentación.', 'Polvo para diluir', 1, 'Chocolate', 1, '150g', 399, 'Agregar 1 1/2 cucharada (20gr) en 250ml. Licuar o agitar antes.',1,'~/PRODUCTOS/19.png', now(),1),
(20, 'Golden Milk', 'Cúrcuma, canela, jengibre, cardamomo, nuez moscada, flor de clavo, pimienta negra.', 'Aporta antioxidantes en la dieta diaria con propiedades antiinflamatorias que benefician a todo el organismo.', 'Polvo para diluir', 1, 'No especificado', 1, '65g', 254, 'Agregar 1 cda(3g) a una taza de leche tibia.',1,'~/PRODUCTOS/20.png', now(),1),
(21, 'Formula 03 BIO ALOE', 'Aloe vera, nopal y miel.', 'Para la gastritis o colitis, estreñimiento y reflujo. Contiene propiedades antiinflamatorias que ayudan al tracto digestivo y es una excelente fuente de fibra soluble.', 'Polvo para diluir', 1, 'Naranja', 5, '65g', 89, 'Disolver 20ml en un vaso de agua 2 veces al día.',1,'~/PRODUCTOS/21.png', now(),1),
(22, 'Formula 03 BIO ALOE', 'Aloe vera, nopal y miel.', 'Para la gastritis o colitis, estreñimiento y reflujo. Contiene propiedades antiinflamatorias que ayudan al tracto digestivo y es una excelente fuente de fibra soluble.', 'Concentrado para diluir', 1, 'Naranja', 1, '500ml', 279, 'Disolver 20ml en un vaso de agua 2 veces al día.',1,'~/PRODUCTOS/22.png', now(),1),
(23, 'Spray eucalipto y romero', 'Aceites esenciales, eucalipto y romero.', 'Para la congestión nasal, resfriados, gripa común, alergias y padecimientos respiratorios.', 'Spray', 2, 'No especificado', 1, '28ml', 79, 'Se aplica sobre la piel, en difusores, sahumerios, en pañuelos desechables y textiles.',1,'~/PRODUCTOS/23.png', now(),1),
(24, 'Spray eucalipto y romero', 'Aceites esenciales, eucalipto y romero.', 'Para la congestión nasal, resfriados, gripa común, alergias y padecimientos respiratorios.', 'Spray', 2, 'No especificado', 1, '120ml', 239, 'Se aplica sobre la piel, en difusores, sahumerios, en pañuelos desechables y textiles.',1,'~/PRODUCTOS/24.png', now(),1),
(25, 'Tónico Herbal', 'Árnica, caléndula, eucalipto, romero, menta, hamamelis, castaño de indias y manzanilla.', 'Antiinflamatorio y analgésico natural, para los dolores musculares, tendones o articulaciones, golpes, torceduras, dolor en nervio ciático, artritis y calambres.', 'Tónico', 2, 'No especificado', 1, '40ml', 75, 'Aplicar sobre área afectada y dar un masaje hasta absorber.',1,'~/PRODUCTOS/25.png', now(),1),
(26, 'Tónico Herbal', 'Árnica, caléndula, eucalipto, romero, menta, hamamelis, castaño de indias y manzanilla.', 'Antiinflamatorio y analgésico natural, para los dolores musculares, tendones o articulaciones, golpes, torceduras, dolor en nervio ciático, artritis y calambres.', 'Tónico', 2, 'No especificado', 1, '120ml', 239, 'Aplicar sobre área afectada y dar un masaje hasta absorber.',1,'~/PRODUCTOS/26.png', now(),1),
(27, 'Pomada Herbal', 'Árnica, caléndula, sauco, manzanilla, salvia, malva y menta.', 'Para dolores musculares, tendones y articulaciones, golpes o torceduras.', 'Pomada', 2, 'No especificado', 1, '60ml', 239, 'Aplicar en el área afectada dando un masaje para humectar la piel.',1,'~/PRODUCTOS/27.png', now(),1),
(28, 'Crema para piernas', 'Mamamelis, caléndula, manzanilla, malva, tilo, menta.', 'Para várices, retención de líquidos, pesadez, hinchazón o tensión corporal. Propiedades analgésicas, relajantes y humectantes que ayudan a disminuir la sensación de pesadez en piernas.', 'Crema', 2, 'No especificado', 1, '20ml', 64, 'Aplicar en piernas afectadas.',1,'~/PRODUCTOS/28.png', now(),1),
(29, 'Crema para piernas', 'Mamamelis, caléndula, manzanilla, malva, tilo, menta.', 'Para várices, retención de líquidos, pesadez, hinchazón o tensión corporal. Propiedades analgésicas, relajantes y humectantes que ayudan a disminuir la sensación de pesadez en piernas.', 'Crema', 2, 'No especificado', 1, '90ml', 264, 'Aplicar en piernas afectadas.',1,'~/PRODUCTOS/29.png', now(),1),
(30, 'Pomada Tepezcohuite', 'Tepezcohuite y caléndula', 'Trata cicatrices, manchas en la piel causadas por el sol, secuelas de acné, signos de edad.', 'Pomada', 2, 'No especificado', 1, '60ml', 149, 'Aplicar en áreas corporales afectadas, su uso nocturno brinda mejores resultados.',1,'~/PRODUCTOS/30.png', now(),1),
(31, 'Solución concentrada para uñas', 'Tea tree y toronja', 'Propiedades antisépticas y desinfectantes que ayudan a tratar microbios y bacterias acumuladas.', 'Solución', 2, 'No especificado', 1, '10ml', 179, 'Aplicar a lo largo de la uña, entre piel y dejar secar.',1,'~/PRODUCTOS/31.png', now(),1),
(32, 'Spray para pies', 'Neem, árbol de té, toronja, limón, eucalipto y tomillo.', 'Para sudoración excesiva, con síntomas de mal olor, piel roja, salpullido, picazón, ardor, dolor, ampollas, hongos. Tratamiento del pie de atleta.', 'Spray', 2, 'No especificado', 1, '120ml', 249, 'Aplicar en los pies afectados.',1,'~/PRODUCTOS/32.png', now(),1),
(33, 'Shampoo capilar', 'Hinoki, ortiga, pino, bardana.', 'Con propiedades que ayudan a controlar la caída del cabello causada por quiebre.', 'Shampoo', 2, 'No especificado', 1, '220ml', 289, 'Aplicar al inicio del baño y dejar actuar de 1-5 min.',1,'~/PRODUCTOS/33.png', now(),1),
(34, 'ATK Loción capilar', 'Extractos de romero, ortiga y jengibre.', 'Refuerza la estructura capilar y regenera nuevo cabello eliminando el exceso de sebo.', 'Locion', 2, 'No especificado', 1, '70ml', 379, 'Agítese antes de usar. Aplique 2-4 atomizaciones directamente en el cuero cabelludo sección por sección, se masajea el cuero cabelludo y dejar reposar 5 minutos.',1,'~/PRODUCTOS/34.png', now(),1),
(35, 'Desodorante', 'Sales naturales y salvia.', 'Para piel sensible, poro tapado, apoya funciones naturales de transpiración y mal olor.', 'Desodorante', 2, 'No especificado', 1, '70ml', 139, 'Aplicar sobre piel limpia y seca.',1,'~/PRODUCTOS/35.png', now(),1),
(36, 'Desodorante unisex', 'Sales naturales y salvia.', 'Para el mal olor y poro tapado, contiene propiedades antimicrobianas y antifúngicas que permiten a los poros respirar.', 'Desodorante', 2, 'No especificado', 1, '70ml', 139, 'Aplicar sobre piel limpia y seca.',1,'~/PRODUCTOS/36.png', now(),1),
(37, 'Notas masculinas', 'Sales naturales y salvia.', 'Propiedades limpiadoras profundas y olores cítricos que ayudan a neutralizar malos olores.', 'Desodorante', 2, 'No especificado', 1, '70ml', 139, 'Aplicar sobre piel limpia y seca.',1,'~/PRODUCTOS/37.png', now(),1),
(38, 'Aceite de almendras dulces', 'Almendras dulces.', 'Para piel desnutrida o deshidratada, cabello y piel opaca, con piel seca. Previene estrías, hidrata y suaviza todo tipo de pieles. Aporta brillo y sedosidad al cabello.', 'Aceite', 2, 'No especificado', 1, '60ml', 149, 'Aplicar sobre la piel o cabello dañado.',1,'~/PRODUCTOS/38.png', now(),1),
(39, 'Notas femeninas', 'Salvia, aceite de jazmín, lavanda y manzanilla.', 'Acción microbiana y antifúngica que protege y deja respirar al poro, dejando un agradable aroma.', 'Desodorante', 2, 'No especificado', 1, '70ml', 139, 'Aplicar sobre piel limpia y seca.',1,'~/PRODUCTOS/39.png', now(),1),
(40, 'Purificante de axilas', 'Sábila, limón, bardana, benzoína, tomillo, menta.', 'Antitranspirante, blanquea axilas con poros obstruidos por tóxicos. Limpia a profundidad eliminando residuos tóxicos.', 'Spray', 2, 'No especificado', 1, '60ml', 209, 'Usar antes del baño, aplicar en zona axilar y dejar secar.',1,'~/PRODUCTOS/40.png', now(),1),
(41, 'Jabon Artesanal Tea Tree', 'Tea tree.', 'Combate imperfecciones y controla el brillo facial.', 'Jabon', 3, 'No especificado', 1, '100g', 84, 'Auxiliar como jabón íntimo (mujeres). Uso facial y corporal.',1,'~/PRODUCTOS/41.png', now(),1),
(42, 'Jabon Artesanal leche de burra', 'Leche de burra.', 'Humecta y nutre la piel seca o sensible, protegiéndola del fotoenvejecimiento.', 'Jabon', 3, 'No especificado', 1, '100g', 84, 'Uso facial y corporal.',1,'~/PRODUCTOS/42.png', now(),1),
(43, 'Tepezcohuite', 'Tepezcohuite.', 'Ideal para pieles maduras por sus propiedades antioxidantes. Para quemaduras en la piel, cicatrices, manchas.', 'Jabon', 3, 'No especificado', 1, '100g', 74, 'Uso facial y corporal.',1,'~/PRODUCTOS/43.png', now(),1),
(44, 'Jabon Artesanal Carbón vegetal activado', 'Carbón vegetal.', 'Exfolia y purifica la piel de forma natural. Absorbe y retira impurezas.', 'Jabon', 3, 'No especificado', 1, '100g', 79, 'Uso facial y corporal.',1,'~/PRODUCTOS/44.png', now(),1),
(45, 'Jabon Artesanal frutos rojos', 'Frutos rojos.', 'Humecta y suaviza gracias a sus activos naturales, con un aroma único a frutos silvestres.', 'Jabon', 3, 'No especificado', 1, '100g', 69, 'Uso facial y corporal.',1,'~/PRODUCTOS/45.png', now(),1),
(46, 'Jabon Artesanal avena y miel', 'Avena y miel.', 'Humecta y da un efecto luminoso a la piel.', 'Jabon', 3, 'No especificado', 1, '100g', 74, 'Uso facial y corporal.',1,'~/PRODUCTOS/46.png', now(),1),
(47, 'Jabon Artesanal café y nuez', 'Café y nuez.', 'Exfoliante facial que ayuda a remover impurezas o células muertas y desodoriza el cuerpo.', 'Jabon', 3, 'No especificado', 1, '100g', 69, 'Uso facial y corporal.',1,'~/PRODUCTOS/47.png', now(),1),
(48, 'Shampoo ortiga y bergamota', 'Ortiga y bergamota.', 'Fortalece y ayuda al control de la caída, ideal para todo tipo de cabello. Rinde hasta 30 lavadas.', 'Shampoo en barra', 3, 'No especificado', 1, '55g', 209, 'Frota la barra sobre el cabello húmedo, dar masaje y enjuagar.',1,'~/PRODUCTOS/48.png', now(),1),
(49, 'Shampoo romenta', 'Romero y menta.', 'Ayuda a limpiar el cuero cabelludo por su efecto astringente. Rinde hasta 30 lavadas.', 'Shampoo en barra', 3, 'No especificado', 1, '55g', 209, 'Frotar la barra sobre el cabello húmedo de 2-4 veces según el largo, hacer espuma y enjuagar con abundante agua.',1,'~/PRODUCTOS/49.png', now(),1),
(50, 'Jabón Aloe Vera', 'Aloe Vera.', 'Interviene en el proceso de oxigenación de las células evitando su envejecimiento. Para irritaciones.', 'Jabon', 3, 'No especificado', 1, '100g', 69, 'Uso facial y corporal.',1,'~/PRODUCTOS/50.png', now(),1),
(51, 'Jabón Coco', 'Coco.', 'Interviene en la prevención del desarrollo de manchas y ayuda a reparar tejidos suavizando la piel. Para estrías y celulitis.', 'Jabon', 3, 'No especificado', 1, '100g', 69, 'Uso facial y corporal.',1,'~/PRODUCTOS/51.png', now(),1),
(52, 'Jabón Azufre', 'Azufre.', 'Actúa como potente desinfectante y ayuda a limpiar, exfoliar la piel de manera natural. Para piel grasa.', 'Jabon', 3, 'No especificado', 1, '100g', 84, 'Uso facial y corporal.',1,'~/PRODUCTOS/52.png', now(),1),
(53, 'Jabón Sandia Melón', 'Sandía y melón.', 'Brinda sensación de suavidad y humecta la piel naturalmente.', 'Jabon', 3, 'No especificado', 1, '100g', 69, 'Uso facial y corporal.',1,'~/PRODUCTOS/53.png', now(),1),
(54, 'Jabón caléndula, miel y manzanilla', 'Caléndula, miel y manzanilla.', 'Calmante, antiséptico y antiinflamatorio. Para piel irritada, alergias o heridas.', 'Jabon', 3, 'No especificado', 1, '100g', 74, 'Uso facial y corporal.',1,'~/PRODUCTOS/54.png', now(),1),
(55, 'Jabón romero', 'Romero.', 'Tratamiento de dolores musculares y reumáticos, interviene en la revitalización del sistema nervioso.', 'Jabon', 3, 'No especificado', 1, '100g', 74, 'Uso facial y corporal.',1,'~/PRODUCTOS/55.png', now(),1),
(56, 'Sinergia descanso', 'Lavanda, patchouli, manzanilla, geranio, pasiflora, naranja, mandarina, petitgrain y albahaca.', 'Auxilia en problemas de ansiedad, estrés, trastornos de sueño.', 'Spray', 4, 'No especificado', 1, '50ml', 284, 'Rociar en la piel exterior.',1,'~/PRODUCTOS/56.png', now(),1),
(57, 'Sinergia descanso', 'Lavanda, patchouli, manzanilla, geranio, pasiflora, naranja, mandarina, petitgrain y albahaca.', 'Auxilia en problemas de ansiedad, estrés, trastornos de sueño.', 'Roll on', 4, 'No especificado', 1, '10ml', 214, 'Aplicar directamente sobre zonas cálidas como sienes, muñecas y planta de los pies.',1,'~/PRODUCTOS/57.png', now(),1),
(58, 'Sinergia descanso', 'Lavanda, patchouli, manzanilla, geranio, pasiflora, naranja, mandarina, petitgrain y albahaca.', 'Auxilia en problemas de ansiedad, estrés, trastornos de sueño.', 'Aceite', 4, 'No especificado', 1, '10ml', 214, 'Aplicar directamente sobre zonas cálidas como sienes, muñecas y planta de los pies.',1,'~/PRODUCTOS/58.png', now(),1),
(59, 'Sinergia descanso', 'Lavanda, patchouli, manzanilla, geranio, pasiflora, naranja, mandarina, petitgrain y albahaca.', 'Auxilia en problemas de ansiedad, estrés, trastornos de sueño.', 'Aceite', 4, 'No especificado', 1, '5ml', 119, 'Aplicar directamente sobre zonas cálidas como sienes, muñecas y planta de los pies.',1,'~/PRODUCTOS/59.png', now(),1),
(60, 'Sinergia CD7', 'Albahaca, geranio, palmarosa, menta, eucalipto, manzanilla y lavanda.', 'Auxilia en problemas de dolores de cabeza y migrañas, tensión nerviosa/ansiedad.', 'Spray', 4, 'No especificado', 1, '50ml', 284, 'Rociar en la piel exterior.',1,'~/PRODUCTOS/60.png', now(),1),
(61, 'Sinergia CD7', 'Albahaca, geranio, palmarosa, menta, eucalipto, manzanilla y lavanda.', 'Auxilia en problemas de dolores de cabeza y migrañas, tensión nerviosa/ansiedad.', 'Roll on', 4, 'No especificado', 1, '10ml', 214, 'Aplicar directamente sobre zonas cálidas como sienes, muñecas y planta de los pies.',1,'~/PRODUCTOS/61.png', now(),1),
(62, 'Sinergia CD7', 'Albahaca, geranio, palmarosa, menta, eucalipto, manzanilla y lavanda.', 'Auxilia en problemas de dolores de cabeza y migrañas, tensión nerviosa/ansiedad.', 'Aceite', 4, 'No especificado', 1, '10ml', 214, 'Aplicar directamente sobre zonas cálidas como sienes, muñecas y planta de los pies.',1,'~/PRODUCTOS/62.png', now(),1),
(63, 'Sinergia CD7', 'Albahaca, geranio, palmarosa, menta, eucalipto, manzanilla y lavanda.', 'Auxilia en problemas de dolores de cabeza y migrañas, tensión nerviosa/ansiedad.', 'Aceite', 4, 'No especificado', 1, '5ml', 119, 'Aplicar directamente sobre zonas cálidas como sienes, muñecas y planta de los pies.',1,'~/PRODUCTOS/63.png', now(),1),
(64, 'Sinergia tomillo y bugambilia', 'Tomillo y bugambilia.', 'Auxilia en problemas de bronquios, infecciones/padecimientos respiratorios. Para sensibles al cambio climático.', 'Roll on', 4, 'No especificado', 1, '10ml', 214, 'Aplicar directamente sobre zonas cálidas como sienes, muñecas y planta de los pies.',1,'~/PRODUCTOS/64.png', now(),1),
(65, 'Sinergia tomillo y bugambilia', 'Tomillo y bugambilia.', 'Auxilia en problemas de bronquios, infecciones/padecimientos respiratorios. Para sensibles al cambio climático.', 'Pomada', 4, 'No especificado', 1, '60ml', 259, 'Aplicar directamente sobre zonas cálidas como sienes, muñecas y planta de los pies.',1,'~/PRODUCTOS/65.png', now(),1),
(66, 'Sinergia tomillo y bugambilia', 'Tomillo y bugambilia.', 'Auxilia en problemas de bronquios, infecciones/padecimientos respiratorios. Para sensibles al cambio climático.', 'Spray', 4, 'No especificado', 1, '50ml', 284, 'Aplicar directamente sobre zonas cálidas como sienes, muñecas y planta de los pies.',1,'~/PRODUCTOS/66.png', now(),1),
(67, 'Sinergia tomillo y bugambilia', 'Tomillo y bugambilia.', 'Auxilia en problemas de bronquios, infecciones/padecimientos respiratorios. Para sensibles al cambio climático.', 'Sobre', 4, 'No especificado', 1, '10g', 39, 'Aplicar directamente sobre zonas cálidas como sienes, muñecas y planta de los pies.',1,'~/PRODUCTOS/67.png', now(),1),
(68, 'Sinergia invernal', 'Eucalipto, romero, menta, clavo y tomillo.', 'Ayuda a prevenir la sensibilidad ante cambios de clima. Auxilia en problemas de asma, congestión nasal.', 'Pomada', 4, 'No especificado', 1, '60ml', 259, 'Aplicar directamente sobre zonas cálidas como sienes, muñecas y planta de los pies.',1,'~/PRODUCTOS/68.png', now(),1),
(69, 'Sinergia invernal', 'Eucalipto, romero, menta, clavo y tomillo.', 'Ayuda a prevenir la sensibilidad ante cambios de clima. Auxilia en problemas de asma, congestión nasal.', 'Spray', 4, 'No especificado', 1, '50ml', 284, 'Aplicar directamente sobre zonas cálidas como sienes, muñecas y planta de los pies.',1,'~/PRODUCTOS/69.png', now(),1),
(70, 'Sinergia invernal', 'Eucalipto, romero, menta, clavo y tomillo.', 'Ayuda a prevenir la sensibilidad ante cambios de clima. Auxilia en problemas de asma, congestión nasal.', 'Sobre', 4, 'No especificado', 1, '10g', 49, 'Aplicar directamente sobre zonas cálidas como sienes, muñecas y planta de los pies.',1,'~/PRODUCTOS/70.png', now(),1),
(71, 'Sinergia invernal', 'Eucalipto, romero, menta, clavo y tomillo.', 'Ayuda a prevenir la sensibilidad ante cambios de clima. Auxilia en problemas de asma, congestión nasal.', 'Aceite', 4, 'No especificado', 1, '10ml', 264, 'Aplicar directamente sobre zonas cálidas como sienes, muñecas y planta de los pies.',1,'~/PRODUCTOS/71.png', now(),1),
(72, 'Sinergia invernal', 'Eucalipto, romero, menta, clavo y tomillo.', 'Ayuda a prevenir la sensibilidad ante cambios de clima. Auxilia en problemas de asma, congestión nasal.', 'Aceite', 4, 'No especificado', 1, '5ml', 144, 'Aplicar directamente sobre zonas cálidas como sienes, muñecas y planta de los pies.',1,'~/PRODUCTOS/72.png', now(),1),
(73, 'Aceite esencial eucalipto', 'Eucalipto.', 'Contiene acciones antisépticas que ayudan a tratar afecciones de vías respiratorias y también ayuda a proveer oxígeno a la sangre.', 'Aceite', 4, 'No especificado', 1, '10ml', 209, 'Ingesta 2 gotas. Sahumerio de 5 a 8 gotas. Difusor 12 gotas.',1,'~/PRODUCTOS/73.png', now(),1),
(74, 'Aceite esencial eucalipto', 'Eucalipto.', 'Contiene acciones antisépticas que ayudan a tratar afecciones de vías respiratorias y también ayuda a proveer oxígeno a la sangre.', 'Aceite', 4, 'No especificado', 1, '5ml', 129, 'Ingesta 2 gotas. Sahumerio de 5 a 8 gotas. Difusor 12 gotas.',1,'~/PRODUCTOS/74.png', now(),1),
(75, 'Aceite esencial menta', 'Menta', 'Propiedades expectorantes, analgésicas y antisépticas que ayudan a tratar dolores y eliminar tensiones nerviosas. Auxilia dolores de cabeza, náuseas y mareos, problemas respiratorios.', 'Aceite', 4, 'No especificado', 1, '10ml', 214, 'Ingesta 2 gotas. Sahumerio de 5 a 8 gotas. Difusor 12 gotas.',1,'~/PRODUCTOS/75.png', now(),1),
(76, 'Aceite esencial menta', 'Menta', 'Propiedades expectorantes, analgésicas y antisépticas que ayudan a tratar dolores y eliminar tensiones nerviosas. Auxilia dolores de cabeza, náuseas y mareos, problemas respiratorios.', 'Aceite', 4, 'No especificado', 1, '5ml', 129, 'Ingesta 2 gotas. Sahumerio de 5 a 8 gotas. Difusor 12 gotas.',1,'~/PRODUCTOS/76.png', now(),1),
(77, 'Aceite esencial tea tree', 'Tea tree.', 'Propiedades antimicrobianas, favorece cicatrización de heridas y regulación de la producción de sebo. Auxilia problemas de acné, afecciones dermatológicas, pie de atleta.', 'Aceite', 4, 'No especificado', 1, '10ml', 264, 'No ingesta, aplicación directa 2 gotas.',1,'~/PRODUCTOS/77.png', now(),1),
(78, 'Aceite esencial tea tree', 'Tea tree.', 'Propiedades antimicrobianas, favorece cicatrización de heridas y regulación de la producción de sebo. Auxilia problemas de acné, afecciones dermatológicas, pie de atleta.', 'Aceite', 4, 'No especificado', 1, '5ml', 149, 'No ingesta, aplicación directa 2 gotas.',1,'~/PRODUCTOS/78.png', now(),1),
(79, 'Aceite esencial lavanda', 'Lavanda.', 'Contiene propiedades antiinflamatorias y relajantes que ayudan a tratar heridas o quemaduras, brinda sensación de alivio. Auxilia en ansiedad, tensión nerviosa, quemaduras, heridas leves.', 'Aceite', 4, 'No especificado', 1, '10ml', 354, 'Ingesta 2 gotas. Sahumerio de 5 a 8 gotas. Difusor 12 gotas.',1,'~/PRODUCTOS/79.png', now(),1),
(80, 'Aceite esencial lavanda', 'Lavanda.', 'Contiene propiedades antiinflamatorias y relajantes que ayudan a tratar heridas o quemaduras, brinda sensación de alivio. Auxilia en ansiedad, tensión nerviosa, quemaduras, heridas leves.', 'Aceite', 4, 'No especificado', 1, '5ml', 209, 'Ingesta 2 gotas. Sahumerio de 5 a 8 gotas. Difusor 12 gotas.',1,'~/PRODUCTOS/80.png', now(),1),
(81, 'Sinergia E3', 'Lavanda, bergamota, mejorana, naranja, mandarina, menta y geranio.', 'Auxilia en problemas de ansiedad, fatiga crónica y estrés.', 'Roll on', 4, 'No especificado', 1, '10ml', 214, 'Aplicar directamente sobre zonas cálidas como sienes, muñecas, y planta de los pies.',1,'~/PRODUCTOS/81.png', now(),1),
(82, 'Sinergia E3', 'Lavanda, bergamota, mejorana, naranja, mandarina, menta y geranio.', 'Auxilia en problemas de ansiedad, fatiga crónica y estrés.', 'Spray', 4, 'No especificado', 1, '50ml', 279, 'Aplicar directamente sobre zonas cálidas como sienes, muñecas, y planta de los pies.',1,'~/PRODUCTOS/82.png', now(),1),
(83, 'Sinergia E3', 'Lavanda, bergamota, mejorana, naranja, mandarina, menta y geranio.', 'Auxilia en problemas de ansiedad, fatiga crónica y estrés.', 'Aceite', 4, 'No especificado', 1, '10ml', 214, 'Aplicar directamente sobre zonas cálidas como sienes, muñecas, y planta de los pies.',1,'~/PRODUCTOS/83.png', now(),1),
(84, 'Sinergia Enfoque', 'Bergamota, limón y romero.', 'Especial para estudiantes y trabajadores con falta de concentración y desempeño mental, estrés laboral y problemas de atención.', 'Spray', 4, 'No especificado', 1, '50ml', 284, 'Aplicar directamente sobre zonas cálidas como sienes, muñecas, y planta de los pies.',1,'~/PRODUCTOS/84.png', now(),1),
(85, 'Sinergia Enfoque', 'Bergamota, limón y romero.', 'Especial para estudiantes y trabajadores con falta de concentración y desempeño mental, estrés laboral y problemas de atención.', 'Roll on', 4, 'No especificado', 1, '10ml', 214, 'Aplicar directamente sobre zonas cálidas como sienes, muñecas, y planta de los pies.',1,'~/PRODUCTOS/85.png', now(),1),
(86, 'Sinergia Enfoque', 'Bergamota, limón y romero.', 'Especial para estudiantes y trabajadores con falta de concentración y desempeño mental, estrés laboral y problemas de atención.', 'Aceite', 4, 'No especificado', 1, '10ml', 214, 'Aplicar directamente sobre zonas cálidas como sienes, muñecas, y planta de los pies.',1,'~/PRODUCTOS/86.png', now(),1),
(87, 'Solución bucal', 'Clavo y romero.', 'Contiene propiedades antisépticas y analgésicas que ayudan en dolor de muelas, aftas o inflamación de encías.', 'Solucion', 4, 'No especificado', 1, '30ml', 169, '2 gotas 4 veces al día.',1,'~/PRODUCTOS/87.png', now(),1),
(88, 'Enjuague bucal', 'Menta, hierbabuena, limón y clavo.', 'Auxilia con inflamación en encías y mal aliento.', 'Enjuague', 4, 'No especificado', 1, '250ml', 249, 'Usar después de cepillar los dientes.',1,'~/PRODUCTOS/88.png', now(),1),
(89, 'Aliento fresco', 'Menta y eucalipto.', 'Auxilia en problemas de mal aliento, mala higiene bucal.', 'Aceite', 4, 'No especificado', 1, '30ml', 169, 'Agitar varias veces para homogenizar la toma. Adultos 2 gotas 4 veces al día. Niños mayores de 2 años tomar 2 gotas 3 veces al día. No tomar mujeres embarazadas o en período de lactancia.',1,'~/PRODUCTOS/89.png', now(),1),
(90, 'Aliento fresco', 'Menta y eucalipto.', 'Auxilia en problemas de mal aliento, mala higiene bucal.', 'Aceite', 4, 'No especificado', 1, '5ml', 54, 'Agitar varias veces para homogenizar la toma. Adultos 2 gotas 4 veces al día. Niños mayores de 2 años tomar 2 gotas 3 veces al día. No tomar mujeres embarazadas o en período de lactancia.',1,'~/PRODUCTOS/90.png', now(),1),
(91, 'Sinergia amor y pareja', 'Lavanda, geranio, ylang ylang, naranja, canela china, palmarosa y patchouli.', 'Efecto relajante afrodisiaco. Auxilia en problemas de pareja, irritabilidad en el matrimonio.', 'Spray', 4, 'No especificado', 1, '50ml', 279, 'Aplicar directamente sobre zonas cálidas como sienes, muñecas, y planta de los pies.',1,'~/PRODUCTOS/91.png', now(),1),
(92, 'Sinergia amor y pareja', 'Lavanda, geranio, ylang ylang, naranja, canela china, palmarosa y patchouli.', 'Efecto relajante afrodisiaco. Auxilia en problemas de pareja, irritabilidad en el matrimonio.', 'Roll on', 4, 'No especificado', 1, '10ml', 214, 'Aplicar directamente sobre zonas cálidas como sienes, muñecas, y planta de los pies.',1,'~/PRODUCTOS/92.png', now(),1),
(93, 'Sinergia amor y pareja', 'Lavanda, geranio, ylang ylang, naranja, canela china, palmarosa y patchouli.', 'Efecto relajante afrodisiaco. Auxilia en problemas de pareja, irritabilidad en el matrimonio.', 'Aceite', 4, 'No especificado', 1, '10ml', 214, 'Aplicar directamente sobre zonas cálidas como sienes, muñecas, y planta de los pies.',1,'~/PRODUCTOS/93.png', now(),1),
(94, 'Sinergia mujer', 'Salvia, menta y geranio.', 'Auxilia en problemas hormonales, pre y menopausia.', 'Spray', 4, 'No especificado', 1, '50ml', 284, 'Aplicar directamente sobre zonas cálidas como sienes, muñecas, y planta de los pies.',1,'~/PRODUCTOS/94.png', now(),1),
(95, 'Sinergia mujer', 'Salvia, menta y geranio.', 'Auxilia en problemas hormonales, pre y menopausia.', 'Roll on', 4, 'No especificado', 1, '10ml', 214, 'Aplicar directamente sobre zonas cálidas como sienes, muñecas, y planta de los pies.',1,'~/PRODUCTOS/95.png', now(),1),
(96, 'Sinergia mujer', 'Salvia, menta y geranio.', 'Auxilia en problemas hormonales, pre y menopausia.', 'Aceite', 4, 'No especificado', 1, '10ml', 214, 'Aplicar directamente sobre zonas cálidas como sienes, muñecas, y planta de los pies.',1,'~/PRODUCTOS/96.png', now(),1);

INSERT INTO SAN_INVENTARIO VALUES
(1, 1, 100),
(2, 2, 100),
(3, 3, 100),
(4, 4, 100),
(5, 5, 100),
(6, 6, 100),
(7, 7, 100),
(8, 8, 100),
(9, 9, 100),
(10, 10, 100),
(11, 11, 100),
(12, 12, 100),
(13, 13, 100),
(14, 14, 100),
(15, 15, 100),
(16, 16, 100),
(17, 17, 100),
(18, 18, 100),
(19, 19, 100),
(20, 20, 100),
(21, 21, 100),
(22, 22, 100),
(23, 23, 100),
(24, 24, 100),
(25, 25, 100),
(26, 26, 100),
(27, 27, 100),
(28, 28, 100),
(29, 29, 100),
(30, 30, 100),
(31, 31, 100),
(32, 32, 100),
(33, 33, 100),
(34, 34, 100),
(35, 35, 100),
(36, 36, 100),
(37, 37, 100),
(38, 38, 100),
(39, 39, 100),
(40, 40, 100),
(41, 41, 100),
(42, 42, 100),
(43, 43, 100),
(44, 44, 100),
(45, 45, 100),
(46, 46, 100),
(47, 47, 100),
(48, 48, 100),
(49, 49, 100),
(50, 50, 100),
(51, 51, 100),
(52, 52, 100),
(53, 53, 100),
(54, 54, 100),
(55, 55, 100),
(56, 56, 100),
(57, 57, 100),
(58, 58, 100),
(59, 59, 100),
(60, 60, 100),
(61, 61, 100),
(62, 62, 100),
(63, 63, 100),
(64, 64, 100),
(65, 65, 100),
(66, 66, 100),
(67, 67, 100),
(68, 68, 100),
(69, 69, 100),
(70, 70, 100),
(71, 71, 100),
(72, 72, 100),
(73, 73, 100),
(74, 74, 100),
(75, 75, 100),
(76, 76, 100),
(77, 77, 100),
(78, 78, 100),
(79, 79, 100),
(80, 80, 100),
(81, 81, 100),
(82, 82, 100),
(83, 83, 100),
(84, 84, 100),
(85, 85, 100),
(86, 86, 100),
(87, 87, 100),
(88, 88, 100),
(89, 89, 100),
(90, 90, 100),
(91, 91, 100),
(92, 92, 100),
(93, 93, 100),
(94, 94, 100),
(95, 95,100),
(96,96,100);

-- SELECTS DE TABLAS
-- SELECT * FROM SAN_CATEGORIA;
-- SELECT * FROM SAN_PROVEDDOR;
-- SELECT * FROM SAN_ROL;
-- SELECT * FROM SAN_USUARIO;
-- SELECT * FROM SAN_PRODUCTO;
-- SELECT * FROM SAN_COMPRA;
-- SELECT * FROM SAN_DETALLE_COMPRA;
-- SELECT * FROM SAN_INVENTARIO;

-- PROCEDIMIENTO PARA VALIDAR ACCESO
-- tsp y nombre de proceso para que vaya directo a la base de datos

-- DROP PROCEDURE tspValidarAccesoSanaT;
DELIMITER $$
CREATE PROCEDURE tspValidarAccesoSanaT
(
IN USU VARCHAR(20), 
IN CONTRA VARCHAR(20)
)
BEGIN
IF EXISTS(SELECT * FROM SAN_USUARIO WHERE USU_Usuario=USU AND USU_Contrasena=CONTRA
		  AND USU_Estatus=1)THEN
	SELECT A.USU_ID id,
				CONCAT(A.USU_Nombre, ' ', A.USU_ApellidoPaterno, ' ', A.USU_ApellidoMaterno) USUARIO,
				B.ROL_Nombre ROL
	FROM SAN_USUARIO A, SAN_ROL B
    WHERE A.USU_Usuario=USU
    AND A.USU_Contrasena=CONTRA
    AND A.ROL_ID=B.ROL_ID
    AND A.USU_Estatus=1;
ELSE
	SELECT 0 CLAVE;
END IF;
END $$
delimiter ;
-- CALL tspValidarAccesoSanaT('AndreaRomero_78902', 'Wv8Z');

-- drop procedure spListarCompras;
DELIMITER //
CREATE PROCEDURE spListarCompras(IN nombreUsuario NVARCHAR(50))
BEGIN
	DECLARE ID INT;
    -- Obtener el ID del usuario a partir del nombre
    SELECT USU_ID INTO ID
    FROM SAN_USUARIO
    WHERE USU_Nombre = nombreUsuario;
    IF ID IS NOT NULL THEN
        -- Listar las compras anteriores del usuario
		SELECT SAN_COMPRA.COM_ID, SAN_COMPRA.COM_FechaCompra, SAN_DETALLE_COMPRA.ROD_ID, SAN_PRODUCTO.ROD_Nombre, SAN_DETALLE_COMPRA.DET_Cantidad, SAN_DETALLE_COMPRA.DET_Total
        FROM SAN_COMPRA
        JOIN SAN_DETALLE_COMPRA ON SAN_COMPRA.COM_ID = SAN_DETALLE_COMPRA.COM_ID
        JOIN SAN_PRODUCTO ON SAN_DETALLE_COMPRA.ROD_ID = SAN_PRODUCTO.ROD_ID
        WHERE SAN_COMPRA.USU_ID = ID;
    ELSE
        SELECT '0' AS Mensaje;
    END IF;
END //
DELIMITER ;
-- CALL spListarCompras('AndreaRomero_78902');

-- drop procedure spListarUsuarios;
DELIMITER //
CREATE PROCEDURE spListarUsuarios(
    IN OP INT,
    IN clave INT
)
BEGIN 
    IF OP = 0 THEN
        SELECT A.USU_ID, A.USU_Nombre, A.USU_ApellidoPaterno, A.USU_ApellidoMaterno, A.USU_Usuario, A.USU_Contrasena, A.USU_Correo, A.USU_Celular,
            B.ROL_Nombre, A.USU_Estatus, A.USU_FechaRegistro
        FROM SAN_USUARIO A
        JOIN SAN_ROL B ON A.ROL_ID = B.ROL_ID
        ORDER BY USU_ID;
    ELSE
        SELECT A.USU_ID, A.USU_Nombre, A.USU_ApellidoPaterno, A.USU_ApellidoMaterno, A.USU_Usuario, A.USU_Contrasena, A.USU_Correo, A.USU_Celular,
            B.ROL_Nombre, A.USU_Estatus, A.USU_FechaRegistro
        FROM SAN_USUARIO A
        JOIN SAN_ROL B ON A.ROL_ID = B.ROL_ID
        WHERE A.USU_ID = clave;
    END IF;
END //
delimiter ;
-- CALL spListarUsuarios(0,25);

-- drop procedure tspListarUsuarios1;
DELIMITER //
CREATE PROCEDURE tspListarUsuarios1
(
	IN OP INT,
    IN clave INT
)
BEGIN 
	IF OP=0 THEN
		SELECT A.USU_ID,
			CONCAT(A.USU_Nombre, ' ', A.USU_ApellidoPaterno, ' ', A.USU_ApellidoMaterno) USUARIO, 
			B.ROL_Nombre ROL,
			IF (A.USU_Estatus=1, 'ACTIVO', 'INACTIVO') VIGENTE
		FROM SAN_USUARIO A, SAN_ROL B
        WHERE A.ROL_ID=B.ROL_ID
        ORDER BY CLAVE;
	ELSE
		SELECT A.USU_ID, B.ROL_Nombre, A.USU_Nombre,
			   A.USU_ApellidoPaterno, A.USU_ApellidoMaterno,
               A.USU_Municipio, A.USU_Estado, A.USU_Correo,
               A.USU_Celular, A.USU_Usuario, A.USU_Contrasena,
               A.USU_Estatus, A.USU_FechaRegistro
		FROM SAN_USUARIO A, SAN_ROL B
        WHERE A.ROL_ID=B.ROL_ID
        AND A.USU_ID=clave;
	END IF;
END //
delimiter ;
-- CALL tspListarUsuarios1(1,2);

-- drop procedure spMostrarVentasCliente;
DELIMITER //
CREATE PROCEDURE spMostrarVentasCliente(
    IN clave INT
)
BEGIN
    IF EXISTS (SELECT USU_ID FROM SAN_COMPRA WHERE USU_ID = clave) THEN
        SELECT A.COM_ID as ClaveCompra, A.USU_ID ClaveCliente,
            CONCAT(B.USU_Nombre, ' ', B.USU_ApellidoPaterno, ' ', B.USU_ApellidoMaterno) Cliente,
            CONCAT(B.USU_Municipio, ', ', B.USU_Estado) Direccion,
            DATE_FORMAT(A.COM_FechaCompra, '%d %M %Y') FechaCompra, A.COM_Total Total,
            CASE
                WHEN A.COM_Estatus =1 THEN "EN PROCESO"
                WHEN A.COM_Estatus =2 THEN "CONFIRMADA"
                ELSE "CANCELADA"
            END Estatus
        FROM SAN_COMPRA A
        JOIN SAN_USUARIO B ON A.USU_ID = B.USU_ID
        WHERE A.USU_ID = clave
        ORDER BY ClaveCompra DESC;
    ELSE 
        SELECT CAST(0 AS UNSIGNED) as ClaveCompra;
    END IF;
END //
DELIMITER ;
-- CALL spMostrarVentasCliente(26);

-- drop procedure spRegistrarNuevaVenta;
DELIMITER //
CREATE PROCEDURE spRegistrarNuevaVenta
(
	IN claveUsuario INT,
    IN total FLOAT
)
BEGIN
	INSERT INTO SAN_COMPRA VALUES(null, claveUsuario, now(), total,1,0);
    SELECT MAX(COM_ID)
    FROM SAN_COMPRA;
END //
DELIMITER ;
-- CALL spRegistrarNuevaVenta(26,0);

-- drop procedure spProductosComprar;
DELIMITER //
CREATE PROCEDURE spProductosComprar()
BEGIN
	SELECT A.ROD_ID Clave, A.ROD_Imagen Imagen, A.ROD_Nombre Productos, A.ROD_Ingredientes Ingredientes, A.ROD_Descripcion 
	Descripcion, A.ROD_Presentacion Presentacion, A.ROD_SaborTipo SaborTipo, 
	A.ROD_GramosMil GramosMililitros, A.ROD_ModoUso ModoUso, 
	E.INV_Cantidad Existencias,A.ROD_Precio Costo
    FROM SAN_PRODUCTO A, SAN_INVENTARIO E
    WHERE A.ROD_Estatus = 1
	AND E.ROD_ID=A.ROD_ID
	ORDER BY A.ROD_ID;
	
END //
DELIMITER ;
-- CALL spProductosComprar();

-- drop procedure spProductosAdmin;
DELIMITER //
CREATE PROCEDURE spProductosAdmin()
BEGIN
	SELECT A.ROD_ID Clave, A.ROD_Imagen Imagen, A.ROD_Nombre Productos, A.ROD_Ingredientes Ingredientes, A.ROD_Descripcion 
	Descripcion, A.ROD_Presentacion Presentacion, A.ROD_SaborTipo SaborTipo, 
	A.ROD_GramosMil GramosMililitros, A.ROD_ModoUso ModoUso, 
	E.INV_Cantidad Existencias,A.ROD_Precio Costo, B.PRO_Nombre Proveedor
    FROM SAN_PRODUCTO A, SAN_INVENTARIO E, SAN_PROVEDDOR B
    WHERE A.ROD_Estatus = 1
	AND E.ROD_ID=A.ROD_ID
	AND B.PRO_ID=A.PRO_ID
	ORDER BY A.ROD_ID;
	
END //
DELIMITER ;
-- CALL spProductosAdmin();

-- drop procedure spRegistrarDetalleCompra;
delimiter $$
CREATE  PROCEDURE spRegistrarDetalleCompra
(IN claveCompra 	INT,
 IN claveProducto 	INT,
 IN cantidad 		INT,
 IN subtotal	 	FLOAT)
BEGIN
   INSERT INTO SAN_DETALLE_COMPRA VALUES(null,now(),cantidad,subtotal,claveCompra,claveProducto); 

   UPDATE SAN_INVENTARIO
   SET INV_Cantidad=INV_Cantidad-cantidad
   WHERE ROD_ID=claveProducto
   AND INV_Cantidad>=cantidad;  
   
   SELECT '0';
END $$
delimiter ;
-- CALL spRegistrarDetalleCompra(26,1,2,50);

-- drop procedure spDetalleCompraActual;
DELIMITER $$
CREATE PROCEDURE spDetalleCompraActual 
(
	IN claveCompra INT
)
BEGIN
SELECT A.COM_ID CveCompra,A.ROD_ID CveProducto,
	B.ROD_Nombre Productos,A.DET_Cantidad UnidadesCompradas,
	B.ROD_Presentacion, B.ROD_Precio PrecioUnidad, A.DET_Total TotalxUnidades
  FROM SAN_DETALLE_COMPRA A, SAN_PRODUCTO B
  WHERE A.COM_ID=claveCompra
  AND   A.ROD_ID=B.ROD_ID;
END $$
DELIMITER ;
-- CALL spDetalleCompraActual(26);

-- drop procedure spEliminarProductoCompra;
delimiter $$
CREATE PROCEDURE spEliminarProductoCompra
(
	IN claveVenta    	INT,
	IN claveProducto	INT,
	IN cantidad		  	INT
)
BEGIN
  DELETE FROM SAN_DETALLE_COMPRA
  WHERE COM_ID=claveVenta
  AND ROD_ID=claveProducto
  AND DET_Cantidad=cantidad;
    
  UPDATE SAN_INVENTARIO
  SET INV_Cantidad=INV_Cantidad+cantidad
  WHERE ROD_ID=claveProducto;
  
  SELECT '1';
END $$
delimiter ;
-- CALL spEliminarProductoCompra(26,1,2);

-- drop procedure spConfirmarVenta;
DELIMITER //
CREATE PROCEDURE spConfirmarVenta
(
	IN claveVenta	INT,
	IN total		FLOAT
)
BEGIN
	UPDATE SAN_COMPRA
	SET COM_IVA=(total*0.16),COM_Total=total+(total*0.16), COM_Estatus=2
	WHERE COM_ID=claveVenta;
	SELECT '1'; 
END //
delimiter ;

-- drop procedure spListarDatosUsuario;
DELIMITER //
CREATE PROCEDURE spListarDatosUsuario
(
	IN claveUsuario INT
)
BEGIN
	SELECT USU_ID ID, concat(USU_Nombre, ' ' ,USU_ApellidoPaterno, ' ' ,USU_ApellidoMaterno) NombreCompleto,
	USU_Usuario NombreUsuario, USU_Municipio Municipio, USU_Estado Estado, USU_Correo Correo, 
	USU_Celular NumTelefonico, USU_FechaRegistro FechaRegistro
	FROM SAN_USUARIO 
	WHERE USU_ID=claveUsuario;
END //
DELIMITER ;
-- CALL spListarDatosUsuario(25);

-- drop procedure spCancelarVenta;
DELIMITER //
CREATE PROCEDURE spCancelarVenta
(
	IN claveVenta INT
)
BEGIN
	UPDATE SAN_COMPRA
	SET COM_Estatus=3
	WHERE COM_ID=claveVenta;
	SELECT '1';
END //
DELIMITER ;

-- drop procedure spCerrarCarrito;
DELIMITER //
CREATE PROCEDURE spCerrarCarrito
(
	IN claveVenta INT
)
BEGIN
	UPDATE SAN_COMPRA
	SET COM_Estatus=1
	WHERE COM_ID=claveVenta;
	SELECT '1';
END //
DELIMITER ;

-- drop procedure spRegistrarProducto;
DELIMITER //
CREATE PROCEDURE spRegistrarProducto
(
	IN ID 		INT,
	IN PROVEDOR	INT,
	IN NOMBRE	NVARCHAR(200),
	IN INGREDIE	NVARCHAR(250),
	IN DESCRIP	NVARCHAR(250),
	IN PRESENT	NVARCHAR(250),
	IN CATEGOR	INT,
	IN SABTIPO	NVARCHAR(250),
	IN CANTIDA	INT,
	IN GRAMMIL	NVARCHAR(250),
	IN COSTO	FLOAT,
	IN MODUSO	NVARCHAR(250),
	IN IMAGEN	NVARCHAR(250)
)
BEGIN
	INSERT INTO SAN_PRODUCTO VALUES(ID,NOMBRE,INGREDIE,DESCRIP,PRESENT,CATEGOR,SABTIPO,CANTIDA,GRAMMIL,
	COSTO,MODUSO,1,IMAGEN,NOW(),PROVEDOR);
	INSERT INTO SAN_INVENTARIO(ROD_ID, INV_Cantidad) VALUES(ID,0);
END //
DELIMITER ;

-- drop procedure spProductosTodos;
delimiter //
CREATE PROCEDURE spProductosTodos()
BEGIN

  SELECT ROD_Id Clave,ROD_Nombre Productos,ROD_Ingredientes Ingredientes, ROD_Descripcion Descripcion,
	   ROD_Presentacion Presentacion, ROD_SaborTipo SaborTipo, ROD_Cantidad Cantidad, 
	   ROD_GramosMil GramosMililitros,ROD_Precio Costo, ROD_ModoUso ModoUso, ROD_Imagen Imagen,  
	   if(ROD_Estatus=1, "ACTIVO","INACTIVO") ESTATUS, DATE_FORMAT(ROD_Fecha,'%d %M %Y') Fecha
  FROM SAN_PRODUCTO  
  ORDER BY Clave;
END //
DELIMITER ;
-- call spProductosTodos();

-- drop procedure spReporteVentasCliente;
DELIMITER //
CREATE PROCEDURE spReporteVentasCliente(IN ID INT)
BEGIN
    SELECT V.COM_ID Clave, B.USU_Nombre Usuario, DATE_FORMAT(V.COM_FechaCompra,'%d %M %Y') Fecha, 
	V.COM_Total Total, V.COM_IVA IVA,
	CASE
		WHEN V.COM_Estatus =1 THEN "EN PROCESO"
        WHEN V.COM_Estatus =2 THEN "CONFIRMADA"
		ELSE "CANCELADA"
	END Estatus
    FROM SAN_COMPRA V, SAN_USUARIO B
    WHERE V.USU_ID = ID
	AND V.USU_ID=B.USU_ID
	AND B.USU_ID=ID;
END //
DELIMITER ;
-- CALL spReporteVentasCliente(25);

-- drop procedure spReporteVentasTodos;
DELIMITER //
CREATE PROCEDURE spReporteVentasTodos()
BEGIN
    SELECT V.COM_ID Clave, B.USU_Nombre Usuario, DATE_FORMAT(V.COM_FechaCompra,'%d %M %Y') Fecha, 
	V.COM_Total Total, V.COM_IVA IVA,
	CASE
		WHEN V.COM_Estatus =1 THEN "EN PROCESO"
        WHEN V.COM_Estatus =2 THEN "CONFIRMADA"
		ELSE "CANCELADA"
	END Estatus
    FROM SAN_COMPRA V, SAN_USUARIO B
	WHERE V.USU_ID=B.USU_ID;
END //
DELIMITER ;
-- CALL spReporteVentasTodos();


-- drop procedure spRegistrarUsuario;
DELIMITER //
CREATE PROCEDURE spRegistrarUsuario
(
	IN ROL 		INT,
	IN NOMBRE	NVARCHAR(50),
	IN APATER	NVARCHAR(50),
	IN AMATER	NVARCHAR(50),
	IN MUNICI	NVARCHAR(60),
	IN ESTADO	NVARCHAR(60),
	IN CORREO	NVARCHAR(80),
	IN CELU		VARCHAR(30),
	IN USUARI	NVARCHAR(50),
	IN CONTRA	NVARCHAR(50),
	IN ESTATU	INT
)
BEGIN
	INSERT INTO SAN_USUARIO VALUES(NULL,ROL,NOMBRE,APATER,AMATER,MUNICI,ESTADO,CORREO,CELU,USUARI,
	CONTRA,ESTATU,NOW());
END //
DELIMITER ;

-- drop procedure spRegistrarInventario;
DELIMITER //
CREATE PROCEDURE spRegistrarInventario
(
	IN PRODUC	INT,
	IN CANTI	INT
)
BEGIN
	IF EXISTS (SELECT ROD_ID FROM SAN_PRODUCTO WHERE ROD_ID = PRODUC) THEN
		IF EXISTS (SELECT ROD_ID FROM SAN_INVENTARIO WHERE ROD_ID = PRODUC) THEN
			SELECT '1' AS Mensaje;
			UPDATE SAN_INVENTARIO
			SET INV_CANTIDAD = INV_CANTIDAD + CANTI
			WHERE ROD_ID = PRODUC;
		ELSE
			INSERT INTO SAN_INVENTARIO (ROD_ID, INV_Cantidad) VALUES (PRODUC, CANTI);
		END IF;
	ELSE
		SELECT '0' AS MENSAJE;
	END IF;
END //
DELIMITER ;
-- CALL spRegistrarInventario1(97,7);

-- drop procedure spRegistrarProveedor;
DELIMITER //
CREATE PROCEDURE spRegistrarProveedor
(
	IN NOMBRE	NVARCHAR(40),
	IN CIUDAD	NVARCHAR(100),
	IN MUNICI	NVARCHAR(60),
	IN ESTADO	NVARCHAR(60),
	IN CODPOS	INT,
	IN TELEF	VARCHAR(12)
)
BEGIN
	INSERT INTO SAN_PROVEDDOR VALUES(NULL,NOMBRE,CIUDAD,MUNICI,ESTADO,CODPOS,TELEF);
END //
DELIMITER ;

-- drop procedure spListarProveedores;
DELIMITER //
CREATE PROCEDURE spListarProveedores()
BEGIN
	SELECT A.PRO_ID Clave, A.PRO_Nombre Proveedor, A.PRO_Ciudad Ciudad, A.PRO_Municipio Municipio, 
	A.PRO_Estado Estado, A.PRO_CodigoPostal CodigoPostal, A.PRO_Telefono Telefono
    FROM SAN_PROVEDDOR A;	
END //
DELIMITER ;
-- CALL spListarProveedores();

-- drop procedure spListarInventario;
DELIMITER //
CREATE PROCEDURE spListarInventario()
BEGIN
	SELECT A.ROD_ID ClaveProducto, A.INV_Cantidad Cantidad
    FROM SAN_INVENTARIO A;	
END //
DELIMITER ;
-- CALL spListarInventario();

-- drop procedure spProductoMasVendido;
DELIMITER //
CREATE PROCEDURE spProductoMasVendido()
BEGIN
	SELECT
		A.ROD_ID AS Clave,
		A.ROD_Nombre AS Producto,
		A.ROD_Descripcion AS Descripcion,
		A.ROD_Presentacion AS Presentacion,
		A.ROD_SaborTipo AS SaborTipo,
		A.ROD_GramosMil AS GramosMililitros,
		A.ROD_ModoUso AS ModoUso,
		SUM(DC.DET_Cantidad) AS TotalVendido
	FROM
		SAN_PRODUCTO A
	JOIN SAN_DETALLE_COMPRA DC ON A.ROD_ID = DC.ROD_ID
	JOIN SAN_COMPRA C ON DC.COM_ID = C.COM_ID
	WHERE
		A.ROD_Estatus = 1
	GROUP BY
		A.ROD_ID
	ORDER BY
		TotalVendido DESC
	LIMIT 1;
END //
DELIMITER ;
-- CALL spProductoMasVendido();

-- drop procedure spCantUsuarios;
DELIMITER //
CREATE PROCEDURE spCantUsuarios()
BEGIN
	SELECT MAX(USU_ID)
	FROM SAN_USUARIO;
END //
DELIMITER ;
-- CALL spCantUsuarios();

-- drop procedure spProductoMenosVendido;
DELIMITER //
CREATE PROCEDURE spProductoMenosVendido()
BEGIN
	SELECT
		A.ROD_ID AS Clave,
		A.ROD_Nombre AS Producto,
		A.ROD_Descripcion AS Descripcion,
		A.ROD_Presentacion AS Presentacion,
		A.ROD_SaborTipo AS SaborTipo,
		A.ROD_GramosMil AS GramosMililitros,
		A.ROD_ModoUso AS ModoUso,
		SUM(DC.DET_Cantidad) AS TotalVendido
	FROM
		SAN_PRODUCTO A
	LEFT JOIN SAN_DETALLE_COMPRA DC ON A.ROD_ID = DC.ROD_ID
	LEFT JOIN SAN_COMPRA C ON DC.COM_ID = C.COM_ID
	WHERE
		A.ROD_Estatus = 1
	GROUP BY
		A.ROD_ID
	ORDER BY
		TotalVendido ASC
	LIMIT 1;
END //
DELIMITER ;
-- CALL spProductoMenosVendido();
