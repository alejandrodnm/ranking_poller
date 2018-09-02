defmodule Web.Schema do
  @moduledoc """
  GraphQL schema
  """
  alias Web.Resolvers.Ranking
  alias Web.Schema.Middleware
  use Absinthe.Schema

  def middleware(middleware, field, object) do
    middleware
    |> apply(:debug, field, object)
  end

  defp apply(middleware, :debug, _field, _object) do
    if System.get_env("DEBUG") do
      [{Middleware.Debug, :start}] ++ middleware
    else
      middleware
    end
  end

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
