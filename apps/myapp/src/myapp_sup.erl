%%%-------------------------------------------------------------------
%% @doc myapp top level supervisor
%% @end
%%%-------------------------------------------------------------------

-module(myapp_sup).

-behaviour(supervisor).

%% API
-export([start_link/0]).

%% Supervisor callbacks
-export([init/1]).

%% Helper macro for declaring children of supervisor
-define(CHILD(I, Type), {I, {I, start_link, []}, permanent, 5000, Type, [I]}).

%%====================================================================
%% API functions
%%====================================================================

start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

%%====================================================================
%% Supervisor callbacks
%%====================================================================

%% Child :: {Id,StartFunc,Restart,Shutdown,Type,Modules}
init([]) ->
    Childs = [{myapp_srv, worker}],
    {ok, {{one_for_all, 0, 1}, [?CHILD(I, Type) || {I, Type} <- Childs]}}.

%%====================================================================
%% Internal functions
%%====================================================================

