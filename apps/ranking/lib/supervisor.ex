defmodule Ranking.Supervisor do
  @moduledoc """
  Ranking Supervisor, starts the Ranking Ticker
  """
  use Supervisor

  def start_link(opts) do
    Supervisor.start_link(__MODULE__, :ok, opts)
  end

  def init(:ok) do
    children = [
      {Ranking.Ticker, name: Ranking.Ticker}
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
