defmodule Web.Schema.Query.ResultsTest do
  alias Ranking.Test.Factory
  use Web.ConnCase
  use Persistence.DataCase

  setup do
    [results: Factory.insert!(:all)]
  end

  @query """
  query ($filter: ResultsFilter!) {
    results(filter: $filter) {
      id,
      inserted_at,
      timestamp,
      num_cryptocurrencies,
      error,
      quotes {
        percent_change_7d,
        coin {
          name,
          symbol
        }
      }
    }
  }
  """

  test "results field returns a list of results", %{results: results} do
    conn = build_conn()
    date = Date.to_iso8601(results.inserted_at)
    variables = %{filter: %{date: date}}
    conn = get(conn, "/api", query: @query, variables: variables)

    assert(
      json_response(conn, 200) == %{
        "data" => %{
          "results" => %{
            "error" => nil,
            "id" => Integer.to_string(results.id),
            "num_cryptocurrencies" => 1910,
            "timestamp" => 1_535_794_922,
            "inserted_at" => DateTime.to_iso8601(results.inserted_at),
            "quotes" => [
              %{
                "percent_change_7d" => "5.05",
                "coin" => %{"name" => "Bitcoin", "symbol" => "BTC"}
              },
              %{
                "percent_change_7d" => "4.13",
                "coin" => %{"name" => "XRP", "symbol" => "XRP"}
              },
              %{
                "percent_change_7d" => "2.49",
                "coin" => %{"name" => "Ethereum", "symbol" => "ETH"}
              }
            ]
          }
        }
      }
    )
  end
end
