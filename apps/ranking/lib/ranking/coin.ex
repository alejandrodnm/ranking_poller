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
    field(:slug, :string)
    field(:symbol, :string)
    has_many(:quotes, Quote, references: :id)
  end

  @doc """
  Validates the attributes of a `Map` against the `Coin` schema.
  """
  @spec changeset(%Ranking.Coin{}, map()) :: Ecto.Changeset.t()
  def changeset(coin, attrs \\ %{}) do
    coin
    |> cast(attrs, [:id, :name, :symbol, :slug])
  end

  @doc """
  Returns a `%Coin{}` from the given payload. The coin is persisted
  in the database if it's not already there.

    iex> payload = %{
    ...> "id" => 1,
    ...> "name"=> "my coin",
    ...> "slug"=> "my-coin",
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

  @spec get_coin(pos_integer) :: %__MODULE__{}
  def get_coin(coin_id) when is_integer(coin_id) do
    Repo.get(Ranking.Coin, coin_id)
  end

  @spec get_coin(String.t()) :: %__MODULE__{}
  def get_coin(slug) when is_binary(slug) do
    Repo.get_by(Ranking.Coin, slug: slug)
  end
end
