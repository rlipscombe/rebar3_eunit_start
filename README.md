# rebar3_eunit_start

A rebar plugin that allows you to run code before `rebar3 eunit` does its thing.

It's useful for starting applications (such as `telemetry`) that your code depends on, without scattering fixtures all
over your tests.

## Build

    $ rebar3 compile

## Use

Add the plugin to your rebar config:

    {project_plugins, [
        {rebar3_eunit_start, {git, "https://github.com/rlipscombe/rebar3_eunit_start.git", {tag, "0.1.0"}}}
    ]}.

Then just run `rebar3 eunit` as normal:

    $ rebar3 eunit

## Development

Add the plugin to your rebar config as above, and then add symlink from the `plugins` directory:

```
cd _build/default/plugins/
ln -sf path/to/rebar3_eunit_start .
```

When you make changes to the plugin, delete the `ebin` directory in _this_ directory, so that rebar recompiles it.
