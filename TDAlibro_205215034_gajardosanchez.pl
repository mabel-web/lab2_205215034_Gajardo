:- module(TDAlibro_205215034_gajardosanchez, [
    libro/5,
    getLibroId/2,
    esLibro/1,
    getLibroTitulo/2,
    getLibroAutor/2,
    getLibroDisponibilidad/2,
    setLibroDisponibilidad/3
]).

%representacion en lista
%idLibro (int)X titulo (string) X autor (string) X disponibilidad (boolean)

%constructor
%Descripcion: Es el constructor del TDA libro, genera una lista que representa un libro
%Dominio: idlibro(int) X nombre(string) X  disponibilidad(boolean)


libro(Id, Titulo, Autor, Disponibilidad, [Id, Titulo, Autor, Disponibilidad]).

%pertenencia  %%%%%%%%%%%%%%%%%%%%%%
esLibro(L) :-
    libro(_, _, _, _, L).


%selectores%%%%%%%%%%%%%%%%%%%%%55
%Descripción: entrega el id del libro
%Dom: libro (list)


%RF10
getLibroId(libro(Id, _, _, _), Id).

%Descripción:  entrega el titulo del libro
%Dom: libro (list)

getLibroTitulo(L, Titulo) :-
    libro(_, Titulo, _, _, L).


%Descripción:  entrega el autor del libro
%Dom: libro (list)

getLibroAutor(L, Autor) :-
    libro(_, _, Autor, _, L).


%Descripción: entrega el estado de disponibilidad del libro
%Dom: libro (list)

getLibroDisponibilidad(L, Disponibilidad) :-
    libro(_, _, _, Disponibilidad, L).

%modificadores%%%%%%%%%%%%%%%%%%%
%idlibro, titulo y autor no deberian modificarse

% Descripción: modifica el estado de disponibilidad la lista libro y entrega el resto de atributos iguales
% Dominio: libro (list)

%Tipo de algoritmo: actualizacion de estructura
setLibroDisponibilidad(LibroIn, NuevaDisponibilidad, LibroOut) :-
    libro(Id, Titulo, Autor, _, LibroIn),
    libro(Id, Titulo, Autor, NuevaDisponibilidad, LibroOut).
