defmodule Web.Schema.Middleware.Debug do
  @moduledoc """
  Middleware that prints debug information at the beggining and end
  of an absinthe query.
  """
  @behaviour Absinthe.Middleware
  alias Absinthe.Resolution

  def call(resolution, :start) do
    path = resolution |> Resolution.path() |> Enum.join(".")

    IO.puts("""
    === === === === ===
    starting: #{path}
    with source: #{inspect(resolution.source)}\
    """)

    new_middleware = resolution.middleware ++ [{__MODULE__, {:finish, path}}]
    %{resolution | middleware: new_middleware}
  end

  def call(resolution, {:finish, path}) do
    IO.puts("""
    completed: #{path}
    value: #{inspect(resolution.value)}
    === === === === ===\
    """)

    resolution
  end
end
