# TODO: Logger
# TODO: Make timeout configurable.
defmodule Customer.Server do
  use GenServer

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  def handle_call(msg, from, state) do
    spawn(fn -> background_worker(from, msg) end)
    {:noreply, state}
  end

  defp background_worker(client, msg) do
    :poolboy.transaction(:customer_pool, fn(worker) ->
      result = GenServer.call(worker, msg)
      GenServer.reply(client, result)
     end)
  end
end
