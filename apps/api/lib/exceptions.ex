defmodule Unauthorized do
  defexception message: "Unauthorized"
end

defmodule NotFound do
  defexception message: "Not Found"
end

defmodule InternalError do
  defexception message: "Internal Error"
end
