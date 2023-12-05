:- [modulos/baseConocimiento].
:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_parameters)).
:- use_module(library(http/http_json)).

% Definir el manejador para el endpoint /sumar
:- http_handler('/plantasNoVisitadas', buscar_planta_handler, [method(get)]).
:- http_handler('/plantasNoVisitadas/Cercanas', buscar_planta_cercana_handler, [method(get)]).

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

buscar_planta_cercana_handler(Request) :-
    http_parameters(Request, [lat(Latitud, [number]), long(Longitud, [number]), idusuario(IdUsuario, [integer])]),
    write(Latitud),
    process_planta_cercana_data(Latitud,Longitud,IdUsuario,Result),
    reply_json_dict(Result).

process_planta_cercana_data(Latitud,Longitud,Id,Result) :-
    plantas_no_visitadas_cercanas_por_usuario(Latitud,Longitud,Id,Plantas),
    Result = _{resultado: Plantas}.
% Ejecutar el servidor en el puerto 8080
:- server(8080).
