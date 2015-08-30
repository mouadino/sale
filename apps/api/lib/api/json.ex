# Credit: https://coderwall.com/p/fhsehq/fix-encoding-issue-with-ecto-and-poison
defimpl Poison.Encoder, for: Api.Model do
  def encode(%{__struct__: _} = struct, options) do
    map = struct
          |> Map.from_struct
          |> sanitize_map
    Poison.Encoder.Map.encode(map, options)
  end

  defp sanitize_map(map) do
    Map.drop(map, [:__meta__, :__struct__])
  end
end
