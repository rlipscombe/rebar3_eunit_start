rebar3_eunit_start
=====

A rebar plugin

Build
-----

    $ rebar3 compile

Use
---

Add the plugin to your rebar config:

    {plugins, [
        {rebar3_eunit_start, {git, "https://host/user/rebar3_eunit_start.git", {tag, "0.1.0"}}}
    ]}.

Then just call your plugin directly in an existing application:


    $ rebar3 rebar3_eunit_start
    ===> Fetching rebar3_eunit_start
    ===> Compiling rebar3_eunit_start
    <Plugin Output>
