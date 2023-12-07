:- [modulos/baseConocimiento].
:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_parameters)).
:- use_module(library(http/http_json)).

% Definir el manejador para el endpoint /sumar
:- http_handler('/plantasNoVisitadas', buscar_planta_handler, [method(get)]).
:- http_handler('/plantasNoVisitadas/Cercanas', buscar_planta_cercana_handler, [method(get)]).
:-http_handler('/plantaMasVisitada',buscar_planta_mas_visitada_handler,[method(get)]).
:-http_handler('/plantaMenosVisitada',buscar_planta_menos_visitada_handler,[method(get)]).
:-http_handler('/plantasCercanas',buscar_plantas_cercanas_handler,[method(get)]).

% Iniciar el servidor en el puerto 8080
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
%------planta mas visitada---------------------
buscar_planta_mas_visitada_handler(Request):-
    process_planta_mas_visitada_data(Result),
    reply_json_dict(Result).

process_planta_mas_visitada_data(Result):-
    planta_mas_visitada(Planta),
    Result=_{resultado:Planta}.
%------------------------------------------------

%-----planta menos visitada----------------------
buscar_planta_menos_visitada_handler(Request):-
    process_planta_menos_visitada_data(Result),
    reply_json_dict(Result).

process_planta_menos_visitada_data(Result):-
    planta_menos_visitada(Planta),
    Result=_{resultado:Planta}.
%-----------------------------------------------

%------plantas cercanas------------------------
buscar_plantas_cercanas_handler(Request):-http_parameters(Request, [lat(Lat, [number]), long(Long, [number])]),
    process_plantas_cercanas_data(Lat,Long,Result),
    reply_json_dict(Result).

process_plantas_cercanas_data(Lat,Long,Result):-
    plantas_cercanas(Lat,Long,Plantas),
    Result=_{resultado:Plantas}.

%----------------------------------------------


buscar_planta_cercana_handler(Request) :-
    http_parameters(Request, [lat(Latitud, [number]), long(Longitud, [number]), idusuario(IdUsuario, [integer])]),
    process_planta_cercana_data(Latitud,Longitud,IdUsuario,Result),
    reply_json_dict(Result).

process_planta_cercana_data(Latitud,Longitud,Id,Result) :-
    plantas_no_visitadas_cercanas_por_usuario(Latitud,Longitud,Id,Plantas),
    Result = _{resultado: Plantas}.
% Ejecutar el servidor en el puerto 8080
:- server(8080).
