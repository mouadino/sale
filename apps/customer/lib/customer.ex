defmodule Customer do
  use Application

  @name :customer

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(Customer.Handler, [[name: {:global, @name}]]),
      worker(Customer.Repo, []),
    ]

    opts = [strategy: :one_for_one, name: Customer.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
