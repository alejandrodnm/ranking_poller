defmodule Web.Schema do
  @moduledoc """
  GraphQL schema
  """
  alias Web.Resolvers.Ranking
  use Absinthe.Schema

  import_types(__MODULE__.Ranking)

  query do
    field :coins, list_of(:coin) do
      resolve(&Ranking.get_coins/3)
    end

    field :results, :results do
      arg(:filter, non_null(:results_filter))
      resolve(&Ranking.get_results/3)
    end
  end
end
