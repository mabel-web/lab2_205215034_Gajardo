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

% El TDA usuario interpreta el booleano del estado
%true = suspendido
%false = activo

%constructor
%Descripcion: Es el constructor del TDA usuario, genera una lista que representa un usuario
%Dominio: Id(int) X Nombre(string) X deuda(int) X libros(list) X PosicionActual(int) X estado(boolean)
%Tipo de algoritmo:
%Meta principal: 
usuario(Id, Nombre, Deuda, Libros, Estado, [Id, Nombre, Deuda, Libros, Estado]).


%Pertenencia
%Descripcion: verifica si la lista tiene las caracteristicas de TDA usuario,  devuelve true si la entrada es valida
%Dominio: Id(int) X Nombre(string) X deuda(int) X libros(list) X PosicionActual(int) X estado(boolean)
%Meta principal: 
esUsuario([_, _, _, _, _]).

%Selectores

%Descripción: entrega el id del usuario
%Dom: usuario (list)
%Meta principal: 
getUsuarioId([Id, _, _, _, _], Id).

%Descripción: entrega el nombre del usuario
%Dom: usuario (list)
%Meta principal: 
getUsuarioNombre([_, Nombre, _, _, _], Nombre).

%Descripción: entrega la deuda del usuario
%Dom: usuario (list)
%Meta principal: 
getUsuarioDeuda([_, _, Deuda, _, _], Deuda).

%Descripción: entrega el estado del usuario
%Dom: usuario (list)
%Meta principal: 
getUsuarioLibros([_, _, _, Libros, _], Libros).

%Descripción: esta funcion entrega la lista de libros del usuario
%Dom: usuario (list)
%Meta principal: 
getUsuarioEstado([_, _, _, _, Estado], Estado).

%Modificadores %%%%%%%%%%%%%%%%%%%%

% Descripción: modifica la deuda de un usuario y entrega el resto de atributos iguales
% Dominio: usuario (list)
%Meta principal: 
%Tipo de algoritmo: actualizacion de estructura
setUsuarioDeuda([Id, Nombre, _, Libros, Estado], NuevaDeuda, [Id, Nombre, NuevaDeuda, Libros, Estado]).
                 

% Descripción: modifica el estado de un usuario y entrega el resto de atributos iguales
% Dominio: usuario (list)
%Meta principal: 
%Tipo de algoritmo: actualizacion de estructura
setUsuarioEstado([Id, Nombre, Deuda, Libros, _], NuevoEstado, [Id, Nombre, Deuda, Libros, NuevoEstado]).


% Descripción: modifica la lista de libros de un usuario y entrega el resto de atributos iguales
% Dominio: usuario (list)
%Meta principal: 
%Tipo de algoritmo: actualizacion de estructura
setUsuarioLibros([Id, Nombre, Deuda, _, Estado], NuevosLibros, [Id, Nombre, Deuda, NuevosLibros, Estado]).               

