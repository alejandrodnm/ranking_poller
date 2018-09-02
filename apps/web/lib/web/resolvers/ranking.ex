defmodule Web.Resolvers.Ranking do
  import Absinthe.Resolution.Helpers, only: [batch: 3]
  alias Ranking.Quote
  alias Ranking.Results

  @moduledoc """
  Coin resolver
  """
  def get_coin(%Quote{} = quote_, _args, _resolution) do
    batch({Ranking, :get_coin}, quote_.coin_id, fn coins ->
      {:ok, Map.get(coins, quote_.coin_id)}
    end)
  end

  def get_coins(_parent, _args, _resolution) do
    {:ok, Ranking.get_coins()}
  end

  @moduledoc """
  Results resolver
  """
  def get_results(_parent, %{filter: %{date: date}}, _resolution) do
    {:ok, Ranking.get_results(date)}
  end

  @moduledoc """
  Quotes resolver
  """
  def get_quotes(%Results{} = parent, _args, _resolution) do
    {:ok, Ranking.get_quotes(parent)}
  end
end
