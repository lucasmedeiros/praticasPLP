:-initialization main.

findSmallest(Ele, N, Smallest):-K is N - 1 ->( N =< 0, Smallest is Ele, !;
    read(NextEle) ->(NextEle < Ele, findSmallest(NextEle, K, Smallest);
    findSmallest(Ele, K, Smallest))).

loop(0, Troco):- writeln(Troco),!.
loop(N, Troco):- K is N - 1, read(Budget), read(Items),Q is Items - 1, read(FirstItem),
    findSmallest(FirstItem, Q, Smallest),Change is mod(Budget, Smallest), T is Troco + Change,
    loop(K, T).

main :- read(Iterations), loop(Iterations, 0).
