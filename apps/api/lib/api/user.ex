defmodule Api.User do
  use Maru.Router

  namespace :user do
    desc "Get current user info"
    get do
      # TODO: Check https://github.com/elixir-lang/plug/blob/master/lib/plug/session.ex
      %{message: "Welcome back!"}
    end
  end

end
