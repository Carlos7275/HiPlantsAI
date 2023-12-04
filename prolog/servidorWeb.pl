:- [modulos/baseConocimiento].
:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_parameters)).
:- use_module(library(http/http_json)).

% Definir el manejador para el endpoint /sumar
:- http_handler('/sumar', sumar_handler, [method(get)]).
:- http_handler('/planta', buscar_planta_handler, [method(get)]).

% Iniciar el servidor en el puerto 8080
server(Port) :-
    http_server(http_dispatch, [port(Port)]).

% Manejador para el endpoint /sumar (GET) con parámetros
sumar_handler(Request) :-
    http_parameters(Request, [x(X, [integer]), y(Y, [integer])]),
    process_sumar_data(X, Y, Result),
    reply_json_dict(Result).

% Lógica para procesar los datos de sumar y generar una respuesta
process_sumar_data(X, Y, Result) :-
    sumar(X,Y, Suma),
    Result = _{resultado: Suma}.

% Manejador para el endpoint /buscar_planta (GET) con parámetros
buscar_planta_handler(Request) :-
    process_planta_data(Result),
    reply_json_dict(Result).

process_planta_data(Result) :-
    findall(Planta, planta(Planta), Plantas),
    Result = _{resultado: Plantas}.

% Ejecutar el servidor en el puerto 8080
:- server(8080).
