defmodule Web.Resolvers.Ranking do
  import Absinthe.Resolution.Helpers, only: [on_load: 2]
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
  Quotes resolver
  """
  def get_quotes(%Coin{} = coin, args, _resolution) do
    Absinthe.Relay.Connection.from_query(
      Ranking.get_quotes(coin, args),
      &Persistence.Repo.all/1,
      args
    )
  end
end
