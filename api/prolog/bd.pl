:- use_module(library(odbc)).

% Establecer la conexión a la base de datos MySQL
conectar_mysql(Connection) :-
    odbc_connect('Mysql Prolog', Connection,
                [ user('root'),
                  password(''),
                  alias(mysql),
                  open(once)
                ]).

consultar_tabla(Query,Resultados):-
      conectar_mysql(Connection), 
      odbc_query(Connection,Query,Resultados).

desconectar:-
  odbc_disconnect(mysql).