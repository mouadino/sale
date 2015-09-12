defmodule Customer.Repo.Migrations.CreateCustomers do
  use Ecto.Migration

  def change do
    create table(:customers) do
      add :username, :string
      add :token, :string
      timestamps
    end
  end
end
