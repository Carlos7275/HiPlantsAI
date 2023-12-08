:- [modulos/baseConocimiento].
:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_parameters)).
:- use_module(library(http/http_json)).

% Definir el manejador para el endpoint /sumar
:- http_handler('/plantasNoVisitadas', buscar_planta_handler, [method(get)]).
:- http_handler('/plantasNoVisitadas/Cercanas', buscar_planta_cercana_handler, [method(get)]).
:-http_handler('/plantaMasVisitada',buscar_planta_mas_visitada_handler,[method(get)]).
:-http_handler('/plantaMasVisitadaTiempo',buscar_planta_mas_visitada_tiempo_handler,[method(get)]).
:-http_handler('/plantaMenosVisitadaTiempo',buscar_planta_menos_visitada_handler,[method(get)]).
:-http_handler('/plantasCercanas',buscar_plantas_cercanas_handler,[method(get)]).
:-http_handler('/plantasCercanasToxicas', buscar_plantas_cercanas_toxicas_handler,[method(get)]).
:-http_handler('/plantasCercanasNoToxicas', buscar_plantas_cercanas_no_toxicas_handler,[method(get)]).
:-http_handler('/plantasCercanasComestibles', buscar_plantas_cercanas_comestibles_handler,[method(get)]).

server(Port) :-
    http_server(http_dispatch, [port(Port)]).

% Manejador para el endpoint /buscar_planta (GET) con parámetros
buscar_planta_handler(Request) :-
    http_parameters(Request, [idusuario(IdUsuario, [integer])]),
    process_planta_data(IdUsuario,Result),
    reply_json_dict(Result).

process_planta_data(Id,Result) :-
    plantas_no_visitadas_por_usuario(Id,Plantas),
    Result = _{resultado: Plantas}.

buscar_planta_mas_visitada_handler(Request):-
    process_planta_mas_visitada_data(Result),
    reply_json_dict(Result).

buscar_planta_mas_visitada_tiempo_handler(Request):-
    process_planta_mas_visitada_tiempo_data(Result),
    reply_json_dict(Result).

process_planta_mas_visitada_data(Result):-
    planta_mas_visitada(Planta),
    Result=_{resultado:Planta}.

process_planta_mas_visitada_tiempo_data(Result):-
    planta_mas_visitada_tiempo(Planta),
    Result=_{resultado:Planta}.

buscar_planta_menos_visitada_handler(Request):-
    process_planta_menos_visitada_data(Result),
    reply_json_dict(Result).

process_planta_menos_visitada_data(Result):-
    planta_menos_visitada_tiempo(Planta),
    Result=_{resultado:Planta}.

buscar_plantas_cercanas_handler(Request):-http_parameters(Request, [lat(Lat, [number]), long(Long, [number])]),
    process_plantas_cercanas_data(Lat,Long,Result),
    reply_json_dict(Result).

process_plantas_cercanas_data(Lat,Long,Result):-
    plantas_cercanas(Lat,Long,Plantas),
    Result=_{resultado:Plantas}.

buscar_planta_cercana_handler(Request) :-
    http_parameters(Request, [lat(Latitud, [number]), long(Longitud, [number]), idusuario(IdUsuario, [integer])]),
    process_planta_cercana_data(Latitud,Longitud,IdUsuario,Result),
    reply_json_dict(Result).

process_planta_cercana_data(Latitud,Longitud,Id,Result) :-
    plantas_no_visitadas_cercanas_por_usuario(Latitud,Longitud,Id,Plantas),
    Result = _{resultado: Plantas}.


buscar_plantas_cercanas_toxicas_handler(Request) :-
    http_parameters(Request, [lat(Latitud,[number]), long(Longitud, [number])]),
    process_planta_cercana_toxica_data(Latitud, Longitud, Result),
    reply_json_dict(Result).

process_planta_cercana_toxica_data(Latitud, Longitud, Result) :-
    plantas_cercanas_toxicas(Latitud, Longitud, PlantasCercanasToxicas),
    Result = _{resultado: PlantasCercanasToxicas}.
    

buscar_plantas_cercanas_no_toxicas_handler(Request) :-
    http_parameters(Request, [lat(Latitud,[number]), long(Longitud, [number])]),
    process_planta_cercana_no_toxica_data(Latitud, Longitud, Result),
    reply_json_dict(Result).

process_planta_cercana_no_toxica_data(Latitud, Longitud, Result) :-
    plantas_cercanas_no_toxicas(Latitud, Longitud, PlantasCercanasNoToxicas),
    Result = _{resultado: PlantasCercanasNoToxicas}.

buscar_plantas_cercanas_comestibles_handler(Request) :-
    http_parameters(Request, [lat(Latitud,[number]), long(Longitud, [number])]),
    process_planta_cercana_comestible_data(Latitud, Longitud, Result),
    reply_json_dict(Result).

process_planta_cercana_comestible_data(Latitud, Longitud, Result) :-
    plantas_cercanas_comestibles(Latitud, Longitud, PlantasCercanasComestibles),
    Result = _{resultado: PlantasCercanasComestibles}.


% Ejecutar el servidor en el puerto 8080
:- server(8080).
