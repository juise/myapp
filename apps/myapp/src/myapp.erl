%%%-------------------------------------------------------------------
%% @doc myapp entry point and public API
%% @end
%%%-------------------------------------------------------------------

-module(myapp).

%% API
-export([start/0,
         stop/0]).

-export([hello/0]).

-include("myapp.hrl").

%%====================================================================
%% API functions
%%====================================================================

-spec start() -> 'ok'.
start() ->
    {ok, _} = application:ensure_all_started(myapp),
    ok.

-spec stop() -> 'ok'.
stop() ->
    ok = application:stop(myapp).


-spec hello() -> 'ok'.
hello() ->
    lager:info("Hello No:~w", [next_number()]),
    ok.

%%====================================================================
%% Internal functions
%%====================================================================

-spec next_number() -> non_neg_integer().
next_number() ->
    myapp_srv:next_number().

