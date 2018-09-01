defmodule Web.Schema do
  @moduledoc """
  GraphQL schema
  """
  alias Web.Resolvers.Ranking
  use Absinthe.Schema

  import_types(__MODULE__.Ranking)

  query do
    field :coins, list_of(:coin) do
      resolve(&Ranking.list_coins/3)
    end

    field :results, list_of(:results) do
      resolve(&Ranking.list_results/3)
    end
  end
end
