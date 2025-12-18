element_at(X, [X|_], 1).
element_at(X, [_|T], K) :- K > 1, J is K-1, element_at(X, T, J).
