%TDA libro
%representacion en lista
%idLibro (int)X titulo (string) X autor (string) X disponibilidad (boolean)

%constructor
%Descripcion: Es el constructor del TDA libro, genera una lista que representa un libro
%Dominio: idlibro(int) X nombre(string) X  disponibilidad(boolean)
%Recorrido: libro (list), con los parametros señalados en el dominio.

libro(Id, Titulo, Autor, Disponibilidad, [Id, Titulo, Autor, Disponibilidad]).

%pertenencia  %%%%%%%%%%%%%%%%%%%%%%
esLibro(L) :-
    libro(_, _, _, _, L).


%selectores%%%%%%%%%%%%%%%%%%%%%55
%Descripción: esta funcion entrega el id del libro
%Dom: libro (list)
%Rec: idLibro (int)

%RF10
getLibroId(L, IdLibro) :-
    libro(IdLibro, _, _, _, L).

%Descripción: esta funcion entrega el titulo del libro
%Dom: libro (list)
%Rec:titulo (string)
getLibroTitulo(L, Titulo) :-
    libro(_, Titulo, _, _, L).


%Descripción: esta funcion entrega el autor del libro
%Dom: libro (list)
%Rec: autor (string)
getLibroAutor(L, Autor) :-
    libro(_, _, Autor, _, L).


%Descripción: esta funcion entrega el estado de disponibilidad del libro
%Dom: libro (list)
%Rec: disponibilidad (boolean)
getLibroDisponibilidad(L, Disponibilidad) :-
    libro(_, _, _, Disponibilidad, L).

%modificadores%%%%%%%%%%%%%%%%%%%
%idlibro, titulo y autor no deberian modificarse

% Descripción: Esta función modifica el estado de disponibilidad la lista libro y entrega el resto de atributos iguales
% Dominio: libro (list)
% Recorrido: libroModificado (list)
%Tipo de algoritmo: actualizacion de estructura
setLibroDisponibilidad(LibroIn, NuevaDisponibilidad, LibroOut) :-
    libro(Id, Titulo, Autor, _, LibroIn),
    libro(Id, Titulo, Autor, NuevaDisponibilidad, LibroOut).
