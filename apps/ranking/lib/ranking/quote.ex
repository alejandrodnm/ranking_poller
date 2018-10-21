defmodule Ranking.Quote do
  @moduledoc """
  Represents the quotes of a `Coin` in a given point in time.
  """
  alias Persistence.Repo
  alias Ranking.Coin
  alias Ranking.Import
  alias Ranking.Results
  import Ecto.Changeset
  import Ecto.Query, only: [from: 2]
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
    belongs_to(:import, Import)
  end

  @doc """
  Validates the attributes of a `Map` against the `Ranking.Ranking.Quote`
  schema, it also checks that the coin that the quote belongs to
  exists in the database.
  """
  @spec changeset(%__MODULE__{}, map) :: Ecto.Changeset.t()
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
      :import_id
    ])
    |> foreign_key_constraint(:coin_id)
    |> foreign_key_constraint(:import_id)
  end

  @doc """
  Persists a `%Ranking.Quote{}` in the database from the given payload.
  """
  @spec insert(map) :: {:ok, %__MODULE__{}} | {:error, String.t()}
  def insert(payload) do
    %__MODULE__{}
    |> changeset(payload)
    |> Repo.insert()
  end

  @doc """
  Returns the quotes belonging to the given coin
  """
  @spec get_quotes_queryable(%Coin{}, map) :: Ecto.Query.t()
  def get_quotes_queryable(%Coin{} = coin, args) do
    query = from(u in __MODULE__, where: u.coin_id == ^coin.id)

    Enum.reduce(args, query, fn
      _, query ->
        query
    end)
  end
end
