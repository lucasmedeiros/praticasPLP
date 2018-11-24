:- initialization main.

method(List, PosA, PosB, FinalList):-
    (length(List, Tam), PosB >= Tam) -> FinalList = 'INVALIDO';
    (PosA =< PosB), 
    (NextPos is (PosA + 1),
    method(List, NextPos, PosB, NewList),
    nth0(PosA, List, Elem),
    append([Elem, PosA], NewList, FinalList));
    append([], [], FinalList).

main :- 
    read(List),
    read(PosA),
    read(PosB),
    method(List, PosA, PosB, FinalList),
    writeln(FinalList).