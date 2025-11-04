check_divisor(X, Y) :- Y * Y > X, !.
check_divisor(X, Y) :- 0 is X mod Y, !, fail.
check_divisor(X, Y) :- Y1 is Y + 1, check_divisor(X, Y1).

is_prime(1) :- !, fail.
is_prime(2) :- !.
is_prime(X) :- X > 2, check_divisor(X, 2).
