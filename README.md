myapp
=====

An OTP application for make simple erlang release with:

 - systools
 - reltool
 - relx
 - rebar + reltool
 - rebar3 + relx

Build
-----

    $ make compile3

Run
---
    $ make run3
    1> myapp:hello().
    ... Hello No:0
    ok
    2> myapp:hello().
    ... Hello No:1
    ok

Release with systools
---------------------

    Generate release and make package file:

    $ make compile3
    $ make run3
    1> systools:make_script("release/myapp", [local]).
    ok
    2> systools:make_tar("release/myapp", [{erts, "/usr/local/lib/erlang/"}]).
    ok

    Check generated release:

    $ erl -boot release/myapp
    1> myapp:hello().
    ... Hello No:0
    ok
    2> myapp:hello().
    ... Hello No:1
    ok

    Unpack release on target system and run:

    $ mkdir -p /tmp/myapp
    $ rm -rf /tmp/myapp/*
    $ cp release/myapp.tar.gz /tmp/myapp
    $ cd /tmp/myapp
    $ tar -xzvf myapp.tar.gz
    $ ./erts-7.0/bin/erl -boot ./releases/1.0.0/start
    1> myapp:hello().
    ... Hello No:0
    ok
    2> myapp:hello().
    ... Hello No:1
    ok

Release with reltool
--------------------

    Generate release and make package file:

    $ make compile3
    $ make run3
    1> {ok, Conf} = file:consult("reltool/reltool.config").
    ...
    2> {ok, Spec} = reltool:get_target_spec(Conf).
    ...
    3> reltool:eval_target_spec(Spec, code:root_dir(), "reltool/myapp").
    ok
    $ cd reltool/myapp
    $ tar -czvf myapp.tar.gz *

    Check generated release:

    $ ./erts-7.0/bin/erl -boot ./releases/1.0.0/myapp
    1> myapp:hello().
    ... Hello No:0
    ok
    2> myapp:hello().
    ... Hello No:1
    ok

    Unpack release on target system and run:

    $ mkdir -p /tmp/myapp
    $ rm -rf /tmp/myapp/*
    $ cp myapp.tar.gz /tmp/myapp
    $ cd /tmp/myapp
    $ tar -xzvf myapp.tar.gz
    $ ./erts-7.0/bin/erl -boot ./releases/1.0.0/myapp
    1> myapp:hello().
    ... Hello No:0
    ok
    2> myapp:hello().
    ... Hello No:1
    ok

Release with relx
-------------------------------

    Generate release and make package file:

    $ make compile3
    $ ./relx
    $ cd _rel/myapp
    $ tar -czvf myapp.tar.gz *

    Check generated release:

    $ ./erts-7.0/bin/erl -boot ./releases/1.0.0/myapp
    1> myapp:hello().
    ... Hello No:0
    ok
    2> myapp:hello().
    ... Hello No:1
    ok

    Unpack release on target system and run:

    $ mkdir -p /tmp/myapp
    $ rm -rf /tmp/myapp/*
    $ cp myapp.tar.gz /tmp/myapp
    $ cd /tmp/myapp
    $ tar -xzvf myapp.tar.gz
    $ ./erts-7.0/bin/erl -boot ./releases/1.0.0/myapp
    1> myapp:hello().
    ... Hello No:0
    ok
    2> myapp:hello().
    ... Hello No:1
    ok

Release with rebar2 and reltool
-------------------------------

    Generate new reltool skel:

    #$ mkdir rel
    #$ cd rel
    #$ ../rebar create-node nodeid=myapp
    #$ cp ../config/* ./files
    #$ cd ..

    Generate release and make package file:

    $ make compile2
    $ make rel2
    $ cd rel/myapp
    $ tar -czvf myapp.tar.gz *

    Check generated release:

    $ ./erts-7.0/bin/erl -boot ./releases/1.0.0/myapp
    1> application:ensure_all_started(myapp).
    ...
    2> myapp:hello().
    ... Hello No:0
    ok
    3> myapp:hello().
    ... Hello No:1
    ok

    Unpack release on target system and run:

    $ mkdir -p /tmp/myapp
    $ rm -rf /tmp/myapp/*
    $ cp myapp.tar.gz /tmp/myapp
    $ cd /tmp/myapp
    $ tar -xzvf myapp.tar.gz
    $ ./erts-7.0/bin/erl -boot ./releases/1.0.0/myapp
    1> application:ensure_all_started(myapp).
    ...
    2> myapp:hello().
    ... Hello No:0
    ok
    3> myapp:hello().
    ... Hello No:1
    ok

Release with rebar3 and relx
----------------------------

    Generate release and make package file:

    $ make compile3
    $ make rel3
    $ cd _build/default/rel/myapp
    $ tar -czvf myapp.tar.gz *

    Check generated release:

    $ ./erts-7.0/bin/erl -boot ./releases/1.0.0/myapp
    1> myapp:hello().
    ... Hello No:0
    ok
    2> myapp:hello().
    ... Hello No:1
    ok

    Unpack release on target system and run:

    $ mkdir -p /tmp/myapp
    $ rm -rf /tmp/myapp/*
    $ cp myapp.tar.gz /tmp/myapp
    $ cd /tmp/myapp
    $ tar -xzvf myapp.tar.gz
    $ ./erts-7.0/bin/erl -boot ./releases/1.0.0/myapp
    1> myapp:hello().
    ... Hello No:0
    ok
    2> myapp:hello().
    ... Hello No:1
    ok

