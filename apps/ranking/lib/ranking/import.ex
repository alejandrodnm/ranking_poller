defmodule Ranking.Import do
  @moduledoc """
  Imports new results from the provider and persists them in the
  database
  """
  alias Ecto.Multi
  alias Persistence.Repo
  alias Ranking.Coin
  alias Ranking.Provider
  alias Ranking.Quote
  alias Ranking.Results
  import Ecto.Changeset
  use Ecto.Schema

  @typep quote_extra_data :: %{required(String.t()) => pos_integer}

  @doc """
  Fetches the current ranking from the provider, processes the output
  and stores the coin and associated quotes in a single database
  transaction.
  """
  def run do
    {:ok, ranking} = Provider.get_ranking()

    Multi.new()
    |> Multi.insert(
      :results,
      Results.changeset(%Results{}, ranking["metadata"])
    )
    |> Multi.merge(fn %{results: results} ->
      Multi.new()
      |> process_coin(
        Map.to_list(ranking["data"]),
        %{
          "timestamp" => ranking["metadata"]["timestamp"],
          "results_id" => results.id
        }
      )
    end)
    |> Repo.transaction()
  end

  @spec process_coin(Multi.t(), list(map()), quote_extra_data) :: Multi.t()
  defp process_coin(multi, [], _) do
    multi
  end

  defp process_coin(multi, [{id, coin_payload} | tail], quote_extra_data) do
    quote_payload = get_quote_payload(coin_payload, quote_extra_data)

    multi
    |> Multi.insert(
      "coin_#{id}",
      Coin.changeset(%Coin{}, coin_payload),
      on_conflict: :nothing
    )
    |> Multi.insert("quote_#{id}", Quote.changeset(%Quote{}, quote_payload))
    |> process_coin(tail, quote_extra_data)
  end

  @spec get_quote_payload(map(), quote_extra_data) :: map()
  defp get_quote_payload(coin_payload, quote_extra_data) do
    {:ok, quotes} = Map.fetch(coin_payload, "quotes")
    {:ok, usd} = Map.fetch(quotes, "USD")

    quote_extra_data
    |> Map.merge(usd)
    |> Map.merge(%{
      "coin_id" => coin_payload["id"],
      "last_updated" => coin_payload["last_updated"],
      "circulating_supply" => coin_payload["circulating_supply"],
      "total_supply" => coin_payload["total_supply"],
      "max_supply" => coin_payload["max_supply"]
    })
  end
end
