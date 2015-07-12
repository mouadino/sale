defmodule Unauthorized do
  defexception message: "Unauthorized", code: :unauthorized
end

defmodule NotFound do
  defexception message: "Not Found", code: :not_found
end

defmodule InternalError do
  defexception message: "Internal Error", code: :internal_server_error
end

defmodule BadRequest do
  defexception message: "Bad Request", code: :bad_request
end
