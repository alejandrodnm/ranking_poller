defmodule RankingTest do
  use Persistence.DataCase
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  alias Ecto.Adapters.SQL.Sandbox
  alias Persistence.Repo

  test "get ranking" do
    use_cassette "ranking_get_ranking" do
      {:ok, ranking} = Ranking.fetch_current()
    end

    query = from(coin in Coin)
    coins = Repo.all(Coin)
  end
end
