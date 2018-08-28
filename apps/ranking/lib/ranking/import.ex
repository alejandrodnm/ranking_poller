defmodule Ranking.Import do
  @moduledoc """
  Represents an import job for the quotes
  """
  alias Ecto.Multi
  alias Persistence.Repo
  alias Ranking.Coin
  alias Ranking.Provider
  alias Ranking.Quote
  import Ecto.Changeset
  use Ecto.Schema

  schema "ranking_import" do
    timestamps(type: :utc_datetime, updated_at: false)
    field(:timestamp, :integer)
    field(:num_cryptocurrencies, :integer)
    field(:error, :string)
    has_many(:quotes, Quote)
  end

  @doc """
  Validates the attributes of a `Map` against the `Ranking.Import` schema.
  """
  @spec changeset(%Ranking.Import{}, map()) :: Ecto.Changeset.t()
  def changeset(ranking_import, attrs \\ %{}) do
    ranking_import
    |> cast(attrs, [:timestamp, :num_cryptocurrencies, :error])
  end

  @spec insert(map()) :: {:ok, %Ranking.Import{}} | {:error, String.t()}
  def insert(payload) do
    %Ranking.Import{}
    |> changeset(payload)
    |> Repo.insert()
  end

  @doc """
  Fetches the current ranking from the provider, processes the output
  and stores the coin and associated quotes in a single database
  transaction.
  """
  def run do
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
        Coin.changeset(%Coin{}, coin_payload)
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
