defmodule ApiTest do
  use ExUnit.Case, async: true
  use Plug.Test

  # TODO: How to test get current user ! Fixture ?
  #test "should fail if no Authorization header is send" do
  #  conn = conn(:get, "/")
  #  conn = Api.call(conn, "")
  #  assert conn.status == 401
  #end

  test "should work if Authorization header is send" do
    conn = conn(:get, "/") |> put_req_header("authorization", "some-token")
    conn = Api.call(conn, "")
    assert conn.status == 200
  end
end
