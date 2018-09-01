defmodule Ranking.Quote do
  @moduledoc """
  Represents the quotes of a `Coin` in a given point in time.
  """
  alias Persistence.Repo
  alias Ranking.Coin
  alias Ranking.Results
  import Ecto.Changeset
  use Ecto.Schema

  schema "ranking_quote" do
    field(:timestamp, :integer)
    field(:price, :decimal)
    field(:volume_24h, :decimal)
    field(:market_cap, :decimal)
    field(:percent_change_1h, :decimal)
    field(:percent_change_24h, :decimal)
    field(:percent_change_7d, :decimal)
    field(:last_updated, :integer)
    field(:circulating_supply, :decimal)
    field(:total_supply, :decimal)
    field(:max_supply, :decimal)
    belongs_to(:coin, Coin, references: :id)
    belongs_to(:results, Results)
  end

  @doc """
  Validates the attributes of a `Map` against the `Ranking.Ranking.Quote`
  schema, it also checks that the coin that the quote belongs to
  exists in the database.
  """
  @spec changeset(%Ranking.Quote{}, map()) :: Ecto.Changeset.t()
  def changeset(quote_, attrs \\ %{}) do
    quote_
    |> cast(attrs, [
      :timestamp,
      :price,
      :volume_24h,
      :market_cap,
      :percent_change_1h,
      :percent_change_24h,
      :percent_change_7d,
      :last_updated,
      :coin_id,
      :circulating_supply,
      :total_supply,
      :max_supply,
      :results_id
    ])
    |> foreign_key_constraint(:coin_id)
    |> foreign_key_constraint(:results_id)
  end

  @doc """
  Persists a `%Ranking.Quote{}` in the database from the given payload.
  """
  @spec insert(map()) :: {:ok, %Ranking.Quote{}} | {:error, String.t()}
  def insert(payload) do
    %Ranking.Quote{}
    |> changeset(payload)
    |> Repo.insert()
  end
end
