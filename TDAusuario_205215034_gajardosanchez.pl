%TDAUsuario

%Representación: usuario(id, nombre, deuda, libros, estado).

%constructor %%%%%%%%%%%%%%%%%%%%%%

%Descripcion: Es el constructor del TDA usuario, genera una lista que representa un usuario
%Dominio: Id(int) X Nombre(string) X deuda(int) X libros(list) X PosicionActual(int) X estado(boolean)
%Recorrido:usuario (list), con los parametros señalados en el dominio.
%Tipo de algoritmo:

usuario(id, nombre, deuda, libros, estado, [id, nombre, deuda, libros, estado]).


%Pertenencia %%%%%%%%%%%%%%%%%%%%%%
%Descripcion: Funcion de pertenencia del TDA usuario, verifica si la lista tiene las caracteristicas de TDA usuario,  devuelve true si la entrada es valida
%Dominio: Id(int) X Nombre(string) X deuda(int) X libros(list) X PosicionActual(int) X estado(boolean)
%Recorrido: usuario (list), con los parametros señalados en el dominio.

esUsuario(usuario(_,_,_,_,_)).

%Selectores %%%%%%%%%%%%%%

%Descripción: esta funcion entrega el id del usuario
%Dom: usuario (list)
%Rec: id (int)
getUsuarioId(usuario, id) :-
    usuario(id, _, _, _, _, usuario).

%Descripción: esta funcion entrega el nombre del usuario
%Dom: usuario (list)
%Rec: nombre (int)
getUsuarioNombre(usuario, nombre) :-
    usuario(_, nombre, _, _, _, usuario).

%Descripción: esta funcion entrega la deuda del usuario
%Dom: usuario (list)
%Rec: deuda (int)
getUsuarioDeuda(usuario, deuda) :-
    usuario(_, _, deuda, _, _, usuario).

%Descripción: esta funcion entrega el id del usuario
%Dom: usuario (list)
%Rec: estado  (int)
getUsuarioEstado(usuario, estado) :-
    usuario(_, _, _, _, estado, usuario).

%Descripción: esta funcion entrega la lista de libros del usuario
%Dom: usuario (list)
%Rec: libros (int)
getUsuarioLibros(usuario, libros) :-
    usuario(_, _, _, libros, _, usuario).

%Modificadores %%%%%%%%%%%%%%%%%%%%

% Descripción: Esta función modifica la deuda de un usuario y entrega el resto de atributos iguales
% Dominio: usuario (list)
% Recorrido: usuarioModificado (list)
%Tipo de algoritmo: actualizacion de estructura
setUsuarioDeuda(usuarioIn, nuevaDeuda, usuarioOut) :-
    usuario(id, nombre, _, libros, estado, usuarioIn),
    usuario(id, nombre, nuevaDeuda, libros, estado, usuarioOut).
                 

% Descripción: Esta función modifica el estado de un usuario y entrega el resto de atributos iguales
% Dominio: usuario (list)
% Recorrido: usuarioModificado (list)
%Tipo de algoritmo: actualizacion de estructura
setUsuarioEstado(usuarioIn, nuevoEstado, usuarioOut) :-
    usuario(id, nombre, deuda, libros, _, usuarioIn),
    usuario(id, nombre, deuda, libros, nuevoEstado, usuarioOut).


% Descripción: Esta función modifica la lista de libros de un usuario y entrega el resto de atributos iguales
% Dominio: usuario (list)
% Recorrido: usuarioModificado (list)
%Tipo de algoritmo: actualizacion de estructura
setUsuarioLibros(usuarioIn, nuevosLibros, usuarioOut) :-
    usuario(id, nombre, deuda, _, estado, usuarioIn),
    usuario(id, nombre, deuda, nuevosLibros, estado, usuarioOut).                 

