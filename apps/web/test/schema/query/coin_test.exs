defmodule Web.Schema.Query.CoinTest do
  alias Ranking.Test.Factory
  use Web.ConnCase
  use Persistence.DataCase

  setup do
    Factory.insert!(:all)
    :ok
  end

  @query """
  {
    coins {
      id,
      name,
      website_slug,
      symbol
    }
  }
  """

  test "coins field return coins" do
    conn = build_conn()
    conn = get(conn, "/api", query: @query)

    assert json_response(conn, 200) == %{
             "data" => %{
               "coins" => [
                 %{
                   "id" => "1",
                   "name" => "Bitcoin",
                   "symbol" => "BTC",
                   "website_slug" => "bitcoin"
                 },
                 %{
                   "id" => "1027",
                   "name" => "Ethereum",
                   "symbol" => "ETH",
                   "website_slug" => "ethereum"
                 },
                 %{
                   "id" => "52",
                   "name" => "XRP",
                   "symbol" => "XRP",
                   "website_slug" => "ripple"
                 }
               ]
             }
           }
  end
end
