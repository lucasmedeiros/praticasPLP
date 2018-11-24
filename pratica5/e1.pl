:- initialization main.

equivalencia('<', '--ptr;').
equivalencia('>', '++ptr;').
equivalencia('+', '++*ptr;').
equivalencia('-', '--*ptr;').
equivalencia('.', 'putchar(*ptr);').
equivalencia(',', '*ptr=getchar();').
equivalencia('[', 'while (*ptr) {').
equivalencia(']', '}').

transpila([], []).
transpila([H|T]) :-
	equivalencia(H, Response),
	write(Response),
	transpila(T).

main :-
	read(X), 
	atom_string(X, S),
	string_chars(S, Response),
	transpila(Response).