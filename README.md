# rebar3_eunit_start

A rebar plugin that allows you to run code before `rebar3 eunit` does its thing.

It's useful for starting applications (such as `telemetry`) that your code depends on, without scattering fixtures all
over your tests.

If you're looking for the equivalent for Common Test, that's here: https://github.com/rlipscombe/ct_ext/

## Use

Add the plugin to your rebar config:

```erlang
{profiles, [
    {test, [
        {plugins, [
            {rebar3_eunit_start, {git, "https://github.com/rlipscombe/rebar3_eunit_start.git", {tag, "0.1.0"}}}
        ]},
        {provider_hooks, [{pre, [{eunit, {default, rebar3_eunit_start}}]}]}
    ]}
]}.
```

Configure the applications and/or modules to start:

```erlang
{eunit_opts, [
    % ...
    {start_applications, [telemetry]},
    {start_modules, [test_helper]}
]}.
```

It starts the listed applications and then the listed modules. The applications are passed to
`application:ensure_all_started/1`. For each module listed, the `Module:start/0` function is called. The modules
are started in the order given.

Then run `rebar3 eunit` as normal:

    $ rebar3 eunit

Before eunit runs your tests, the `telemetry` application will be started, and `test_helper:start()` will be called.

## Development

Add the plugin to your rebar config as above, and then add symlink from the `plugins` directory:

```
cd _build/default/plugins/
ln -sf path/to/rebar3_eunit_start .
```

When you make changes to the plugin, delete the `ebin` directory in _this_ directory, so that rebar recompiles it.
