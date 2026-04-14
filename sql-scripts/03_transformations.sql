SELECT ins.idInstructor,
       ins.nombreInstructor,
	   cdd.nombreCiudad,
	   pas.nombrePais,
	   ply.nombrePLaya INTO surfSA.tra.instructor_d
FROM surfSA.ext.INSTRUCTORES ins
	 left join surfSA.ext.CIUDAD cdd
	  ON ins.idCiudad = cdd.idCiudad
	 left join surfSA.ext.PLAYAS ply
	  ON cdd.idCiudad = ply.idCiudad
	 left join surfSA.ext.PAIS pas
	  ON cdd.idPais = pas.idPais

-- Creacion tabla cliente_d
SELECT clt.idCliente,
	   clt.nombreCliente,
	   case 
	    when clt.tarjetaCliente is not null then 'S'
		else 'N'
	   end tieneTarjeta,
	   cdd.nombreCiudad,
	   pas.nombrePais INTO surfSA.tra.cliente_d
FROM surfSA.ext.CLIENTE clt
	 left join surfSA.ext.CIUDAD cdd
	  on clt.idCiudad = cdd.idCiudad
	 left join surfSA.ext.PAIS pas
	  on cdd.idPais = pas.idPais


-- Creacion tabla tipoRental_d
CREATE TABLE surfSA.tra.tipoRental_d(
	idTipoRental int identity(1,1) primary key,
	tipoRental nvarchar(50)
	)
INSERT INTO surfSA.tra.tipoRental_d(tipoRental)
	SELECT distinct tipoTabla
	FROM surfSA.ext.RENTALS

-- Creacion tabla tamanoRental_d
CREATE TABLE surfSA.tra.tamanoRental_d(
	idTamanoRental INT IDENTITY(1,1) PRIMARY KEY,
	tamanoTabla INT
	)
INSERT INTO surfSA.tra.tamanoRental_d(tamanoTabla)
	SELECT distinct tamanoTabla
	FROM surfSA.ext.RENTALS

-- Creacion tabla dificultad_d
CREATE TABLE surfSA.tra.dificultad_d(
	idDificultad INT IDENTITY(1,1) PRIMARY KEY,
	dificultad nvarchar(50))
INSERT INTO surfSA.tra.dificultad_d(dificultad)
	SELECT distinct dificultad
	FROM surfSA.ext.PLAYAS

-- Creacion tabla tipoPago_d
CREATE TABLE surfSA.tra.tipoPago_d(
	idTipoPago INT IDENTITY(1,1) PRIMARY KEY,
	descripcionTipoPago nvarchar(50))
INSERT INTO surfSA.tra.tipoPago_d(descripcionTipoPago)
	SELECT distinct metodoPago
	FROM surfSA.ext.FACTURA_CLASE

-- Creacion tabla ubicacion_d
CREATE TABLE surfSA.tra.ubicacion_d(
	idUbicacion INT PRIMARY KEY,
	nombrePais nvarchar(50),
	nombreCiudad nvarchar(50),
	nombrePlaya nvarchar(50))
INSERT INTO surfSA.tra.ubicacion_d(idUbicacion,nombrePais,nombreCiudad,nombrePlaya)
		SELECT tda.idTienda as idUbicacion,
			   pas.nombrePais,
			   cdd.nombreCiudad,
			   ply.nombrePlaya
		FROM surfSA.ext.TIENDA tda
			 left join surfSA.ext.PLAYAS ply
			  on tda.idPlaya = ply.idPlaya
			 left join surfSA.ext.CIUDAD cdd
			  ON ply.idCiudad = cdd.idCiudad 
			 left join surfSA.ext.PAIS pas
			  ON cdd.idPais = pas.idPais


-- Creacion tabla tiempo_d
SELECT ttmp.horaClase,
	   day(horaClase) as dia, 
	   month(horaClase) as mes,
	   datepart(quarter, horaClase) as trimestre,
	   year(horaClase) as anno INTO surfSA.tra.tiempo_d
FROM (SELECT distinct horaClase
	  FROM surfSA.ext.CLASES) ttmp

-- Creacion tabla de hechos reservasClases_h
SELECT cls.idClase as idReservasClases,
	   cls.costoClase,
	   ins.idInstructor,
	   cli.idCliente,
	   tmp.horaClase,
	   ubid.idUbicacion,
	   tprD.idTipoRental,
	   tmnD.idTamanoRental,
	   dfcD.idDificultad,
	   tppD.idTipoPago INTO surfSA.tra.reservasClases_h
FROM surfSA.ext.CLASES cls
	 left join surfSA.ext.INSTRUCTORES ins
	  on cls.idInstructor = ins.idInstructor

	  left join surfSA.ext.FACTURA_CLASES fcs
	   on cls.idClase = fcs.idClase
	  left join surfSA.ext.FACTURA_CLASE fct
	   on fcs.idFacturaClase = fct.idFacturaClase
	  left join surfSA.ext.CLIENTE cli 
	   on fct.idCliente = cli.idCliente

	   left join surfSA.tra.tiempo_d tmp
	    on cls.horaClase = tmp.horaClase

	  left join surfSA.ext.TIENDA tnd 
	   on cls.idTienda = tnd.idTienda
	  left join surfSA.ext.PLAYAS ply
	   on tnd.idPlaya = ply.idPlaya
	  left join surfSA.ext.CIUDAD cdd 
	   on ply.idCiudad = cdd.idCiudad
	  left join surfSA.ext.PAIS pas
	   on cdd.idPais = pas.idPais
	  left join surfSA.tra.ubicacion_d ubiD 
	   on tnd.idTienda = ubiD.idUbicacion

	  left join surfSA.ext.RENTALS rnt 
	   on cls.idRental = rnt.idRental
	  left join surfSA.tra.tipoRental_d tprD
	   on rnt.tipoTabla = tprD.tipoRental

	 left join surfSA.tra.tamanoRental_d tmnD
	  on rnt.tamanoTabla = tmnD.tamanoTabla

	 left join surfSA.tra.dificultad_d dfcD
	  on ply.dificultad = dfcD.dificultad

	 left join surfSA.tra.tipoPago_d tppD
	  on fct.metodoPago = tppd.descripcionTipoPago
