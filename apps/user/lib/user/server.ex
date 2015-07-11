# TODO: Logger
defmodule User.Server do
  use GenServer

  import Ecto.Query
  alias User.Model, as: UserModel
  alias User.Repo

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  def handle_call({:get_by_token, token}, from, state) do
    {:reply, get_by_token(token), state}
  end

  def handle_call({:create, username, token}, from, state) do
    {:reply, create(username, token), state}
  end

  @doc """
  Get user associated to a token.
  """
  def get_by_token(token) do
    query = from u in UserModel,
         where: u.token == ^token,
         select: u
    {:ok, Repo.one(query)}
  end

  @doc """
  Create a new user.
  """
  def create(username, token) do
    user = %UserModel{username: username, token: token}
    {:ok, Repo.insert user}
  end
end
