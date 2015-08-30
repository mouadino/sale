defmodule Api do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    port = Application.get_env(:api, :port)
    ip = Application.get_env(:api, :ip)

    children = [
      worker(Plug.Adapters.Cowboy, [Api.Router, [], [port: port, ip: ip]], function: :http),
      worker(Api.Repo, []),
    ]

    opts = [strategy: :one_for_one, name: Api.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
