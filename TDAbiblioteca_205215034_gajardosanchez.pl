%TDA biblioteca

:- module(TDAbiblioteca_205215034_gajardosanchez, [
    biblioteca/10,
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
%Meta principal: 


biblioteca(Libros, Usuarios, Prestamos, MaxLibros, DiasMax, TasaMulta, LimiteDeuda, DiasRetraso, FechaInicial, 
           [Libros, Usuarios, Prestamos, MaxLibros, DiasMax, TasaMulta, LimiteDeuda, DiasRetraso, FechaInicial]).

%pertenencia
esBiblioteca([_, _, _, _, _, _, _, _, _]).

%selectores
%Descripción: entrega la lista de libros
%Dom: biblioteca (list)
%Meta principal: 

getBibliotecaLibros([Libros, _, _, _, _, _, _, _, _], Libros).

%Descripción: entrega la lista de usuarios
%Dom: biblioteca (list)
%Meta principal: 

getBibliotecaUsuarios([_, Usuarios, _, _, _, _, _, _, _], Usuarios).


%Descripción:  entrega la lista de prestamos
%Dom: biblioteca (list)
%Meta principal: 

getBibliotecaPrestamos([_, _, Prestamos, _, _, _, _, _, _], Prestamos).


%Descripción: entrega la cantidad maxima de libros que puede prestar
%Dom: biblioteca (list)
%Meta principal: 

getBibliotecaMaxLibros([_, _, _, MaxLibros, _, _, _, _, _], MaxLibros).


%Descripción: entrega los dias maximos 
%Dom: biblioteca (list)
%Meta principal: 
getBibliotecaDiasMax([_, _, _, _, DiasMax, _, _, _, _], DiasMax).


%Descripción: entrega la multa diaria en retraso de libros
%Dom: biblioteca (list)
%Meta principal: 
getBibliotecaTasaMulta([_, _, _, _, _, TasaMulta, _, _, _], TasaMulta).


%Descripción: entrega el limite de deuda 
%Dom: biblioteca (list)
%Meta principal: 
getBibliotecaLimiteDeuda([_, _, _, _, _, _, LimiteDeuda, _, _], LimiteDeuda).


%Descripción: entrega los dias de retraso maximo
%Dom: biblioteca (list)
%Meta principal: 
getBibliotecaDiasRetraso([_, _, _, _, _, _, _, DiasRetraso, _], DiasRetraso).


%Descripción: entrega la fecha inicial
%Dom: biblioteca (list)
%Meta principal: 
getBibliotecaFechaInicial([_, _, _, _, _, _, _, _, FechaInicial], FechaInicial).



%modificadores
% Descripción: modifica la lista de libros del tda biblioteca y entrega el resto de atributos iguales
% Dominio: biblioteca (list)
%Meta principal: 
%Tipo de algoritmo: actualizacion de estructura
setBibliotecaLibros([_, Usuarios, Prestamos, MaxLibros, DiasMax, TasaMulta, LimiteDeuda, DiasRetraso, FechaInicial], NuevoLibros, [NuevoLibros, Usuarios, Prestamos, MaxLibros, DiasMax, TasaMulta, LimiteDeuda, DiasRetraso, FechaInicial]).



% Descripción: modifica la lista de usuarios del tda biblioteca y entrega el resto de atributos iguales
% Dominio: biblioteca (list)
%Meta principal: 
%Tipo de algoritmo: actualizacion de estructura
setBibliotecaUsuarios([Libros, _, Prestamos, MaxLibros, DiasMax, TasaMulta, LimiteDeuda, DiasRetraso, FechaInicial], NuevosUsuarios, [Libros, NuevosUsuarios, Prestamos, MaxLibros, DiasMax, TasaMulta, LimiteDeuda, DiasRetraso, FechaInicial]).


% Descripción: modifica la lista de prestamos del tda biblioteca y entrega el resto de atributos iguales
% Dominio: biblioteca (list)
%Meta principal: 
%Tipo de algoritmo: actualizacion de estructura
setBibliotecaPrestamos([Libros, Usuarios, _, MaxLibros, DiasMax, TasaMulta, LimiteDeuda, DiasRetraso, FechaInicial], NuevosPrestamos, [Libros, Usuarios, NuevosPrestamos, MaxLibros, DiasMax, TasaMulta, LimiteDeuda, DiasRetraso, FechaInicial]).

% Descripción: modifica la fecha inicial del tda biblioteca y entrega el resto de atributos iguales
% Dominio: biblioteca (list)
%Meta principal: 
%Tipo de algoritmo: actualizacion de estructura
setBibliotecaFecha([Libros, Usuarios, Prestamos, MaxLibros, DiasMax, TasaMulta, LimiteDeuda, DiasRetraso, _], NuevaFechaInicial, [Libros, Usuarios, Prestamos, MaxLibros, DiasMax, TasaMulta, LimiteDeuda, DiasRetraso, NuevaFechaInicial]).
