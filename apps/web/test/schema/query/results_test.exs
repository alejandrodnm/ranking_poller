defmodule Web.Schema.Query.ResultsTest do
  alias Ranking.Test.Factory
  use Web.ConnCase
  use Persistence.DataCase

  setup do
    [results: Factory.insert!(:all)]
  end

  @query """
  {
    results {
      id,
      timestamp,
      num_cryptocurrencies,
      error
    }
  }
  """

  test "results field returns a list of results", %{results: results} do
    conn = build_conn()
    conn = get(conn, "/api", query: @query)

    assert json_response(conn, 200) == %{
             "data" => %{
               "results" => [
                 %{
                   "error" => nil,
                   "id" => Integer.to_string(results.id),
                   "num_cryptocurrencies" => 1910,
                   "timestamp" => 1_535_794_922
                 }
               ]
             }
           }
  end
end
