defmodule Ranking.Coin do
  @moduledoc """
  Represents a virtual coin.
  """
  alias Persistence.Repo
  alias Ranking.Quote
  import Ecto.Changeset
  import Ecto.Query
  use Ecto.Schema

  @primary_key false

  schema "ranking_coin" do
    field(:id, :id, primary_key: true)
    field(:name, :string)
    field(:website_slug, :string)
    field(:symbol, :string)
    has_many(:quotes, Quote, references: :id)
  end

  @doc """
  Validates the attributes of a `Map` against the `Coin` schema.
  """
  @spec changeset(%Ranking.Coin{}, map()) :: Ecto.Changeset.t()
  def changeset(coin, attrs \\ %{}) do
    coin
    |> cast(attrs, [:id, :name, :symbol, :website_slug])
  end

  @doc """
  Returns a `%Coin{}` from the given payload. The coin is persisted
  in the database if it's not already there.

    iex> payload = %{
    ...> "id" => 1,
    ...> "name"=> "my coin",
    ...> "website_slug"=> "my-coin",
    ...> "symbol"=> "mc"
    ...> }
    iex> {:ok, coin} = Coin.get_or_insert(payload)
    iex> coin.id
    1
  """
  @spec get_or_insert(map()) :: {:ok, %Ranking.Coin{}} | {:error, String.t()}
  def get_or_insert(payload) do
    %Ranking.Coin{}
    |> changeset(payload)
    |> Repo.insert(on_conflict: :nothing)
  end

  @spec get_coins() :: [%Ranking.Coin{}]
  def get_coins do
    Repo.all(from(Ranking.Coin))
  end
end
