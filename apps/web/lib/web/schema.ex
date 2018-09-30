defmodule Web.Schema do
  @moduledoc """
  GraphQL schema
  """
  use Absinthe.Schema
  use Absinthe.Relay.Schema, :modern

  alias Absinthe.Plugin
  alias Ranking.Import
  alias Ranking.Quote
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

  node interface do
    resolve_type(fn
      %Import{}, _ ->
        :import

      %Ranking.Quote{}, _ ->
        :quote

      _, _ ->
        nil
    end)
  end

  query do
    node field do
      resolve(fn
        %{type: :import, id: import_id}, _ ->
          Resolvers.Ranking.get_import(String.to_integer(import_id))

        _, _ ->
          {:error, "Unkown node"}
      end)
    end

    field :coins, list_of(:coin) do
      resolve(&Resolvers.Ranking.get_coins/3)
    end

    field :import, :import do
      arg(:filter, non_null(:import_filter))
      resolve(&Resolvers.Ranking.get_import/3)
    end
  end
end
