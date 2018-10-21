defmodule Web.Resolvers.Ranking do
  import Absinthe.Resolution.Helpers, only: [on_load: 2]
  alias Absinthe.Relay.Connection
  alias Persistence.Repo
  alias Ranking.Coin
  alias Ranking.Import
  alias Ranking.Quote

  @moduledoc """
  Coin resolver
  """
  def get_coin(_parent, %{slug: slug}, _resolution) do
    {:ok, Ranking.get_coin(slug)}
  end

  def get_coin(_parent, _args, _resolution) do
    # this fails coin (filter: 1) {
    {:error, "invalid filter"}
  end

  def get_coin(coin_id) do
    {:ok, Ranking.get_coin(coin_id)}
  end

  @moduledoc """
  Empty node used for having a list of coins as a top level node.
  """
  def get_coins_wrapper(_parent, _args, _resolution) do
    # this fails coin (filter: 1) {
    {:ok, %{}}
  end

  def get_coins(_parent, args, _resolution) do
    Connection.from_query(
      Ranking.get_coins_queryable(args),
      &Repo.all/1,
      args
    )
  end

  @moduledoc """
  Quotes resolver
  """
  def get_quotes(%Coin{} = coin, args, _resolution) do
    Connection.from_query(
      Ranking.get_quotes_queryable(coin, args),
      &Repo.all/1,
      args
    )
  end
end
