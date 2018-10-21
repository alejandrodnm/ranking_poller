defmodule Ranking do
  @moduledoc """
  Maintains the ranking of the virtual coins.
  """
  import Ecto.Query
  alias Persistence.Repo
  alias Ranking.Coin
  alias Ranking.Import
  alias Ranking.Quote

  @spec get_coins(any) :: [%Coin{}]
  def get_coins(args) do
    Enum.reduce(args, Coin, fn
      _, query ->
        query
    end)
  end

  @spec get_coin(pos_integer | String.t()) :: %Coin{}
  def get_coin(coin_id) do
    case get_coin_by(coin_id) do
      %Coin{} = coin -> coin
      nil -> {:error, "coin does not exists"}
    end
  end

  @spec get_coin_by(pos_integer | String.t()) :: %Coin{}
  defp get_coin_by(coin_id) when is_integer(coin_id) do
    Coin.get_coin(coin_id)
  end

  defp get_coin_by(slug) when is_binary(slug) do
    Coin.get_coin(slug)
  end

  @spec get_quotes(%Coin{}, any) :: [%Quote{}]
  def get_quotes(%Coin{} = _, args) do
    Enum.reduce(args, Quote, fn
      _, query ->
        query
    end)
  end
end
