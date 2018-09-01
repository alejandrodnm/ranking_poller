defmodule Web.Schema.Coin do
  @moduledoc """
  GraphQL types
  """
  use Absinthe.Schema.Notation

  object :coin do
    field(:id, :id)
    field(:name, :string)
    field(:website_slug, :string)
    field(:symbol, :string)
  end
end
