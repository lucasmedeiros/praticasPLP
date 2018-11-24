:- initialization(main).

replaceFistElementForZero([_|T], 0, X, [X|T]).

rotleft([E|T], R) :-
    append(T,[E],R).

rotright(L, R) :-
    rotleft(R, L).

myXor(A, B, C):-
    A == B -> C = 0; C = 1.

isGray([], [], _, Output) :- Output = "is gray".
isGray([H1|T1], [H2|T2], [H3|T3], Output) :-
    myXor(H1, H2, R),
    H3 == R -> isGray(T1, T2, T3, Output); Output = "not gray".

evaluate(List1, List2, Output) :-
    rotright(List1, ResultList1),
    replaceFistElementForZero(ResultList1, 0, 0, ResultFinal),
    isGray(List1, ResultFinal, List2, Output).

main :-
    read(List1),
    read(List2),
    evaluate(List1, List2, Output),
    writeln(Output).