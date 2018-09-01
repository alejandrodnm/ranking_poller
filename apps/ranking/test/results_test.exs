defmodule Ranking.ResultsTest do
  alias Ranking.Results
  alias Ranking.Test.Factory
  use Persistence.DataCase

  test "insert a new results" do
    payload = Factory.payload(:results)
    {:ok, results} = Results.insert(payload)
    assert results.timestamp == payload["timestamp"]
    assert results.error == nil
    assert results.num_cryptocurrencies == payload["num_cryptocurrencies"]
  end
end
