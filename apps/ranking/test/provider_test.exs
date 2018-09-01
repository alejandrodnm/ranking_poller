defmodule Ranking.ProviderTest do
  alias Ranking.Provider
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  doctest Provider

  test "get ranking" do
    use_cassette "provider_get_ranking" do
      {:ok, _} = Provider.get_ranking()
    end
  end
end
