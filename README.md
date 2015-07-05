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

    $ curl -H "Content-Type: application/json" -X POST -d '{"username":"mouad","token":"xyz"}' 127.0.0.1:8880/user/
    $ curl -v -H "Authorization: xyz" 127.0.0.1:8880/

Benchmark
---------

Using https://github.com/wg/wrk

    $ ./wrk -t10 -c400 -d30s -H"Authorization: xyz" http://127.0.0.1:8880/user/

    Running 30s test @ http://127.0.0.1:8880/user/
      10 threads and 400 connections
      Thread Stats   Avg      Stdev     Max   +/- Stdev
        Latency     1.03s   503.05ms   1.90s    47.37%
        Req/Sec    10.45     12.17   155.00     89.99%
      1623 requests in 30.10s, 400.06KB read
      Socket errors: connect 0, read 1089, write 0, timeout 1490
      Non-2xx or 3xx responses: 1105
    Requests/sec:     53.92
    Transfer/sec:     13.29KB

Quite few timeouts like the following happened:

    14:51:25.087 [error] #PID<0.1386.0> running Api terminated
    Server: 127.0.0.1:8880 (http)
    Request: GET /user
    ** (exit) exited in: GenServer.call(#PID<0.135.0>, {:get_by_token,
    "xyz"}, 5000)
      ** (EXIT) time out

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
