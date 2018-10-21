defmodule Ranking do
  @moduledoc """
  Maintains the ranking of the virtual coins.
  """
  import Ecto.Query
  alias Persistence.Repo
  alias Ranking.Coin
  alias Ranking.Import
  alias Ranking.Quote

  @doc """
  Returns a Coin queryable filtered by the given args
  """
  @spec get_coins_queryable(map) :: Ecto.Query.t()
  def get_coins_queryable(args) do
    Coin.get_coins_queryable(args)
  end

  @doc """
  Returns the coin belongin to the given identifier, either its id or
  the coin slug.
  """
  @spec get_coin(pos_integer | String.t()) :: %Coin{} | {:error, String.t()}
  def get_coin(identifier) do
    Coin.get_coin(identifier)
  end

  @doc """
  Returns a Quotes queryable filtered by the given coin and args.
  """
  @spec get_quotes_queryable(%Coin{}, map) :: Ecto.Query.t()
  def get_quotes_queryable(%Coin{} = coin, args) do
    Quote.get_quotes_queryable(coin, args)
  end
end
