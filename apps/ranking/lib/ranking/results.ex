defmodule Ranking.Results do
  @moduledoc """
  Represents the results for a single day
  """
  alias Persistence.Repo
  alias Ranking.Quote
  import Ecto.Changeset
  use Ecto.Schema

  @typep quote_extra_data :: %{required(String.t()) => pos_integer}

  schema "ranking_results" do
    timestamps(type: :utc_datetime, updated_at: false)
    field(:timestamp, :integer)
    field(:num_cryptocurrencies, :integer)
    field(:error, :string)
    has_many(:quotes, Quote)
  end

  @doc """
  Validates the attributes of a `Map` against the `Ranking.Import` schema.
  """
  @spec changeset(%Ranking.Results{}, map()) :: Ecto.Changeset.t()
  def changeset(ranking_import, attrs \\ %{}) do
    ranking_import
    |> cast(attrs, [:timestamp, :num_cryptocurrencies, :error])
  end

  @spec insert(map()) :: {:ok, %Ranking.Results{}} | {:error, String.t()}
  def insert(payload) do
    %Ranking.Results{}
    |> changeset(payload)
    |> Repo.insert()
  end
end
