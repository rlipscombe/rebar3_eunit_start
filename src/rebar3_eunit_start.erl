-module(rebar3_eunit_start).

-export([init/1]).

-spec init(rebar_state:t()) -> {ok, rebar_state:t()}.
init(State) ->
    {ok, State1} = rebar3_eunit_start_prv:init(State),
    {ok, State1}.
