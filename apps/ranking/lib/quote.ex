defmodule Quote do
  @moduledoc """
  Represents the quotes of a `Coin` in a given point in time.
  """
  alias Persistence.Repo
  import Ecto.Changeset
  use Ecto.Schema

  schema "ranking_quote" do
    timestamps(type: :utc_datetime)
    field(:timestamp, :integer)
    field(:price, :decimal)
    field(:volume_24h, :decimal)
    field(:market_cap, :decimal)
    field(:percent_change_1h, :decimal)
    field(:percent_change_24h, :decimal)
    field(:percent_change_7d, :decimal)
    field(:last_updated, :integer)
    belongs_to(:coin, Coin, references: :id)
  end

  @doc """
  Validates the attributes of a `Map` against the `Quote` schema, it
  also checks that the coin that the quote belongs to exists in the
  database.
  """
  @spec changeset(%Quote{}, map()) :: Ecto.Changeset.t()
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
      :coin_id
    ])
    |> foreign_key_constraint(:coin_id)
  end

  @doc """
  Persists a `%Quote{}` in the database from the given payload.
  """
  @spec insert(map()) :: {:ok, %Quote{}} | {:error, String.t()}
  def insert(payload) do
    %Quote{}
    |> changeset(payload)
    |> Repo.insert()
  end
end
