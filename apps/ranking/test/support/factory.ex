defmodule Ranking.Test.Factory do
  @moduledoc """
  Factory for Coin test data
  """
  alias Persistence.Repo
  alias Ranking.Coin
  alias Ranking.Import

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
    ranking_import = insert!(:ranking_import)

    %{
      "timestamp" => 1_532_465_408,
      "price" => 0.00341024,
      "volume_24h" => 5_905_270_000,
      "market_cap" => 140_764_123_319,
      "percent_change_1h" => -0.54,
      "percent_change_24h" => 0.41,
      "percent_change_7d" => 43.98,
      "last_updated" => 1_532_248_213,
      "coin_id" => coin.id,
      "circulating_supply" => 115_378_271_672,
      "total_supply" => 115_378_271_672,
      "max_supply" => nil,
      "ranking_import_id" => ranking_import.id
    }
  end

  def payload(:ranking_import) do
    %{
      "timestamp" => 1_532_465_408,
      "num_cryptocurrencies" => 5_905,
      "error" => ""
    }
  end

  @spec build(:ranking_coin) :: %Import{}
  def build(:ranking_import) do
    payload = payload(:ranking_import)

    %Import{
      timestamp: payload["timestamp"],
      num_cryptocurrencies: payload["num_cryptocurrencies"],
      error: payload["error"]
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
