defmodule Ranking.Test.Payload do
  @moduledoc """
  Payload as fetched from the Ranking.Provider
  """
  def get do
    %{
      "data" => %{
        "1" => %{
          "id" => 1,
          "name" => "Bitcoin",
          "symbol" => "BTC",
          "slug" => "bitcoin",
          "rank" => 1,
          "circulating_supply" => 17_243_437.0,
          "total_supply" => 17_243_437.0,
          "max_supply" => 21_000_000.0,
          "quotes" => %{
            "USD" => %{
              "price" => 7067.23472339,
              "volume_24h" => 4_379_917_582.80366,
              "market_cap" => 121_863_416_717.0,
              "percent_change_1h" => 0.1,
              "percent_change_24h" => 1.35,
              "percent_change_7d" => 5.05
            }
          },
          "last_updated" => 1_535_795_430
        },
        "1027" => %{
          "id" => 1027,
          "name" => "Ethereum",
          "symbol" => "ETH",
          "slug" => "ethereum",
          "rank" => 2,
          "circulating_supply" => 101_684_757.0,
          "total_supply" => 101_684_757.0,
          "max_supply" => nil,
          "quotes" => %{
            "USD" => %{
              "price" => 287.28231002,
              "volume_24h" => 1_369_983_103.0254,
              "market_cap" => 29_212_231_786.0,
              "percent_change_1h" => 0.13,
              "percent_change_24h" => 2.17,
              "percent_change_7d" => 2.49
            }
          },
          "last_updated" => 1_535_795_431
        },
        "52" => %{
          "id" => 52,
          "name" => "XRP",
          "symbol" => "XRP",
          "slug" => "ripple",
          "rank" => 3,
          "circulating_supply" => 39_650_153_121.0,
          "total_supply" => 99_991_852_985.0,
          "max_supply" => 100_000_000_000.0,
          "quotes" => %{
            "USD" => %{
              "price" => 0.3403532667,
              "volume_24h" => 219_707_243.320949,
              "market_cap" => 13_495_059_139.0,
              "percent_change_1h" => 0.06,
              "percent_change_24h" => 2.58,
              "percent_change_7d" => 4.13
            }
          },
          "last_updated" => 1_535_795_403
        }
      },
      "metadata" => %{
        "timestamp" => 1_535_794_922,
        "num_cryptocurrencies" => 1910,
        "error" => nil
      }
    }
  end
end
