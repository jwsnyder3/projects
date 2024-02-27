% Setting global variables, one for grid size of s and one for subgrid of size n.
% These constants are set currently for a sudoku of size 9 with subgrids of size 3.
%
#const s=9.
#const n=3.

%Creating an interval of number values from 1 to size of grid.
%
values(1..s).


% This rule regards given initials.
%
sudoku(X,Y,N) :- initial(X,Y,N).

% This rule assigns exactly one value to each X,Y position in the grid.
%
1 { sudoku(X,Y,N) : values(N) } 1 :- values(X), values(Y).

%These constraints confirm each row X has no repeating values,
%           and confirms each colum Y has no repeating values.
%
:- sudoku(X,Y,N), sudoku(X',Y,N), X != X'.
:- sudoku(X,Y,N), sudoku(X,Y',N), Y != Y'.

% Creates an interval from 1 to grid size squared, so that we have the number of subgrids.
%
grid(1..(n*n)).

% This will create a subgrid object that considers each cell(X,Y), the subgrid number
%              as well as computing the specific subgrid of the current X,Y location.
%
subgrid(X,Y,G) :- values(X), values(Y), grid(G), G = ( 1 + ( ( X - 1 ) / n ) * n + ( ( Y - 1 ) / n ) ).

% This constraint is similar to the one for rows and columns above, but now it is considering the rows
%                                and columns of each indivdual subgrid in relation to the full sudoku.
%
:- sudoku(X,Y,N), sudoku(X',Y',N), subgrid(X,Y,G), subgrid(X',Y',G), (X,Y) != (X',Y').

%This show directive will show all sudoku(X,Y,N).
%
#show sudoku/3.
