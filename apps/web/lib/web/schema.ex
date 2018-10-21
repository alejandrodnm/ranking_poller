defmodule Web.Schema do
  @moduledoc """
  GraphQL schema
  """
  use Absinthe.Schema
  use Absinthe.Relay.Schema, :modern

  alias Absinthe.Plugin
  alias Ranking.Coin
  alias Ranking.Import
  alias Ranking.Quote
  alias Web.Resolvers
  alias Web.Schema.Middleware

  def middleware(middleware, field, object) do
    middleware
    |> apply(:debug, field, object)
  end

  defp apply(middleware, :debug, _field, _object) do
    if System.get_env("DEBUG") == "verbose" do
      [{Middleware.Debug, :start}] ++ middleware
    else
      middleware
    end
  end

  import_types(__MODULE__.Ranking)

  node interface do
    resolve_type(fn
      %Coin{}, _ ->
        :coin

      _, _ ->
        nil
    end)
  end

  query do
    node field do
      resolve(fn
        %{type: :coin, id: coin_id}, _ ->
          Resolvers.Ranking.get_coin(String.to_integer(coin_id))

        _, _ ->
          {:error, "Unkown node"}
      end)
    end

    field :coin, :coin do
      arg(:slug, non_null(:string))
      resolve(&Resolvers.Ranking.get_coin/3)
    end

    connection field(:coins, node_type: :coin_simple) do
      resolve(&Resolvers.Ranking.get_coins/3)
    end
  end
end
