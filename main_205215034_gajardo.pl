%RF2

%Descripcion: Crea un usuario con deuda inicial 0 y estado activo (no suspendido).
%Dominio: id (int) X nombre (string) X usuario (Usuario)
%Recorrido: usuario (lista)
%Tipo de algortimo:

crearUsuario(Id, Nombre, UsuarioOut) :-
    usuario(Id, Nombre, 0, #t, [], UsuarioOut).
****************


%RF3
%Descripcion: Crea un libro con id, título y autor. Título y autor se convierten en minúsculas al crear.
%Dominio: id (int) X titulo (string) X autor (string) X libro (Libro)
%Recorrido: libro (lista)

crearLibro(Id, Titulo, Autor, LibroOut) :-
    string_lower(Titulo, TituloMinuscula),
    string_lower(Autor, AutorMinuscula),
    libro(Id, TituloMinuscula, AutorMinuscula, #t, LibroOut).

%RF4
%Descripcion:Crea un préstamo. Los días solicitados no deben exceder el máximo permitido por el sistema. 
%**Formato fecha: "DD/MM" donde todos los meses tienen 30 días**
%Dominio: id (int) X idUsuario (int) X idLibro (int) X fechaPrestamo (string) X diasSolicitados (int) X prestamo (Prestamo)
%Recorrido:
crearPrestamo(IdPrestramo, IdUsuario, IdLibro, FechaPrestamo, DiasSolicitados, PrestamoOut) :-
	prestamo(IdPrestamo, IdUsuario, IdLibro, FechaPrestamo, DiasSolicitados, PrestamoOut).


%RF5
%Descripcion: Crea la biblioteca con parámetros de configuración y **fecha inicial del sistema**. maxLibrosUsuario: límite de libros simultáneos. 
%diasMaxPrestamo: máximo de días permitidos. tasaMultaDiaria: monto por día de retraso. 
%limiteDeudaMax: deuda máxima antes de suspensión. diasMaxRetraso: días de retraso antes de suspensión. fechaInicial: fecha de inicio del sistema.
%Dominio:libros (Lista Libro) X usuarios (Lista Usuario) X prestamos (Lista Prestamo) X max-libros(int) X dias-max-prestamo (int) X
%tasa-multa-diaria (int) X limite-deuda-max (int) X dias-max-retraso (int) X fecha-inicial (string) X biblioteca (Biblioteca)
%Recorrido: biblioteca (lista)

crearBiblioteca(Libros, Usuarios, Prestamos, MaxLibros, DiasMax, TasaMulta, LimiteDeuda, DiasRetraso, FechaInicial, BibliotecaOut) :-
    biblioteca(Libros, Usuarios, Prestamos, MaxLibros, DiasMax, TasaMulta, LimiteDeuda, DiasRetraso, FechaInicial, BibliotecaOut).

%RF6
%Descripcion: Agrega un libro a la biblioteca. 
%**Si el ID ya existe, no se agrega y retorna la biblioteca sin cambios**. Se permiten libros con mismo título/autor pero diferente ID. **La posición donde se agrega el libro queda a criterio del estudiante**.
%Dominio: biblioteca (Biblioteca) X libro (Libro) X biblioteca (Biblioteca)
%Recorrido: biblioteca (Biblioteca)

existeLibro(IdX, [L|_]) :-
    getLibroId(L, Id),
    Id =:= IdX, !.
existeLibro(IdX, [_|LibrosRestantes]) :- % siguo buscando
    existeLibro(IdX, LibrosRestantes).
existeLibro(_, []) :-  % al final de la lista, no existe
    fail.

agregarLibro(BibliotecaIn, Libro1, BibliotecaOut) :-             
    biblioteca(Libros, _, _, _, _, _, _, _, _, BibliotecaIn),
    getLibroId(Libro, Id),
    existeLibro(Id, Libros),
    BibliotecaOut = BibliotecaIn,   % salida = entrada
    !.

agregarLibro(BibliotecaIn, Libro1, BibliotecaOut) :-
    biblioteca(Libros, Usuarios, Prestamos, MaxLibros, DiasMax, TasaMulta, LimiteDeuda, DiasRetraso, FechaInicial, BibliotecaIn),
    LibrosNuevos = [Libro1|Libros],
    biblioteca(LibrosNuevos, Usuarios, Prestamos, MaxLibros, DiasMax, TasaMulta, LimiteDeuda, DiasRetraso, FechaInicial, BibliotecaOut).


%RF7
%Descripcion: Registra usuario en el sistema. **Si el ID ya existe, no se registra y retorna la biblioteca sin cambios**. Usuario inicia con deuda 0 y estado activo. 
%**El usuario debe agregarse AL FINAL de la lista de usuarios**.
%Dominio: biblioteca (Biblioteca) X usuario (Usuario) X biblioteca (Biblioteca)
%Recorrido: biblioteca (Biblioteca)

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
%Recorrido: usuario (Usuario)
%Tipo de algortimo:

obtenerUsuario(BibliotecaIn, Id, Usuario) :-
    biblioteca(_, Usuarios, _, _, _, _, _, _, _, BibliotecaIn),
    member(U, Usuarios),
    getUsuarioId(U, Id),
    Id =:= IdUsuario.


%RF10
%Descripción: esta funcion entrega el id del libro
%Dom: libro (list)
%Rec: idLibro (int)
getLibroId(L, IdLibro) :-
    libro(IdLibro, _, _, _, L).