defmodule Ranking do
  @moduledoc """
  Maintains the ranking of the virtual coins.
  """
  alias Ranking.Coin
  alias Ranking.Import

  @doc """
  Executes the import job that fetches the current ranking and stores
  it in the database.
  """
  def fetch_current do
    Import.run()
  end

  @spec get_coins() :: [%Ranking.Coin{}]
  def get_coins do
    Coin.get_coins()
  end
end
