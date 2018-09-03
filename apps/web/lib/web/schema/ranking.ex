defmodule Web.Schema.Ranking do
  @moduledoc """
  GraphQL Ranking types
  """
  use Absinthe.Schema.Notation
  use Absinthe.Relay.Schema.Notation, :modern

  import Absinthe.Resolution.Helpers
  alias Web.Resolvers

  import_types(Absinthe.Type.Custom)

  connection(node_type: :quote)

  object :coin do
    field(:id, :id)
    field(:name, :string)
    field(:website_slug, :string)
    field(:symbol, :string)
  end

  node object(:quote) do
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
      resolve(dataloader(Ranking, :coin))
    end
  end

  input_object :results_filter do
    non_null(field(:date, :date))
  end

  node object(:results) do
    field(:inserted_at, :datetime)
    field(:timestamp, :integer)
    field(:num_cryptocurrencies, :integer)
    field(:error, :string)

    connection field(:quotes, node_type: :quote) do
      resolve(&Resolvers.Ranking.get_quotes/3)
    end
  end
end
