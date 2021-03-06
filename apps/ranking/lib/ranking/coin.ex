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
  @spec changeset(%__MODULE__{}, map()) :: Ecto.Changeset.t()
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
  @spec get_or_insert(map()) :: {:ok, %__MODULE__{}} | {:error, String.t()}
  def get_or_insert(payload) do
    %__MODULE__{}
    |> changeset(payload)
    |> Repo.insert(on_conflict: :nothing)
  end

  @doc """
  Returns the coin belongin to the given identifier, either its id or
  the coin slug.
  """
  @spec get_coin(pos_integer | String.t()) :: %__MODULE__{} | {:error, String.t()}
  def get_coin(identifier) do
    case get_coin_by(identifier) do
      %__MODULE__{} = coin -> coin
      nil -> {:error, "coin does not exists"}
    end
  end

  @spec get_coin_by(pos_integer | String.t()) :: %__MODULE__{} | nil
  defp get_coin_by(coin_id) when is_integer(coin_id) do
    Repo.get(__MODULE__, coin_id)
  end

  defp get_coin_by(slug) when is_binary(slug) do
    Repo.get_by(__MODULE__, slug: slug)
  end

  @doc """
  Returns a Coin queryable filtered by the given args
  """
  @spec get_coins_queryable(map) :: Ecto.Query.t()
  def get_coins_queryable(args) do
    Enum.reduce(args, __MODULE__, fn
      _, query ->
        query
    end)
  end
end
