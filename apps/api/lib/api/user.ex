
# TODO: Check https://github.com/elixir-lang/plug/blob/master/lib/plug/session.ex
# TODO: Check https://github.com/teodor-pripoae/maru_entity
defmodule Api.User do
  use Maru.Router
  import Plug.Conn

  namespace :user do
    desc "Get current user info"
    get do
      # FIXME: Copy-paster from auth.ex we can do better !
      token = case get_req_header(conn, "authorization") do
        [token] -> token
        _ -> raise Unauthorized
      end
      IO.inspect token
      case GenServer.call(server_pid, {:get_by_token, token}) do
        {:ok, user} when is_map user -> user
        _ -> raise NotFound, message: "Unknown User"
      end
    end

    desc "Create new user"
    params do
      requires :username, type: String
      requires :token, type: String
    end
    post do
      case GenServer.call(server_pid, {:create, params[:username], params[:token]}) do
        {:ok, user} -> user
        _ -> raise InternalError
      end
    end
  end
  # TODO: Regenerate token endpoint.

  def server_pid do
    :global.whereis_name :user
  end

end
