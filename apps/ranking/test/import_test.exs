defmodule Ranking.ImportTest do
  alias Persistence.Repo
  alias Ranking.Coin
  alias Ranking.Import
  alias Ranking.Test.Factory
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  use Persistence.DataCase

  test "insert a new ranking import" do
    payload = Factory.payload(:ranking_import)
    {:ok, ranking_import} = Import.insert(payload)
    assert ranking_import.timestamp == payload["timestamp"]
    assert ranking_import.error == nil
    assert ranking_import.num_cryptocurrencies == payload["num_cryptocurrencies"]
  end

  test "get ranking" do
    use_cassette "ranking_get_ranking" do
      {:ok, ranking} = Ranking.fetch_current()
    end

    query = from(coin in Coin)
    coins = Repo.all(Coin)
  end
end
