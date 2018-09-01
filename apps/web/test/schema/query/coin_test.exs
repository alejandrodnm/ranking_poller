defmodule Web.Schema.Query.CoinTest do
  alias Ranking.Test.Factory
  use Web.ConnCase
  use Persistence.DataCase

  setup do
    Factory.insert!(:coin)
    :ok
  end

  @query """
  {
    coins {
      id,
      name
    }
  }
  """

  test "coins field return coins" do
    conn = build_conn()
    conn = get(conn, "/api", query: @query)

    assert json_response(conn, 200) == %{
             "data" => %{
               "coins" => [
                 %{"id" => 1, "name" => "BTC"}
               ]
             }
           }
  end
end
