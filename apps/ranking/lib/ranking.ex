defmodule Ranking do
  @moduledoc """
  Maintains the ranking of the virtual coins.
  """
  import Ecto.Query
  alias Persistence.Repo
  alias Ranking.Coin
  alias Ranking.Import
  alias Ranking.Quote

  def data do
    Dataloader.Ecto.new(Repo, query: &query/2)
  end

  def query(queryable, _) do
    queryable
  end

  @spec get_import(pos_integer) :: %Import{}
  def get_import(id) when is_integer(id) do
    Import.get_import(id)
  end

  @spec get_import(Date.t()) :: %Import{}
  def get_import(date) do
    Import.get_import(date)
  end

  @spec get_coins() :: [%Coin{}]
  def get_coins do
    Coin.get_coins()
  end

  @spec get_coin(list, pos_integer) :: %Coin{}
  def get_coin(_, coins_ids) do
    Coin
    |> where([coin], coin.id in ^Enum.uniq(coins_ids))
    |> Repo.all()
    |> Map.new(fn coin -> {coin.id, coin} end)
  end

  @spec get_quotes(%Import{}, any) :: [%Quote{}]
  def get_quotes(_, args) do
    Enum.reduce(args, Quote, fn
      _, query ->
        query
    end)
  end
end
