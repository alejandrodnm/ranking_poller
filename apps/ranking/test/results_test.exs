defmodule Ranking.ResultsTest do
  alias Ranking.Test.Factory
  use Persistence.DataCase

  test "insert a new results" do
    payload = Factory.payload(:results)
    {:ok, ranking_import} = Import.insert(payload)
    assert ranking_import.timestamp == payload["timestamp"]
    assert ranking_import.error == nil
    assert ranking_import.num_cryptocurrencies == payload["num_cryptocurrencies"]
  end
end
