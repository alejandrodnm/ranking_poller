defmodule Coin do
  @moduledoc """
  Represents a virtual coin.
  """
  use Ecto.Schema
  alias Persistence.Repo
  import Ecto.Changeset
  @primary_key false

  schema "ranking_coin" do
    field(:id, :id, primary_key: true)
    field(:name, :string)
    field(:website_slug, :string)
    field(:symbol, :string)
    has_many(:quotes, Quote, references: :id)
  end

  def changeset(coin, attrs \\ %{}) do
    coin
    |> cast(attrs, [:id, :name, :symbol, :website_slug])
  end

  def get_or_insert(payload) do
    %Coin{}
    |> changeset(payload)
    |> Repo.insert(on_conflict: :nothing)
  end
end
