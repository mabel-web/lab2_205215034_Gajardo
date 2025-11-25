%TDA biblioteca
%representacion en lista
%libros, usuarios, prestamos, maxLibros, diasMax, tasaMulta, limiteDeuda, diasRetraso, fechaInicial, B

%constructor
%Descripcion: Es el constructor del TDA biblioteca, genera una lista que representa la biblioteca
%Dominio: libros (Lista Libro) X usuarios (Lista Usuario) X prestamos (Lista Prestamo) X max-libros-usuario (int) X dias-max-prestamo (int) X tasa-multa-diaria (int) X limite-deuda-max (int)
% X dias-max-retraso (int) X fecha-inicial (string) X biblioteca (Biblioteca)
%Recorrido: biblioteca (list), con los parametros señalados en el dominio

biblioteca(libros, usuarios, prestamos, maxLibros, diasMax, tasaMulta, limiteDeuda, diasRetraso, fechaInicial,
           [libros, usuarios, prestamos, maxLibros, diasMax, tasaMulta, limiteDeuda, diasRetraso, fechaInicial]).


%pertenencia %%%%%%%%%%%5
esBiblioteca(B) :-
    biblioteca(_, _, _, _, _, _, _, _, _, B).





%selectores %%%%%%%%%%%%%%%%%%%%%
%CAMBIAR A INICIALES LOS OTROS TDA PORQUE LO PIDE EN EL DOC

%Descripción: esta funcion entrega la lista de libros
%Dom: biblioteca (list)
%Rec: libros (list)
getBibliotecaLibros(B, libros) :- biblioteca(libros, _, _, _, _, _, _, _, _, B).

%Descripción: esta funcion entrega la lista de usuarios
%Dom: biblioteca (list)
%Rec: usuarios (list)
getBibliotecaUsuarios(B, usuarios) :- biblioteca(_, usuarios, _, _, _, _, _, _, _, B).


%Descripción: esta funcion entrega la lista de prestamos
%Dom: biblioteca (list)
%Rec: prestamos (list)
getBibliotecaPrestamos(B, prestamos) :- biblioteca(_, _, prestamos, _, _, _, _, _, _, B).


%Descripción: esta funcion entrega la cantidad maxima de libros que puede prestar
%Dom: biblioteca (list)
%Rec: maxLibros (int)
getBibliotecaMaxLibros(B, maxLibros) :- biblioteca(_, _, _, maxLibros, _, _, _, _, _, B).


%Descripción: esta funcion entrega los dias maximos 
%Dom: biblioteca (list)
%Rec: diasMax (int)
getBibliotecaDiasMax(B, diasMax) :- biblioteca(_, _, _, _, diasMax, _, _, _, _, B).


%Descripción: esta funcion entrega la multa diaria en retraso de libros
%Dom: biblioteca (list)
%Rec: tasaMulta (int)
getBibliotecaTasaMulta(B, tasaMulta) :- biblioteca(_, _, _, _, _, tasaMulta, _, _, _, B).


%Descripción: esta funcion entrega el limite de deuda 
%Dom: biblioteca (list)
%Rec: limiteDeuda (int)
getBibliotecaLimiteDeuda(B, limiteDeuda) :- biblioteca(_, _, _, _, _, _, limiteDeuda, _, _, B).


%Descripción: esta funcion entrega los dias de retraso maximo
%Dom: biblioteca (list)
%Rec: diasRetraso (int)
getBibliotecaDiasRetraso(B, diasRetraso) :- biblioteca(_, _, _, _, _, _, _, diasRetraso, _, B).


%Descripción: esta funcion entrega la fecha inicial
%Dom: biblioteca (list)
%Rec: fechaInicial (string)
getBibliotecaFechaInicial(B, fechaInicial) :- biblioteca(_, _, _, _, _, _, _, _, fechaInicial, B).



%modificadores %%%%%%%%

% Descripción: Esta funcion modifica la lista de libros del tda biblioteca y entrega el resto de atributos iguales
% Dominio: biblioteca (list)
% Recorrido: bibliotecaModificado (list)
%Tipo de algoritmo: actualizacion de estructura
setBibliotecaLibros(bibliotecaIn, nuevoLibros, bibliotecaOut) :-
    biblioteca(_, usuarios, prestamos, maxLibros, diasMax, tasaMulta, limiteDeuda, diasRetraso, fechaInicial, bibliotecaIn),
    biblioteca(nuevoLibros, usuarios, prestamos, maxLibros, diasMax, tasaMulta, limiteDeuda, diasRetraso, fechaInicial, bibliotecaIn)).


% Descripción: Esta funcion modifica la lista de usuarios del tda biblioteca y entrega el resto de atributos iguales
% Dominio: biblioteca (list)
% Recorrido: bibliotecaModificado (list)
%Tipo de algoritmo: actualizacion de estructura
setBibliotecaUsuarios(bibliotecaIn, nuevoUsuarios, bibliotecaOut) :-
    biblioteca(libros, _, prestamos, maxLibros, diasMax, tasaMulta, limiteDeuda, diasRetraso, fechaInicial, bibliotecaIn),
    biblioteca(libros, nuevosUsuarios, prestamos, maxLibros, diasMax, tasaMulta, limiteDeuda, diasRetraso, fechaInicial, bibliotecaIn).


% Descripción: Esta funcion modifica la lista de prestamos del tda biblioteca y entrega el resto de atributos iguales
% Dominio: biblioteca (list)
% Recorrido: bibliotecaModificado (list)
%Tipo de algoritmo: actualizacion de estructura
setBibliotecaPrestamos(bibliotecaIn, nuevoPrestamos, bibliotecaOut)) :-
    biblioteca(libros, usuarios, _, maxLibros, diasMax, tasaMulta, limiteDeuda, diasRetraso, fechaInicial, bibliotecaIn),
    biblioteca(libros, usuarios, nuevosPrestamos, maxLibros, diasMax, tasaMulta, limiteDeuda, diasRetraso, fechaInicial, bibliotecaIn).


% Descripción: Esta funcion modifica la fecha inicial del tda biblioteca y entrega el resto de atributos iguales
% Dominio: biblioteca (list)
% Recorrido: bibliotecaModificado (list)
%Tipo de algoritmo: actualizacion de estructura
setBibliotecaFecha(bibliotecaIn, nuevaFechaInicial, bibliotecaOut) :-
    biblioteca(libros, usuarios, prestamos, maxLibros, diasMax, tasaMulta, limiteDeuda, diasRetraso, _, bibliotecaIn),
    biblioteca(libros, usuarios, prestamos, maxLibros, diasMax, tasaMulta, limiteDeuda, diasRetraso, nuevaFechaInicial, bibliotecaIn)).
