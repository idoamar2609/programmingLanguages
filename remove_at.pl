remove_at(X, [X|T], 1, T).
remove_at(X, [H|T], K, [H|R]) :- K > 1, J is K - 1, remove_at(X, T, J, R).

