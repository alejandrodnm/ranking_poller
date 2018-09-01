defmodule Web.Schema.Ranking do
  @moduledoc """
  GraphQL Ranking types
  """
  use Absinthe.Schema.Notation
  import_types(Absinthe.Type.Custom)

  object :coin do
    field(:id, :id)
    field(:name, :string)
    field(:website_slug, :string)
    field(:symbol, :string)
  end

  object :results do
    field(:id, :id)
    field(:inserted_at, :datetime)
    field(:timestamp, :integer)
    field(:num_cryptocurrencies, :integer)
    field(:error, :string)
  end
end
