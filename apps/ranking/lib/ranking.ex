defmodule Ranking do
  @moduledoc """
  Documentation for Standings.
  """

  @doc """
  Hello world.
  """
  def fetch_current do
    {:ok, ranking} = Provider.get_ranking()
    Enum.map(ranking["data"], &Coin.insert_coin_with_quote/1)
  end
end
