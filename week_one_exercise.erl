-module(week_one_exercise).

-export([perimeter/1, area/1, enclose/1, bits/1, bitsTail/1]). 

-include_lib("eunit/include/eunit.hrl").

perimeter({circle, {_X,_Y}, R}) ->
	math:pi() * 2 * R;

perimeter({rectangle, {_X,_Y}, H, W}) ->
	2 * H + 2 * W;

perimeter({triangle, {_X,_Y}, A, B, C}) ->
	A + B + C.

area({circle, {_X,_Y}, R}) ->
	math:pi() * R * R;

area({rectangle, {_X,_Y}, H, W}) ->
	H * W;

area({triangle, {_X,_Y}, A, B, C}) ->
	S = (A + B + C)/2,
	math:sqrt(S*(S-A)*(S-B)*(S-C)).

enclose({circle, {X, Y}, R}) ->
	{rectangle, {X, Y}, 2 * R, 2 * R};

enclose({rectangle, {X, Y}, H, W}) ->
	{rectangle, {X, Y}, H, W};

enclose({triangle, {X, Y}, A, B, C}) ->
	A = area({triangle, {X, Y}, A, B, C}),
	W = erlang:max(erlang:max(A,B),C),
	H = (A * 2) - W,
	{rectangle, {X, Y}, H, W}.


bits(0) -> 
	0;

bits(N) -> 
	(N band 1) + bits(N bsr 1). 


bitsTail(N) -> 
	bitsTailRec(N, 0).

bitsTailRec(0, Sum) -> 
	Sum;

bitsTailRec(N, Sum) -> 
	bitsTailRec(N bsr 1, Sum + (N band 1)).


perimeter_test()->
	 ?assert(perimeter({rectangle, {0, 0}, 5, 5}) =:= 20),
	 ?assert(perimeter({circle, {0, 0}, 10}) =:= 62.83185307179586),
	 ?assert(perimeter({triangle, {0, 0}, 5, 6, 7}) =:= 18).

area_test()->
	 ?assert(area({rectangle, {0, 0}, 5, 5}) =:= 25),
	 ?assert(area({circle, {0, 0}, 10}) =:= 314.1592653589793),
	 ?assert(area({triangle, {0, 0}, 5, 6, 7}) =:= 14.696938456699069).

bits_test() ->
	?assert(bits(8) =:= bitsTail(8)),
	?assert(bits(7) =:= bitsTail(7)),
	?assert(bits(0) =:= bitsTail(0)).

