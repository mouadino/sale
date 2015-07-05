defmodule Api do
  use Maru.Router

  require Logger

  plug Plug.Logger
  # FIXME: Debugger doesn't work :(
  #plug Plug.Debugger  # FIXME: Only when Mix.env is dev:

  mount Api.User
  mount Api.Order

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

  # FIXME: How to print traceback ! :(
  rescue_from :all, as: e do
    Logger.error "Internal error: #{inspect e}"
    status 500
    "Server Error"
  end
end
