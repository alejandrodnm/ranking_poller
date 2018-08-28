defmodule QuoteTest do
  alias Ecto.Adapters.SQL.Sandbox
  alias Persistence.Repo
  alias Ranking.Quote
  alias Ranking.Test.Factory
  use Persistence.DataCase

  defp assert_quote(quote_, payload) do
    assert quote_.timestamp == payload["timestamp"]
    assert quote_.price == Decimal.new(payload["price"])
    assert quote_.volume_24h == Decimal.new(payload["volume_24h"])
    assert quote_.market_cap == Decimal.new(payload["market_cap"])
    assert quote_.percent_change_1h == Decimal.new(payload["percent_change_1h"])
    assert quote_.percent_change_24h == Decimal.new(payload["percent_change_24h"])
    assert quote_.percent_change_7d == Decimal.new(payload["percent_change_7d"])
    assert quote_.coin_id == payload["coin_id"]
  end

  test "insert a new quote" do
    payload = Factory.payload(:quote)
    {:ok, quote_} = Quote.insert(payload)
    assert_quote(quote_, payload)
  end
end
