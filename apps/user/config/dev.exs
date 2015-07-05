use Mix.Config

config :user, User.Repo,
  adapter: Sqlite.Ecto,
    database: "/tmp/user.sqlite3"
