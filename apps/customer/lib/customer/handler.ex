defmodule Customer.Handler do
  use GenServer

  import Ecto.Query
  alias Customer.Model, as: CustomerModel
  alias Customer.Repo

  def init(opts) do
    {:ok, %{pending: Map.new()}}
  end

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  def handle_call({:get_by_token, token}, from, %{pending: pending} = state) do
    t = Task.async(fn -> get_by_token(token) end)
    new_pending = Map.put_new(pending, t.ref, from)
    {:noreply, %{state | pending: new_pending}}
  end
  def handle_call({:create, username, token}, from, %{pending: pending} = state) do
    t = Task.async(fn -> create(username, token) end)
    new_pending = Map.put_new(pending, t.ref, from)
    {:noreply, %{state | pending: new_pending}}
  end
  def handle_call(msg, from, state) do
    {:reply, {:error, "Unknown message #{msg}"}}
  end

  def handle_info({ref, result}, %{pending: pending} = state) when is_reference(ref) do
    GenServer.reply(pending[ref], result)
    {:noreply, %{state | pending: Map.delete(pending, ref)}}
  end
  def handle_info(_, state) do
    {:noreply, state}
  end

  @doc """
  Get user associated to a token.
  """
  def get_by_token(token) do
    query = from u in CustomerModel,
         where: u.token == ^token,
         select: u
    {:ok, Repo.one(query)}
  end

  @doc """
  Create a new user.
  """
  def create(username, token) do
    if Repo.get_by(CustomerModel, token: token) != nil do
      {:error, "duplicate token"}
    end
    user = %CustomerModel{username: username, token: token}
    # TODO: Handle duplicate.
    {:ok, Repo.insert! user}
  end
end
