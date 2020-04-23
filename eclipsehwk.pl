/* Koby Tseng, Sergei Bondarenko, Emi Eliason */

/* Notes from office hours session
– Consolidate all problems to one method
- Problem 7: Write out every variable
- 

*/

:- lib(lists).
:- lib(fd).
:- lib(fd_search).

      /* Problem 1 */

/* 2s 6d = 60 pence */
/* 2s 3d = 54 pence */
/* 1s 9d = 42 pence */
/* 2s 4.5d = 28.5 x 2 = 57 pence */

problem1(Teas) :-
  problem1Setup(Teas),
  problem1Print(Teas).

problem1Setup(Teas) :-
  Teas = [BestTea, GoodTea, BadTea],
  BestTea #>= 0,
  GoodTea #>= 0,
  BadTea #>= 0,
  BestTea + GoodTea + BadTea #= 20,

  ((BestTea * 60) + (GoodTea * 54) + (BadTea * 42)) / 20 #= 57,

  minimize(labeling(Teas), BestTea).

problem1Print(Teas) :-
  Teas = [BestTea, GoodTea, BadTea],
  printf("Best Tea: %3d\n", [BestTea]),
  printf("Good Tea: %3d\n", [GoodTea]),
  printf("Bad Tea: %3d\n", [BadTea]).

      /* Problem 2 */

problem2(Barrels) :-
  Barrels = [Wine1, Wine2, Wine3, Wine4, Wine5, Beer],
  Barrels #:: [15, 19, 31, 20, 16, 18],
  alldifferent(Barrels),

  /*119 - Beer #= X, */

  Wine1 + Wine2 #= Y,

  Wine3 + Wine4 + Wine5 #= (2 * Y),

  labeling(Barrels),

  printf("Beer: %3d\n", [Beer]).

      /* Problem 3 */

problem3(Digits) :-
  problem3SetUp(Digits, Product),
  problem3Maximize(Digits, Product),
  problem3Print(Digits, Product).

problem3SetUp(Digits, Product) :-
  Digits = [Num1Dig1, Num1Dig2, Num1Dig3, Num2Dig1, Num2Dig2, Num3Dig1, Num3Dig2, Num4Dig1, Num4Dig2],
  Digits #:: [1..9],
  alldifferent(Digits),

  ((Num1Dig1 * 100) * (Num2Dig1 * 10)) + ((Num1Dig1 * 100) * (Num2Dig2)) + ((Num1Dig2 * 10) * (Num2Dig1 * 10)) + ((Num1Dig2 * 10) * (Num2Dig2)) + ((Num1Dig3) * (Num2Dig1 * 10)) + ((Num1Dig3) * (Num2Dig2)) #= Product,

  ((Num3Dig1 * 10) * (Num4Dig1 * 10)) + ((Num3Dig1 * 10) * (Num4Dig2)) + ((Num3Dig2) * (Num4Dig1 * 10)) + ((Num3Dig2) * (Num4Dig2)) #= Product.

problem3Solve(Digits) :-
  labeling(Digits).

problem3Maximize(Digits, Product) :-
  Product1 #= -1 * Product,
  /* Can't figure out why -Product doesn't work. */
  minimize(labeling(Digits), Product1).

problem3Print(Digits, Product) :-
  Digits = [Num1Dig1, Num1Dig2, Num1Dig3, Num2Dig1, Num2Dig2, Num3Dig1, Num3Dig2, Num4Dig1, Num4Dig2],
  printf("Number 1: %3d%3d%3d\n", [Num1Dig1, Num1Dig2, Num1Dig3]),
  printf("Number 2: %3d%3d\n", [Num2Dig1, Num2Dig2]),
  printf("Number 3: %3d%3d\n", [Num3Dig1, Num3Dig2]),
  printf("Number 4: %3d%3d\n", [Num4Dig1, Num4Dig2]),
  printf("Product: %3d\n", [Product]).

      /* Problem 4 */

problem4(Basket) :-
  Basket = [Eggs],

  /* What's the correct syntax for constraining via mod? */

  /* Eggs mod 2 #= 1,
  mod(Eggs, 3) #= 1,
  mod(Eggs, 4) #= 1,
  mod(Eggs, 5) #= 1,
  mod(Eggs, 6) #= 1,
  mod(Eggs, 7) #= 0, */

  Eggs #= (A * 2) + 1,
  Eggs #= (B * 3) + 1,
  Eggs #= (C * 4) + 1,
  Eggs #= (D * 5) + 1,
  Eggs #= (E * 6) + 1,
  Eggs #= F * 7,

  Eggs #> 0,
  minimize(labeling(Basket), Eggs),
  printf("Minimum number of eggs: %3d\n", [Eggs]).

      /* Problem 5 */

problem5(Trusses) :-
  Trusses = [A, B, C, D, E],
  Products = [AB, AC, AD, AE, BC, BD, BE, CD, CE, DE],
  Products #:: [110, 112, 113, 114, 115, 116, 117, 118, 120, 121],

  AB #= A + B,
  AC #= A + C,
  AD #= A + D,
  AE #= A + E,
  BC #= B + C,
  BD #= B + D,
  BE #= B + E,
  CD #= C + D,
  CE #= C + E,
  DE #= D + E,

  /* A + B #:: Products,
  A + C #:: Products,
  A + D #:: Products,
  A + E #:: Products,
  B + C #:: Products,
  B + D #:: Products,
  B + E #:: Products,
  C + D #:: Products,
  C + E #:: Products,
  D + E #:: Products, */

  alldifferent(Products),
  labeling(Trusses).

      /* Problem 6 */

problem6(Planets) :-
  Letters = [P, L, U, T, O, R, A, N, S, E, J, I, M, H, V, C, Y],

  /* How to make each element of Letters positive? */
  Letters #:: [0..50],

  P + L + U + T + O #= 40,
  U + R + A + N + U + S #= 36,
  N + E + P + T + U + N + E #= 29,
  S + A + T + U + R + N #= 33,
  J + U + P + I + T + E + R #= 50,
  M + A + R + S #= 32,
  E + A + R + T + H #= 31,
  M + O + O + N #= 36,
  V + E + N + U + S #= 39,
  M + E + R + C + U + R + Y #= 33,
  S + U + N #= 18,

  labeling(Letters),
  Planets is (P + L + A + N + E + T + S),
  printf("PLANETS: %3d\n", Planets).

problem7(Casks) :-
  N1 = [N1f , N1tq, N1h, N1q, N1e],
  N2 = [N1f , N2tq, N2h, N2q, N2e],
  N3 = [N3f , N3tq, N3h, N3q, N3e],
  N4 = [N4f , N4tq, N4h, N4q, N4e],
  N5 = [N5f , N5tq, N5h, N5q, N5e],
  Casks = [N1, N2, N3, N4, N5],

  /* everyone gets same number of casks(9) */
  N1f + N1tq + N1h + N1q + N1e #= 9,
  N2f + N2tq + N2h + N2q + N2e #= 9,
  N3f + N3tq + N3h + N3q + N3e #= 9,
  N4f + N4tq + N4h + N4q + N4e #= 9,
  N5f + N5tq + N5h + N5q + N5e #= 9,

  /* 9 of each cask*/
  N1f + N2f + N3f + N4f + N5f #= 9,
  N1tq + N2tq + N3tq + N4tq + N5tq #= 9,
  N1h + N2h + N3h + N4h + N5h #= 9,
  N1q + N2q + N3q + N4q + N5q #= 9,
  N1e + N2e + N3e + N4e + N5e #= 9,

  /* everyone gets at least one of each cask*/
  N1f #>= 1,
  N1tq #>= 1,
  N1h #>= 1,
  N1q #>= 1,
  N1e #>= 1,
  N2f #>= 1,
  N2tq #>= 1,
  N2h #>= 1,
  N2q #>= 1,
  N2e #>= 1,
  N3f #>= 1,
  N3tq #>= 1,
  N3h #>= 1,
  N3q #>= 1,
  N3e #>= 1,
  N4f #>= 1,
  N4tq #>= 1,
  N4h #>= 1,
  N4q #>= 1,
  N4e #>= 1,
  N5f #>= 1,
  N5tq #>= 1,
  N5h #>= 1,
  N5q #>= 1,
  N5e #>= 1,

  /* everyone gets same amount of wine*/
  F = 100,
  Tq = 75,
  H = 50,
  Oq = 25,

  (N1f * F) + (N1tq * Tq) + (N1h * H) + (N1q * Oq) #= W,
  (N2f * F) + (N2tq * Tq) + (N2h * H) + (N2q * Oq) #= W,
  (N3f * F) + (N3tq * Tq) + (N3h * H) + (N3q * Oq) #= W,
  (N4f * F) + (N4tq * Tq) + (N4h * H) + (N4q * Oq) #= W,
  (N5f * F) + (N5tq * Tq) + (N5h * H) + (N5q * Oq) #= W,

  /*No two people get the exact same distribution */
  N1T = (N1f * 10000) + (N1tq * 1000) + (N1h * 100) + (N1q * 10) + N1e,
  N2T = (N2f * 10000) + (N2tq * 1000) + (N2h * 100) + (N2q * 10) + N2e,
  N3T = (N3f * 10000) + (N3tq * 1000) + (N3h * 100) + (N3q * 10) + N3e,
  N4T = (N4f * 10000) + (N4tq * 1000) + (N4h * 100) + (N4q * 10) + N4e,
  N5T = (N5f * 10000) + (N5tq * 1000) + (N5h * 100) + (N5q * 10) + N5e,

  Totals = [N1T, N2T, N3T, N4T, N5T],
  alldifferent(Totals),

  labeling(Casks).
