Sale
====

Check README of each app under apps/

Running
-------

    $ mix ecto.create -r Customer.Repo
    $ mix ecto.migrate -r Customer.Repo
    $ iex -S mix


Manual Testing
--------------

    $ curl -H "Content-Type: application/json" -X POST -d '{"username":"mouad","token":"xyz"}' 127.0.0.1:8880/user/
    $ curl -v -H "Authorization: xyz" 127.0.0.1:8880/

Benchmark
---------

Using https://github.com/wg/wrk

    $ ./wrk -t10 -c400 -d30s -H"Authorization: xyz" http://127.0.0.1:8880/user/
    Running 30s test @ http://127.0.0.1:8880/user/
      10 threads and 400 connections
      Thread Stats   Avg      Stdev     Max   +/- Stdev
        Latency    68.17ms   16.35ms 306.50ms   89.61%
        Req/Sec   583.23     90.59   840.00     80.47%
      174360 requests in 30.05s, 54.87MB read
      Socket errors: connect 0, read 254, write 0, timeout 0
    Requests/sec:   5802.36
    Transfer/sec:      1.83MB


TODO
----

- grep for TODO/FIXME there is quite few stuff that are still to check !
- distribute and test (i.e. different nodes).
- Benchmark.
- Fix tests for user (need for mix ecto.drop should not be done manually)
- Evaluate other REST frameworks.
- Evaluate other solution beside GenServer.
- Check if we can use GenEvent for emitting events.
- Figure out how to do releases http://bitwalker.org/blog/2014/03/20/releases-for-elixir/
- X-requrest-id logging.
- monitoring https://github.com/boundary/folsom
- Check http://blog.rusty.io/2009/09/16/g-proc-erlang-global-process-registry/


Comparison with lymph
---------------------

- remote console
- monitoring
- registry
- Integration with newrelic
- benchmarks
- ...
