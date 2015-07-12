defmodule Api.Customer do
  use Plug.Router

  import Plug.Conn

  plug :match
  plug :dispatch

  get "/" do
    token = case get_req_header(conn, "authorization") do
      [token] -> token
      _ -> raise Unauthorized
    end
    response = case GenServer.call(server_pid, {:get_by_token, token}) do
      {:ok, user} when is_map user -> user
      _ -> raise NotFound, message: "Unknown User"
    end
    send_resp(conn, 200, response |> Poison.encode!)
  end

  post "/" do
    params = case read_body(conn) do
      {:ok, body, _} -> Poison.decode! body
      _ -> raise BadRequest, message: "Invalid JSON body"
    end
    response = case GenServer.call(server_pid, {:create, params["username"], params["token"]}) do
      {:ok, user} -> user
      _ -> raise InternalError
    end
    send_resp(conn, 201, response |> Poison.encode!)
  end

  defp server_pid() do
    :global.whereis_name :customer
  end
end
