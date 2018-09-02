defmodule Web.Schema.Ranking do
  @moduledoc """
  GraphQL Ranking types
  """
  alias Web.Resolvers.Ranking
  use Absinthe.Schema.Notation
  import_types(Absinthe.Type.Custom)

  object :coin do
    field(:id, :id)
    field(:name, :string)
    field(:website_slug, :string)
    field(:symbol, :string)
  end

  object :quote do
    field(:id, :id)
    field(:inserted_at, :datetime)
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

    field :coin, :coin do
      resolve(&Ranking.get_coin/3)
    end
  end

  input_object :results_filter do
    non_null(field(:date, :date))
  end

  object :results do
    field(:id, :id)
    field(:inserted_at, :datetime)
    field(:timestamp, :integer)
    field(:num_cryptocurrencies, :integer)
    field(:error, :string)

    field :quotes, list_of(:quote) do
      resolve(&Ranking.get_quotes/3)
    end
  end
end
