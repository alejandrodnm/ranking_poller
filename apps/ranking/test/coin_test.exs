defmodule Ranking.CoinTest do
  alias Persistence.Repo
  alias Ranking.Coin
  alias Ranking.Test.Factory
  use Persistence.DataCase

  doctest Coin

  defp assert_coin(coin, payload) do
    assert coin.id == payload["id"]
    assert coin.name == payload["name"]
    assert coin.website_slug == payload["website_slug"]
    assert coin.symbol == payload["symbol"]
  end

  test "insert a new coin" do
    payload = Factory.payload(:coin)
    {:ok, coin} = Coin.get_or_insert(payload)
    assert_coin(coin, payload)
  end

  test "try to insert a duplicate coin" do
    payload = Factory.payload(:coin)
    coin = Factory.insert!(:coin)
    {:ok, ^coin} = Coin.get_or_insert(payload)
  end
end
