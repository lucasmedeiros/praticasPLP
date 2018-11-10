:- initialization main .
planeta("Terra", 1).
planeta("Mercurio", 0.2408467).
planeta("Venus", 0.61519726).
planeta("Marte", 1.8808158).
planeta("Jupter", 11.862615).
planeta("Saturno", 29.447498).
planeta("Urano", 84.016846).
planeta("Netuno", 164.79132).
anos(Valor, Resultado):- Resultado is Valor / 31557600.
converte(Idade, Planetaa, Resultado):- planeta(Planetaa,X), Resultado is Idade * X.
arredonda(Valor, Resultado):- Resultado is round(Valor).
input(Number):-
    read_line_to_codes(user_input, Codes),
    string_to_atom(Codes, Atom),
    atom_number(Atom, Y),
    anos(Y, Number).
main:-
    read_line_to_string(user_input, X1),
    input(N),
    converte(N, X1, R),
    arredonda(R, F),
    write(F),
    writeln(" Anos"),
    halt(0).
