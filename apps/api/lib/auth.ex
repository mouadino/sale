defmodule Auth do
  use Maru.Middleware
  import Plug.Conn

  def call(conn, _opts) do
    case get_req_header(conn, "authorization") do
      [] -> raise Unauthorized, "unset authorization header"
      [token] -> unless valid_token? token do
         raise Unauthorized, "unknown token"
      end
    end
    conn
  end

  defp valid_token?(token) do
    # TODO: How to do remote call (different application ?)
    pid = :erlang.whereis User.Server
    case GenServer.call(pid, {:get_by_token, token}) do
      {:ok, _} -> true
      _ -> false
    end
  end
end
