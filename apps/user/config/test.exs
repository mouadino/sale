use Mix.Config

config :user, User.Repo,
  adapter: Sqlite.Ecto,
  pool: Ecto.Adapters.SQL.Sandbox,
  database: "/tmp/user-test.sqlite3"
