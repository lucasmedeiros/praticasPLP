:- initialization(main).

%! Fatos

tipo(o).
tipo(a).
tipo(b).
tipo(ab).

resultado(o, o, "doar_e_receber").
resultado(o, a, "doar").
resultado(o, b, "doar").
resultado(o, ab, "doar").
resultado(a, o, "receber").
resultado(a, a, "doar_e_receber").
resultado(a, b, "incompativel").
resultado(a, ab, "doar").
resultado(b, o, "receber").
resultado(b, a, "incompativel").
resultado(b, b, "doar_e_receber").
resultado(b, ab, "doar").
resultado(ab, o, "receber").
resultado(ab, a, "receber").
resultado(ab, b, "receber").
resultado(ab, ab, "doar_e_receber").

avaliacao(X, Y) :-
    tipo(X), tipo(Y),
    resultado(X, Y, Out),
    writeln(Out).

main:-
	read(user_input, Tipo1),
    read(user_input, Tipo2),
	avaliacao(Tipo1, Tipo2).
