:- [bd].
:-[utils].
:- dynamic planta/1. % Declaramos el hecho de planta
% Esto es para pruebas
%sumar(A, B, C) :- C is A + B.

inicializar_plantas :- %inicializamos el hecho de plantas con lo que hay en la bd
    Query = 'SELECT mapa.id,nombre_planta,zona,latitud,longitud,toxicidad,comestible,familia,genero,mapa.estatus FROM mapa inner join info_plantas on id_planta=info_plantas.id where mapa.estatus=1;', % Assuming you want only one row
    consultar_tabla(Query, Row), %obtenemos informacion de la bd
    rows_to_lists_dynamic(Row, Lista), %convertimos los rows a multiple lista
    retractall(planta(_)), % limpiamos los hechos de planta
    leer_lista(Lista). % leemos y guardamos en la bd de prolog la planta

leer_lista([]).
leer_lista([Element | Rest]) :-
    asserta(planta(Element)),
    leer_lista(Rest).
:- inicializar_plantas.

%busca de la lista de plantas por atributo de la planta
buscar_planta(Elemento, Planta) :-
    planta(Planta),
    member(Elemento, Planta).
