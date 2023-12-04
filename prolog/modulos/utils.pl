rows_to_lists_dynamic(Rows, Lists) :-
    maplist(row_to_list_dynamic, Rows, Lists).

row_to_list_dynamic(Row, List) :-
    Row =.. [_|Fields], % Extract fields of the row term
    List = Fields.

term_to_list(Term, List) :-
    Term =.. [row | List].
