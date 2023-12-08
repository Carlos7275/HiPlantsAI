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
    Query='SELECT recorridos.id,id_mapa,id_planta,id_usuario,nombre_planta,zona,toxicidad,tiempo,latitud,longitud FROM recorridos inner join mapa on mapa.id=recorridos.id_mapa inner join info_plantas on info_plantas.id=mapa.id_planta;',
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

planta_mas_visitada(PlantasMasVisitadas) :-
    findall(Planta, recorridos(Planta), Plantas),
    most_common_element_by_id(Plantas,PlantasMasVisitadas).

% Predicado para contar las ocurrencias de un elemento en una lista
count_occurrences(_, [], 0).
count_occurrences(X, [X | Tail], N) :-
    count_occurrences(X, Tail, N1),
    N is N1 + 1.
count_occurrences(X, [Y | Tail], N) :-
    X \= Y,
    count_occurrences(X, Tail, N).

% Predicado para encontrar el elemento que más se repite en la lista por ID
most_common_element_by_id(List, Element) :-
    flatten(List, Flattened),  % Aplanar la lista
    list_to_set(Flattened, Set),  % Eliminar duplicados
    most_common_element_by_id_helper(Set, List, 0, _, Element).

most_common_element_by_id_helper([], _, _, Element, Element).
most_common_element_by_id_helper([H | T], List, MaxCount, AccElement, Element) :-
    count_occurrences_by_id(H, List, Count),
    (Count > MaxCount ->
        most_common_element_by_id_helper(T, List, Count, H, Element)
    ;
        most_common_element_by_id_helper(T, List, MaxCount, AccElement, Element)
    ).


%_____________Planta mas y menos visitada en general______________________________________________

planta_mas_visitada_tiempo(PlantasMasVisitadas) :-
    findall(Planta, recorridos(Planta), Plantas),
    planta_con_mayor_tiempo(Plantas,PlantasMasVisitadas).

planta_menos_visitada_tiempo(PlantasMenosVisitadas) :-
    findall(Planta, recorridos(Planta), Plantas),
    planta_con_menor_tiempo(Plantas,PlantasMenosVisitadas).


planta_con_mayor_tiempo(List, Result) :-
    findall(MaxValue, (member(Sublist, List), nth1(8, Sublist, MaxValue)), MaxValues),
    max_list(MaxValues, Max),
    findall(Sublist, (member(Sublist, List), nth1(8, Sublist, Max)), Result).

planta_con_menor_tiempo(List, Result) :-
    findall(MinValue, (member(Sublist, List), nth1(8, Sublist, MinValue)), MinValues),
    min_list(MinValues, Min),
    findall(Sublist, (member(Sublist, List), nth1(8, Sublist, Min)), Result).

%__________________________________________________________________________________________________


%________________Plantas cercanas al usuario mas visitadas_________________________________________

plantas_cercanas_mas_visitadas(Lat, Long, PlantasCercanasMasVisitadas) :-
    planta_mas_visitada(PlantasMasVisitadas),
    findall([Planta, Distancia],(
        member(Planta, PlantasMasVisitadas),
        nth0(8, Planta, LatP),
        nth0(9, Planta, LongP),
        haversine_distance(Lat, Long, LatP, LongP, Distancia),
        distanciamin(DistanciaMin),
        distanciamax(DistanciaMax),
        Distancia >= DistanciaMin,
        Distancia =< DistanciaMax

    ), PlantasCercanasMasVisitadas).

%___________________________________________________________________________________________________

plantas_cercanas(Lat, Long, PlantasCercanas) :-
    findall(Planta,(
        plantas(Planta),
        nth0(4, Planta, LatP),
        nth0(5, Planta, LongP),
        haversine_distance(Lat, Long, LatP, LongP, Distancia),
        distanciamin(DistanciaMin),
        distanciamax(DistanciaMax),
        Distancia >= DistanciaMin,
        Distancia =< DistanciaMax

    ), PlantasCercanas).



plantas_toxicas(PlantasToxicas) :-
    findall(Plantas, (
        plantas(Plantas),
        nth0(6, Plantas, PlantaToxica),
        PlantaToxica = 'Si'

    ), PlantasToxicas).


plantas_no_toxicas(PlantasNoToxicas) :-
    findall(Plantas, (
        plantas(Plantas),
        nth0(6, Plantas, PlantaNoToxica),
        PlantaNoToxica = 'No'

    ), PlantasNoToxicas).


%_______________Plantas toxicas cercanas a la ubi del usuario_____________________________________

plantas_cercanas_toxicas(Lat, Long, PlantasCercanasToxicas) :-
    plantas_toxicas(PlantasToxicas),
    findall(Planta,(
        member(Planta, PlantasToxicas),
        nth0(4, Planta, LatP),
        nth0(5, Planta, LongP),
        haversine_distance(Lat, Long, LatP, LongP, Distancia),
        distanciamin(DistanciaMin),
        distanciamax(DistanciaMax),
        Distancia >= DistanciaMin,
        Distancia =< DistanciaMax

    ), PlantasCercanasToxicas).


plantas_cercanas_no_toxicas(Lat, Long, PlantasCercanasNoToxicas) :-
    plantas_no_toxicas(PlantasNoToxicas),
    findall(Planta,(
        member(Planta, PlantasNoToxicas),
        nth0(4, Planta, LatP),
        nth0(5, Planta, LongP),
        haversine_distance(Lat, Long, LatP, LongP, Distancia),
        distanciamin(DistanciaMin),
        distanciamax(DistanciaMax),
        Distancia >= DistanciaMin,
        Distancia =< DistanciaMax

    ), PlantasCercanasNoToxicas).