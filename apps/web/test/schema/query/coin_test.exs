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

  @simple_coin_query """
    id,
    name,
    slug,
    symbol,
  """

  @quotes_query """
    quotes (first: 3) {
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
  """

  @coin_query "{ #{@simple_coin_query} #{@quotes_query} }"

  test "coin field returns a coin with its quotes" do
    query = "query ($slug: String) { coin (slug: $slug) #{@coin_query} }"
    Factory.insert!(:all)

    conn = build_conn()
    conn = get(conn, "/api", query: query, variables: %{slug: "bitcoin"})

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

  test "coins field returns a list of coin with its quotes" do
    query =
      Enum.join([
        """
        query {
          coins (first: 3) {
            edges {
              node {
        """,
        @simple_coin_query,
        """
              }
            }
          }
        }
        """
      ])

    quote_ = Factory.insert!(:all)

    conn = build_conn()
    conn = get(conn, "/api", query: query)

    assert json_response(conn, 200) == %{
             "data" => %{
               "coins" => %{
                 "edges" => [
                   %{
                     "node" => %{
                       "name" => "Bitcoin",
                       "id" => "Q29pblNpbXBsZTox",
                       "slug" => "bitcoin",
                       "symbol" => "BTC"
                     }
                   },
                   %{
                     "node" => %{
                       "name" => "Ethereum",
                       "id" => "Q29pblNpbXBsZToxMDI3",
                       "slug" => "ethereum",
                       "symbol" => "ETH"
                     }
                   },
                   %{
                     "node" => %{
                       "name" => "XRP",
                       "id" => "Q29pblNpbXBsZTo1Mg==",
                       "slug" => "ripple",
                       "symbol" => "XRP"
                     }
                   }
                 ]
               }
             }
           }
  end
end
