defmodule Quote do
  @moduledoc """
  Represents the quotes of a `Coin` in a given point in time
  """
  use Ecto.Schema
  alias Persistence.Repo
  import Ecto.Changeset

  schema "ranking_quote" do
    timestamps(type: :utc_datetime)
    field(:timestamp, :integer)
    field(:price, :decimal)
    field(:volume_24h, :integer)
    field(:market_cap, :integer)
    field(:percent_change_1h, :decimal)
    field(:percent_change_24h, :decimal)
    field(:percent_change_7d, :decimal)
    field(:last_updated, :integer)
    belongs_to(:coin, Coin, references: :id)
  end

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

  def insert(payload) do
    %Quote{}
    |> changeset(payload)
    |> Repo.insert()
  end
end
