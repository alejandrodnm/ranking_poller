defmodule Ranking.Import do
  @moduledoc """
  Represents an import job for the quotes
  """
  alias Persistence.Repo
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
end
