defmodule Web.Schema do
  @moduledoc """
  GraphQL schema
  """
  use Absinthe.Schema

  alias Absinthe.Plugin
  alias Web.Resolvers
  alias Web.Schema.Middleware

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

  def plugins do
    [Absinthe.Middleware.Dataloader | Plugin.defaults()]
  end

  def dataloader do
    Dataloader.new()
    |> Dataloader.add_source(Ranking, Ranking.data())
  end

  def context(ctx) do
    Map.put(ctx, :loader, dataloader())
  end

  import_types(__MODULE__.Ranking)

  query do
    field :coins, list_of(:coin) do
      resolve(&Resolvers.Ranking.get_coins/3)
    end

    field :results, :results do
      arg(:filter, non_null(:results_filter))
      resolve(&Resolvers.Ranking.get_results/3)
    end
  end
end
