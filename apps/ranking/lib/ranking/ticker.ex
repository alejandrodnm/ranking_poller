defmodule Ranking.Ticker do
  @moduledoc """
  Executes the ranking import
  """
  use GenServer
  alias Ranking.Import

  @default_timeout 5_000

  def start_link(opts) do
    GenServer.start_link(__MODULE__, [], opts)
  end

  def init(_opts) do
    {:ok, [], 0}
  end

  def handle_info(:timeout, state) do
    Import.run()
    {:noreply, state, get_timeout}
  end

  defp get_timeout do
    case System.get_env("RANKING_POLLER_TICKER_TIMEOUT") do
      nil ->
        @default_timeout

      timeout ->
        try do
          timeout
          |> String.trim()
          |> String.to_integer()
        rescue
          _ -> @default_timeout
        end
    end
  end
end
