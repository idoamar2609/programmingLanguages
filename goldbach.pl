is_prime(N) :-
    N > 1,                
    \+ has_divisor(N, 2).  

has_divisor(N, D) :-
    D * D =< N,             
	0 is N mod D.
	
has_divisor(N, D) :-
    D * D =< N,
    D1 is D + 1,
    has_divisor(N, D1).   

goldbach(N, [X,Y]) :-
    N > 2,
    goldbach_from(2, N, [X,Y]), !.

goldbach_from(X, N, [X,Y]) :-
    Y is N - X,
    Y > 1,
    is_prime(X),
    is_prime(Y), !.

goldbach_from(X, N, Pair) :-
    X < N,
    X1 is X + 1,
    goldbach_from(X1, N, Pair).

