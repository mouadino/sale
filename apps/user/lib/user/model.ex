defmodule User.Model do
  use Ecto.Model

  # TODO: How to mark unique constraint ?
  schema "users" do
    field :username, :string
    field :token, :string
    timestamps
  end
end
