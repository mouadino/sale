defmodule Api.Customer do
  use Plug.Router

  import Plug.Conn
  import Ecto.Query
  alias Api.Model, as: CustomerModel
  alias Api.Repo

  plug :match
  plug :dispatch

  get "/" do
    token = case get_req_header(conn, "authorization") do
      [token] -> token
      _ -> raise Unauthorized
    end
    query = from u in CustomerModel,
         where: u.token == ^token,
         select: u
    response = Repo.one(query)
    if response == nil do
      raise NotFound
    else
      send_resp(conn, 200, response |> Poison.encode!)
    end
  end

  post "/" do
    params = case read_body(conn) do
      {:ok, body, _} -> Poison.decode! body
      _ -> raise BadRequest, message: "Invalid JSON body"
    end
    if Repo.get_by(CustomerModel, token: params["token"]) != nil do
        raise Conflict
    end
    user = %CustomerModel{username: params["username"], token: params["token"]}
    response = Repo.insert! user
    send_resp(conn, 201, response |> Poison.encode!)
  end
end
