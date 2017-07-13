%%%-------------------------------------------------------------------
%%% @author Gaizka Rubio Landaluze
%%% @doc
%%% My solution to the first week exercises of future learn.
%%% @end
%%% Created : 13. Jul 2017 11:28 AM
%%%-------------------------------------------------------------------

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

%% We use Heron formula to get the area
area({triangle, {_X,_Y}, A, B, C}) ->
	S = semiperimeter(A, B, C),
	math:sqrt(S*(S-A)*(S-B)*(S-C)).

enclose({circle, {X, Y}, R}) ->
	{rectangle, {X, Y}, 2 * R, 2 * R};

enclose({rectangle, {X, Y}, H, W}) ->
	{rectangle, {X, Y}, H, W};

%% We suppose that X and Y are the coords of the circumcenter
enclose({triangle, {X, Y}, A, B, C}) ->
	S = semiperimeter(A, B, C),
	R = (A*B*C)/(4*math:sqrt(S*(S-A)*(S-B)*(S-C))),
	enclose({circle, {X, Y}, R}).

semiperimeter(A, B, C) ->
	(A + B + C)/2.

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


%% Test for each of the functions
perimeter_test()->
	?assert(perimeter({rectangle, {0, 0}, 5, 5}) =:= 20),
	?assert(perimeter({circle, {0, 0}, 10}) =:= 62.83185307179586),
	?assert(perimeter({triangle, {0, 0}, 5, 6, 7}) =:= 18).

area_test()->
	?assert(area({rectangle, {0, 0}, 5, 5}) =:= 25),
	?assert(area({circle, {0, 0}, 10}) =:= 314.1592653589793),
	?assert(area({triangle, {0, 0}, 5, 6, 7}) =:= 14.696938456699069).

enclose_test() ->
	?assert(enclose({rectangle, {0, 0}, 5, 5}) =:= {rectangle, {0, 0}, 5, 5}),
	?assert(enclose({circle, {0, 0}, 10}) =:= {rectangle,{0,0},20,20}),
	?assert(enclose({triangle, {0, 0}, 10, 10, 10}) =:= {rectangle,{0,0},11.547005383792516,11.547005383792516}).

bits_test() ->
	?assert(bits(8) =:= bitsTail(8)),
	?assert(bits(7) =:= bitsTail(7)),
	?assert(bits(0) =:= bitsTail(0)).