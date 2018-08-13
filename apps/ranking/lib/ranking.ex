defmodule Ranking do
  @moduledoc """
  Maintains the ranking of the virtual coins.
  """
  alias Ecto.Multi
  alias Persistence.Repo

  @doc """
  Fetches the current ranking from the provider, processes the output
  and stores the coin and associated quotes in a single database
  transaction.
  """
  def fetch_current do
    {:ok, ranking} = Provider.get_ranking()

    multi =
      process_coin(
        Map.to_list(ranking["data"]),
        ranking["metadata"]["timestamp"],
        Multi.new()
      )

    Repo.transaction(multi)
  end

  @spec process_coin(list(map()), pos_integer(), Multi.t()) :: Multi.t()
  defp process_coin([], _, multi) do
    multi
  end

  defp process_coin([{id, coin_payload} | tail], timestamp, multi) do
    quote_payload = get_quote_payload(coin_payload, timestamp)

    new_multi =
      multi
      |> Multi.insert(
        "coin_#{id}",
        Coin.changeset(%Coin{}, coin_payload),
        on_conflict: :nothing
      )
      |> Multi.insert("quote_#{id}", Quote.changeset(%Quote{}, quote_payload))

    process_coin(tail, timestamp, new_multi)
  end

  @spec get_quote_payload(map(), pos_integer()) :: map()
  defp get_quote_payload(coin_payload, timestamp) do
    {:ok, quotes} = Map.fetch(coin_payload, "quotes")
    {:ok, usd} = Map.fetch(quotes, "USD")

    Map.merge(
      usd,
      %{
        "coin_id" => coin_payload["id"],
        "last_updated" => coin_payload["last_updated"],
        "timestamp" => timestamp
      }
    )
  end
end
