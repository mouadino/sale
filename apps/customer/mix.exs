defmodule Customer.Mixfile do
  use Mix.Project

  def project do
    [app: :customer,
     version: "0.0.1",
     deps_path: "../../deps",
     lockfile: "../../mix.lock",
     elixir: "~> 1.0",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [applications: [:logger, :sqlite_ecto, :ecto, :postgrex],
     mod: {Customer, []}]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # To depend on another app inside the umbrella:
  #
  #   {:myapp, in_umbrella: true}
  #
  # Type `mix help deps` for more examples and options
  defp deps do
    [
      # NOTE: Temporarily use esqlite git master to be able to work with
      # Erlang18
      {:esqlite, git: "https://github.com/mmzeeman/esqlite.git", override: true},
      {:postgrex, ">= 0.0.0"},
      {:sqlite_ecto, "~> 0.3.0"},
      {:ecto, "~> 0.13.1"},
      {:poolboy, "~> 1.5.1"},
    ]

  end
end
