defmodule Web.Resolvers.Ranking do
  import Absinthe.Resolution.Helpers, only: [on_load: 2]
  alias Ranking.Import
  alias Ranking.Quote

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
  Import resolver
  """
  def get_import(_parent, %{filter: %{date: date}}, _resolution) do
    {:ok, Ranking.get_import(date)}
  end

  def get_import(import_id) do
    {:ok, Ranking.get_import(import_id)}
  end

  @moduledoc """
  Quotes resolver
  """
  def get_quotes(%Import{} = import, args, _resolution) do
    Absinthe.Relay.Connection.from_query(
      Ranking.get_quotes(import, args),
      &Persistence.Repo.all/1,
      args
    )
  end
end
