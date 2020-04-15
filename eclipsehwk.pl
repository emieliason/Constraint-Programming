/* Koby Tseng, Sergei Bondarenko, Emi Eliason */

/* 2s 6d = 60 pence */
/* 2s 3d = 54 pence */
/* 1s 9d = 42 pence */
/* 2s 4.5d = 28.5 x 2 = 57 pence */

:- lib(lists).
:- lib(fd).
:- lib(fd_search).

problem1(Teas) :-
  problem1Setup(Teas),
  problem1Solve(Teas),
  problem1Print(Teas).

problem1Setup(Teas) :-
  Teas = [BestTea, GoodTea, BadTea],
  BestTea #>= 0,
  GoodTea #>= 0,
  BadTea #>= 0,
  BestTea + GoodTea + BadTea #= 20,

  ((BestTea * 60) + (GoodTea * 54) + (BadTea * 42)) / 3 #= 57.

problem1Solve(Teas) :-
  minimize(labeling(Teas), BestTea).

problem1Print(Teas) :-
  Teas = [BestTea, GoodTea, BadTea],
  printf("Best Tea: %3d\n", [BestTea]),
  printf("Good Tea: %3d\n", [GoodTea]),
  printf("Bad Tea: %3d\n", [BadTea]).
