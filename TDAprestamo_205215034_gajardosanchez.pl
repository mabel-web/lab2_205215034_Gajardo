%TDA prestamo
%representacion en lista


%contructor %%%%%%%%%%%%%%%%%%%%%
%Descripcion: Es el constructor del TDA libro, genera una lista que representa un libro
%Dominio: idlibro(int) X nombre(string) X  disponibilidad(boolean)
%Recorrido: libro (list), con los parametros señalados en el dominio.

prestamo(idPrestamo, idUsuario, idLibro, fecha, diasSolicitados, estadoPrestamo, [idPrestamo, idUsuario, idLibro, fecha, diasSolicitados, estadoPrestamo]).

%pertenencia %%%%%%%%%%%%%%%%%%
esPrestamo(prestamo) :-
    prestamo(_, _, _, _, _, _, prestamo).




%selectores %%%%%%%%%%%%%%
%Descripción: esta funcion entrega el id del prestamo
%Dom: prestamo (list)
%Rec: idPrestamo (int)
getPrestamoId(prestamo, idPrestamo) :- 
    prestamo(idPrestamo, _, _, _, _, _, prestamo).


%Descripción: esta funcion entrega el id del usuario que realiza el prestamo
%Dom: prestamo (list)
%Rec: idUsuario (int)
getPrestamoUsuario(prestamo, idUsuario) :- 
    prestamo(_, idUsuario, _, _, _, _, prestamo).


%Descripción: esta funcion entrega el id del libro prestado
%Dom: prestamo (list)
%Rec: idLibro (int)
getPrestamoLibro(prestamo, idLibro) :- 
    prestamo(_, _, idLibro, _, _, _, prestamo).


%Descripción: esta funcion entrega la fecha de inicio del prestamo
%Dom: prestamo (list)
%Rec: fecha (string)
getPrestamoFecha(prestamo, fecha) :- 
    prestamo(_, _, _, fecha, _, _, prestamo).


%Descripción: esta funcion entrega el numero de dias solicitados que fue pedido el libro
%Dom: prestamo (list)
%Rec: diasSolicitados (int)
getPrestamoDias(prestamo, diasSolicitados) :- 
    prestamo(_, _, _, _, diasSolicitados, _, prestamo).


%Descripción: esta funcion entrega el id del prestamo
%Dom: prestamo (list)
%Rec: idPrestamo (int)
getPrestamoEstado(prestamo, estadoPrestamo) :- 
    prestamo(_, _, _, _, _, estadoPrestamo, prestamo).


%modificadores %%%%%%%%%%%%%%%%%

% Descripción: Esta funcion modifica el numero de dias solicitados del prestamo y entrega el resto de atributos iguales
% Dominio: prestamo (list)
% Recorrido: prestamoModificado (list)
%Tipo de algoritmo: actualizacion de estructura
setPrestamoDiasSolicitados(prestamoIn, nuevosDiasSolicitados, prestamoOut) :-
    prestamo(idPrestamo, idUsuario, idLibro, fecha, _, estadoPrestamo, prestamoIn),
    prestamo(idPrestamo, idUsuario, idLibro, fecha, nuevosDiasSolictados, estadoPrestamo, prestamoOut).



% Descripción: Esta función modifica el estado del prestamo y entrega el resto de atributos iguales
% Dominio: prestamo (list)
% Recorrido: prestamoModificado (list)
%Tipo de algoritmo: actualizacion de estructura
setPrestamoEstado(prestamoIn, nuevoEstadoPrestamo, prestamoOut) :-
    prestamo(idPrestamo, idUsuario, idLibro, fecha, diasSolicitados, _, prestamoIn),
    prestamo(idPrestamo, idUsuario, idLibro, fecha, diasSolicitados, nuevoEstadoPrestamo, prestamoOut).

