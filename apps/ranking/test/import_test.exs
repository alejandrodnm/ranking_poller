defmodule Ranking.ImportTest do
  alias Persistence.Repo
  alias Ranking.Coin
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  use Persistence.DataCase

  test "get ranking" do
    use_cassette "ranking_get_ranking" do
      {:ok, _} = Ranking.fetch_current_results()
    end

    _ = Repo.all(Coin)
  end
end
