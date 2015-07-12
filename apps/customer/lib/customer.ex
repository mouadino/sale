defmodule Customer do
  use Application

  @name :customer

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    pool_options = [
      name: {:local, :customer_pool},
      worker_module: Customer.Handler,
      size: Application.get_env(:customer, :pool_size),
      max_overflow: Application.get_env(:customer, :pool_max_overflow)
    ]

    children = [
      worker(Customer.Server, [[name: {:global, @name}]]),
      worker(Customer.Repo, []),
      :poolboy.child_spec(:customer_pool, pool_options, []),
    ]

    opts = [strategy: :one_for_one, name: Customer.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
