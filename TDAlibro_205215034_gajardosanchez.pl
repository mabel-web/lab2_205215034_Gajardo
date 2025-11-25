%TDA libro
%representacion en lista
%idLibro (int)X titulo (string) X autor (string) X disponibilidad (boolean)

%constructor
%Descripcion: Es el constructor del TDA libro, genera una lista que representa un libro
%Dominio: idlibro(int) X nombre(string) X  disponibilidad(boolean)
%Recorrido: libro (list), con los parametros señalados en el dominio.

libro(id, titulo, autor, disponibilidad, [id, titulo, autor, disponibilidad]).

%pertenencia  %%%%%%%%%%%%%%%%%%%%%%
esLibro(libro) :-
    libro(_, _, _, _, libro).



%selectores%%%%%%%%%%%%%%%%%%%%%55
%Descripción: esta funcion entrega el id del libro
%Dom: libro (list)
%Rec: idLibro (int)
getLibroId(libro, idLibro) :-
    libro(idLibro, _, _, _, libro).

%Descripción: esta funcion entrega el titulo del libro
%Dom: libro (list)
%Rec:titulo (string)
getLibroTitulo(libro, titulo) :-
    libro(_, titulo, _, _, libro).


%Descripción: esta funcion entrega el autor del libro
%Dom: libro (list)
%Rec: autor (string)
getLibroAutor(libro, autor) :-
    libro(_, _, autor, _, libro).


%Descripción: esta funcion entrega el estado de disponibilidad del libro
%Dom: libro (list)
%Rec: disponibilidad (boolean)
getLibroDisponibilidad(libro, disponibilidad) :-
    libro(_, _, _, disponibilidad, libro).

%modificadores%%%%%%%%%%%%%%%%%%%
%idlibro, titulo y autor no deberian modificarse

% Descripción: Esta función modifica el estado de disponibilidad la lista libro y entrega el resto de atributos iguales
% Dominio: libro (list)
% Recorrido: libroModificado (list)
%Tipo de algoritmo: actualizacion de estructura
setLibroDisponibilidad(libroIn, nuevaDisponibilidad, libroOut) :-
    libro(id, titulo, autor, _, libroIn),
    libro(id, titulo, autor, nuevaDisponibilidad, libroOut).
