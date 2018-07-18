defmodule RankingTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  doctest Ranking

  test "fetch current standings" do
    use_cassette "coin_base_v2_standings" do
      assert Ranking.fetch_current()
    end
  end
end
