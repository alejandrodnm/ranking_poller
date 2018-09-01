defmodule Web.Schema do
  @moduledoc """
  GraphQL schema
  """
  alias Web.Resolvers.Coin
  use Absinthe.Schema
  import_types(__MODULE__.Coin)

  query do
    field :coins, list_of(:coin) do
      resolve(&Coin.list_coins/3)
    end
  end
end
