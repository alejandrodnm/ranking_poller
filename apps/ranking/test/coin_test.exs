defmodule CoinTest do
  use ExUnit.Case
  alias Ecto.Adapters.SQL.Sandbox
  alias Persistence.Repo
  alias Ranking.Test.Factory

  setup do
    # Explicitly get a connection before each test
    # By default the test is wrapped in a transaction
    :ok = Sandbox.checkout(Repo)
  end

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
