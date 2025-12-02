:- module(main, [
    fecha/4,
	crearUsuario/3,
	crearLibro/4,
	crearPrestamo/6,
	crearBiblioteca/10,
    agregarLibro/3,
    existeLibro/2,
    idLibroDisponible/2,
    registrarUsuario/3,
    existeUsuario/2,
    buscarLibro/4,
    busquedaParcial/3,
    obtenerUsuario/3,
	getFecha/2,
	isLibroDisponible/2,
	isUsuarioSuspendido/1,
	obtenerDeuda/2,
    obtenerFechaVencimiento/2
]).

:- use_module('TDAlibro_205215034_gajardosanchez.pl', [
    libro/5, esLibro/1, getLibroId/2, getLibroTitulo/2, getLibroAutor/2, getLibroDisponibilidad/2, setLibroDisponibilidad/3
]).

:- use_module('TDAusuario_205215034_gajardosanchez.pl', [
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

:- use_module('TDAbiblioteca_205215034_gajardosanchez.pl', [
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

:- use_module('TDAprestamo_205215034_gajardosanchez.pl', [
    prestamo/6,
    getPrestamoId/2,
    getPrestamoUsuario/2,
    getPrestamoLibro/2,
    getPrestamoFecha/2,
    getPrestamoDias/2,
    setPrestamoDiasSolicitados/3
]).


%constructor tda fecha
fecha(Ano, Mes, Dia, [Ano, Mes, Dia]).


%RF2

%Descripcion: Crea un usuario con deuda inicial 0 y estado activo (no suspendido = false).
%Dominio: id (int) X nombre (string) X usuario (Usuario)
%Meta principal: crearUsuario/3
%Meta secundaria:
%Tipo de algortimo:

crearUsuario(Id, Nombre, UsuarioOut) :-
    usuario(Id, Nombre, 0, [], false, UsuarioOut).



%RF3
%Descripcion: Crea un libro con id, título y autor. Título y autor se convierten en minúsculas al crear.
%Dominio: id (int) X titulo (string) X autor (string) X libro (Libro)
%Meta principal: crearLibro/4
%Meta secundaria:

crearLibro(Id, Titulo, Autor, LibroOut) :-
    string_lower(Titulo, TituloMinuscula),
    string_lower(Autor, AutorMinuscula),
    libro(Id, TituloMinuscula, AutorMinuscula, true, LibroOut).

%RF4
%Descripcion:Crea un préstamo. Los días solicitados no deben exceder el maximo permitido por el sistema. 
%**Formato fecha: "DD/MM" donde todos los meses tienen 30 días**
%Dominio: id (int) X idUsuario (int) X idLibro (int) X fechaPrestamo (string) X diasSolicitados (int) X prestamo (Prestamo)
%Meta principal: crearPrestamo/6
%Meta secundaria:

crearPrestamo(IdPrestamo, IdUsuario, IdLibro, FechaPrestamo, DiasSolicitados, PrestamoOut) :-
	prestamo(IdPrestamo, IdUsuario, IdLibro, FechaPrestamo, DiasSolicitados, PrestamoOut).


%RF5
%Descripcion: Crea la biblioteca con parámetros de configuración y fecha inicial del sistema. maxLibrosUsuario: límite de libros simultáneos. 
%diasMaxPrestamo: maximo de días permitidos. tasaMultaDiaria: monto por día de retraso. 
%limiteDeudaMax: deuda maxima antes de suspensión. diasMaxRetraso: días de retraso antes de suspensión. fechaInicial: fecha de inicio del sistema.
%Dominio:libros (Lista Libro) X usuarios (Lista Usuario) X prestamos (Lista Prestamo) X max-libros(int) X dias-max-prestamo (int) X
%tasa-multa-diaria (int) X limite-deuda-max (int) X dias-max-retraso (int) X fecha-inicial (string) X biblioteca (Biblioteca)
%Meta principal: crearBiblioteca/10
%Meta secundaria:

crearBiblioteca(Libros, Usuarios, Prestamos, MaxLibros, DiasMax, TasaMulta, LimiteDeuda, DiasRetraso, FechaInicial,
[Libros, Usuarios, Prestamos, MaxLibros, DiasMax, TasaMulta, LimiteDeuda, DiasRetraso, FechaInicial]).

%RF6 
% Descripcion: Agrega un libro a la biblioteca. 
%**Si el ID ya existe, no se agrega y retorna la biblioteca sin cambios**. Se permiten libros con mismo título/autor pero diferente ID. **La posición donde se agrega el libro queda a criterio del estudiante**.
% Dominio: biblioteca (Biblioteca) X libro (Libro) X biblioteca (Biblioteca)
%Meta principal: existeLibro/2
%Meta secundaria:

existeLibro(Id, Libros) :-
    member([Id, _, _, _], Libros).

%metra principal: isLibroDisponible/2
idLibroDisponible(Id, Libros) :-
    \+ existeLibro(Id, Libros).

agregarLibro(BibliotecaIn, Libro1, BibliotecaOut) :- 
    esLibro(Libro1),
    getLibroId(Libro1, Id),
    getBibliotecaLibros(BibliotecaIn, Libros),
    idLibroDisponible(Id, Libros),  
    append(Libros, [Libro1], NuevosLibros),    
    setBibliotecaLibros(BibliotecaIn, NuevosLibros, BibliotecaOut).

%RF7
%Descripcion: Registra usuario en el sistema. **Si el ID ya existe, no se registra y retorna la biblioteca sin cambios**. Usuario inicia con deuda 0 y estado activo. 
%**El usuario debe agregarse AL FINAL de la lista de usuarios**.
%Dominio: biblioteca (Biblioteca) X usuario (Usuario) X biblioteca (Biblioteca)
%Meta principal: registrarUsuario/3
%Meta secundaria:

registrarUsuario(BibliotecaIn, Usuario, BibliotecaOut) :-              
    biblioteca(_, Usuarios, _, _, _, _, _, _, _, BibliotecaIn),
    getUsuarioId(Usuario, IdNuevo),
    existeUsuario(IdNuevo, Usuarios), 
    BibliotecaOut = BibliotecaIn,
    !. 
registrarUsuario(BibliotecaIn, Usuario, BibliotecaOut) :-  %  agrego y reconstruyo la biblioteca
    biblioteca(Libros, Usuarios, Prestamos, MaxLibros, DiasMax, TasaMulta, LimiteDeuda, DiasRetraso, Fecha, BibliotecaIn),
    append(Usuarios, [Usuario], UsuariosNuevos),
    biblioteca(Libros, UsuariosNuevos, Prestamos, MaxLibros, DiasMax, TasaMulta, LimiteDeuda, DiasRetraso, Fecha, BibliotecaOut).

%meta principal: existeUsuario/2
existeUsuario(IdX, [U|_]) :-
    getUsuarioId(U, Id),
    Id =:= IdX, !.
existeUsuario(IdX, [_|UsuariosRestantes]) :-
    existeUsuario(IdX, UsuariosRestantes).
existeUsuario(_, []) :- fail. 


%RF8
%Descripcion: Busca usuario por ID. **Retorna false si no encuentra el usuario**.
%Dominio: biblioteca (Biblioteca) X id (int) X usuario (Usuario)
%Meta principal: obtenerUsuario/3
%Meta secundaria:
%Tipo de algortimo:

obtenerUsuario(BibliotecaIn, Id, Usuario) :-
    getBibliotecaUsuarios(BibliotecaIn, Usuarios),
    member(Usuario, Usuarios),
    getUsuarioId(Usuario, Id).


%RF9
%Descripcion: Busca un libro por "id", "titulo" o "autor". **Para "titulo"/"autor": búsqueda parcial case insensitive (todo en minúsculas)**. 
%**Para "id": búsqueda exacta**. **Si hay multiples resultados, retorna el primero. Retorna false**.
%Dominio: biblioteca (Biblioteca) X criterio (string) X valor (string/int) X libro (Libro) 
%Meta principal: buscarLibro/4
%Meta secundaria:
%Tipo de algortimo:

buscarLibro(BibliotecaIn, Criterio, Valor, LibroOut) :-  %primer libro coincide
    getBibliotecaLibros(BibliotecaIn, Libros),
    member(LibroOut, Libros),
    busquedaParcial(Criterio, Valor, LibroOut), !.
busquedaParcial(id, Valor, Libro) :-
    getLibroId(Libro, IdLibro),
    IdLibro =:= Valor.
busquedaParcial(titulo, Valor, Libro) :-
    getLibroTitulo(Libro, Titulo),
    string_lower(Titulo, TituloMinuscula),
    string_lower(Valor, ValorMinuscula),
    sub_string(TituloMinuscula, _, _, _, ValorMinuscula).
busquedaParcial(autor, Valor, Libro) :-
    getLibroAutor(Libro, Autor),
    string_lower(Autor, AutorMinuscula),
    string_lower(Valor, ValorMinuscula),
    sub_string(AutorMinuscula, _, _, _, ValorMinuscula).


%RF11 
%Descripción: Obtiene la fecha actual del sistema desde la biblioteca.
%Dominio: biblioteca (Biblioteca) X fecha (String)
%Meta principal: getFecha/2
%Meta secundaria:
%Tipo de algortimo: 
getFecha(Biblioteca, Fecha) :- 
    getBibliotecaFechaInicial(Biblioteca, Fecha).

%RF12
%Descripción: Verifica si un libro está disponible (no prestado). **Retorna false si el libro no existe o está prestado**.
%Dominio: biblioteca (Biblioteca) X idLibro (int)
%Meta principal: isLibroDisponible/2
%Meta secundaria:
%Tipo de algortimo: 

isLibroDisponible(BibliotecaIn, IdLibro) :-
    getBibliotecaLibros(BibliotecaIn, Libros),
    \+ existeLibro(IdLibro, Libros), !, fail. %pregunto si el libro no existe, si es vd corte y fail para buscar otra respuesta
isLibroDisponible(BibliotecaIn, IdLibro) :-
    buscarLibro(BibliotecaIn, Id, IdLibro, Libro),
    getLibroDisponibilidad(Libro, Disponibilidad),
    Disponibilidad == false , !, fail.
isLibroDisponible(BibliotecaIn, IdLibro) :-
    buscarLibro(BibliotecaIn, Id, IdLibro, Libro),
    getLibroDisponibilidad(Libro, Disponibilidad),
    Disponibilidad == true.


%RF13
%Descripción: Verifica estado de suspensión del usuario. **Un usuario está suspendido si su campo suspendido es true**.
%Dominio: usuario (Usuario)  
%Meta principal: isUsuarioSuspendido/1
%Meta secundaria:
%Tipo de algortimo: 

isUsuarioSuspendido(Usuario) :- %%%%%%%%% no retorna true pero retorna la lista, y retorna false bien
    getUsuarioEstado(Usuario, Estado),
    Estado == true.


%RF14
%Descripción: Retorna la deuda acumulada del usuario.
%Dominio: usuario (Usuario) X deuda (int)
%Meta principal: obtenerDeuda/2
%Meta secundaria:
%Tipo de algortimo: 

obtenerDeuda(Usuario, Deuda) :-
    getUsuarioDeuda(Usuario, Deuda).


%RF15
%Descripción: Calcula fecha de vencimiento sumando días solicitados a fecha de préstamo. 
%**Formato "DD/MM", todos los meses tienen 30 días. Si pasa del día 30, cambia de mes**.
%Dominio: prestamo (Prestamo) X fecha (String)
%Meta principal: obtenerFechaVencimiento/2
%Meta secundaria:
%Tipo de algortimo: 

obtenerFechaVencimiento(Prestamo, Fecha) :- 
    getPrestamoFecha(Prestamo, Fecha), 
    getPrestamoDias(Prestamo, DiasSolicitados),
  