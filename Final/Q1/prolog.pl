sudoku([[2,1,4,3],[4,3,2,1],[1,2,3,4],[3,4,1,2]]).
sudoku([[2,1,4,3],[4,3,2,1],[1,2,3,3],[3,4,1,2]]).

different([]) :- !.
different([Head | Tail]) :-
    \+member(Head, Tail),
    different(Tail),
    !.
    
/*
 * Extract every first item in each row (RowHead) and store it into a list
 * and return the rest matrix without the first column (composed of RowTails)
 */
extract4Columns([], [], []) :- !.
extract4Columns([[RowHead | RowTail] | RowsLeft], [RowHead | RowHeads], [RowTail | RowTails]) :-
    extract4Columns(RowsLeft, RowHeads, RowTails),
    !.
/* 
 * Recursively deprive one column from the matrix
 * and store it into a list.
 */
extract4Columns([[] | _], []) :- !.
extract4Columns(Matrix, [Column | Columns]) :-
    extract4Columns(Matrix, Column, MatrixLeft),
    extract4Columns(MatrixLeft, Columns),
    !.


getMatrixElement(Matrix, X, Y, Element) :-
   nth0(X, Matrix, Row),
   nth0(Y, Row, Element),
   !.

extract1Quadrant(Matrix, X, Y, Quadrant) :-
    NewX is X + 1,
    NewY is Y + 1,
    getMatrixElement(Matrix, X, Y, First),
    getMatrixElement(Matrix, X, NewY, Second),
    getMatrixElement(Matrix, NewX, Y, Third),
    getMatrixElement(Matrix, NewX, NewY, Fourth),
    Quadrant = [First, Second, Third, Fourth],
    !.
    
extract4Quadrants(Matrix, Quadrants) :-
    extract1Quadrant(Matrix, 0, 0, Quadrant1),
    extract1Quadrant(Matrix, 0, 2, Quadrant2),
    extract1Quadrant(Matrix, 2, 0, Quadrant3),
    extract1Quadrant(Matrix, 2, 2, Quadrant4),
    Quadrants = [Quadrant1, Quadrant2, Quadrant3, Quadrant4],
    !.

checkSudoku([], [], []) :- !.
checkSudoku([RowMatrix | MatrixLeft], [RowTranspose | TransposeLeft], [RowBlock | BlockLeft]) :-
    different(RowMatrix),
    different(RowTranspose),
    different(RowBlock),
    checkSudoku(MatrixLeft, TransposeLeft, BlockLeft),
    !.
checkSudoku(Matrix) :-
    extract4Columns(Matrix, Transpose),
    extract4Quadrants(Matrix, Block),
    checkSudoku(Matrix, Transpose, Block),
    !.
