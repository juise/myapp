%%%-------------------------------------------------------------------
%% @doc myapp simple server
%% @end
%%%-------------------------------------------------------------------

-module(myapp_srv).

-behaviour(gen_server).

%% API
-export([start_link/0]).

-export([next_number/0]).

%% gen_server callbacks
-export([init/1,
         handle_call/3,
         handle_cast/2,
         handle_info/2,
         terminate/2,
         code_change/3]).

-include("myapp.hrl").

-record(state, {n               :: non_neg_integer()
}).

%% ===================================================================
%% API functions
%% ===================================================================

start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).


-spec next_number() -> non_neg_integer().
next_number() ->
    gen_server:call(?MODULE, next_number).

%% ===================================================================
%% gen_server callbacks
%% ===================================================================

init([]) ->
    {ok, #state{n = 0}}.

handle_call(next_number, From, #state{n = N} = State) ->
    gen_server:reply(From, N),
    {noreply, State#state{n = N + 1}};

handle_call(Msg, _From, State) ->
    lager:error("Unknown call message: '~p'", [Msg]),
    {reply, {error, unknown_msg}, State}.

handle_cast(Msg, State) ->
    lager:error("Unknown cast message: '~p'", [Msg]),
    {noreply, State}.

handle_info(Msg, State) ->
    lager:error("Unknown info message: '~p'", [Msg]),
    {noreply, State}.

terminate(Reason, _State) ->
    lager:info("Terminate with reason '~p'", [Reason]),
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.

%% ===================================================================
%% Internal functions
%% ===================================================================

