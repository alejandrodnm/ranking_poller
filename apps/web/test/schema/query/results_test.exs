defmodule Web.Schema.Query.ResultsTest do
  alias Ranking.Test.Factory
  use Web.ConnCase
  use Persistence.DataCase

  setup do
    [results: Factory.insert!(:all)]
  end

  test "results field returns a results", %{results: results} do
    query = """
    query ($filter: ResultsFilter!) {
      results (filter: $filter) {
        id,
        inserted_at,
        timestamp,
        num_cryptocurrencies,
        error,
        quotes (first: 2) {
          page_info {
            end_cursor
            start_cursor
          }
          edges {
            node {
              percent_change_7d
              coin {
                id,
                name
              }
            }
          }
        }
      }
    }
    """

    conn = build_conn()
    date = Date.to_iso8601(results.inserted_at)
    variables = %{filter: %{date: date}}
    conn = get(conn, "/api", query: query, variables: variables)
    json = json_response(conn, 200)

    assert(
      json == %{
        "data" => %{
          "results" => %{
            "error" => nil,
            "id" => json["data"]["results"]["id"],
            "num_cryptocurrencies" => 1910,
            "timestamp" => 1_535_794_922,
            "inserted_at" => DateTime.to_iso8601(results.inserted_at),
            "quotes" => %{
              "edges" => [
                %{
                  "node" => %{
                    "coin" => %{"id" => "1", "name" => "Bitcoin"},
                    "percent_change_7d" => "5.05"
                  }
                },
                %{
                  "node" => %{
                    "coin" => %{"id" => "1027", "name" => "Ethereum"},
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
        }
      }
    )
  end

  test "node returns results", %{results: results} do
    id = Base.encode64("Results:#{results.id}")

    query = """
    query {
      node (id: "#{id}") {
        ...on Results {
          id,
          inserted_at,
          timestamp,
          num_cryptocurrencies,
          error,
          quotes (first: 2) {
            page_info {
              end_cursor
              start_cursor
            }
            edges {
              node {
                percent_change_7d
                coin {
                  id,
                  name
                }
              }
            }
          }
        }
      }
    }
    """

    conn = build_conn()
    conn = get(conn, "/api", query: query)
    json = json_response(conn, 200)

    assert(
      json == %{
        "data" => %{
          "node" => %{
            "error" => nil,
            "id" => id,
            "inserted_at" => DateTime.to_iso8601(results.inserted_at),
            "num_cryptocurrencies" => 1910,
            "quotes" => %{
              "edges" => [
                %{
                  "node" => %{
                    "coin" => %{"id" => "1", "name" => "Bitcoin"},
                    "percent_change_7d" => "5.05"
                  }
                },
                %{
                  "node" => %{
                    "coin" => %{"id" => "1027", "name" => "Ethereum"},
                    "percent_change_7d" => "2.49"
                  }
                }
              ],
              "page_info" => %{
                "end_cursor" => "YXJyYXljb25uZWN0aW9uOjE=",
                "start_cursor" => "YXJyYXljb25uZWN0aW9uOjA="
              }
            },
            "timestamp" => 1_535_794_922
          }
        }
      }
    )
  end
end
