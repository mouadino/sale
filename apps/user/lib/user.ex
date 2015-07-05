defmodule User do
  use Application

  @name :user

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(User.Server, [[name: {:global, @name}]]),
      worker(User.Repo, [])
    ]

    opts = [strategy: :one_for_one, name: User.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
