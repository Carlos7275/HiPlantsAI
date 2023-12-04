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
    Radius is 6371.0,
    
    % Calculate distance
    Distance is Radius * C.