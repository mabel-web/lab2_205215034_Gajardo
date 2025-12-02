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
%Meta principal: 
libro(Id, Titulo, Autor, Disponibilidad, [Id, Titulo, Autor, Disponibilidad]).

%pertenencia  
%Meta principal: 
esLibro([_, _, _, _]).


%selectores
%Descripción: entrega el id del libro
%Dom: libro (list)
%Meta principal: 
%RF10
getLibroId([Id, _, _, _], Id).


%Descripción:  entrega el titulo del libro
%Dom: libro (list)
%Meta principal: 
getLibroTitulo([_, Titulo, _, _], Titulo).


%Descripción:  entrega el autor del libro
%Dom: libro (list)
%Meta principal: 
getLibroAutor([_, _, Autor, _], Autor).


%Descripción: entrega el estado de disponibilidad del libro
%Dom: libro (list)
%Meta principal: 
getLibroDisponibilidad([_, _, _, Disponibilidad], Disponibilidad).

%modificadores
%idlibro, titulo y autor no deberian modificarse

% Descripción: modifica el estado de disponibilidad la lista libro y entrega el resto de atributos iguales
% Dominio: libro (list)
%Meta principal: 
%Tipo de algoritmo: actualizacion de estructura

setLibroDisponibilidad([Id, Titulo, Autor, _], NuevaDisponibilidad, [Id, Titulo, Autor, NuevaDisponibilidad]).
