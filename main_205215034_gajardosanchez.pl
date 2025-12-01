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
    obtenerUsuario/3,
	getFecha/2,
	isLibroDisponible/2,
	isUsuarioSuspendido/1,
	obtenerDeuda/2
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

%Descripcion: Crea un usuario con deuda inicial 0 y estado activo (no suspendido).
%Dominio: id (int) X nombre (string) X usuario (Usuario)
%Recorrido: usuario (lista)
%Tipo de algortimo:

crearUsuario(Id, Nombre, UsuarioOut) :-
    usuario(Id, Nombre, 0, [], true, UsuarioOut).



%RF3
%Descripcion: Crea un libro con id, título y autor. Título y autor se convierten en minúsculas al crear.
%Dominio: id (int) X titulo (string) X autor (string) X libro (Libro)
%Recorrido: libro (lista)

crearLibro(Id, Titulo, Autor, LibroOut) :-
    string_lower(Titulo, TituloMinuscula),
    string_lower(Autor, AutorMinuscula),
    libro(Id, TituloMinuscula, AutorMinuscula, true, LibroOut).

%RF4
%Descripcion:Crea un préstamo. Los días solicitados no deben exceder el maximo permitido por el sistema. 
%**Formato fecha: "DD/MM" donde todos los meses tienen 30 días**
%Dominio: id (int) X idUsuario (int) X idLibro (int) X fechaPrestamo (string) X diasSolicitados (int) X prestamo (Prestamo)

crearPrestamo(IdPrestamo, IdUsuario, IdLibro, FechaPrestamo, DiasSolicitados, PrestamoOut) :-
	prestamo(IdPrestamo, IdUsuario, IdLibro, FechaPrestamo, DiasSolicitados, PrestamoOut).


%RF5
%Descripcion: Crea la biblioteca con parámetros de configuración y fecha inicial del sistema. maxLibrosUsuario: límite de libros simultáneos. 
%diasMaxPrestamo: maximo de días permitidos. tasaMultaDiaria: monto por día de retraso. 
%limiteDeudaMax: deuda maxima antes de suspensión. diasMaxRetraso: días de retraso antes de suspensión. fechaInicial: fecha de inicio del sistema.
%Dominio:libros (Lista Libro) X usuarios (Lista Usuario) X prestamos (Lista Prestamo) X max-libros(int) X dias-max-prestamo (int) X
%tasa-multa-diaria (int) X limite-deuda-max (int) X dias-max-retraso (int) X fecha-inicial (string) X biblioteca (Biblioteca)

crearBiblioteca(Libros, Usuarios, Prestamos, MaxLibros, DiasMax, TasaMulta,
                LimiteDeuda, DiasRetraso, FechaInicial,
                biblioteca(Libros, Usuarios, Prestamos, MaxLibros, DiasMax,
                           TasaMulta, LimiteDeuda, DiasRetraso, FechaInicial)).

%RF6
%Descripcion: Agrega un libro a la biblioteca. 
%**Si el ID ya existe, no se agrega y retorna la biblioteca sin cambios**. Se permiten libros con mismo título/autor pero diferente ID. **La posición donde se agrega el libro queda a criterio del estudiante**.
%Dominio: biblioteca (Biblioteca) X libro (Libro) X biblioteca (Biblioteca)

% Verifica si un libro con ese ID ya existe
existeLibro(Id, Libros) :-
    member(libro(Id, _, _, _), Libros).

% Retorna true si el ID está disponible (no existe)
idLibroDisponible(Id, Libros) :-
    \+ existeLibro(Id, Libros).

% Agregar un libro solo si su ID está disponible
agregarLibro(BibliotecaIn, Libro1, BibliotecaOut) :-   
    getLibroId(Libro1, Id),
    getBibliotecaLibros(BibliotecaIn, Libros),
    idLibroDisponible(Id, Libros),      
    setBibliotecaLibros(BibliotecaIn, [Libro1 | Libros], BibliotecaOut).

%RF7
%Descripcion: Registra usuario en el sistema. **Si el ID ya existe, no se registra y retorna la biblioteca sin cambios**. Usuario inicia con deuda 0 y estado activo. 
%**El usuario debe agregarse AL FINAL de la lista de usuarios**.
%Dominio: biblioteca (Biblioteca) X usuario (Usuario) X biblioteca (Biblioteca)

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

existeUsuario(IdX, [U|_]) :-
    getUsuarioId(U, Id),
    Id =:= IdX, !.
existeUsuario(IdX, [_|UsuariosRestantes]) :-
    existeUsuario(IdX, UsuariosRestantes).
existeUsuario(_, []) :- fail. 


%RF8
%Descripcion: Busca usuario por ID. **Retorna false si no encuentra el usuario**.
%Dominio: biblioteca (Biblioteca) X id (int) X usuario (Usuario)

%Tipo de algortimo:

obtenerUsuario(BibliotecaIn, Id, Usuario) :-
    biblioteca(_, Usuarios, _, _, _, _, _, _, _, BibliotecaIn),
    member(U, Usuarios),
    getUsuarioId(U, Id),
    Id =:= IdUsuario.


%RF9
%Descripcion: Busca un libro por "id", "titulo" o "autor". **Para "titulo"/"autor": búsqueda parcial case insensitive (todo en minúsculas)**. 
%**Para "id": búsqueda exacta**. **Si hay multiples resultados, retorna el primero. Retorna false**.
%Dominio: biblioteca (Biblioteca) X criterio (string) X valor (string/int) X libro (Libro) 

%Tipo de algortimo:

buscarLibro(BibliotecaIn, Criterio, Valor, LibroOut) :-  %primer libro coincide
    biblioteca(Libros, _, _, _, _, _, _, _, _, BibliotecaIn),
    Libros = [L | _],



%RF11 
%Descripción: Obtiene la fecha actual del sistema desde la biblioteca.
%Dominio: biblioteca (Biblioteca) X fecha (String)

%Tipo de algortimo: 

getFecha(Biblioteca, Fecha) :- biblioteca(_, _, _, _, _, _, _, _, Fecha, Biblioteca).


%RF13
%Descripción: Verifica estado de suspensión del usuario. **Un usuario está suspendido si su campo suspendido es #t**.
%Dominio: usuario (Usuario)  

%Tipo de algortimo: 

isUsuarioSuspendido(Usuario) :-
    usuario(_, _, _, _, Estado, Usuario),
    Estado == true.



%RF14
%Descripción: Retorna la deuda acumulada del usuario.
%Dominio: usuario (Usuario) X deuda (int)

%Tipo de algortimo: 

obtenerDeuda(Usuario, Deuda) :-
    usuario(_, _, Deuda, _, _, Usuario).





