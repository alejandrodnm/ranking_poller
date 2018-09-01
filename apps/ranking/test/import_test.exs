defmodule Ranking.ImportTest do
  alias Persistence.Repo
  alias Ranking.Coin
  alias Ranking.Import
  alias Ranking.Test.Factory
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  use Persistence.DataCase

  test "get ranking" do
    use_cassette "ranking_get_ranking" do
      {:ok, ranking} = Ranking.fetch_current_results()
    end

    query = from(coin in Coin)
    coins = Repo.all(Coin)
  end
end
