use Mix.Config

config :customer, User.Repo,
  adapter: Sqlite.Ecto,
    database: "/tmp/customer.sqlite3"

config :logger, :console,
   level: :warn
