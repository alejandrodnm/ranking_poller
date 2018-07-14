defmodule Standings do
  @moduledoc """
  Documentation for Standings.
  """
  @provider_endpoint "https://api.coinmarketcap.com/v2/ticker/?sort=rank"

  @doc """
  Hello world.
  """
  def fetch_current do
    standings = HTTPoison.get(@provider_endpoint)
  end
end
