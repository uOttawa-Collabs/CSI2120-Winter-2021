/**
 * CSI2120 - 2021W
 *
 * Comprehensive Assignment Part 3
 * Solution.pl
 *
 * @author Xiaoxuan Wang 300133594
 */

library(pcre).

% Utilities
generateOutputFilename(InputFilename, OutputFilename) :-
    re_compile('(.+)\\..+', Regex, [string]),
    re_match(Regex, InputFilename),
    re_replace('(.+)\\..+', '\\{1}.sol', InputFilename, OutputFilename),
    !.
generateOutputFilename(InputFilename, OutputFilename) :-
    re_compile('(.+)\\..+', Regex, [string]),
    \+re_match(Regex, InputFilename),
    string_concat(InputFilename, '.sol', OutputFilename),
    !.
    
parseInput(InputStream, NumberOfItems, KnapsackCapacity, Items, ItemsAccumulator, LineCount) :-
    LineCount =:= 0,
    read_line_to_string(InputStream, String),
    atom_number(String, NumberOfItems),
    parseInput(InputStream, NumberOfItems, KnapsackCapacity, Items, ItemsAccumulator, LineCount + 1),
    !.
parseInput(InputStream, NumberOfItems, KnapsackCapacity, Items, ItemsAccumulator, LineCount) :-
    LineCount >= 1,
    LineCount =< NumberOfItems,
    read_line_to_string(InputStream, String),
    split_string(String, ' ', ' ', List),
    nth0(0, List, ItemName),
    nth0(1, List, Value),
    atom_number(Value, ItemValue),
    nth0(2, List, Weight),
    atom_number(Weight, ItemWeight),
    parseInput(InputStream, NumberOfItems, KnapsackCapacity, Items, [item(ItemName, ItemValue, ItemWeight) | ItemsAccumulator], LineCount + 1),
    !.
parseInput(InputStream, _, KnapsackCapacity, ItemsAccumulator, ItemsAccumulator, _) :-
    read_line_to_string(InputStream, String),
    atom_number(String, KnapsackCapacity),
    !.
parseInput(InputStream, NumberOfItems, KnapsackCapacity, Items) :-
    parseInput(InputStream, NumberOfItems, KnapsackCapacity, Items, [], 0),
    !.

nth0Matrix(RowIndex, ColumnIndex, Matrix, Element) :-
    nth0(RowIndex, Matrix, Column),
    nth0(ColumnIndex, Column, Element),
    !.

getKnapsackStats([], ValueAccumulator, WeightAccumulator, ItemCountAccumulator, ValueAccumulator, WeightAccumulator, ItemCountAccumulator) :- !.
getKnapsackStats([item(_, ItemValue, ItemWeight) | Tail], Value, Weight, ItemCount, ValueAccumulator, WeightAccumulator, ItemCountAccumulator) :-
    NewValueAccumulator is ValueAccumulator + ItemValue,
    NewWeightAccumulator is WeightAccumulator + ItemWeight,
    NewItemCountAccumulator is ItemCountAccumulator + 1,
    getKnapsackStats(Tail, Value, Weight, ItemCount, NewValueAccumulator, NewWeightAccumulator, NewItemCountAccumulator),
    !.
getKnapsackStats(Knapsack, Value, Weight, ItemCount) :-
    getKnapsackStats(Knapsack, Value, Weight, ItemCount, 0, 0, 0),
    !.

putItemInKnapsack(Knapsack, Item, [Item | Knapsack]) :- !.

findMostValuableKnapsackForRow([], _) :- !.
findMostValuableKnapsackForRow([Knapsack1 | Tail], Knapsack1) :-
    getKnapsackStats(Knapsack1, Value1, _, _),
    findMostValuableKnapsackForRow(Tail, Knapsack2),
    getKnapsackStats(Knapsack2, Value2, _, _),
    Value1 >= Value2,
    !.
findMostValuableKnapsackForRow([Knapsack1 | Tail], Knapsack2) :-
    getKnapsackStats(Knapsack1, Value1, _, _),
    findMostValuableKnapsackForRow(Tail, Knapsack2),
    getKnapsackStats(Knapsack2, Value2, _, _),
    Value2 > Value1,
    !.

findMostValuableKnapsackForMatrix([], _) :- !.
findMostValuableKnapsackForMatrix([Row | Tail], Knapsack1) :-
    findMostValuableKnapsackForRow(Row, Knapsack1),
    getKnapsackStats(Knapsack1, Value1, _, _),
    findMostValuableKnapsackForMatrix(Tail, Knapsack2),
    getKnapsackStats(Knapsack2, Value2, _, _),
    Value1 >= Value2,
    !.
findMostValuableKnapsackForMatrix([], _) :- !.
findMostValuableKnapsackForMatrix([Row | Tail], Knapsack2) :-
    findMostValuableKnapsackForRow(Row, Knapsack1),
    getKnapsackStats(Knapsack1, Value1, _, _),
    findMostValuableKnapsackForMatrix(Tail, Knapsack2),
    getKnapsackStats(Knapsack2, Value2, _, _),
    Value2 > Value1,
    !.

getItemNamesFromKnapsack([], []) :- !.
getItemNamesFromKnapsack([item(ItemName, _, _) | Tail], [ItemName | NextNames]) :-
    getItemNamesFromKnapsack(Tail, NextNames),
    !.
    
% Algorithm
% Row 0: All knapsacks are empty
generateStatusMatrixRow(_, TotalColumnCount, 0, TotalColumnCount, _, _, Accumulator, Accumulator) :- !.
generateStatusMatrixRow(_, TotalColumnCount, 0, CurrentColumnIndex, _, _, Row, Accumulator) :-
    NewColumnIndex is CurrentColumnIndex + 1,
    generateStatusMatrixRow(_, TotalColumnCount, 0, NewColumnIndex, _, _, Row, [[] | Accumulator]),
    !.
% Row n > 0, not fit
generateStatusMatrixRow(_, TotalColumnCount, _, TotalColumnCount, _, _, Accumulator, Accumulator) :- !.
generateStatusMatrixRow(TotalRowCount, TotalColumnCount, CurrentRowIndex, CurrentColumnIndex, MatrixAccumulator, item(ItemName, ItemValue, ItemWeight), Row, Accumulator) :-
    CurrentRowIndex > 0,
    CurrentRowIndex < TotalRowCount,
    ItemWeight > CurrentColumnIndex,
    NewColumnIndex is CurrentColumnIndex + 1,
    % Last row is actually at the start of MatrixAccumulator, which has the index 0.
    AboveRowIndex is 0,
    % All columns are flipped vertically. We need to calculate the "mirrored" index instead.
    AboveColumnCount is TotalColumnCount - CurrentColumnIndex - 1,
    nth0Matrix(AboveRowIndex, AboveColumnCount, MatrixAccumulator, KnapsackAbove),
    generateStatusMatrixRow(TotalRowCount, TotalColumnCount, CurrentRowIndex, NewColumnIndex, MatrixAccumulator, item(ItemName, ItemValue, ItemWeight), Row, [KnapsackAbove | Accumulator]),
    !.
% Row n > 0, fit, not putting in the item
generateStatusMatrixRow(TotalRowCount, TotalColumnCount, CurrentRowIndex, CurrentColumnIndex, MatrixAccumulator, item(ItemName, ItemValue, ItemWeight), Row, Accumulator) :-
    CurrentRowIndex > 0,
    CurrentRowIndex < TotalRowCount,
    ItemWeight =< CurrentColumnIndex,
    NewColumnIndex is CurrentColumnIndex + 1,
    AboveRowIndex is 0,
    AboveColumnIndex1 is TotalColumnCount - CurrentColumnIndex - 1,
    AboveColumnIndex2 is TotalColumnCount - (CurrentColumnIndex - ItemWeight) - 1,
    nth0Matrix(AboveRowIndex, AboveColumnIndex1, MatrixAccumulator, KnapsackAbove1),
    nth0Matrix(AboveRowIndex, AboveColumnIndex2, MatrixAccumulator, KnapsackAbove2),
    putItemInKnapsack(KnapsackAbove2, item(ItemName, ItemValue, ItemWeight), NewKnapsack),
    getKnapsackStats(KnapsackAbove1, Value1, _, _),
    getKnapsackStats(NewKnapsack, Value2, _, _),
    Value1 >= Value2,
    generateStatusMatrixRow(TotalRowCount, TotalColumnCount, CurrentRowIndex, NewColumnIndex, MatrixAccumulator, item(ItemName, ItemValue, ItemWeight), Row, [KnapsackAbove1 | Accumulator]),
    !.
% Row n > 0, fit, putting in the item
generateStatusMatrixRow(TotalRowCount, TotalColumnCount, CurrentRowIndex, CurrentColumnIndex, MatrixAccumulator, item(ItemName, ItemValue, ItemWeight), Row, Accumulator) :-
    CurrentRowIndex > 0,
    CurrentRowIndex < TotalRowCount,
    ItemWeight =< CurrentColumnIndex,
    NewColumnIndex is CurrentColumnIndex + 1,
    AboveRowIndex is 0,
    AboveColumnIndex1 is TotalColumnCount - CurrentColumnIndex - 1,
    AboveColumnIndex2 is TotalColumnCount - (CurrentColumnIndex - ItemWeight) - 1,
    nth0Matrix(AboveRowIndex, AboveColumnIndex1, MatrixAccumulator, KnapsackAbove1),
    nth0Matrix(AboveRowIndex, AboveColumnIndex2, MatrixAccumulator, KnapsackAbove2),
    putItemInKnapsack(KnapsackAbove2, item(ItemName, ItemValue, ItemWeight), NewKnapsack),
    getKnapsackStats(KnapsackAbove1, Value1, _, _),
    getKnapsackStats(NewKnapsack, Value2, _, _),
    Value1 < Value2,
    generateStatusMatrixRow(TotalRowCount, TotalColumnCount, CurrentRowIndex, NewColumnIndex, MatrixAccumulator, item(ItemName, ItemValue, ItemWeight), Row, [NewKnapsack | Accumulator]),
    !.
generateStatusMatrixRow(TotalRowCount, TotalColumnCount, CurrentRowIndex, MatrixAccumulator, CurrentItem, Row) :-
    generateStatusMatrixRow(TotalRowCount, TotalColumnCount, CurrentRowIndex, 0, MatrixAccumulator, CurrentItem, Row, []),
    !.

generateStatusMatrix(TotalRowCount, _, [], MatrixAccumulator, MatrixAccumulator, TotalRowCount) :- !.
% Must gap when CurrentRowIndex =:= 0. Otherwise the first item will be discarded.
generateStatusMatrix(TotalRowCount, TotalColumnCount, Items, Matrix, MatrixAccumulator, 0) :-
    generateStatusMatrixRow(TotalRowCount, TotalColumnCount, CurrentRowIndex, MatrixAccumulator, _, Row),
    NewRowIndex is CurrentRowIndex + 1,
    generateStatusMatrix(TotalRowCount, TotalColumnCount, Items, Matrix, [Row | MatrixAccumulator], NewRowIndex), 
    !.
generateStatusMatrix(TotalRowCount, TotalColumnCount, [Item | Tail], Matrix, MatrixAccumulator, CurrentRowIndex) :-
    CurrentRowIndex > 0,
    generateStatusMatrixRow(TotalRowCount, TotalColumnCount, CurrentRowIndex, MatrixAccumulator, Item, Row),
    NewRowIndex is CurrentRowIndex + 1,
    generateStatusMatrix(TotalRowCount, TotalColumnCount, Tail, Matrix, [Row | MatrixAccumulator], NewRowIndex),
    !.
generateStatusMatrix(TotalRowCount, TotalColumnCount, Items, Matrix) :-
    generateStatusMatrix(TotalRowCount, TotalColumnCount, Items, Matrix, [], 0),
    !.

% Main procedure
knapsack(NumberOfItems, KnapsackCapacity, Items, ResultTotalValue, ResultItemsNames) :-
    TotalRowCount is NumberOfItems + 1,
    TotalColumnCount is KnapsackCapacity + 1,
    generateStatusMatrix(TotalRowCount, TotalColumnCount, Items, Matrix),
    findMostValuableKnapsackForMatrix(Matrix, SolutionKnapsack),
    getKnapsackStats(SolutionKnapsack, ResultTotalValue, _, _),
    getItemNamesFromKnapsack(SolutionKnapsack, ResultItemsNames),
    !.

% Entry point
solveKnapsack(Filename) :-
    open(Filename, read, FileInputStream),
    generateOutputFilename(Filename, OutputFilename),
    open(OutputFilename, write, FileOutputStream),
    parseInput(FileInputStream, NumberOfItems, KnapsackCapacity, Items),
    knapsack(NumberOfItems, KnapsackCapacity, Items, ResultTotalValue, ResultItemsNames),
    atomics_to_string(ResultItemsNames, '  ', ResultItemsName),
    write(FileOutputStream, ResultTotalValue), nl(FileOutputStream),
    write(FileOutputStream, ResultItemsName), nl(FileOutputStream),
    close(FileOutputStream),
    close(FileInputStream),
    !.
