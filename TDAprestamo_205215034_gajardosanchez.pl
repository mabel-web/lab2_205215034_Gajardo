%TDA prestamo
%representacion en lista

:- module(TDAprestamo_205215034_gajardosanchez, [
    prestamo/6,
    getPrestamoId/2,
    getPrestamoUsuario/2,
    getPrestamoLibro/2,
    getPrestamoFecha/2,
    getPrestamoDias/2,
    setPrestamoDiasSolicitados/3
]).

%contructor
%Descripcion: Es el constructor del TDA libro, genera una lista que representa un libro
%Dominio: 
%Meta principal: 

prestamo(IdPrestamo, IdUsuario, IdLibro, Fecha, DiasSolicitados, [IdPrestamo, IdUsuario, IdLibro, Fecha, DiasSolicitados]).

%pertenencia
%Meta principal: 
esPrestamo([_, _, _, _, _]).

%selectores
%Descripción: entrega el id del prestamo
%Dom: prestamo (list)
%Meta principal: 
getPrestamoId([IdPrestamo, _, _, _, _], IdPrestamo).


%Descripción: entrega el id del usuario que realiza el prestamo
%Dom: prestamo (list)
%Meta principal: 
getPrestamoUsuario([_, IdUsuario, _, _, _], IdUsuario).


%Descripción: entrega el id del libro prestado
%Dom: prestamo (list)
%Meta principal: 
getPrestamoLibro([_, _, IdLibro, _, _], IdLibro).


%Descripción: entrega la fecha de inicio del prestamo
%Dom: prestamo (list)
%Meta principal: 
getPrestamoFecha([_, _, _, Fecha, _], Fecha).


%Descripción: entrega el numero de dias solicitados que fue pedido el libro
%Dom: prestamo (list)
%Meta principal: 
getPrestamoDias([_, _, _, _, DiasSolicitados], DiasSolicitados).


%modificadores
% Descripción: modifica el numero de dias solicitados del prestamo y entrega el resto de atributos iguales
% Dominio: prestamo (list)
%Meta principal: 
%Tipo de algoritmo: actualizacion de estructura
setPrestamoDiasSolicitados([IdPrestamo, IdUsuario, IdLibro, Fecha, _], NuevosDiasSolicitados, [IdPrestamo, IdUsuario, IdLibro, Fecha, NuevosDiasSolicitados]).