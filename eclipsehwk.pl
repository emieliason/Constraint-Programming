/*  Koby Tseng, Sergei Bondarenko, Emi Eliason
    April 23rd, 2020
    Programming Language Paradigms
    John Rager  */


      /* Imports */

:- lib(lists).
:- lib(fd).
:- lib(fd_search).


      /* Problem 1 */

  /* 2s 6d = 60 pence */
  /* 2s 3d = 54 pence */
  /* 1s 9d = 42 pence */
  /* 2s 4.5d = 28.5 x 2 = 57 pence */

problem1(Teas) :-
  Teas = [BestTea, GoodTea, BadTea],

  /* Use positive integers only. */
  BestTea #>= 0,
  GoodTea #>= 0,
  BadTea #>= 0,

  /* 20 pounds of tea in total. */
  BestTea + GoodTea + BadTea #= 20,

  /* The average price for the teas must be 57 pence.
     We rescaled by a factor of 2 to avoid fractions. */
  ((BestTea * 60) + (GoodTea * 54) + (BadTea * 42)) / 20 #= 57,

  /* Find the answer that uses the least amount of the best tea. */
  minimize(labeling(Teas), BestTea),

  printf("Best Tea: %3d\n", [BestTea]),
  printf("Good Tea: %3d\n", [GoodTea]),
  printf("Bad Tea: %3d\n", [BadTea]).


      /* Problem 2 */

problem2(Barrels) :-
  Barrels = [Wine1, Wine2, Wine3, Wine4, Wine5, Beer],

  /* Barrels must take on one of the following quantities of wine. */
  Barrels #:: [15, 19, 31, 20, 16, 18],
  alldifferent(Barrels),

  /* The man kept the beer to himself. */
  119 - Beer #= X,

  /* The man sold a quantity of wine to one man and twice the quantity to another. */
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

  /* Digits must take on one unique value from 1 to 9. */
  Digits #:: [1..9],
  alldifferent(Digits),

  /* The product of Num1 * Num2 must be equal to the product of Num3 * Num4. */
  ((Num1Dig1 * 100) * (Num2Dig1 * 10)) + ((Num1Dig1 * 100) * (Num2Dig2)) + ((Num1Dig2 * 10) * (Num2Dig1 * 10)) + ((Num1Dig2 * 10) * (Num2Dig2)) + ((Num1Dig3) * (Num2Dig1 * 10)) + ((Num1Dig3) * (Num2Dig2)) #= Product,

  ((Num3Dig1 * 10) * (Num4Dig1 * 10)) + ((Num3Dig1 * 10) * (Num4Dig2)) + ((Num3Dig2) * (Num4Dig1 * 10)) + ((Num3Dig2) * (Num4Dig2)) #= Product.

problem3Solve(Digits) :-
  /* Find all solutions. */
  labeling(Digits).

problem3Maximize(Digits, Product) :-
  /* Find the solution with the largest product. */
  Product1 #= -1 * Product,
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

  /* There is a remainder of 1 when the quantity is divided by 2, 3, 4, 5, and 6, and a remainder of 0 when divided by 7. */
  Eggs #= (A * 2) + 1,
  Eggs #= (B * 3) + 1,
  Eggs #= (C * 4) + 1,
  Eggs #= (D * 5) + 1,
  Eggs #= (E * 6) + 1,
  Eggs #= F * 7,
  Eggs #> 0,

  /* Minimize the number of eggs in the basket. */
  minimize(labeling(Basket), Eggs),
  printf("Minimum number of eggs: %3d\n", [Eggs]).


      /* Problem 5 */

problem5(Trusses) :-
  Trusses = [A, B, C, D, E],
  Sums = [AB, AC, AD, AE, BC, BD, BE, CD, CE, DE],

  /* These are the weights of each pair. */
  Sums #:: [110, 112, 113, 114, 115, 116, 117, 118, 120, 121],

  /* Define each pair as the combination of its two parts. */
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

  alldifferent(Sums),
  labeling(Trusses).


      /* Problem 6 */

problem6(Planets) :-
  Letters = [P, L, U, T, O, R, A, N, S, E, J, I, M, H, V, C, Y],

  /* No letter will be larger than the largest sum. */
  Letters #:: [0..50],

  /* Define each word as the summation of its letters. */
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

  /* Find the value of PLANETS. */
  labeling(Letters),
  Planets is (P + L + A + N + E + T + S),
  printf("PLANETS: %3d\n", Planets).


        /* Problem 7 */

problem7(Casks) :-
  N1 = [N1f, N1tq, N1h, N1q, N1e],
  N2 = [N2f, N2tq, N2h, N2q, N2e],
  N3 = [N3f, N3tq, N3h, N3q, N3e],
  N4 = [N4f, N4tq, N4h, N4q, N4e],
  N5 = [N5f, N5tq, N5h, N5q, N5e],
  Casks = [N1, N2, N3, N4, N5],

  /* Every nephew gets 9 casks. */
  N1f + N1tq + N1h + N1q + N1e #= 9,
  N2f + N2tq + N2h + N2q + N2e #= 9,
  N3f + N3tq + N3h + N3q + N3e #= 9,
  N4f + N4tq + N4h + N4q + N4e #= 9,
  N5f + N5tq + N5h + N5q + N5e #= 9,

  /* There is 9 of each type of cask. */
  N1f + N2f + N3f + N4f + N5f #= 9,
  N1tq + N2tq + N3tq + N4tq + N5tq #= 9,
  N1h + N2h + N3h + N4h + N5h #= 9,
  N1q + N2q + N3q + N4q + N5q #= 9,
  N1e + N2e + N3e + N4e + N5e #= 9,

  /* Each nephew gets at least one of each cask. */
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

  /* Each nephew gets the same amount of wine. */
  F = 100,
  Tq = 75,
  H = 50,
  Oq = 25,

  (N1f * F) + (N1tq * Tq) + (N1h * H) + (N1q * Oq) #= W,
  (N2f * F) + (N2tq * Tq) + (N2h * H) + (N2q * Oq) #= W,
  (N3f * F) + (N3tq * Tq) + (N3h * H) + (N3q * Oq) #= W,
  (N4f * F) + (N4tq * Tq) + (N4h * H) + (N4q * Oq) #= W,
  (N5f * F) + (N5tq * Tq) + (N5h * H) + (N5q * Oq) #= W,

  /* No two nephews get the exact same distribution. */
  N1T = (N1f * 10000) + (N1tq * 1000) + (N1h * 100) + (N1q * 10) + N1e,
  N2T = (N2f * 10000) + (N2tq * 1000) + (N2h * 100) + (N2q * 10) + N2e,
  N3T = (N3f * 10000) + (N3tq * 1000) + (N3h * 100) + (N3q * 10) + N3e,
  N4T = (N4f * 10000) + (N4tq * 1000) + (N4h * 100) + (N4q * 10) + N4e,
  N5T = (N5f * 10000) + (N5tq * 1000) + (N5h * 100) + (N5q * 10) + N5e,

  Totals = [N1T, N2T, N3T, N4T, N5T],
  alldifferent(Totals),

  labeling(N1),
  labeling(N2),
  labeling(N3),
  labeling(N4),
  labeling(N5),

  printf("Nephew 1: %3d Full, %3d Three-Quarters, %3d Half, %3d Quarter, %3d Empty\n", [N1f, N1tq, N1h, N1q, N1e]),
  printf("Nephew 2: %3d Full, %3d Three-Quarters, %3d Half, %3d Quarter, %3d Empty\n", [N2f, N2tq, N2h, N2q, N2e]),
  printf("Nephew 3: %3d Full, %3d Three-Quarters, %3d Half, %3d Quarter, %3d Empty\n", [N3f, N3tq, N3h, N3q, N3e]),
  printf("Nephew 4: %3d Full, %3d Three-Quarters, %3d Half, %3d Quarter, %3d Empty\n", [N4f, N4tq, N4h, N4q, N4e]),
  printf("Nephew 5: %3d Full, %3d Three-Quarters, %3d Half, %3d Quarter, %3d Empty\n", [N5f, N5tq, N5h, N5q, N5e]).


        /* Problem 8 */

problem8(Grid):-
  /* Define a 2-D array of squares. */
	Grid = [S11, S12, S13, S14, S15, S16, S17, S18,
  S21, S22, S23, S24, S25, S26, S27, S28,
	S31, S32, S33, S34, S35, S36, S37, S38,
	S41, S42, S43, S44, S45, S46, S47, S48,
	S51, S52, S53, S54, S55, S56, S57, S58,
	S61, S62, S63, S64, S65, S66, S67, S68,
	S71, S72, S73, S74, S75, S76, S77, S78,
	S81, S82, S83, S84, S85, S86, S87, S88],

  /* Squares can either be marked or not marked. */
	Grid :: [0,1],

  /* If a square is marked, add its column value to the row total. */
  1 * S31 + 2 * S32 + 3 * S33 + 4 * S34 + 5 * S35 + 6 * S36 + 7 * S37 + 8 * S38 #= 5,
	1 * S41 + 2 * S42 + 3 * S43 + 4 * S44 + 5 * S45 + 6 * S46 + 7 * S47 + 8 * S48 #= 10,
	1 * S51 + 2 * S52 + 3 * S53 + 4 * S54 + 5 * S55 + 6 * S56 + 7 * S57 + 8 * S58 #= 29,
	1 * S71 + 2 * S72 + 3 * S73 + 4 * S74 + 5 * S75 + 6 * S76 + 7 * S77 + 8 * S78 #= 26,

  /* If a square is marked, add its row value to the column total. */
	1 * S11 + 2 * S21 + 3 * S31 + 4 * S41 + 5 * S51 + 6 * S61 + 7 * S71 + 8 * S81 #= 6,
	1 * S12 + 2 * S22 + 3 * S32 + 4 * S42 + 5 * S52 + 6 * S62 + 7 * S72 + 8 * S82 #= 15,
	1 * S13 + 2 * S23 + 3 * S33 + 4 * S43 + 5 * S53 + 6 * S63 + 7 * S73 + 8 * S83 #= 28,
	1 * S14 + 2 * S24 + 3 * S34 + 4 * S44 + 5 * S54 + 6 * S64 + 7 * S74 + 8 * S84 #= 27,
	1 * S15 + 2 * S25 + 3 * S35 + 4 * S45 + 5 * S55 + 6 * S65 + 7 * S75 + 8 * S85 #= 30,
	1 * S16 + 2 * S26 + 3 * S36 + 4 * S46 + 5 * S56 + 6 * S66 + 7 * S76 + 8 * S86 #= 28,
	1 * S17 + 2 * S27 + 3 * S37 + 4 * S47 + 5 * S57 + 6 * S67 + 7 * S77 + 8 * S87 #= 6,
	1 * S18 + 2 * S28 + 3 * S38 + 4 * S48 + 5 * S58 + 6 * S68 + 7 * S78 + 8 * S88 #= 30,

	labeling(Grid),

  printf("%3d%3d%3d%3d%3d%3d%3d%3d\n", [S11, S12, S13, S14, S15, S16, S17, S18]),
  printf("%3d%3d%3d%3d%3d%3d%3d%3d\n", [S21, S22, S23, S24, S25, S26, S27, S28]),
  printf("%3d%3d%3d%3d%3d%3d%3d%3d\n", [S31, S32, S33, S34, S35, S36, S37, S38]),
  printf("%3d%3d%3d%3d%3d%3d%3d%3d\n", [S41, S42, S43, S44, S45, S46, S47, S48]),
  printf("%3d%3d%3d%3d%3d%3d%3d%3d\n", [S51, S52, S53, S54, S55, S56, S57, S58]),
  printf("%3d%3d%3d%3d%3d%3d%3d%3d\n", [S61, S62, S63, S64, S65, S66, S67, S68]),
  printf("%3d%3d%3d%3d%3d%3d%3d%3d\n", [S71, S72, S73, S74, S75, S76, S77, S78]),
  printf("%3d%3d%3d%3d%3d%3d%3d%3d\n", [S81, S82, S83, S84, S85, S86, S87, S88]).


        /* Problem 9 */

problem9(Lights) :-
  /* Define a 2-D array of squares. */
  Lights = [S11, S12, S13, S14,
          S21, S22, S23, S24,
          S31, S32, S33, S34,
          S41, S42, S43, S44],

  /* It is never necessary to click a square twice. */
  Lights :: [0,1],

  /* Define each square's sum as the number of times the squares in its row and column have been toggled. Constrain the sum to be an even number of toggles – that is, the square is lit. (If the square is already unlit, it requires an odd number of toggles to become lit.) */
  Sum1 #= S11 + S12 + S13 + S14 + S21 + S31 + S41,
  Sum1 #= (A*2),

  Sum2 #= S11 + S12 + S13 + S14 + S22 + S32 + S42,
  Sum2 #= (B*2),

  Sum3 #= S11 + S12 + S13 + S14 + S23 + S33 + S43,
  Sum3 #= (C*2),

  Sum4 #= S11 + S12 + S13 + S14 + S24 + S34 + S44,
  Sum4 #= (D*2) + 1,

  Sum5 #= S21 + S22 + S23 + S24 + S11 + S31 + S41,
  Sum5 #= (E*2),

  Sum6 #= S21 + S22 + S23 + S24 + S12 + S32 + S42,
  Sum6 #= (F*2),

  Sum7 #= S21 + S22 + S23 + S24 + S13 + S33 + S43,
  Sum7 #= (G*2),

  Sum8 #= S21 + S22 + S23 + S24 + S14 + S34 + S44,
  Sum8 #= (H*2) + 1,

  Sum9 #= S31 + S32 + S33 + S34 + S11 + S21 + S41,
  Sum9 #= (I*2) + 1,

  Sum10 #= S31 + S32 + S33 + S34 + S12 + S22 + S42,
  Sum10 #= (J*2),

  Sum11 #= S31 + S32 + S33 + S34 + S13 + S23 + S43,
  Sum11 #= (K*2) + 1,

  Sum12 #= S31 + S32 + S33 + S34 + S14 + S24 + S44,
  Sum12 #= (L*2),

  Sum13 #= S41 + S42 + S43 + S44 + S11 + S21 + S31,
  Sum13 #= (M*2) + 1,

  Sum14 #= S41 + S42 + S43 + S44 + S12 + S22 + S32,
  Sum14 #= (N*2),

  Sum15 #= S41 + S42 + S43 + S44 + S13 + S23 + S33,
  Sum15 #= (O*2),

  Sum16 #= S41 + S42 + S43 + S44 + S14 + S24 + S34,
  Sum16 #= (P*2),

  labeling(Lights),

  printf("%3d %3d %3d %3d\n", [S11, S12, S13, S14]),
  printf("%3d %3d %3d %3d\n", [S21, S22, S23, S24]),
  printf("%3d %3d %3d %3d\n", [S31, S32, S33, S34]),
  printf("%3d %3d %3d %3d\n", [S41, S42, S43, S44]).
