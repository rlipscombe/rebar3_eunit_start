-module(rebar3_eunit_start_prv).

-export([init/1, do/1, format_error/1]).

-define(PROVIDER, rebar3_eunit_start).
-define(DEPS, [app_discovery]).

%% ===================================================================
%% Public API
%% ===================================================================
-spec init(rebar_state:t()) -> {ok, rebar_state:t()}.
init(State) ->
    Provider = providers:create([
        % The 'user friendly' name of the task
        {name, ?PROVIDER},
        % The module implementation of the task
        {module, ?MODULE},
        % Don't show up in 'rebar3 help'
        {bare, false},
        % The list of dependencies
        {deps, ?DEPS},
        % How to use the plugin
        {example, "rebar3 eunit"},
        % list of options understood by the plugin
        {opts, []},
        {short_desc, "Start applications before rebar3 eunit"},
        {desc, "Start applications before rebar3 eunit"}
    ]),
    {ok, rebar_state:add_provider(State, Provider)}.

-spec do(rebar_state:t()) -> {ok, rebar_state:t()} | {error, string()}.
do(State) ->
    Opts = rebar_state:get(State, eunit_opts, []),
    Applications = proplists:get_value(start_applications, Opts, []),
    {ok, _} = application:ensure_all_started(Applications),
    Modules = proplists:get_value(start_modules, Opts, []),
    lists:foreach(
        fun(Module) ->
            apply(Module, start, [])
        end,
        Modules
    ),
    {ok, State}.

-spec format_error(any()) -> iolist().
format_error(Reason) ->
    io_lib:format("~p", [Reason]).
