%TDAUsuario

:- module(TDAusuario_205215034_gajardosanchez, [
    usuario/6,
    getUsuarioId/2,
    getUsuarioNombre/2,
    getUsuarioDeuda/2,
    getUsuarioLibros/2,
    getUsuarioEstado/2,
    setUsuarioDeuda/3,
	setUsuarioEstado/3,
	setUsuarioLibros/3
]).

%Representación en lista (id, nombre, deuda, libros, estado).

%constructor %%%%%%%%%%%%%%%%%%%%%%

%Descripcion: Es el constructor del TDA usuario, genera una lista que representa un usuario
%Dominio: Id(int) X Nombre(string) X deuda(int) X libros(list) X PosicionActual(int) X estado(boolean)

%Tipo de algoritmo:

usuario(Id, Nombre, Deuda, Libros, Estado, [Id, Nombre, Deuda, Libros, Estado]).


%Pertenencia %%%%%%%%%%%%%%%%%%%%%%
%Descripcion: verifica si la lista tiene las caracteristicas de TDA usuario,  devuelve true si la entrada es valida
%Dominio: Id(int) X Nombre(string) X deuda(int) X libros(list) X PosicionActual(int) X estado(boolean)


esUsuario(U) :-
    usuario(_, _, _, _, _, U).

%Selectores %%%%%%%%%%%%%%

%Descripción: entrega el id del usuario
%Dom: usuario (list)

getUsuarioId(U, Id) :-
    usuario(Id, _, _, _, _, U).

%Descripción: entrega el nombre del usuario
%Dom: usuario (list)

getUsuarioNombre(U, Nombre) :-
    usuario(_, Nombre, _, _, _, U).

%Descripción: entrega la deuda del usuario
%Dom: usuario (list)

getUsuarioDeuda(U, Deuda) :-
    usuario(_, _, Deuda, _, _, U).

%Descripción: entrega el estado del usuario
%Dom: usuario (list)

getUsuarioEstado(U, Estado) :-
    usuario(_, _, _, _, Estado, U).

%Descripción: esta funcion entrega la lista de libros del usuario
%Dom: usuario (list)

getUsuarioLibros(U, Libros) :-
    usuario(_, _, _, Libros, _, U).

%Modificadores %%%%%%%%%%%%%%%%%%%%

% Descripción: modifica la deuda de un usuario y entrega el resto de atributos iguales
% Dominio: usuario (list)

%Tipo de algoritmo: actualizacion de estructura
setUsuarioDeuda(UsuarioIn, NuevaDeuda, UsuarioOut) :-
    usuario(Id, Nombre, _, Libros, Estado, UsuarioIn),
    usuario(Id, Nombre, NuevaDeuda, Libros, Estado, UsuarioOut).
                 

% Descripción: modifica el estado de un usuario y entrega el resto de atributos iguales
% Dominio: usuario (list)

%Tipo de algoritmo: actualizacion de estructura
setUsuarioEstado(UsuarioIn, NuevoEstado, UsuarioOut) :-
    usuario(Id, Nombre, Deuda, Libros, _, UsuarioIn),
    usuario(Id, Nombre, Deuda, Libros, NuevoEstado, UsuarioOut).


% Descripción: modifica la lista de libros de un usuario y entrega el resto de atributos iguales
% Dominio: usuario (list)

%Tipo de algoritmo: actualizacion de estructura
setUsuarioLibros(UsuarioIn, NuevosLibros, UsuarioOut) :-
    usuario(Id, Nombre, Deuda, _, Estado, UsuarioIn),
    usuario(Id, Nombre, Deuda, NuevosLibros, Estado, UsuarioOut).                 

