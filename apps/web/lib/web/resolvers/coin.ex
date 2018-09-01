defmodule Web.Resolvers.Coin do
  @moduledoc """
  GraphQL Coin resolver
  """
  def list_coins(_parent, _args, _resolution) do
    {:ok, Ranking.get_coins()}
  end
end
