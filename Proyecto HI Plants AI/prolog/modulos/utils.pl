rows_to_lists_dynamic(Rows, Lists) :-
    maplist(row_to_list_dynamic, Rows, Lists).

row_to_list_dynamic(Row, List) :-
    Row =.. [_|Fields], % Extract fields of the row term
    List = Fields.

term_to_list(Term, List) :-
    Term =.. [row | List].

% Convert degrees to radians
degrees_to_radians(Degrees, Radians) :-
    Radians is Degrees * pi / 180.

haversine_distance(Lat1, Lon1, Lat2, Lon2, Distance) :-
    % Convert latitude and longitude from degrees to radians
    degrees_to_radians(Lat1, RadLat1),
    degrees_to_radians(Lon1, RadLon1),
    degrees_to_radians(Lat2, RadLat2),
    degrees_to_radians(Lon2, RadLon2),
    
    % Calculate differences
    DeltaLat is RadLat2 - RadLat1,
    DeltaLon is RadLon2 - RadLon1,
    
    % Haversine formula
    A is sin(DeltaLat / 2) ** 2 + cos(RadLat1) * cos(RadLat2) * sin(DeltaLon / 2) ** 2,
    C is 2 * atan2(sqrt(A), sqrt(1 - A)),
    
    % Radius of the Earth (in kilometers)
    RadiusKm is 6371.0,
    
    % Calculate distance in meters
    Distance is RadiusKm * C * 1000.


leer_lista([]).
leer_lista([Element | Rest]) :-
    asserta(plantas(Element)),
    leer_lista(Rest).

leer_lista_recorridos([]).
leer_lista_recorridos([Element | Rest]) :-
    asserta(recorridos(Element)),
    leer_lista_recorridos(Rest).

leer_lista_distancias([]).
leer_lista_distancias([Element | Rest]) :-
    nth0(0,Element,DistanciaMin),
    nth0(1,Element,DistanciaMax),
    asserta(distanciamin(DistanciaMin)),
    asserta(distanciamax(DistanciaMax)),
    leer_lista_distancias(Rest).


% Predicado para contar las ocurrencias de un ID en la lista
count_occurrences_by_id(_, [], 0).
count_occurrences_by_id(Id, [[_, Id | Rest] | Tail], N) :-
    count_occurrences_by_id(Id, Tail, N1),
    N is N1 + 1.
count_occurrences_by_id(Id, [_ | Tail], N) :-
    count_occurrences_by_id(Id, Tail, N).