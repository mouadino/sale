defmodule UserTest do
  use ExUnit.Case, async: false

  setup do
    {:ok, server} = User.Server.start_link
    {:ok, server: server}
  end

  test "create user", %{server: server} do
      assert {:ok, new_user} = GenServer.call(server, {:create, "mouad", "secret-token"})
      IO.inspect new_user

      assert new_user.username == "mouad"

      assert {:ok, got_user} = GenServer.call(server, {:get_by_token, "secret-token"})
      assert got_user.username == "mouad"
    end
end
