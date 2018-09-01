defmodule Ranking do
  @moduledoc """
  Maintains the ranking of the virtual coins.
  """
  alias Persistence.Repo
  alias Ranking.Coin
  alias Ranking.Import
  alias Ranking.Quote
  alias Ranking.Results

  @doc """
  Executes the import job that fetches the current ranking and stores
  it in the database.
  """
  def fetch_current_results do
    Import.run()
  end

  @spec get_results(Date.t()) :: %Results{}
  def get_results(date) do
    Results.get_results(date)
  end

  @spec get_coins() :: [%Coin{}]
  def get_coins do
    Coin.get_coins()
  end

  @spec get_coin(%Quote{}) :: %Coin{}
  def get_coin(quote) do
    Repo.one(Ecto.assoc(quote, :coin))
  end

  @spec get_quotes(%Results{}) :: [%Quote{}]
  def get_quotes(results) do
    Repo.all(Ecto.assoc(results, :quotes))
  end
end
