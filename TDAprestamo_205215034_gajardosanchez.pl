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

%contructor %%%%%%%%%%%%%%%%%%%%%
%Descripcion: Es el constructor del TDA libro, genera una lista que representa un libro
%Dominio: 

prestamo(IdPrestamo, IdUsuario, IdLibro, Fecha, DiasSolicitados, PrestamoOut) :-
    PrestamoOut = [IdPrestamo, IdUsuario, IdLibro, Fecha, DiasSolicitados].


%pertenencia %%%%%%%%%%%%%%%%%%
esPrestamo(P) :-
    prestamo(_, _, _, _, _, P).

%selectores %%%%%%%%%%%%%%
%Descripción: entrega el id del prestamo
%Dom: prestamo (list)

getPrestamoId(P, IdPrestamo) :- 
    prestamo(IdPrestamo, _, _, _, _, P).


%Descripción: entrega el id del usuario que realiza el prestamo
%Dom: prestamo (list)

getPrestamoUsuario(P, IdUsuario) :- 
    prestamo(_, IdUsuario, _, _, _, P).


%Descripción: entrega el id del libro prestado
%Dom: prestamo (list)

getPrestamoLibro(P, IdLibro) :- 
    prestamo(_, _, IdLibro, _, _, P).


%Descripción: entrega la fecha de inicio del prestamo
%Dom: prestamo (list)

getPrestamoFecha(P, Fecha) :- 
    prestamo(_, _, _, Fecha, _, P).


%Descripción: entrega el numero de dias solicitados que fue pedido el libro
%Dom: prestamo (list)

getPrestamoDias(P, DiasSolicitados) :- 
    prestamo(_, _, _, _, DiasSolicitados, P).


%modificadores %%%%%%%%%%%%%%%%%

% Descripción: modifica el numero de dias solicitados del prestamo y entrega el resto de atributos iguales
% Dominio: prestamo (list)

%Tipo de algoritmo: actualizacion de estructura
setPrestamoDiasSolicitados(PrestamoIn, NuevosDiasSolicitados, PrestamoOut) :-
    prestamo(IdPrestamo, IdUsuario, IdLibro, Fecha, _, PrestamoIn),
    prestamo(IdPrestamo, IdUsuario, IdLibro, Fecha, NuevosDiasSolictados, PrestamoOut).
