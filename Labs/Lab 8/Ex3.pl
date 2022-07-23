bunkbeds(L) :-
    L = [[N1, C1], [N2, C2], [kayla, C3], [N4, C4], [N5, C5], [N6, C6]],
    ((N1 = reeva, N2 = haley); (N2 = reeva, N1 = haley)),
    ((C1 = black, C5 = brown, C3 = blue); (C3 = black, C5 = brown, C1 = blue)),
    ((C2 = red, C4 = yellow, C6 = green); (C2 = red, C6 = yellow, C4 = green); (C4 = red, C2 = yellow, C6 = green); (C4 = red, C6 = yellow, C2 = green); (C6 = red, C2 = yellow, C4 = green); (C6 = red, C4 = yellow, C2 = green)),
    ((N4 = beth); (N5 = beth, member(C5, [red, yellow, green])); (N6 = beth)),
    ((C1 = blue, C2 = red); (C3 = blue, C4 = red); (C5 = blue, C6 = red)),
    (N1 = liza; N5 = liza),
    (N1 = zoe; N2 = zoe; N5 = zoe; N6 = zoe),
    ((C1 = black, C2 = yellow); (C3 = black, C4 = yellow); (C5 = black, C6 = yellow)).
