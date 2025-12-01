%TDA biblioteca

:- module(TDAbiblioteca_205215034_gajardosanchez, [
    biblioteca/9,
	getBibliotecaLibros/2,
	getBibliotecaUsuarios/2,
	getBibliotecaPrestamos/2,
	getBibliotecaMaxLibros/2,
	getBibliotecaDiasMax/2,
	getBibliotecaTasaMulta/2,
	getBibliotecaLimiteDeuda/2,
	getBibliotecaDiasRetraso/2,
	getBibliotecaFechaInicial/2,
	setBibliotecaLibros/3,
	setBibliotecaUsuarios/3,
	setBibliotecaPrestamos/3,
	setBibliotecaFecha/3
]).



%representacion en lista
%libros, usuarios, prestamos, maxLibros, diasMax, tasaMulta, limiteDeuda, diasRetraso, fechaInicial, B

%constructor
%Descripcion: Es el constructor del TDA biblioteca, genera una lista que representa la biblioteca
%Dominio: libros (Lista Libro) X usuarios (Lista Usuario) X prestamos (Lista Prestamo) X max-libros-usuario (int) X dias-max-prestamo (int) X tasa-multa-diaria (int) X limite-deuda-max (int)
% X dias-max-retraso (int) X fecha-inicial (string) X biblioteca (Biblioteca)


biblioteca(Libros, Usuarios, Prestamos, MaxLibros, DiasMax, TasaMulta, LimiteDeuda, DiasRetraso, FechaInicial).


%pertenencia %%%%%%%%%%%5
esBiblioteca(B) :-
    biblioteca(_, _, _, _, _, _, _, _, _, B).


%selectores %%%%%%%%%%%%%%%%%%%%%

%Descripción: entrega la lista de libros
%Dom: biblioteca (list)

getBibliotecaLibros(B, Libros) :- biblioteca(Libros, _, _, _, _, _, _, _, _, B).


%Descripción: entrega la lista de usuarios
%Dom: biblioteca (list)

getBibliotecaUsuarios(B, Usuarios) :- biblioteca(_, Usuarios, _, _, _, _, _, _, _, B).


%Descripción:  entrega la lista de prestamos
%Dom: biblioteca (list)

getBibliotecaPrestamos(B, Prestamos) :- biblioteca(_, _, Prestamos, _, _, _, _, _, _, B).


%Descripción: entrega la cantidad maxima de libros que puede prestar
%Dom: biblioteca (list)

getBibliotecaMaxLibros(B, MaxLibros) :- biblioteca(_, _, _, MaxLibros, _, _, _, _, _, B).


%Descripción: entrega los dias maximos 
%Dom: biblioteca (list)

getBibliotecaDiasMax(B, DiasMax) :- biblioteca(_, _, _, _, DiasMax, _, _, _, _, B).


%Descripción: entrega la multa diaria en retraso de libros
%Dom: biblioteca (list)

getBibliotecaTasaMulta(B, TasaMulta) :- biblioteca(_, _, _, _, _, TasaMulta, _, _, _, B).


%Descripción: entrega el limite de deuda 
%Dom: biblioteca (list)

getBibliotecaLimiteDeuda(B, LimiteDeuda) :- biblioteca(_, _, _, _, _, _, LimiteDeuda, _, _, B).


%Descripción: entrega los dias de retraso maximo
%Dom: biblioteca (list)

getBibliotecaDiasRetraso(B, DiasRetraso) :- biblioteca(_, _, _, _, _, _, _, DiasRetraso, _, B).


%Descripción: entrega la fecha inicial
%Dom: biblioteca (list)

getBibliotecaFechaInicial(B, FechaInicial) :- biblioteca(_, _, _, _, _, _, _, _, FechaInicial, B).



%modificadores %%%%%%%%

% Descripción: modifica la lista de libros del tda biblioteca y entrega el resto de atributos iguales
% Dominio: biblioteca (list)

%Tipo de algoritmo: actualizacion de estructura
setBibliotecaLibros(BibliotecaIn, NuevoLibros, BibliotecaOut) :-
    biblioteca(_, Usuarios, Prestamos, MaxLibros, DiasMax, TasaMulta, LimiteDeuda, DiasRetraso, FechaInicial, BibliotecaIn),
    biblioteca(NuevoLibros, Usuarios, Prestamos, MaxLibros, DiasMax, TasaMulta, LimiteDeuda, DiasRetraso, FechaInicial, BibliotecaIn).


% Descripción: modifica la lista de usuarios del tda biblioteca y entrega el resto de atributos iguales
% Dominio: biblioteca (list)

%Tipo de algoritmo: actualizacion de estructura
setBibliotecaUsuarios(BibliotecaIn, NuevoUsuarios, BibliotecaOut) :-
    biblioteca(Libros, _, Prestamos, MaxLibros, DiasMax, TasaMulta, LimiteDeuda, DiasRetraso, FechaInicial, BibliotecaIn),
    biblioteca(Libros, NuevosUsuarios, Prestamos, MaxLibros, DiasMax, TasaMulta, LimiteDeuda, DiasRetraso, FechaInicial, BibliotecaIn).


% Descripción: modifica la lista de prestamos del tda biblioteca y entrega el resto de atributos iguales
% Dominio: biblioteca (list)

%Tipo de algoritmo: actualizacion de estructura
setBibliotecaPrestamos(BibliotecaIn, NuevoPrestamos, BibliotecaOut) :-
    biblioteca(Libros, Usuarios, _, MaxLibros, DiasMax, TasaMulta, LimiteDeuda, DiasRetraso, FechaInicial, BibliotecaIn),
    biblioteca(Libros, Usuarios, NuevosPrestamos, MaxLibros, DiasMax, TasaMulta, LimiteDeuda, DiasRetraso, FechaInicial, BibliotecaIn).


% Descripción: modifica la fecha inicial del tda biblioteca y entrega el resto de atributos iguales
% Dominio: biblioteca (list)

%Tipo de algoritmo: actualizacion de estructura
setBibliotecaFecha(BibliotecaIn, NuevaFechaInicial, BibliotecaOut) :-
    biblioteca(Libros, Usuarios, Prestamos, MaxLibros, DiasMax, TasaMulta, LimiteDeuda, DiasRetraso, _, BibliotecaIn),
    biblioteca(Libros, Usuarios, Prestamos, MaxLibros, DiasMax, TasaMulta, LimiteDeuda, DiasRetraso, NuevaFechaInicial, BibliotecaIn).
