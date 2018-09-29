defmodule Ranking.ImportTest do
  alias Persistence.Repo
  alias Ranking.Coin
  alias Ranking.Import
  alias Ranking.Test.Factory
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  use Persistence.DataCase

  test "import run" do
    use_cassette "ranking_get_ranking" do
      {:ok, _} = Import.run()
    end

    _ = Repo.all(Coin)
  end

  test "insert a new import" do
    payload = Factory.payload(:import)
    {:ok, import_} = Import.insert(payload)
    assert import_.timestamp == payload["timestamp"]
    assert import_.error == nil
    assert import_.num_cryptocurrencies == payload["num_cryptocurrencies"]
  end
end
