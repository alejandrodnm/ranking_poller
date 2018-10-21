defmodule Ranking.CoinTest do
  alias Persistence.Repo
  alias Ranking.Coin
  alias Ranking.Test.Factory
  use Persistence.DataCase

  doctest Coin

  defp assert_coin(coin, payload) do
    assert coin.id == payload["id"]
    assert coin.name == payload["name"]
    assert coin.slug == payload["slug"]
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

  test "get a coin by id" do
    expected_coin = Factory.insert!(:coin)
    coin = Ranking.get_coin(expected_coin.id)
    assert expected_coin == coin
  end

  test "get a coin by slug" do
    expected_coin = Factory.insert!(:coin)
    coin = Ranking.get_coin(expected_coin.slug)
    assert expected_coin == coin
  end

  test "get a non-existing coin by id" do
    assert {:error, "coin does not exists"} == Ranking.get_coin(42)
  end

  test "get a non-existing coin by slug" do
    assert {:error, "coin does not exists"} == Ranking.get_coin("dogecoin")
  end
end
