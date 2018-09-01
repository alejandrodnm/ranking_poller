defmodule Ranking.Test.Factory do
  @moduledoc """
  Factory for Coin test data
  """
  alias Persistence.Repo
  alias Ranking.Coin
  alias Ranking.Import
  alias Ranking.Quote
  alias Ranking.Test.Payload

  @doc """
  Returns a map with all the elementes necessary for creating the
  given structure.
  """
  def payload(factory_name, opt \\ [])

  def payload(:coin, opts) do
    coin_id = opts |> Keyword.get(:coin_id, 1) |> Integer.to_string()
    Payload.get()["data"][coin_id]
  end

  def payload(:quote, opts) do
    coin_id = insert!(:coin, coin_id: Keyword.get(opts, :coin_id, 1)).id

    ranking_import_id =
      case Keyword.get(opts, :ranking_import_id) do
        nil -> insert!(:ranking_import).id
        ranking_import_id -> ranking_import_id
      end

    coin_payload = payload(:coin, coin_id: coin_id)
    quote_payload = coin_payload["quotes"]["USD"]

    %{
      "timestamp" => Payload.get()["metadata"]["timestamp"],
      "price" => quote_payload["price"],
      "volume_24h" => quote_payload["volume_24h"],
      "market_cap" => quote_payload["market_cap"],
      "percent_change_1h" => quote_payload["percent_change_1h"],
      "percent_change_24h" => quote_payload["percent_change_24h"],
      "percent_change_7d" => quote_payload["percent_change_7d"],
      "last_updated" => coin_payload["last_updated"],
      "coin_id" => coin_id,
      "circulating_supply" => coin_payload["circulating_supply"],
      "total_supply" => coin_payload["total_supply"],
      "max_supply" => coin_payload["max_supply"],
      "ranking_import_id" => ranking_import_id
    }
  end

  def payload(:ranking_import, opts) do
    metadata_payload = Payload.get()["metadata"]

    %{
      "timestamp" => metadata_payload["timestamp"],
      "num_cryptocurrencies" => metadata_payload["num_cryptocurrencies"],
      "error" => metadata_payload["error"]
    }
  end

  @spec insert!(atom) :: struct
  def insert!(:all) do
    ranking_import_id = insert!(:ranking_import).id

    Payload.get()
    |> Map.get("data")
    |> Map.keys()
    |> Enum.map(fn coin_id ->
      insert!(
        :quote,
        coin_id: String.to_integer(coin_id),
        ranking_import_id: ranking_import_id
      )
    end)
  end

  def insert!(factory_name, opts \\ []) do
    factory_name
    |> payload(opts)
    |> (&build(factory_name, &1)).()
    |> Repo.insert!()
  end

  @spec build(atom, map) :: struct
  defp build(:ranking_import, payload) do
    %Import{
      timestamp: payload["timestamp"],
      num_cryptocurrencies: payload["num_cryptocurrencies"],
      error: payload["error"]
    }
  end

  defp build(:coin, payload) do
    %Coin{
      id: payload["id"],
      name: payload["name"],
      symbol: payload["symbol"],
      website_slug: payload["website_slug"]
    }
  end

  defp build(:quote, payload) do
    %Quote{
      timestamp: payload["timestamp"],
      price: payload["price"],
      volume_24h: payload["volume_24h"],
      market_cap: payload["market_cap"],
      percent_change_1h: payload["percent_change_1h"],
      percent_change_24h: payload["percent_change_24h"],
      percent_change_7d: payload["percent_change_7d"],
      last_updated: payload["last_updated"],
      coin_id: payload["coin_id"],
      circulating_supply: payload["circulating_supply"],
      total_supply: payload["total_supply"],
      max_supply: payload["max_supply"],
      ranking_import_id: payload["ranking_import_id"]
    }
  end
end
