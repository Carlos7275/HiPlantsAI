:- [bd].
:-[utils].
:- dynamic plantas/1. % Declaramos el hecho de planta
:- dynamic recorridos/1. % Declaramos el hecho de recorridos
:- dynamic distanciamin/1.
:- dynamic distanciamax/1.

inicializar_plantas :- %inicializamos el hecho de plantas con lo que hay en la bd
    Query = 'SELECT mapa.id,info_plantas.id,nombre_planta,zona,latitud,longitud,toxicidad,comestible,familia,genero,mapa.estatus FROM mapa inner join info_plantas on id_planta=info_plantas.id where mapa.estatus=1;', % Assuming you want only one row
    consultar_tabla(Query, Row), %obtenemos informacion de la bd
    rows_to_lists_dynamic(Row, Lista), %convertimos los rows a multiple lista
    retractall(plantas(_)), % limpiamos los hechos de planta
    leer_lista(Lista). % leemos y guardamos en la bd de prolog la planta

inicializar_recorridos:-
    Query='SELECT recorridos.id,id_mapa,id_planta,id_usuario,nombre_planta,zona,toxicidad,tiempo FROM recorridos inner join mapa on mapa.id=recorridos.id_mapa inner join info_plantas on info_plantas.id=mapa.id_planta;',
    consultar_tabla(Query, Row),
    rows_to_lists_dynamic(Row,Lista),
    retractall(recorridos(_)),
    leer_lista_recorridos(Lista).

inicializar_distancias:-
 Query='Select distanciamin,distanciamax from configuracion;',
    consultar_tabla(Query, Row),
    rows_to_lists_dynamic(Row,Lista),
    retractall(distanciamin(_)),
    retractall(distanciamax(_)),
    leer_lista_distancias(Lista).
    

%inicializar hechos con info de la bd
:- inicializar_plantas.
:- inicializar_recorridos.
:- inicializar_distancias.
    
% Predicado para filtrar recorridos por el tercer elemento igual a un valor dado
buscar_recorridos_usuario(IdUsuario, RecorridosUsuario) :-
    findall(Recorrido, (
        recorridos(Recorrido),  % Extrae cada recorrido individualmente
        nth0(3, Recorrido, IdUsuarioComp),  % Obtén el IdUsuario del recorrido
        IdUsuario == IdUsuarioComp  % Filtra por IdUsuario
    ), RecorridosUsuario).
% Uso del predicado para obtener recorridos filtrados

plantas_no_visitadas_por_usuario(IdUsuario, PlantasNoEnRecorridos) :-
    buscar_recorridos_usuario(IdUsuario, Recorridos),
    findall(Planta, plantas(Planta), PlantasRegistradas),
    plantas_no_en_recorridos(PlantasRegistradas, Recorridos, PlantasNoEnRecorridos).

plantas_no_visitadas_cercanas_por_usuario(Lat, Long, IdUsuario, PlantasNoEnRecorridos) :-
    plantas_no_visitadas_por_usuario(IdUsuario, PlantasCercanas),
    findall([Planta, Distancia], (
        member(Planta, PlantasCercanas),
        nth0(4, Planta, LatP),
        nth0(5, Planta, LongP),
        haversine_distance(Lat, Long, LatP, LongP, Distancia),
        distanciamin(DistanciaMin),
        distanciamax(DistanciaMax),
        Distancia >= DistanciaMin,
        Distancia =< DistanciaMax
    ), PlantasNoEnRecorridos).
    
plantas_no_en_recorridos(Plantas, Recorridos, PlantasNoEnRecorridos) :-
    findall(Planta, (
        member(Planta, Plantas),
        nth0(1, Planta, IdPlanta),
        \+ (member(Recorrido, Recorridos),
            nth0(2, Recorrido, IdPlantaRecorrido),
            IdPlantaRecorrido == IdPlanta
        )
    ), PlantasNoEnRecorridos).
