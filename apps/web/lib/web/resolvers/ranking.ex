defmodule Web.Resolvers.Ranking do
  alias Ranking.Results

  @moduledoc """
  Coin resolver
  """
  def get_coins(_parent, _args, _resolution) do
    {:ok, Ranking.get_coins()}
  end

  @moduledoc """
  Results resolver
  """
  def get_results(_parent, %{filter: %{date: date}}, _resolution) do
    {:ok, Ranking.get_results(date)}
  end

  @moduledoc """
  Quotes resolver
  """
  def get_quotes(%Results{} = parent, _args, _resolution) do
    {:ok, Ranking.get_quotes(parent)}
  end
end
