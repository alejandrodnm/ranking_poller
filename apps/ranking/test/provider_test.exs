defmodule ProviderTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  doctest Provider

  test "get ranking" do
    use_cassette "provider_get_ranking" do
      assert Ranking.fetch_current()
    end
  end
end
