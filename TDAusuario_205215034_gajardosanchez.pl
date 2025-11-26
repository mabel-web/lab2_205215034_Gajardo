%TDAUsuario
%Representación en lista (id, nombre, deuda, libros, estado).

%constructor %%%%%%%%%%%%%%%%%%%%%%

%Descripcion: Es el constructor del TDA usuario, genera una lista que representa un usuario
%Dominio: Id(int) X Nombre(string) X deuda(int) X libros(list) X PosicionActual(int) X estado(boolean)
%Recorrido:usuario (list), con los parametros señalados en el dominio.
%Tipo de algoritmo:

usuario(Id, Nombre, Deuda, Libros, Estado, [Id, Nombre, Deuda, Libros, Estado]).


%Pertenencia %%%%%%%%%%%%%%%%%%%%%%
%Descripcion: Funcion de pertenencia del TDA usuario, verifica si la lista tiene las caracteristicas de TDA usuario,  devuelve true si la entrada es valida
%Dominio: Id(int) X Nombre(string) X deuda(int) X libros(list) X PosicionActual(int) X estado(boolean)
%Recorrido: usuario (list), con los parametros señalados en el dominio.

esUsuario(U) :-
    usuario(_, _, _, _, _, U).

%Selectores %%%%%%%%%%%%%%

%Descripción: esta funcion entrega el id del usuario
%Dom: usuario (list)
%Rec: id (int)
getUsuarioId(U, Id) :-
    usuario(Id, _, _, _, _, U).

%Descripción: esta funcion entrega el nombre del usuario
%Dom: usuario (list)
%Rec: nombre (string)
getUsuarioNombre(U, Nombre) :-
    usuario(_, Nombre, _, _, _, U).

%Descripción: esta funcion entrega la deuda del usuario
%Dom: usuario (list)
%Rec: deuda (int)
getUsuarioDeuda(U, Deuda) :-
    usuario(_, _, Deuda, _, _, U).

%Descripción: esta funcion entrega el estado del usuario
%Dom: usuario (list)
%Rec: estado  (string)
getUsuarioEstado(U, Estado) :-
    usuario(_, _, _, _, Estado, U).

%Descripción: esta funcion entrega la lista de libros del usuario
%Dom: usuario (list)
%Rec: libros (list)
getUsuarioLibros(U, Libros) :-
    usuario(_, _, _, Libros, _, U).

%Modificadores %%%%%%%%%%%%%%%%%%%%

% Descripción: Esta función modifica la deuda de un usuario y entrega el resto de atributos iguales
% Dominio: usuario (list)
% Recorrido: usuarioModificado (list)
%Tipo de algoritmo: actualizacion de estructura
setUsuarioDeuda(UsuarioIn, NuevaDeuda, UsuarioOut) :-
    usuario(Id, Nombre, _, Libros, Estado, UsuarioIn),
    usuario(Id, Nombre, NuevaDeuda, Libros, Estado, UsuarioOut).
                 

% Descripción: Esta función modifica el estado de un usuario y entrega el resto de atributos iguales
% Dominio: usuario (list)
% Recorrido: usuarioModificado (list)
%Tipo de algoritmo: actualizacion de estructura
setUsuarioEstado(UsuarioIn, NuevoEstado, UsuarioOut) :-
    usuario(Id, Nombre, Deuda, Libros, _, UsuarioIn),
    usuario(Id, Nombre, Deuda, Libros, NuevoEstado, UsuarioOut).


% Descripción: Esta función modifica la lista de libros de un usuario y entrega el resto de atributos iguales
% Dominio: usuario (list)
% Recorrido: usuarioModificado (list)
%Tipo de algoritmo: actualizacion de estructura
setUsuarioLibros(UsuarioIn, NuevosLibros, UsuarioOut) :-
    usuario(Id, Nombre, Deuda, _, Estado, UsuarioIn),
    usuario(Id, Nombre, Deuda, NuevosLibros, Estado, UsuarioOut).                 

