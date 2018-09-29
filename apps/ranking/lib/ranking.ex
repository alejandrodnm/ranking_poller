defmodule Ranking do
  @moduledoc """
  Maintains the ranking of the virtual coins.
  """
  import Ecto.Query
  alias Persistence.Repo
  alias Ranking.Coin
  alias Ranking.Quote
  alias Ranking.Results

  def data do
    Dataloader.Ecto.new(Repo, query: &query/2)
  end

  def query(queryable, _) do
    queryable
  end

  @spec get_results(pos_integer) :: %Results{}
  def get_results(id) when is_integer(id) do
    Results.get_results(id)
  end

  @spec get_results(Date.t()) :: %Results{}
  def get_results(date) do
    Results.get_results(date)
  end

  @spec get_coins() :: [%Coin{}]
  def get_coins do
    Coin.get_coins()
  end

  @spec get_coin(list, pos_integer) :: %Coin{}
  def get_coin(a, coins_ids) do
    Coin
    |> where([coin], coin.id in ^Enum.uniq(coins_ids))
    |> Repo.all()
    |> Map.new(fn coin -> {coin.id, coin} end)
  end

  @spec get_quotes(%Results{}, any) :: [%Quote{}]
  def get_quotes(results, args) do
    Enum.reduce(args, Quote, fn
      _, query ->
        query
    end)
  end
end
