defmodule Api.Router do
  # TODO: Check https://github.com/elixir-lang/plug/blob/master/lib/plug/session.ex
  # TODO: Something like this for map https://github.com/falood/maru/blob/master/lib/maru/response.ex
  use Plug.Router
  use Plug.ErrorHandler
  if Mix.env == :dev do
    use Plug.Debugger
  end

  import Plug.Conn.Status
  import Plug.Conn

  plug Plug.Logger
  plug :to_json
  plug :match
  plug :dispatch

  get "/" do
    send_resp(conn, 200, %{hello: "world"} |> Poison.encode!)
  end

  forward "/user", to: Api.Customer

  defp to_json(conn, _) do
    conn
    |> put_resp_content_type("application/json")
  end

  defp handle_errors(conn, %{kind: _kind, reason: _reason, stack: _stack}) do
    # XXX: Exception are reraised after this.
    case _reason do
      %{code: http_code, message: http_message} ->
        send_resp(conn, code(http_code), http_message)
      _ ->
        send_resp(conn, conn.status, "Something went wrong")
    end
  end

  match _ do
    send_resp(conn, 404, "Not Found")
  end
end
