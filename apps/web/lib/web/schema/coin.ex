defmodule Web.Schema.Coin do
  @moduledoc """
  GraphQL types
  """
  use Absinthe.Schema.Notation

  object :coin do
    field(:id, :id)
    field(:name, :string)
  end
end
