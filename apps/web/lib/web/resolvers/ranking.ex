defmodule Web.Resolvers.Ranking do
  import Absinthe.Resolution.Helpers, only: [on_load: 2]
  alias Ranking.Quote
  alias Ranking.Results

  @moduledoc """
  Coin resolver
  """
  def get_coin(%Quote{} = quote_, _args, %{context: %{loader: loader}}) do
    loader
    |> Dataloader.load(Ranking, :coin, quote_)
    |> on_load(fn loader ->
      coin = Dataloader.get(loader, Ranking, :coin, quote_)
      {:ok, coin}
    end)
  end

  def get_coins(_parent, _args, _resolution) do
    {:ok, Ranking.get_coins()}
  end

  @moduledoc """
  Results resolver
  """
  def get_results(_parent, %{filter: %{date: date}}, _resolution) do
    {:ok, Ranking.get_results(date)}
  end

  def get_results(results_id) do
    {:ok, Ranking.get_results(results_id)}
  end

  @moduledoc """
  Quotes resolver
  """
  def get_quotes(%Results{} = parent, _args, _resolution) do
    {:ok, Ranking.get_quotes(parent)}
  end
end
