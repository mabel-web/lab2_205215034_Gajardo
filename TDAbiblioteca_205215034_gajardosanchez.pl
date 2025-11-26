%TDA biblioteca
%representacion en lista
%libros, usuarios, prestamos, maxLibros, diasMax, tasaMulta, limiteDeuda, diasRetraso, fechaInicial, B

%constructor
%Descripcion: Es el constructor del TDA biblioteca, genera una lista que representa la biblioteca
%Dominio: libros (Lista Libro) X usuarios (Lista Usuario) X prestamos (Lista Prestamo) X max-libros-usuario (int) X dias-max-prestamo (int) X tasa-multa-diaria (int) X limite-deuda-max (int)
% X dias-max-retraso (int) X fecha-inicial (string) X biblioteca (Biblioteca)
%Recorrido: biblioteca (list), con los parametros señalados en el dominio

biblioteca(Libros, Usuarios, Prestamos, MaxLibros, DiasMax, TasaMulta, LimiteDeuda, DiasRetraso, FechaInicial,
           [Libros, Usuarios, Prestamos, MaxLibros, DiasMax, TasaMulta, LimiteDeuda, DiasRetraso, FechaInicial]).


%pertenencia %%%%%%%%%%%5
esBiblioteca(B) :-
    biblioteca(_, _, _, _, _, _, _, _, _, B).


%selectores %%%%%%%%%%%%%%%%%%%%%

%Descripción: esta funcion entrega la lista de libros
%Dom: biblioteca (list)
%Rec: libros (list)
getBibliotecaLibros(B, Libros) :- biblioteca(Libros, _, _, _, _, _, _, _, _, B).

%Descripción: esta funcion entrega la lista de usuarios
%Dom: biblioteca (list)
%Rec: usuarios (list)
getBibliotecaUsuarios(B, Usuarios) :- biblioteca(_, Usuarios, _, _, _, _, _, _, _, B).


%Descripción: esta funcion entrega la lista de prestamos
%Dom: biblioteca (list)
%Rec: prestamos (list)
getBibliotecaPrestamos(B, Prestamos) :- biblioteca(_, _, Prestamos, _, _, _, _, _, _, B).


%Descripción: esta funcion entrega la cantidad maxima de libros que puede prestar
%Dom: biblioteca (list)
%Rec: maxLibros (int)
getBibliotecaMaxLibros(B, MaxLibros) :- biblioteca(_, _, _, MaxLibros, _, _, _, _, _, B).


%Descripción: esta funcion entrega los dias maximos 
%Dom: biblioteca (list)
%Rec: diasMax (int)
getBibliotecaDiasMax(B, DiasMax) :- biblioteca(_, _, _, _, DiasMax, _, _, _, _, B).


%Descripción: esta funcion entrega la multa diaria en retraso de libros
%Dom: biblioteca (list)
%Rec: tasaMulta (int)
getBibliotecaTasaMulta(B, TasaMulta) :- biblioteca(_, _, _, _, _, TasaMulta, _, _, _, B).


%Descripción: esta funcion entrega el limite de deuda 
%Dom: biblioteca (list)
%Rec: limiteDeuda (int)
getBibliotecaLimiteDeuda(B, LimiteDeuda) :- biblioteca(_, _, _, _, _, _, LimiteDeuda, _, _, B).


%Descripción: esta funcion entrega los dias de retraso maximo
%Dom: biblioteca (list)
%Rec: diasRetraso (int)
getBibliotecaDiasRetraso(B, DiasRetraso) :- biblioteca(_, _, _, _, _, _, _, DiasRetraso, _, B).


%Descripción: esta funcion entrega la fecha inicial
%Dom: biblioteca (list)
%Rec: fechaInicial (string)
getBibliotecaFechaInicial(B, FechaInicial) :- biblioteca(_, _, _, _, _, _, _, _, FechaInicial, B).



%modificadores %%%%%%%%

% Descripción: Esta funcion modifica la lista de libros del tda biblioteca y entrega el resto de atributos iguales
% Dominio: biblioteca (list)
% Recorrido: bibliotecaModificado (list)
%Tipo de algoritmo: actualizacion de estructura
setBibliotecaLibros(BibliotecaIn, NuevoLibros, BibliotecaOut) :-
    biblioteca(_, Usuarios, Prestamos, MaxLibros, DiasMax, TasaMulta, LimiteDeuda, DiasRetraso, FechaInicial, BibliotecaIn),
    biblioteca(NuevoLibros, Usuarios, Prestamos, MaxLibros, DiasMax, TasaMulta, LimiteDeuda, DiasRetraso, FechaInicial, BibliotecaIn).


% Descripción: Esta funcion modifica la lista de usuarios del tda biblioteca y entrega el resto de atributos iguales
% Dominio: biblioteca (list)
% Recorrido: bibliotecaModificado (list)
%Tipo de algoritmo: actualizacion de estructura
setBibliotecaUsuarios(BibliotecaIn, NuevoUsuarios, BibliotecaOut) :-
    biblioteca(Libros, _, Prestamos, MaxLibros, DiasMax, TasaMulta, LimiteDeuda, DiasRetraso, FechaInicial, BibliotecaIn),
    biblioteca(Libros, NuevosUsuarios, Prestamos, MaxLibros, DiasMax, TasaMulta, LimiteDeuda, DiasRetraso, FechaInicial, BibliotecaIn).


% Descripción: Esta funcion modifica la lista de prestamos del tda biblioteca y entrega el resto de atributos iguales
% Dominio: biblioteca (list)
% Recorrido: bibliotecaModificado (list)
%Tipo de algoritmo: actualizacion de estructura
setBibliotecaPrestamos(BibliotecaIn, NuevoPrestamos, BibliotecaOut)) :-
    biblioteca(Libros, Usuarios, _, MaxLibros, DiasMax, TasaMulta, LimiteDeuda, DiasRetraso, FechaInicial, BibliotecaIn),
    biblioteca(Libros, Usuarios, NuevosPrestamos, MaxLibros, DiasMax, TasaMulta, LimiteDeuda, DiasRetraso, FechaInicial, BibliotecaIn).


% Descripción: Esta funcion modifica la fecha inicial del tda biblioteca y entrega el resto de atributos iguales
% Dominio: biblioteca (list)
% Recorrido: bibliotecaModificado (list)
%Tipo de algoritmo: actualizacion de estructura
setBibliotecaFecha(BibliotecaIn, NuevaFechaInicial, BibliotecaOut) :-
    biblioteca(Libros, Usuarios, Prestamos, MaxLibros, DiasMax, TasaMulta, LimiteDeuda, DiasRetraso, _, BibliotecaIn),
    biblioteca(Libros, Usuarios, Prestamos, MaxLibros, DiasMax, TasaMulta, LimiteDeuda, DiasRetraso, NuevaFechaInicial, BibliotecaIn)).
