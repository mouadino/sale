use Mix.Config

config :customer, User.Repo,
  adapter: Sqlite.Ecto,
  pool: Ecto.Adapters.SQL.Sandbox,
  database: "/tmp/customer-test.sqlite3"
