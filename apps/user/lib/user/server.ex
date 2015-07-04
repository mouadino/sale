# TODO: Logger
defmodule User.Server do
  use GenServer

  import Ecto.Query
  alias User.Model, as: UserModel
  alias User.Repo

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  def handle_call(action, _from, state) do
    result = case action do
      {:get_by_token, token} -> get_by_token(token)
      {:create, username, token} -> create(username, token)
      # TODO: _ wildcard ! or is it better to user pattern matching in method level ?
    end
    {:reply, result, state}
  end

  @doc """
  Get user associated to a token.
  """
  def get_by_token(token) do
    query = from u in UserModel,
         where: u.token == ^token,
         select: u
    # TODO: {:notfound, []}  If user is not found.
    {:ok, Repo.one(query)}
  end

  @doc """
  Greate a new user.
  """
  def create(username, token) do
    user = %UserModel{username: username, token: token}
    {:ok, Repo.insert user}
  end
end
