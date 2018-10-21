defmodule Web.Schema.Query.CoinTest do
  alias Persistence.Repo
  alias Ranking.Test.Factory
  use Web.ConnCase
  use Persistence.DataCase

  @coin_response %{
    "id" => "Q29pbjox",
    "name" => "Bitcoin",
    "quotes" => %{
      "edges" => [
        %{
          "node" => %{
            "marketCap" => "121863416717.0",
            "percentChange_1h" => "0.1",
            "percentChange_24h" => "1.35",
            "percentChange_7d" => "5.05",
            "price" => "7067.23472339",
            "timestamp" => 1_535_794_922
          }
        }
      ]
    },
    "symbol" => "BTC",
    "slug" => "bitcoin"
  }

  @coin_query """
  {
    id,
    name,
    slug,
    symbol,
    quotes (first: 1) {
      edges {
        node {
          price,
          marketCap,
          timestamp,
          percentChange_1h,
          percentChange_24h,
          percentChange_7d,
        }
      }
    }
  }
  """

  test "coin field returns a coin with its quotes" do
    query = "query ($slug: String) { coin (slug: $slug) #{@coin_query} }"
    quote_ = Factory.insert!(:quote)
    coin = Repo.one(Ecto.assoc(quote_, :coin))

    conn = build_conn()
    conn = get(conn, "/api", query: query, variables: %{slug: coin.slug})

    assert json_response(conn, 200) == %{"data" => %{"coin" => @coin_response}}
  end

  test "node returns coin" do
    query = "query ($id: String) { node (id: $id) { ...on Coin #{@coin_query} } }"
    quote_ = Factory.insert!(:quote)
    coin = Repo.one(Ecto.assoc(quote_, :coin))
    id = Base.encode64("Coin:#{coin.id}")

    conn = build_conn()
    conn = get(conn, "/api", query: query, variables: %{id: id})

    assert json_response(conn, 200) == %{"data" => %{"node" => @coin_response}}
  end
end
