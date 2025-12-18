bool_not(true, fail).
bool_not(fail, true).

bool_and(true,  true,  true).
bool_and(true,  fail,  fail).
bool_and(fail,  true,  fail).
bool_and(fail,  fail,  fail).

bool_or(true,   true,  true).
bool_or(true,   fail,  true).
bool_or(fail,   true,  true).
bool_or(fail,   fail,  fail).

bool_xor(true,  true,  fail).
bool_xor(true,  fail,  true).
bool_xor(fail,  true,  true).
bool_xor(fail,  fail,  fail).

bool_nand(A,B,R) :- bool_and(A,B,T), bool_not(T,R).
bool_nor(A,B,R)  :- bool_or(A,B,T),  bool_not(T,R).

bool_equal(A,B,true) :- A == B, !.
bool_equal(_,_,fail).

eval(true, true)  :- !.
eval(fail, fail)  :- !.
eval(not(E), R)        :- eval(E, V), bool_not(V, R).
eval(and(E1,E2), R)    :- eval(E1, V1), eval(E2, V2), bool_and(V1, V2, R).
eval(or(E1,E2), R)     :- eval(E1, V1), eval(E2, V2), bool_or(V1, V2, R).
eval(xor(E1,E2), R)    :- eval(E1, V1), eval(E2, V2), bool_xor(V1, V2, R).
eval(nand(E1,E2), R)   :- eval(E1, V1), eval(E2, V2), bool_nand(V1, V2, R).
eval(nor(E1,E2), R)    :- eval(E1, V1), eval(E2, V2), bool_nor(V1, V2, R).
eval(equal(E1,E2), R)  :- eval(E1, V1), eval(E2, V2), bool_equal(V1, V2, R).
eval(X, X) :- X == true ; X == fail.

table(A,B,Expr) :-
    member(A, [true, fail]),
    member(B, [true, fail]),
    eval(Expr, R),
    format('~w  ~w  ~w~n', [A, B, R]),
    fail ; true.
