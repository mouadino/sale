defmodule Customer.Handler do
  use GenServer

  import Ecto.Query
  alias Customer.Model, as: CustomerModel
  alias Customer.Repo

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  def handle_call({:get_by_token, token}, _, state) do
    {:reply, get_by_token(token), state}
  end

  def handle_call({:create, username, token}, _, state) do
    {:reply, create(username, token), state}
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
    user = %CustomerModel{username: username, token: token}
    {:ok, Repo.insert! user}
  end
end
