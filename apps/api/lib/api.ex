defmodule Api do
  use Maru.Router
  alias Maru.Exceptions.NotFound

  plug Plug.Logger
  # FIXME: Debugger doesn't work :(
  #plug Plug.Debugger  # FIXME: Only when Mix.env is dev:
  plug Auth

  mount Api.User

  get do
    # TODO: Show something like this https://github.com/falood/maru/blob/master/lib/mix/tasks/routers.ex.
    %{ hello: :world }
  end

  rescue_from NotFound do
    status 404
    "Not Found"
  end

  rescue_from Unauthorized do
    status 401
    "Unauthorized"
  end

  # FIXME: No traceback ! :(
  #rescue_from :all do
  #  status 500
  #  "Server Error"
  #end
end
