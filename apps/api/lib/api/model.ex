defmodule Api.Model do
  use Ecto.Model

  # TODO: How to mark unique constraint ?
  schema "customers" do
    field :username, :string
    field :token, :string
    timestamps
  end
end
