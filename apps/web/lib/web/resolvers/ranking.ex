defmodule Web.Resolvers.Ranking do
  @moduledoc """
  Coin resolver
  """
  def list_coins(_parent, _args, _resolution) do
    {:ok, Ranking.get_coins()}
  end

  @moduledoc """
  Results resolver
  """
  def list_results(_parent, _args, _resolution) do
    {:ok, Ranking.get_results()}
  end
end
