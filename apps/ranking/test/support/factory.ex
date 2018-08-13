defmodule Ranking.Test.Factory do
  @moduledoc """
  Factory for Coin test data
  """
  alias Persistence.Repo

  def payload(:coin) do
    %{
      "id" => 74,
      "name" => "Dogecoin",
      "symbol" => "DOGE",
      "website_slug" => "dogecoin",
      "rank" => 36,
      "circulating_supply" => 115_378_271_672,
      "total_supply" => 115_378_271_672,
      "max_supply" => nil,
      "quotes" => %{
        "USD" => %{
          "price" => 0.00341024,
          "volume_24h" => 5_905_270_000,
          "market_cap" => 140_764_123_319,
          "percent_change_1h" => -0.54,
          "percent_change_24h" => 0.41,
          "percent_change_7d" => 43.98
        },
        "last_updated" => 1_532_248_213
      }
    }
  end

  def payload(:quote) do
    coin = insert!(:coin)

    %{
      "timestamp" => 1_532_465_408,
      "price" => 0.00341024,
      "volume_24h" => 5_905_270_000,
      "market_cap" => 140_764_123_319,
      "percent_change_1h" => -0.54,
      "percent_change_24h" => 0.41,
      "percent_change_7d" => 43.98,
      "last_updated" => 1_532_248_213,
      "coin_id" => coin.id
    }
  end

  @spec build(:coin) :: %Coin{}
  def build(:coin) do
    payload = payload(:coin)

    %Coin{
      id: payload["id"],
      name: payload["name"],
      symbol: payload["symbol"],
      website_slug: payload["website_slug"]
    }
  end

  @spec build(atom, keyword) :: struct
  def build(factory_name, attributes) do
    factory_name
    |> build
    |> struct(attributes)
  end

  @spec insert!(atom, keyword) :: struct
  def insert!(factory_name, attributes \\ []) do
    factory_name
    |> build(attributes)
    |> Repo.insert!()
  end
end
