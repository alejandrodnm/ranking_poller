defmodule StandingsTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  doctest Standings

  test "fetch current standings" do
    use_cassette "coin_base_v2_standings" do
      assert Standings.fetch_current()
    end
  end
end
