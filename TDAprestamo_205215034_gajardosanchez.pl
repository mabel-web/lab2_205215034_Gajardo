%TDA prestamo
%representacion en lista


%contructor %%%%%%%%%%%%%%%%%%%%%
%Descripcion: Es el constructor del TDA libro, genera una lista que representa un libro
%Dominio: idlibro(int) X nombre(string) X  disponibilidad(boolean)
%Recorrido: libro (list), con los parametros señalados en el dominio.

prestamo(IdPrestamo, IdUsuario, IdLibro, Fecha, DiasSolicitados, EstadoPrestamo, [IdPrestamo, IdUsuario, IdLibro, Fecha, DiasSolicitados, EstadoPrestamo]).

%pertenencia %%%%%%%%%%%%%%%%%%
esPrestamo(P) :-
    prestamo(_, _, _, _, _, _, P).


%selectores %%%%%%%%%%%%%%
%Descripción: esta funcion entrega el id del prestamo
%Dom: prestamo (list)
%Rec: idPrestamo (int)
getPrestamoId(P, IdPrestamo) :- 
    prestamo(IdPrestamo, _, _, _, _, _, P).


%Descripción: esta funcion entrega el id del usuario que realiza el prestamo
%Dom: prestamo (list)
%Rec: idUsuario (int)
getPrestamoUsuario(P, IdUsuario) :- 
    prestamo(_, IdUsuario, _, _, _, _, P).


%Descripción: esta funcion entrega el id del libro prestado
%Dom: prestamo (list)
%Rec: idLibro (int)
getPrestamoLibro(P, IdLibro) :- 
    prestamo(_, _, IdLibro, _, _, _, P).


%Descripción: esta funcion entrega la fecha de inicio del prestamo
%Dom: prestamo (list)
%Rec: fecha (string)
getPrestamoFecha(P, Fecha) :- 
    prestamo(_, _, _, Fecha, _, _, P).


%Descripción: esta funcion entrega el numero de dias solicitados que fue pedido el libro
%Dom: prestamo (list)
%Rec: diasSolicitados (int)
getPrestamoDias(P, DiasSolicitados) :- 
    prestamo(_, _, _, _, DiasSolicitados, _, P).


%Descripción: esta funcion entrega el id del prestamo
%Dom: prestamo (list)
%Rec: idPrestamo (int)
getPrestamoEstado(P, EstadoPrestamo) :- 
    prestamo(_, _, _, _, _, EstadoPrestamo, P).


%modificadores %%%%%%%%%%%%%%%%%

% Descripción: Esta funcion modifica el numero de dias solicitados del prestamo y entrega el resto de atributos iguales
% Dominio: prestamo (list)
% Recorrido: prestamoModificado (list)
%Tipo de algoritmo: actualizacion de estructura
setPrestamoDiasSolicitados(PrestamoIn, NuevosDiasSolicitados, PrestamoOut) :-
    prestamo(IdPrestamo, IdUsuario, IdLibro, Fecha, _, EstadoPrestamo, PrestamoIn),
    prestamo(IdPrestamo, IdUsuario, IdLibro, Fecha, NuevosDiasSolictados, EstadoPrestamo, PrestamoOut).



% Descripción: Esta función modifica el estado del prestamo y entrega el resto de atributos iguales
% Dominio: prestamo (list)
% Recorrido: prestamoModificado (list)
%Tipo de algoritmo: actualizacion de estructura
setPrestamoEstado(PrestamoIn, NuevoEstadoPrestamo, PrestamoOut) :-
    prestamo(IdPrestamo, IdUsuario, IdLibro, Fecha, DiasSolicitados, _, PrestamoIn),
    prestamo(IdPrestamo, IdUsuario, IdLibro, Fecha, DiasSolicitados, NuevoEstadoPrestamo, PrestamoOut).

