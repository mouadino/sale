Sale
====

Check README of each app under apps/

Running
-------

    $ mix ecto.create -r User.Repo
    $ mix ecto.migrate -r User.Repo
    $ iex -S mix


Manual Testing
--------------

    $ curl -v -H "Authorization: 123" 127.0.0.1:8880/

TODO
----

- grep for TODO/FIXME there is quite few stuff that are still to check !
- distribute and test (i.e. different nodes).
- Benchmark.
- Fix tests for user (need for mix ecto.drop should not be done manually)
- Evaluate other REST frameworks.
- Evaluate other solution beside GenServer.
- Check if we can use GenEvent for emitting events.
- ... 
