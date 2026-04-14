select * into surfDW.dbo.cliente_d
from surfSA.tra.cliente_d

alter table surfDW.dbo.cliente_d add primary key(idCliente)


select * into surfDW.dbo.dificultad_d
from surfSA.tra.dificultad_d

alter table surfDW.dbo.dificultad_d add primary key(idDificultad)

select * into surfDW.dbo.instructor_d
from surfSA.tra.instructor_d

alter table surfDW.dbo.instructor_d add primary key(idInstructor)

select * into surfDW.dbo.tamanoRental_d
from surfSA.tra.tamanoRental_d

alter table surfDW.dbo.tamanoRental_d add primary key(idTamanoRental)

select * into surfDW.dbo.tiempo_d
from surfSA.tra.tiempo_d

alter table surfDW.dbo.tiempo_d add primary key(horaClase)

select * into surfDW.dbo.tipoPago_d
from surfSA.tra.tipoPago_d

alter table surfDW.dbo.tipoPago_d add primary key(idTipoPago)

select * into surfDW.dbo.tipoRental_d
from surfSA.tra.tipoRental_d

alter table surfDW.dbo.tipoRental_d add primary key(idTipoRental)

select * into surfDW.dbo.ubicacion_d
from surfSA.tra.ubicacion_d

alter table surfDW.dbo.ubicacion_d add primary key(idUbicacion)

select * into surfDW.dbo.reservasClases_h
from surfSA.tra.reservasClases_h

alter table surfDW.dbo.reservasClases_h add primary key(idReservasClases)
alter table surfDW.dbo.reservasClases_h add foreign key(idInstructor) references surfDW.dbo.instructor_d(idInstructor)
alter table surfDW.dbo.reservasClases_h add foreign key(idCliente) references surfDW.dbo.cliente_d(idCliente)
alter table surfDW.dbo.reservasClases_h add foreign key(horaClase) references surfDW.dbo.tiempo_d(horaClase)
alter table surfDW.dbo.reservasClases_h add foreign key(idUbicacion) references surfDW.dbo.ubicacion_d(idUbicacion)
alter table surfDW.dbo.reservasClases_h add foreign key(idTipoRental) references surfDW.dbo.tipoRental_d(idTipoRental)
alter table surfDW.dbo.reservasClases_h add foreign key(idTamanoRental) references surfDW.dbo.tamanoRental_d(idTamanoRental)
alter table surfDW.dbo.reservasClases_h add foreign key(idDificultad) references surfDW.dbo.dificultad_d(idDificultad)
alter table surfDW.dbo.reservasClases_h add foreign key(idTipoPago) references surfDW.dbo.tipoPago_d(idTipoPago)




























