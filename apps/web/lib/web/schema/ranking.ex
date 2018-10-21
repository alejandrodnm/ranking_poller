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
  connection(node_type: :coin_simple)

  interface :coin_interface do
    field(:name, :string)
    field(:slug, :string)
    field(:symbol, :string)

    resolve_type(fn
      %{role: "coin"}, _ -> :coin
    end)
  end

  node object(:coin) do
    interface(:coin_interface)
    field(:id, :id)
    field(:name, :string)
    field(:slug, :string)
    field(:symbol, :string)

    connection field(:quotes, node_type: :quote) do
      resolve(&Resolvers.Ranking.get_quotes/3)
    end
  end

  node object(:coin_simple) do
    interface(:coin_interface)
    field(:id, :id)
    field(:name, :string)
    field(:slug, :string)
    field(:symbol, :string)
  end

  node object(:quote) do
    field(:id, :id)
    field(:timestamp, :integer)
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
  end
end
