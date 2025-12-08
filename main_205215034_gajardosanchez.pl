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
    obtenerFechaVencimiento/2,
    calcularDiasRetraso/3,
    calcularMulta/4,
    tomarPrestamo/6,
    devolverLibro/5,
    debeSuspenderse/3,
    suspenderUsuario/3,
    renovarPrestamo/5,
    pagarDeuda/4,
    historialPrestamosUsuario/3,
    historialPrestamosSistema/2
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
%Meta secundaria: usuario/6

crearUsuario(Id, Nombre, UsuarioOut) :-
    usuario(Id, Nombre, 0, [], false, UsuarioOut).

%RF3
%Descripcion: Crea un libro con id, título y autor. Título y autor se convierten en minúsculas al crear.
%Dominio: id (int) X titulo (string) X autor (string) X libro (Libro)
%Meta principal: crearLibro/4
%Meta secundaria: string_lower/2, libro/5 

crearLibro(Id, Titulo, Autor, LibroOut) :-
    string_lower(Titulo, TituloMinuscula),
    string_lower(Autor, AutorMinuscula),
    libro(Id, TituloMinuscula, AutorMinuscula, true, LibroOut).

%RF4
%Descripcion:Crea un préstamo. Los días solicitados no deben exceder el maximo permitido por el sistema. 
%**Formato fecha: "DD/MM" donde todos los meses tienen 30 días**
%Dominio: id (int) X idUsuario (int) X idLibro (int) X fechaPrestamo (string) X diasSolicitados (int) X prestamo (Prestamo)
%Meta principal: crearPrestamo/6
%Meta secundaria: string/1, prestamo/6, crearPrestamo/6, atom/1, atom_string/2

crearPrestamo(IdPrestamo, IdUsuario, IdLibro, FechaPrestamo, DiasSolicitados, PrestamoOut) :-
	string(FechaPrestamo),
    prestamo(IdPrestamo, IdUsuario, IdLibro, FechaPrestamo, DiasSolicitados, PrestamoOut).
crearPrestamo(IdPrestamo, IdUsuario, IdLibro, FechaPrestamo, DiasSolicitados, PrestamoOut) :-
    atom(FechaPrestamo),
    atom_string(FechaPrestamo, FechaString),
    prestamo(IdPrestamo, IdUsuario, IdLibro, FechaString, DiasSolicitados, PrestamoOut).

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
%Meta secundaria: esLibro/1, getLibroId/2, getBibliotecaLibros/2, idLibroDisponible/2, append/3, setBibliotecaLibros/3

agregarLibro(BibliotecaIn, Libro1, BibliotecaOut) :- 
    esLibro(Libro1),
    getLibroId(Libro1, Id),
    getBibliotecaLibros(BibliotecaIn, Libros),
    idLibroDisponible(Id, Libros),  
    append(Libros, [Libro1], NuevosLibros),    
    setBibliotecaLibros(BibliotecaIn, NuevosLibros, BibliotecaOut).
existeLibro(Id, Libros) :-
    member([Id, _, _, _], Libros).
idLibroDisponible(Id, Libros) :-
    \+ existeLibro(Id, Libros).

%RF7
%Descripcion: Registra usuario en el sistema. **Si el ID ya existe, no se registra y retorna la biblioteca sin cambios**. Usuario inicia con deuda 0 y estado activo. 
%**El usuario debe agregarse AL FINAL de la lista de usuarios**.
%Dominio: biblioteca (Biblioteca) X usuario (Usuario) X biblioteca (Biblioteca)
%Meta principal: registrarUsuario/3
%Meta secundaria: biblioteca/10, getUsuarioId/2, existeUsuario/2, append/3

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
%Meta principal: obtenerUsuario/3
%Meta secundaria: getBibliotecaUsuarios/2, member/2, getUsuarioId/2
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
%Meta secundaria: getBibliotecaLibros/2, member/2, busquedaParcial/3, getLibroId/2, getLibroTitulo/2, string_lower/2, sub_string/5, getLibroAutor/2

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
%Meta secundaria:getBibliotecaFechaInicial/2

getFecha(Biblioteca, Fecha) :- 
    getBibliotecaFechaInicial(Biblioteca, Fecha).

%RF12
%Descripción: Verifica si un libro está disponible (no prestado). **Retorna false si el libro no existe o está prestado**.
%Dominio: biblioteca (Biblioteca) X idLibro (int)
%Meta principal: isLibroDisponible/2
%Meta secundaria: getBibliotecaLibros/2, existeLibro/2, isLibroDisponible/2, buscarLibro/4, getLibroDisponibilidad/2

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
%Descripción: Verifica estado de suspensión del usuario.
%Dominio: usuario (Usuario)  
%Meta principal: isUsuarioSuspendido/1
%Meta secundaria: getUsuarioEstado/2

isUsuarioSuspendido(Usuario) :- 
    getUsuarioEstado(Usuario, Estado),
    Estado == true. 
    % Si el estado es falso entonces esta activo y retorns true

%RF14
%Descripción: Retorna la deuda acumulada del usuario.
%Dominio: usuario (Usuario) X deuda (int)
%Meta principal: obtenerDeuda/2
%Meta secundaria: getUsuarioDeuda/2

obtenerDeuda(Usuario, Deuda) :-
    getUsuarioDeuda(Usuario, Deuda).


%RF15
%Descripción: Calcula fecha de vencimiento sumando días solicitados a fecha de préstamo. 
%**Formato "DD/MM", todos los meses tienen 30 días. Si pasa del día 30, cambia de mes**.
%Dominio: prestamo (Prestamo) X fecha (String)
%Meta principal: obtenerFechaVencimiento/2
%Meta secundaria: getPrestamoFecha/2, getPrestamoDias/2, split_string/4, number_string/2, agregarCero/2, string_concat/3


obtenerFechaVencimiento(Prestamo, Fecha) :- 
    getPrestamoFecha(Prestamo, FechaString), 
    getPrestamoDias(Prestamo, DiasSolicitados),
    split_string(FechaString, "/", "", FechaSeparada),
    FechaSeparada = [DiaString, MesString],
    number_string(Dia, DiaString),
    number_string(Mes, MesString),
    DiaActual is Dia + DiasSolicitados,
    MesesExtra is (DiaActual - 1) // 30,
    DiaFinal is ((DiaActual - 1) mod 30) + 1,
    MesFinal is Mes + MesesExtra,
    agregarCero(DiaFinal, DiaFinalString), % si el número es un digito le agrego un cero 
    agregarCero(MesFinal, MesFinalString),
    string_concat(DiaFinalString, "/", DiasGuardados),
    string_concat(DiasGuardados, MesFinalString, Fecha).
agregarCero(Numero, String) :-
    Numero < 10,
    number_string(Numero, NumeroString),
    string_concat("0", NumeroString, String).
agregarCero(Numero, String) :-
    Numero >= 10,
    number_string(Numero, String).


%RF16
%Descripción: Calcula días de retraso entre fecha de vencimiento y fecha actual. 
%**Retorna 0 si no hay retraso (fecha actual <= vencimiento)**
%Dominio: fecha-vencimiento (string) X fecha-actual (string) X dias (int)
%Meta principal: calcularDiasRetraso/3
%Meta secundaria:
%Tipo de algortimo: 

calcularDiasRetraso(FechaVenc, FechaActual, DiasRetraso) :- 
    split_string(FechaVenc, "/", "", [DiaVencString, MesVencString]),
    number_string(DiaVenc, DiaVencString),
    number_string(MesVenc, MesVencString),
    split_string(FechaActual, "/", "", [DiaActString, MesActString]),
    number_string(DiaActual, DiaActString),
    number_string(MesActual, MesActString),
    DiasVenc is MesVenc * 30 + DiaVenc,
    DiasActual is MesActual * 30 + DiaActual,
    Diferencia is DiasActual - DiasVenc,
    DiasRetraso is max(0, Diferencia).

%RF17
%Descripcion: Calcula multa multiplicando días de retraso por tasa diaria. **Si no hay retraso, multa es 0**.
%Dominio: prestamo (Prestamo) X fecha-actual (string) X tasa-multa-diaria (int) X multa (number)
%Meta principal: calcularMulta/4
%Meta secundaria: obtenerFechaVencimiento/2, calcularDiasRetraso/3

calcularMulta(PrestamoIn, FechaActual, Tasa, Multa) :-  
    obtenerFechaVencimiento(PrestamoIn, FechaVenc),
    calcularDiasRetraso(FechaVenc, FechaActual, DiasRetraso),
    Multa is DiasRetraso * Tasa.

%RF18
%Descripcion:Usuario toma libro prestado. **Verifica: 1) libro disponible, 2) usuario no suspendido, 3) no excede límite de libros, 
%4) días solicitados no exceden maximo, 5) deuda no excede límite**. **Si alguna verificación falla retorna false**.
%Dominio: biblioteca (Biblioteca) X id-usuario (int) X id-libro (int) X dias-solicitados (int) X fecha-actual (string) X biblioteca (Biblioteca)
%Meta principal: tomarPrestamo/6
%Meta secundaria: getBibliotecaMaxLibros/2, getBibliotecaDiasMax/2, getBibliotecaLimiteDeuda/2, buscarLibro/4, getLibroDisponibilidad/2, obtenerUsuario/3, 
%getUsuarioEstado/2, getUsuarioLibros/2, getUsuarioDeuda/2, setUsuarioLibros/3, getBibliotecaPrestamos/2, crearPrestamo/6, cambiarLibro/4
%setBibliotecaUsuarios/3, setBibliotecaPrestamos/3.

tomarPrestamo(BibliotecaIn, IdUsuario, IdLibro, Dias, FechaActual, BibliotecaOut) :-
    getBibliotecaMaxLibros(BibliotecaIn, MaxLibros),
    getBibliotecaDiasMax(BibliotecaIn, DiasMax),
    getBibliotecaLimiteDeuda(BibliotecaIn, LimiteDeuda),
    buscarLibro(BibliotecaIn, id, IdLibro, Libro),
    getLibroDisponibilidad(Libro, true),
    obtenerUsuario(BibliotecaIn, IdUsuario, Usuario),
    getUsuarioEstado(Usuario, false), %El estado false indica que el usuaruo esta activo (doc)
    getUsuarioLibros(Usuario, LibrosUsuario),
    length(LibrosUsuario, CantidadLibros),
    CantidadLibros < MaxLibros, % condición
    Dias =< DiasMax,         %condición
    getUsuarioDeuda(Usuario, Deuda),
    Deuda < LimiteDeuda,       % condición
    setLibroDisponibilidad(Libro, false, LibroActualizado), % en libros false indica prestado (desactivado)
    append(LibrosUsuario, [IdLibro], NuevosLibrosUsuario),
    setUsuarioLibros(Usuario, NuevosLibrosUsuario, UsuarioActualizado),
    getBibliotecaPrestamos(BibliotecaIn, Prestamos),
    length(Prestamos, CantidadPrestamos),
    IdPrestamo is CantidadPrestamos + 1,
    crearPrestamo(IdPrestamo, IdUsuario, IdLibro, FechaActual, DiasSolicitados, NuevoPrestamo),
    getBibliotecaLibros(BibliotecaIn, Libros),
    cambiarLibro(Libros, IdLibro, LibroActualizado, NuevosLibros),
    setBibliotecaLibros(BibliotecaIn, NuevosLibros, Biblioteca1),
    getBibliotecaUsuarios(Biblioteca1, Usuarios),
    cambiarUsuario(Usuarios, IdUsuario, UsuarioActualizado, NuevosUsuarios),
    setBibliotecaUsuarios(Biblioteca1, NuevosUsuarios, Biblioteca2),
    append(Prestamos, [NuevoPrestamo], NuevosPrestamos),
    setBibliotecaPrestamos(Biblioteca2, NuevosPrestamos, BibliotecaOut).
% función aux q cambia el libro creo que no puuedo usar solo setters, cambia solo 1 libro/usuario dentro de la lista
cambiarLibro([Libro|Resto], IdBuscado, LibroNuevo, [LibroNuevo|Resto]) :-
    getLibroId(Libro, IdLibro),
    IdLibro =:= IdBuscado.
cambiarLibro([Libro|Resto], IdBuscado, LibroNuevo, [Libro|RestoActualizado]) :-
    getLibroId(Libro, IdLibro),
    IdLibro =\= IdBuscado,
    cambiarLibro(Resto, IdBuscado, LibroNuevo, RestoActualizado).
cambiarUsuario([Usuario|Resto], IdBuscado, UsuarioNuevo, [UsuarioNuevo|Resto]) :-
    getUsuarioId(Usuario, IdUsuario),
    IdUsuario =:= IdBuscado.
cambiarUsuario([Usuario|Resto], IdBuscado, UsuarioNuevo, [Usuario|RestoActualizado]) :-
    getUsuarioId(Usuario, IdUsuario),
    IdUsuario =\= IdBuscado,
    cambiarUsuario(Resto, IdBuscado, UsuarioNuevo, RestoActualizado).



%RF19
%Descripción: Devuelve un libro y procesa multas. **Calcula multa por retraso, suma la deuda del usuario, marca el libro disponible. 
%Si la deuda total excede el límite, se suspende al usuario automáticamente. Usuario suspendido SÍ puede devolver**.
% Dominio:biblioteca (Biblioteca) X id-usuario (int) X id-libro (int) X fecha-actual (string) X biblioteca (Biblioteca)
% Meta principal: devolverLibro/5
%Meta secundaria: 

devolverLibro(BibliotecaIn, IdUsuario, IdLibro, FechaActual, BibliotecaOut) :-
    getBibliotecaTasaMulta(BibliotecaIn, TasaMulta),
    getBibliotecaLimiteDeuda(BibliotecaIn, LimiteDeuda),
    getBibliotecaPrestamos(BibliotecaIn, Prestamos),
    member(Prestamo, Prestamos),
    getPrestamoUsuario(Prestamo, IdUsuario),
    getPrestamoLibro(Prestamo, IdLibro),
    calcularMulta(Prestamo, FechaActual, TasaMulta, Multa),
    obtenerUsuario(BibliotecaIn, IdUsuario, Usuario), % Actualizo deuda 
    getUsuarioDeuda(Usuario, DeudaActual),
    NuevaDeuda is DeudaActual + Multa,
    setUsuarioDeuda(Usuario, NuevaDeuda, Usuario2),
    verificarSuspension(Usuario2, NuevaDeuda, LimiteDeuda, Usuario3),
    % elimino el libro de la lista de usuario
    getUsuarioLibros(Usuario3, LibrosUsuario),
    delete(LibrosUsuario, IdLibro, NuevosLibros),
    setUsuarioLibros(Usuario3, NuevosLibros, Usuario4),
    buscarLibro(BibliotecaIn, id, IdLibro, Libro),
    setLibroDisponibilidad(Libro, true, LibroDisponible), % marcar  el libro como disponible de nuevo
    getBibliotecaLibros(BibliotecaIn, Libros),
    cambiarLibro(Libros, IdLibro, LibroDisponible, LibrosNuevos),
    setBibliotecaLibros(BibliotecaIn, LibrosNuevos, B1),
    getBibliotecaUsuarios(B1, Usuarios),
    cambiarUsuario(Usuarios, IdUsuario, Usuario4, UsuariosNuevos),
    setBibliotecaUsuarios(B1, UsuariosNuevos, B2),
    delete(Prestamos, Prestamo, PrestamosNuevos),
    setBibliotecaPrestamos(B2, PrestamosNuevos, BibliotecaOut).
verificarSuspension(Usuario, Deuda, Limite, UsuarioFinal) :- % Aux
    Deuda >= Limite,
    setUsuarioEstado(Usuario, true, UsuarioFinal). % True indica q está suspendido (sale en el doc)
verificarSuspension(Usuario, Deuda, Limite, Usuario) :-
    Deuda < Limite.


%RF20
%Descripcion: Verifica si el usuario debe suspenderse automáticamente. **Criterios: 1) deuda > límite maximo, O 
%2) tiene algun libro con retraso > días maximos permitidos**. Si el usuario debe ser suspendido retorna true caso contrario false.
%Dominio: biblioteca (Biblioteca) X id-usuario (int) X fecha-actual (string)
%Meta principal: debeSuspenderse/3
%meta secundaria: obtenerUsuario/3, getUsuarioDeuda/2, getBibliotecaLimiteDeuda/2, getBibliotecaPrestamos/2, getBibliotecaDiasRetraso/2, member/2,
%getPrestamoUsuario/2, obtenerFechaVencimiento/2, calcularDiasRetraso/3

debeSuspenderse(Biblioteca, IdUsuario, FechaActual) :-
    obtenerUsuario(Biblioteca, IdUsuario, Usuario),
    getUsuarioDeuda(Usuario, Deuda),
    getBibliotecaLimiteDeuda(Biblioteca, Limite),
    Deuda >= Limite.
debeSuspenderse(Biblioteca, IdUsuario, FechaActual) :-
    getBibliotecaPrestamos(Biblioteca, Prestamos),
    getBibliotecaDiasRetraso(Biblioteca, DiasMax),
    member(Prestamo, Prestamos),
    getPrestamoUsuario(Prestamo, IdUsuario),
    obtenerFechaVencimiento(Prestamo, FechaVenc),
    calcularDiasRetraso(FechaVenc, FechaActual, Retraso),
    Retraso > DiasMax.


%RF21
% Descripcion: Suspende al usuario manualmente cambiando su estado a true. Si el usuario se encuentra suspendido entonces el usuario se mantiene intacto en la biblioteca de salida.
%Dominio: biblioteca (Biblioteca) X idUsuario (int) X biblioteca (Biblioteca)
%Meta principal: suspenderUsuario/3
%meta secundaria: obtenerUsuario/3, getUsuarioEstado/2, setUsuarioEstado/3, getBibliotecaUsuarios/2, cambiarUsuario/4, setBibliotecaUsuarios/3

suspenderUsuario(BibliotecaIn, IdUsuario, BibliotecaOut) :-
    obtenerUsuario(BibliotecaIn, IdUsuario, Usuario),
    getUsuarioEstado(Usuario, false), 
    setUsuarioEstado(Usuario, true, UsuarioSuspendido),  
    getBibliotecaUsuarios(BibliotecaIn, Usuarios),
    cambiarUsuario(Usuarios, IdUsuario, UsuarioSuspendido, NuevosUsuarios),
    setBibliotecaUsuarios(BibliotecaIn, NuevosUsuarios, BibliotecaOut).
suspenderUsuario(BibliotecaIn, IdUsuario, BibliotecaIn) :-
    obtenerUsuario(BibliotecaIn, IdUsuario, Usuario),
    getUsuarioEstado(Usuario, true).  


%RF22
%Descripcion: Renueva préstamo agregando días extra. **Verifica: 1) préstamo existe y está activo, 2) usuario no suspendido, 
% 3) no hay retraso actual, 4) días totales no exceden maximo**. **Si falla alguna verificación, retorna false**.
%Dominio: biblioteca (Biblioteca) X id-prestamo (int) X dias-extra (int) X fecha-actual (string) X biblioteca (Biblioteca)
%Meta principal: renovarPrestamo/5

renovarPrestamo(B1, IdPrestamo, DiasExtra, FechaActual, B2) :-
    getBibliotecaPrestamos(B1, Prestamos),
    member(Prestamo, Prestamos),
    getPrestamoId(Prestamo, IdPrestamo),
    getPrestamoUsuario(Prestamo, IdUsuario),
    obtenerUsuario(B1, IdUsuario, Usuario),
    getUsuarioEstado(Usuario, false),  % activo
    obtenerFechaVencimiento(Prestamo, FechaVenc),
    calcularDiasRetraso(FechaVenc, FechaActual, Retraso),
    Retraso =:= 0, % Sin retraso
    getPrestamoDias(Prestamo, Dias),
    DiasTotales is Dias + DiasExtra, 
    getBibliotecaDiasMax(B1, DiasMax),
    DiasTotales =< DiasMax, %verificacion q los días no sobrepasen
    setPrestamoDiasSolicitados(Prestamo, DiasTotales, PrestamoActualizado), %renuevo prest
    cambiarPrestamo(Prestamos, IdPrestamo, PrestamoActualizado, NuevosPrestamos),
    setBibliotecaPrestamos(B1, NuevosPrestamos, B2).
cambiarPrestamo([Prestamo|Resto], IdPrestamo, PrestamoNuevo, [PrestamoNuevo|Resto]) :-
    getPrestamoId(Prestamo, Id).
cambiarPrestamo([Prestamo|Resto], IdPrestamo, PrestamoNuevo, [Prestamo|RestoActualizado]) :-
    getPrestamoId(Prestamo, IdPrestamo),
    IdPrestamo =\= Id,
    cambiarPrestamo(Resto, Id, PrestamoNuevo, RestoActualizado).


%RF23
%Descripcion: Usuario paga monto para reducir deuda. **Para reactivarse debe: pagar TODA la deuda (deuda=0) 
%Y no tener libros con retraso excesivo**. Si paga parcialmente, reduce deuda pero sigue suspendido.
%Dominio: biblioteca (Biblioteca) X id-usuario (int) X monto (int) X biblioteca (Biblioteca)
%Meta principal: pagarDeuda/4
%meta secundaria: obtenerUsuario/3, getUsuarioDeuda/2, setUsuarioDeuda/3, verificarReactivacion/4, getBibliotecaUsuarios/2, cambiarUsuario/4
%setBibliotecaUsuarios/3, getUsuarioId/2, tieneRetrasoExcesivo/2, setUsuarioEstado/3

pagarDeuda(BibliotecaIn, IdUsuario, Monto, BibliotecaOut) :-
    obtenerUsuario(BibliotecaIn, IdUsuario, Usuario),
    getUsuarioDeuda(Usuario, DeudaActual),
    NuevaDeuda is DeudaActual - Monto, 
    DeudaFinal is max(0, NuevaDeuda),
    setUsuarioDeuda(Usuario, DeudaFinal, Usuario2),  
    verificarReactivacion(BibliotecaIn, Usuario2, DeudaFinal, Usuario3),   
    getBibliotecaUsuarios(BibliotecaIn, Usuarios),  
    cambiarUsuario(Usuarios, IdUsuario, Usuario3, NuevosUsuarios),
    setBibliotecaUsuarios(BibliotecaIn, NuevosUsuarios, BibliotecaOut).
verificarReactivacion(Bib, Usuario, 0, UsuarioActivo) :- 
    getUsuarioId(Usuario, IdUsuario),
    \+ tieneRetrasoExcesivo(Bib, IdUsuario),
    setUsuarioEstado(Usuario, false, UsuarioActivo).
verificarReactivacion(_, Usuario, _, Usuario).
tieneRetrasoExcesivo(Biblioteca, IdUsuario) :-
    getBibliotecaPrestamos(Biblioteca, Prestamos),
    getBibliotecaDiasRetraso(Biblioteca, DiasMax),
    getBibliotecaFechaInicial(Biblioteca, FechaActual),
    member(Prestamo, Prestamos),
    getPrestamoUsuario(Prestamo, IdUsuario),
    obtenerFechaVencimiento(Prestamo, FechaVenc),
    calcularDiasRetraso(FechaVenc, FechaActual, Retraso),
    Retraso > DiasMax.

%RF24
%Descripcion: Obtiene préstamos de un usuario formateados como string. 
%**Retorna string vacío si usuario no existe o sin préstamos**. **Muestra: ID préstamo, ID libro, fecha préstamo, vencimiento, estado**.
%Dominio: biblioteca (Biblioteca) X IdUsuario (int) X str (String)
%Meta principal: historialPrestamosUsuario/3
%meta secundaria: getBibliotecaPrestamos/2, member/2, getPrestamoUsuario/2, formarPrestamo/2, getPrestamoId/2, getPrestamoLibro/2, getPrestamoFecha/2, obtenerFechaVencimiento/2, format/3

historialPrestamosUsuario(Biblioteca, IdUsuario, StrPrestamo) :-
    getBibliotecaPrestamos(Biblioteca, Prestamos),
    member(Prestamo, Prestamos), 
    getPrestamoUsuario(Prestamo, IdUsuario),
    formarPrestamo(Prestamo, StrPrestamo).
formarPrestamo(Prestamo, Str) :-
    getPrestamoId(Prestamo, IdPrestamo),
    getPrestamoLibro(Prestamo, IdLibro),
    getPrestamoFecha(Prestamo, Fecha),
    obtenerFechaVencimiento(Prestamo, FechaVenc),
    format(string(Str), "Prestamo ~w | Libro ~w | Fecha ~w | Vence ~w", 
           [IdPrestamo, IdLibro, Fecha, FechaVenc]).



