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
      symbol,
      quotes (first: 2) {
        page_info {
          end_cursor,
          start_cursor,
        }
        edges {
          node {
            percent_change_7d,
            percent_change_24h,
            percent_change_1h
          }
        }
      }
    }
  }
  """

  test "coins field return coins" do
    conn = build_conn()
    conn = get(conn, "/api", query: @query)

    assert json_response(conn, 200) ==
             %{
               "data" => %{
                 "coins" => [
                   %{
                     "name" => "Bitcoin",
                     "symbol" => "BTC",
                     "website_slug" => "bitcoin",
                     "id" => "Q29pbjox",
                     "quotes" => %{
                       "edges" => [
                         %{
                           "node" => %{
                             "percent_change_1h" => "0.1",
                             "percent_change_24h" => "1.35",
                             "percent_change_7d" => "5.05"
                           }
                         },
                         %{
                           "node" => %{
                             "percent_change_1h" => "0.13",
                             "percent_change_24h" => "2.17",
                             "percent_change_7d" => "2.49"
                           }
                         }
                       ],
                       "page_info" => %{
                         "end_cursor" => "YXJyYXljb25uZWN0aW9uOjE=",
                         "start_cursor" => "YXJyYXljb25uZWN0aW9uOjA="
                       }
                     }
                   },
                   %{
                     "name" => "Ethereum",
                     "symbol" => "ETH",
                     "website_slug" => "ethereum",
                     "id" => "Q29pbjoxMDI3",
                     "quotes" => %{
                       "edges" => [
                         %{
                           "node" => %{
                             "percent_change_1h" => "0.1",
                             "percent_change_24h" => "1.35",
                             "percent_change_7d" => "5.05"
                           }
                         },
                         %{
                           "node" => %{
                             "percent_change_1h" => "0.13",
                             "percent_change_24h" => "2.17",
                             "percent_change_7d" => "2.49"
                           }
                         }
                       ],
                       "page_info" => %{
                         "end_cursor" => "YXJyYXljb25uZWN0aW9uOjE=",
                         "start_cursor" => "YXJyYXljb25uZWN0aW9uOjA="
                       }
                     }
                   },
                   %{
                     "name" => "XRP",
                     "symbol" => "XRP",
                     "website_slug" => "ripple",
                     "id" => "Q29pbjo1Mg==",
                     "quotes" => %{
                       "edges" => [
                         %{
                           "node" => %{
                             "percent_change_1h" => "0.1",
                             "percent_change_24h" => "1.35",
                             "percent_change_7d" => "5.05"
                           }
                         },
                         %{
                           "node" => %{
                             "percent_change_1h" => "0.13",
                             "percent_change_24h" => "2.17",
                             "percent_change_7d" => "2.49"
                           }
                         }
                       ],
                       "page_info" => %{
                         "end_cursor" => "YXJyYXljb25uZWN0aW9uOjE=",
                         "start_cursor" => "YXJyYXljb25uZWN0aW9uOjA="
                       }
                     }
                   }
                 ]
               }
             }
  end
end
